import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';
import 'package:medicollap_assignment/models/country_model.dart';
import 'package:xml2json/xml2json.dart';

class LocationProvider extends ChangeNotifier {
  LocationProvider() {
    loadFromDB();

  }
  

  final _myBox = Hive.box("COUNTRY_BOX");

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  late Position _position;
  bool isPositionSet = false;

  late String _countryCode;
  bool isCountryCodeSet = false;

  String get countryCode => _countryCode;
  Position get position => _position;

  final Map<dynamic, dynamic> _countriesList = {};
  bool isDB = false;
  Map<dynamic, dynamic> get countryList => _countriesList;

  // ? Get Current Location
  Future<void> getCurrentLocation() async {
    _isLoading = true;
    notifyListeners();

    LocationPermission permission;
    Position currentPosition;
    // ? Check Location Permission for GeoLocater
    permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      // ? If Permisison Denied then Request User
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // ? If Denied Again then Throw Exception.
        throw Exception('Location Permissions Denied');
      } else {
        
        currentPosition = await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.high);
        _position = currentPosition;
        isPositionSet = true;
        getCountryCode();
        notifyListeners();
      }
      // ? If Permission already given then get current position
    } else {
      currentPosition = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      // ? Update _position
      _position = currentPosition;
      isPositionSet = true;
      getCountryCode();
      notifyListeners();
    }

    _isLoading = false;
    notifyListeners();
  }

  // ? Get Country Code - IN,MM,US,etc.
  Future<void> getCountryCode() async {
    _isLoading = true;
    notifyListeners();

    if (isPositionSet == false) return;
    Uri uri = Uri.parse(
        "http://api.geonames.org/countryCode?lat=${_position.latitude}&lng=${_position.longitude}&username=medcollapp");
    try {
      http.Response response = await http.get(uri);
      _countryCode = response.body;
      isCountryCodeSet = true;
      getCountryDetails();
      notifyListeners();
    } on SocketException catch (_) {
      throw 'Error whilst getting the data: no internet connection.';
    } on HttpException catch (_) {
      throw 'Error whilst getting the data: requested data could not be found.';
    } on FormatException catch (_) {
      throw 'Error whilst getting the data: bad format.';
    } on TimeoutException catch (_) {
      throw 'Error whilst getting the data: connection timed out.';
    } catch (err) {
      throw 'An error occurred whilst fetching the requested data: $err';
    }
    _isLoading = false;
    notifyListeners();
  }

  // ? Get Country Details
  Future<void> getCountryDetails() async {
    if (isCountryCodeSet == false) return;

    String url =
        "http://api.geonames.org/countryInfo?country=${_countryCode.trim()}&username=medcollapp";

    Uri uri = Uri.parse(url);

    try {
      http.Response response = await http.get(uri);

      // ? Converting the XML received from server into JSON String.
      Xml2Json xml2json = Xml2Json();
      xml2json.parse(response.body);
      var json = xml2json.toParker();

      // ? Converting JSON String into JSON.
      final body = jsonDecode(json);

      // ? Finally converting the json into Instance of Country.
      Country currentCountry = Country.fromJson(body['geonames']['country']);

      // ? Extract CurrencyCode from Country Object
      String rate = await getExchangeRate(currentCountry.currencyCode!);
      
      // ? Add Exchange Rate to Country Object
      currentCountry.exchangeRate = rate;
        log(currentCountry.exchangeRate.toString());
      // ? Append Country to _countriesList Map
      _countriesList[currentCountry.countryName!] = currentCountry;

      // ? Save _countriesList to LocalStorage
      await _saveToDB();

    } on SocketException catch (_) {
      throw 'Error whilst getting the data: no internet connection.';
    } on HttpException catch (_) {
      throw 'Error whilst getting the data: requested data could not be found.';
    } on FormatException catch (_) {
      throw 'Error whilst getting the data: bad format.';
    } on TimeoutException catch (_) {
      throw 'Error whilst getting the data: connection timed out.';
    } catch (err) {
      throw 'An error occurred whilst fetching the requested data: $err';
    }
  }

  // ? Get Exchange Rate w.r.t USD - Takes CurrencyCode as Parameter,
  Future<String> getExchangeRate(String symbol) async {
    String url =
        'https://api.exchangerate.host/latest?base=USD&symbols=${symbol.trim()}&amount=1&places=2';
    Uri uri = Uri.parse(url);

    try {
      http.Response response = await http.get(uri);
      var data = jsonDecode(response.body);
      return data['rates'][symbol].toString();
    } on SocketException catch (_) {
      throw 'Error whilst getting the data: no internet connection.';
    } on HttpException catch (_) {
      throw 'Error whilst getting the data: requested data could not be found.';
    } on FormatException catch (_) {
      throw 'Error whilst getting the data: bad format.';
    } on TimeoutException catch (_) {
      throw 'Error whilst getting the data: connection timed out.';
    } catch (err) {
      throw 'An error occurred whilst fetching the requested data: $err';
    }
  }

  // ? Save Data to LocalStorage (HiveBox)
  _saveToDB() async {
    _isLoading = true;
    notifyListeners();
    await _myBox.put('COUNTRY_LIST', _countriesList);
    _isLoading = false;
    notifyListeners();
  }

  // ? Load Data from Box
  // ! Gets called when Instance of Provider is Created.
  loadFromDB() async {
    _isLoading = true;
    notifyListeners();

    Map<dynamic, dynamic>? map = await _myBox.get('COUNTRY_LIST');
    if (map != null) {
      _countriesList.addAll(map);
      isDB = true;
    }

    _isLoading = false;
    notifyListeners();
  }
}

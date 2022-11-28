import 'package:hive/hive.dart';

part 'country_model.g.dart';

@HiveType(typeId: 0)
class Country {
  @HiveField(0)
  String? countryCode;
  @HiveField(1)
  String? countryName;
  @HiveField(2)
  String? isoNumeric;
  @HiveField(3)
  String? isoAlpha3;
  @HiveField(4)
  String? fipsCode;
  @HiveField(5)
  String? continent;
  @HiveField(6)
  String? continentName;
  @HiveField(7)
  String? capital;
  @HiveField(8)
  String? areaInSqKm;
  @HiveField(9)
  String? population;
  @HiveField(10)
  String? currencyCode;
  @HiveField(11)
  String? languages;
  @HiveField(12)
  String? geonameId;
  @HiveField(13)
  String? west;
  @HiveField(14)
  String? north;
  @HiveField(15)
  String? east;
  @HiveField(16)
  String? south;
  @HiveField(17)
  String? postalCodeFormat;
  @HiveField(18)
  String? exchangeRate;

  Country(
      {this.countryCode,
      this.countryName,
      this.isoNumeric,
      this.isoAlpha3,
      this.fipsCode,
      this.continent,
      this.continentName,
      this.capital,
      this.areaInSqKm,
      this.population,
      this.currencyCode,
      this.languages,
      this.geonameId,
      this.west,
      this.north,
      this.east,
      this.south,
      this.postalCodeFormat,
      this.exchangeRate});

  Country.fromJson(Map<String, dynamic> json) {
    countryCode = json['countryCode'];
    countryName = json['countryName'];
    isoNumeric = json['isoNumeric'];
    isoAlpha3 = json['isoAlpha3'];
    fipsCode = json['fipsCode'];
    continent = json['continent'];
    continentName = json['continentName'];
    capital = json['capital'];
    areaInSqKm = json['areaInSqKm'];
    population = json['population'];
    currencyCode = json['currencyCode'];
    languages = json['languages'];
    geonameId = json['geonameId'];
    west = json['west'];
    north = json['north'];
    east = json['east'];
    south = json['south'];
    postalCodeFormat = json['postalCodeFormat'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['countryCode'] = countryCode;
    data['countryName'] = countryName;
    data['isoNumeric'] = isoNumeric;
    data['isoAlpha3'] = isoAlpha3;
    data['fipsCode'] = fipsCode;
    data['continent'] = continent;
    data['continentName'] = continentName;
    data['capital'] = capital;
    data['areaInSqKm'] = areaInSqKm;
    data['population'] = population;
    data['currencyCode'] = currencyCode;
    data['languages'] = languages;
    data['geonameId'] = geonameId;
    data['west'] = west;
    data['north'] = north;
    data['east'] = east;
    data['south'] = south;
    data['postalCodeFormat'] = postalCodeFormat;
    return data;
  }

 
}

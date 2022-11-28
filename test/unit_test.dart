import 'package:flutter_test/flutter_test.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:medicollap_assignment/providers/location_provider.dart';
import 'package:path_provider/path_provider.dart';


void main() {
 setUp((()async {
  
  final appDocumentDirectory = await getApplicationDocumentsDirectory();
   await Hive.initFlutter(appDocumentDirectory.path);
   await Hive.openBox('COUNTRY_BOX');
 }));


  // ! Geolocator Errors - No implementation found for method checkPermission on channel flutter.baseflow.com/geolocator 
  
  // ! Unable to check for location services
  test('Testing Location Provider', () async {
    
    

    final locationProvider = LocationProvider();
 
    
    expect(locationProvider.isLoading, true);
  });
}

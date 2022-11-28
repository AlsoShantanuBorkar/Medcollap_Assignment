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

  test('Testing Location Provider', () async {
    
    

    final locationProvider = LocationProvider();
 
    
    expect(locationProvider.isLoading, true);
  });
}

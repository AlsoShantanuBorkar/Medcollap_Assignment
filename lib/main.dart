import 'package:flutter/material.dart';
import 'package:medicollap_assignment/models/country_model.dart';
import 'package:medicollap_assignment/providers/location_provider.dart';
import 'package:medicollap_assignment/screens/home_screen.dart';
import 'package:provider/provider.dart';
import 'package:path_provider/path_provider.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // ? Get App Directory for storing data
  final appDocumentDirectory = await getApplicationDocumentsDirectory();
  // ? Initialize Hive
  await Hive.initFlutter(appDocumentDirectory.path);
  Hive.registerAdapter(CountryAdapter());
  await Hive.openBox('COUNTRY_BOX');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<LocationProvider>(
            create: ((context) => LocationProvider()))
      ],
      child: MaterialApp(
        title: 'Location Search',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const HomeScreen(title: 'Location Search'),
      ),
    );
  }
}

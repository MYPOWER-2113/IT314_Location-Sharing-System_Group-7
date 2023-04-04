import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart' as latLng;
// import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';
import'package:locatinsharing/signin.dart';
import 'homepage.dart';
import 'SOS.dart';

late SharedPreferences sharedPreferences;

void main() {

  // WidgetsFlutterBinding.ensureInitialized();
  // sharedPreferences=await SharedPreferences.getInstance();
  // await dotenv.load(fileName: "assets/config/.env");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Location Sharing App',
      theme: ThemeData(
        // Define the default brightness and colors.
        brightness: Brightness.light,
        primaryColor: Colors.cyan[900],

        // Define the default font family.
        fontFamily: 'gotham',

        textTheme: const TextTheme(
          displayLarge: TextStyle(fontSize:40.0, fontWeight: FontWeight.bold),
          titleLarge: TextStyle(fontSize: 25.0, /*fontStyle: FontStyle.italic*/),
          bodyMedium: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
        ),
      ),

      darkTheme: ThemeData(
          brightness: Brightness.dark,
          
      ),

      themeMode: ThemeMode.system,
      home: MyHomePage(),
    );
  }
}


import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart' as latLng;
// import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';
import'package:locatinsharing/signin.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'homepage.dart';
import 'navigation.dart';
import 'SOS.dart';
import 'ShareLoc.dart';

late SharedPreferences sharedPreferences;

Future<void> main() async {

  WidgetsFlutterBinding.ensureInitialized();
  sharedPreferences=await SharedPreferences.getInstance();
  await dotenv.load(fileName: "assets/config/.env");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Location Sharing App',
      theme: ThemeData(
        // Define the default brightness and colors.
        brightness: Brightness.light,
        primaryColor: Colors.lightBlue[400],

        // Define the default font family.
        fontFamily: 'Gotham',

        textTheme: const TextTheme(
          displayLarge: TextStyle(fontSize:40.0, fontWeight: FontWeight.bold),
          titleLarge: TextStyle(fontSize: 25.0, /*fontStyle: FontStyle.italic*/),
          bodyMedium: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
        ),
      ),

      darkTheme: ThemeData(
          brightness: Brightness.dark,
        primaryColor: Colors.deepPurple,
      ),

      themeMode: ThemeMode.system,
      home: MyHomePage(),
    );
  }
}


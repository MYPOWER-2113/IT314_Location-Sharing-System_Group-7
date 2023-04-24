import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart' as latLng;
import 'package:locatinsharing/Signin_Signup/signin.dart';
// import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:locatinsharing/Splash/splash_screen.dart';
import 'package:provider/provider.dart';
import 'Signin_Signup/auth.dart';
import 'Signin_Signup/user_provider.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

late SharedPreferences sharedPreferences;

void main() async {
  // sharedPreferences = await SharedPreferences.getInstance();
  await GetStorage.init();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final AuthService authService = AuthService();

  @override
  void initState() {
    super.initState();
    authService.getUserData(context);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'LocSS',
      theme: ThemeData(
        primarySwatch: Colors.blue,

        // Define the default brightness and colors.
        brightness: Brightness.light,
        primaryColor: Colors.blueAccent.shade400,

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
        primaryColor: Colors.blueAccent.shade200,
      ),

      debugShowCheckedModeBanner: false,

      home:MySplashScreen(),
    );
  }
}
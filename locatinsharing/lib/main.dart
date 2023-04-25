import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:locatinsharing/FriendFamily/Contacts.dart';

// import 'package:latlong2/latlong.dart' as latLng;
import 'package:locatinsharing/Navigation/helper/directions_handler.dart';
import 'package:locatinsharing/Signin_Signup/signin.dart';
import 'package:location/location.dart';
import 'package:mapbox_gl/mapbox_gl.dart';

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
  WidgetsFlutterBinding.ensureInitialized();
  sharedPreferences = await SharedPreferences.getInstance();

  await dotenv.load(fileName: "assets/config/.env");
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
    // sharedPreferences = await SharedPreferences.getInstance();

    super.initState();
    initializeLocationAndSave();
    // sharedPreferences = await SharedPreferences.getInstance();
    authService.getUserData(context);
  }

  void initializeLocationAndSave() async {
    // Ensure all permissions are collected for Locations
    Location _location = Location();
    bool? _serviceEnabled;
    PermissionStatus? _permissionGranted;

    _serviceEnabled = await _location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await _location.requestService();
    }

    _permissionGranted = await _location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await _location.requestPermission();
    }

    // Get capture the current user location
    LocationData _locationData = await _location.getLocation();

    LatLng currentLatLng =
        LatLng(_locationData.latitude!, _locationData.longitude!);
    String currentAddress =
        (await getParsedReverseGeocoding(currentLatLng))['place'];
    // String mp = (await getParsedReverseGeocoding(currentLatLng))['place']!;
    // String _currentAddress = mp['place'];
    // print(_currentAddress);
    // Store the user location in sharedPreferences
    // print(currentAddress);
    sharedPreferences.setDouble('latitude', _locationData.latitude!);
    sharedPreferences.setDouble('longitude', _locationData.longitude!);

    sharedPreferences.setString('current-address', currentAddress);

    // Get and store the directions API repsonse in sharedPreferences
    // print("${currentLatLng.latitude},${currentLatLng.longitude}");
    // Map modifiedresponse = await getDirectionsAPIResponse(currentLatLng,LatLng(26.915458,75.818982));
    // saveDirectionsAPIResponse(json.encode(modifiedresponse));
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'LocSS',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        brightness: Brightness.light,
        primaryColor: Colors.blueAccent.shade400,

        // Define the default font family.
        fontFamily: 'Gotham',

        textTheme: TextTheme(
          displayLarge: TextStyle(
              fontSize: 40.0,
              fontWeight: FontWeight.bold,
              color: Colors.greenAccent.shade700),
          titleLarge: TextStyle(
            fontSize: 25.0,
            /*fontStyle: FontStyle.italic*/
            color: Colors.greenAccent,
          ),
          bodyMedium: TextStyle(
              fontSize: 14.0, fontFamily: 'Hind', color: Colors.black),
        ),
      ),

      // darkTheme: ThemeData(
      //   brightness: Brightness.dark,
      //   primaryColor: Colors.blueAccent.shade200,
      // ),
      debugShowCheckedModeBanner: false,
      home: MySplashScreen(),
    );
  }
}

import 'dart:async';
import 'package:latlong2/latlong.dart' as ll;
import 'package:mapbox_gl/mapbox_gl.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:location/location.dart';
import 'package:permission_handler/permission_handler.dart' as per;
import 'package:flutter/material.dart';
import 'package:locatinsharing/Signin_Signup/signin.dart';
import 'package:locatinsharing/homepage.dart';
import 'package:locatinsharing/main.dart';
import 'package:locatinsharing/Signin_Signup/user_provider.dart';

import '../Navigation/helper/directions_handler.dart';

class MySplashScreen extends StatefulWidget {
  const MySplashScreen({Key? key}) : super(key: key);

  @override
  State<MySplashScreen> createState() => _MySplashScreenState();
}

class _MySplashScreenState extends State<MySplashScreen> {
  @override
  void initState() {
    super.initState();
    initializeLocationAndSave();
    startTimer();
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
    // String currentAddress = (await getParsedReverseGeocoding(currentLatLng))['place'];
    // String mp = (await getParsedReverseGeocoding(currentLatLng))['place']!;
    // String _currentAddress = mp['place'];
    // print(_currentAddress);
    // Store the user location in sharedPreferences
    // print(currentAddress);
    sharedPreferences.setDouble('latitude', _locationData.latitude!);
    sharedPreferences.setDouble('longitude', _locationData.longitude!);

    String currentAddress =
    (await getParsedReverseGeocoding(currentLatLng))['place'];

    sharedPreferences.setString('current-address', currentAddress);

    // Get and store the directions API repsonse in sharedPreferences
    // print("${currentLatLng.latitude},${currentLatLng.longitude}");
    // Map modifiedresponse = await getDirectionsAPIResponse(currentLatLng,LatLng(26.915458,75.818982));
    // saveDirectionsAPIResponse(json.encode(modifiedresponse));
  }

  startTimer() {
    Timer(const Duration(seconds: 3), () async {
      // send user to home screen

      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (c) =>
                  Provider.of<UserProvider>(context).user.token.isEmpty
                      ? const Signin()
                      : const MyHomePage()));

      //Uncomment for homepage
      // Navigator.push(context,
      //     MaterialPageRoute(builder: (c) => MyHomePage())
      // );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        color: Colors.black,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "images/Logo_Horizontal_Black.png",
              width: 500,
              height: 200,
            ),

            // const SizedBox(height: 80,),
            // const Text("Location Sharing App",
            //     style : TextStyle(
            //         fontSize: 20,
            //         color : Colors.white,
            //         fontWeight: FontWeight.bold
            //     )
            // )
          ],
        ),
      ),
    );
  }
}

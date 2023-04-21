import 'dart:async';
import 'package:latlong2/latlong.dart' as ll;
import 'package:mapbox_gl/mapbox_gl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:location/location.dart';
import 'package:permission_handler/permission_handler.dart' as per;
import 'package:flutter/material.dart';
import 'package:locatinsharing/Signin_Signup/signin.dart';
import 'package:locatinsharing/homepage.dart';
import 'package:locatinsharing/main.dart';

class MySplashScreen extends StatefulWidget {
  const MySplashScreen({Key? key}) : super(key: key);

  @override
  State<MySplashScreen> createState() => _MySplashScreenState();
}

class _MySplashScreenState extends State<MySplashScreen> {

  @override
  void initState() {
    super.initState();
    // _initialCameraPostion = CameraPosition(target: ltlg,zoom: 15);
    // initializeLocationAndSave();
    startTimer();
  }

  /*void initializeLocationAndSave() async {
    // Ensure all permissions are collected for Locations
    Location _location = new Location();
    bool _serviceEnabled;
    // _serviceEnabled ??=false;
    PermissionStatus _permissionGranted;
    // _permissionGranted ??=false;
    // _permissionGranted
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
    LatLng currentLatLng = LatLng( _locationData.latitude!, _locationData.longitude!);
    // Store the user location in sharedPreferences
    sharedPreferences.setDouble('latitude', _locationData.latitude!);
    sharedPreferences.setDouble('longitude', _locationData.longitude!);
    //
    //   //
    //   //   // Get and store the directions API response in sharedPreferences
    //     for (int i = 0; i < restaurants.length; i++) {
    //       Map modifiedResponse = await getDirectionsAPIResponse(currentLatLng, i);
    //       saveDirectionsAPIResponse(i, json.encode(modifiedResponse));
    //     }
    //   //
    //   // Navigator.pushAndRemoveUntil(
    //   //   context,
    //   //   MaterialPageRoute(builder: (_) => MyHomePage()),
    //   //   (route) => false
    //   // );
    // }
    //
    // _onMapCreated(MapboxMapController controller) async {
    //   this.controller=controller;
    //
    // }
    //
    // _onStyleLoadedCallback() async {}
  }
*/

  startTimer()
  {
    Timer(const Duration(seconds: 3), () async{
      // send user to home screen
      Navigator.push(context, MaterialPageRoute(builder: (c) => MyHomePage()));
    });
  }

  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //
  //   startTimer();
  // }
  @override
  Widget build(BuildContext context)
  {
    return Material(
      child: Container(
        color: Colors.black,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("images/Logo_Horizontal_Black.png", width: 500, height: 200,),

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
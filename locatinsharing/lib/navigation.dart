import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart' as ll;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:mapbox_gl/mapbox_gl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:location/location.dart';
import 'package:permission_handler/permission_handler.dart' as per;
import 'package:mapbox_gl/mapbox_gl.dart' as mpgl;

import 'homepage.dart';
import 'main.dart';
import 'Contacts.dart';
import 'SOS.dart';
import 'ShareLoc.dart';
import 'NearbyMe.dart';

class Navigation extends StatefulWidget {
  const Navigation({Key? key}) : super(key: key);

  @override
  State<Navigation> createState() => _Navigation();
}

class _Navigation extends State<Navigation>{


  @override
  void initState() {
    super.initState();
    // _initialCameraPostion = CameraPosition(target: ltlg,zoom: 15);
    initializeLocationAndSave();
    _initialCameraPostion = CameraPosition(target: ltlg,zoom: 15);

  }

  void initializeLocationAndSave() async {
    // Ensure all permissions are collected for Locations
    Location _location = new Location();
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

    LatLng currentLatLng = LatLng( _locationData.latitude!, _locationData.longitude!);

    // Store the user location in sharedPreferences
    sharedPreferences.setDouble('latitude', _locationData.latitude!);
    sharedPreferences.setDouble('longitude', _locationData.longitude!);


  }

  LatLng ltlg = LatLng(sharedPreferences.getDouble('latitude')!, sharedPreferences.getDouble('longitude')!);
  late CameraPosition _initialCameraPostion;
  late MapboxMapController controller;

  _onMapCreated(MapboxMapController controller){
    this.controller=controller;
  }

  _onStyleLoadedCallback(){}


  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: const Text('Navigation'),
      ),

      /*body: FlutterMap(
        options: MapOptions(
          // center: ll.LatLng(23.2156, 72.6369),
          center: ll.LatLng(ltlg.latitude,ltlg.longitude),
          zoom: 16,
        ),
        nonRotatedChildren: [
          AttributionWidget.defaultWidget(
            source: 'OpenStreetMap contributors',
            onSourceTapped: null,
          ),
        ],
        children: [
          TileLayer(
            urlTemplate: 'https://api.mapbox.com/styles/v1/ronitjain04/clfxzfjit000301qflgwwr3ip/tiles/256/{z}/{x}/{y}@2x?access_token=pk.eyJ1Ijoicm9uaXRqYWluMDQiLCJhIjoiY2xmeHdsdGt1MHY5ajNpczZwZ2gzZ2U3YiJ9.4YWhnln8WAvbrzSEKYf_Jg',
            additionalOptions: {
              'accessToken': 'pk.eyJ1Ijoicm9uaXRqYWluMDQiLCJhIjoiY2xmeHdsdGt1MHY5ajNpczZwZ2gzZ2U3YiJ9.4YWhnln8WAvbrzSEKYf_Jg',
              'id': 'mapbox.mapbox-streets-v8'
            },
          ),
        ],
      ),
      */

      body: SafeArea(
        child: Stack(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height*0.8,
              child: MapboxMap(
                accessToken: dotenv.env['MAPBOX_ACCESS_TOKEN'],
                initialCameraPosition: _initialCameraPostion,
                onMapCreated: _onMapCreated,
                onStyleLoadedCallback: _onStyleLoadedCallback,
                myLocationEnabled: true,
                myLocationTrackingMode: MyLocationTrackingMode.TrackingGPS,
                minMaxZoomPreference: const MinMaxZoomPreference(14, 18),
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          controller.animateCamera(CameraUpdate.newCameraPosition(_initialCameraPostion));
        },
        child: const Icon(Icons.my_location),
      ),
    );
  }
}
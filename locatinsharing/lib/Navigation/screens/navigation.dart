import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
// import 'package:latlong2/latlong.dart' as latlng;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:locatinsharing/Navigation/directions_handler.dart';
import 'package:mapbox_gl/mapbox_gl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:location/location.dart';
import 'package:permission_handler/permission_handler.dart' as per;

import 'package:locatinsharing/homepage.dart';
import 'package:locatinsharing/main.dart';
import 'package:locatinsharing/Navigation/navigation.dart';
import 'package:locatinsharing/SOS/SOS.dart';
import 'package:locatinsharing/ShareLoc/ShareLoc.dart';
import 'package:locatinsharing/NearbyMe/NearbyMe.dart';
import 'package:locatinsharing/FriendFamily/Contacts.dart';


class Navigation extends StatefulWidget {
  const Navigation({Key? key}) : super(key: key);

  @override
  State<Navigation> createState() => _Navigation();
}

class _Navigation extends State<Navigation>{

  late LatLng ltlg = LatLng(sharedPreferences.getDouble('latitude')!, sharedPreferences.getDouble('longitude')!) ;
  late CameraPosition _initialCameraPostion;
  late MapboxMapController controller;
  late CameraPosition dest=CameraPosition(target: LatLng(72.63394,23.196299),zoom: 15);
  // late Map _data;

  @override
  void initState() {
    super.initState();

    initializeLocationAndSave();
    _initialCameraPostion = CameraPosition(target: ltlg,zoom: 15);
    // Map response = json.decode(sharedPreferences.getString('destination')!);
    // num distance = response['distance']/1000;
    // num duration = response['duration']/60;

    dest=CameraPosition(target: LatLng(23.196299,72.63394),zoom: 15);

    // Initialize map symbols
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

    LatLng currentLatLng = LatLng( _locationData.latitude!, _locationData.longitude!);

    // Store the user location in sharedPreferences
    sharedPreferences.setDouble('latitude', _locationData.latitude!);
    sharedPreferences.setDouble('longitude', _locationData.longitude!);

    // Get and store the directions API repsonse in sharedPreferences
    // print("${currentLatLng.latitude},${currentLatLng.longitude}");
    // Map modifiedresponse = await getDirectionsAPIResponse(currentLatLng);
    // saveDirectionsAPIResponse(jsonEncode(modifiedresponse));

  }


  _addSourceAndLineLayer() async {
  //  Can animate camera to focus on items
    controller.animateCamera(CameraUpdate.newCameraPosition(dest));

  //  add a polyline between source and Destination
    late String? key;
    key=sharedPreferences.getString('destiny')!;
    Map resp = json.decode(key);
    Map geometry = resp['geometry'];
  //   Map geometry = getGeometryFromSharedPrefs("destiny");
    final _fills = {
      "type": "FeatureCollection",
      "features": [
        {
          "type": "Feature",
          "id": 0,
          "properties": <String,dynamic>{},
          "geometry": geometry,
        },
      ]
    };

  //  Remove linelayer and source if it exists
  //   if(removeLayer==true){
  //     await controller.removeLayer("lines");
  //     await controller.removeSource("fills");
  //   }

  //  add new source and linelayer
    await controller.addSource("fills", GeojsonSourceProperties(data: _fills));
    await controller.addLineLayer(
      "fills",
      "lines",
      LineLayerProperties(
        lineColor: Colors.blue.toHexStringRGB(),
        lineCap: "round",
        lineJoin: "round",
        lineWidth: 4,
      ),
    );
  }

  _onMapCreated(MapboxMapController controller) async {
    this.controller=controller;
  }

  _onStyleLoadedCallback() async {
    late CameraPosition des=dest;
    await controller.addSymbol(
      SymbolOptions(
        geometry: des.target,
        iconSize: 0.1,
        iconImage: "images/Variety-fruits-vegetables.png",
      ),
    ) ;

    _addSourceAndLineLayer();
  }

  int selectedPage = 0;

  final _pageOptions = [
    MyHomePage(),
    SOS(),
    Navigation(),
    ShareLocation(),
    Contacts(),
    NearMe()
  ];

  int _currentIndex = 2;

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => _pageOptions[index]),
    );
  }

  @override
  Widget build(BuildContext context){
    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(

            leading: IconButton(
              icon: Icon(Icons.menu),
              onPressed: () {},
            ),

            title: Text("Navigation"),

            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.notifications_none, size: 30,),
                onPressed: () {},
              ),
            ],

            //backgroundColor: Colors.cyan,
            flexibleSpace: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.blueAccent.shade100, Colors.greenAccent.shade200],
                  begin: Alignment.bottomRight,
                  end: Alignment.topLeft,
                ),
              ),
            ),
          ),

          bottomNavigationBar: BottomNavigationBar(
            currentIndex: _currentIndex,
            selectedItemColor: Colors.teal[900],
            onTap: _onItemTapped,

            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.home, size: 30,),
                label: 'Home',
                backgroundColor: Colors.greenAccent.shade200,
              ),

              BottomNavigationBarItem(
                icon: Icon(Icons.emergency_share, size: 30,),
                label: 'SOS Share',
                backgroundColor: Colors.blueAccent.shade100,
              ),

              BottomNavigationBarItem(
                icon: Icon(Icons.navigation, size: 30,),
                label: 'Navigation',
                backgroundColor: Colors.greenAccent.shade200,
              ),

              BottomNavigationBarItem(
                icon: Icon(Icons.share_location_sharp, size: 30,),
                label: 'ShareLocation',
                backgroundColor: Colors.blueAccent.shade100,
              ),

              BottomNavigationBarItem(
                icon: Icon(Icons.person_4, size: 30,),
                label: 'Contacts',
                backgroundColor: Colors.greenAccent.shade200,
              ),

              BottomNavigationBarItem(
                icon: Icon(Icons.near_me_rounded, size: 30,),
                label: 'Near Me',
                backgroundColor: Colors.blueAccent.shade100,
              ),
            ],

            elevation: 50,
            selectedFontSize: 15,
          ),

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
                    // minMaxZoomPreference: const MinMaxZoomPreference(14, 18),
                    compassEnabled: true,

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
        ),

        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0, vertical:100.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Card(
                child: TextField(
                  decoration: InputDecoration(

                    contentPadding: EdgeInsets.all(16.0),
                    hintText: "Search",
                    prefixIcon: Icon(Icons.search),
                  ),
                ),
              ),
            ],
          ),
        ),


      ],
    );
  }
}
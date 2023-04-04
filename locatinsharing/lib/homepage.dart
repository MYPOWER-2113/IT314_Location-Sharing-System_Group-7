import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart' as latLng;
// import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:location/location.dart';
import 'package:permission_handler/permission_handler.dart' as per;
import 'SOS.dart';
import 'main.dart';

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // @override
  // void initState() {
  //   super.initState();
  //   initializeLocationAndSave();
  // }
  //
  // void initializeLocationAndSave() async {
  //   // Ensure all permissions are collected for Locations
  //   Location _location = Location();
  //   bool? _serviceEnabled;
  //   PermissionStatus? _permissionGranted;
  //
  //   _serviceEnabled = await _location.serviceEnabled();
  //   if (!_serviceEnabled) {
  //     _serviceEnabled = await _location.requestService();
  //   }
  //
  //   _permissionGranted = await _location.hasPermission();
  //   if (_permissionGranted == PermissionStatus.denied) {
  //     _permissionGranted = await _location.requestPermission();
  //   }
  //
  //   // Get capture the current user location
  //   LocationData _locationData = await _location.getLocation();
  //   latLng.LatLng currentLatLng =
  //   latLng.LatLng(_locationData.latitude!, _locationData.longitude!);
  //
  //   // Store the user location in sharedPreferences
  //   sharedPreferences.setDouble('latitude', _locationData.latitude!);
  //   sharedPreferences.setDouble('longitude', _locationData.longitude!);
  //
  //   // Get and store the directions API response in sharedPreferences
  //   // for (int i = 0; i < restaurants.length; i++) {
  //   //   Map modifiedResponse = await getDirectionsAPIResponse(currentLatLng, i);
  //   //   saveDirectionsAPIResponse(i, json.encode(modifiedResponse));
  //   // }
  //
  //   Navigator.pushAndRemoveUntil(
  //       context,
  //       MaterialPageRoute(builder: (_) => MyHomePage()),
  //           (route) => false);
  // }

  int selectedPage = 0;

  final _pageOptions = [
    MyHomePage(),
    // Navigation(),
    // ShareLocation()
    SOS()
    // Friends()
    // NearMe()
  ];

  int _currentIndex = 0;

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
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(

        leading: IconButton(
          icon: Icon(Icons.menu),
          onPressed: () {},
        ),

        title: Text("LocSS"),

        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.notifications_none, size: 30,),
            onPressed: () {},
          ),

          // IconButton(
          //   icon: Icon(Icons.search),
          //   onPressed: () {},
          // )

        ],

        //backgroundColor: Colors.cyan,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.lightGreenAccent, Colors.lightBlueAccent],
              begin: Alignment.bottomRight,
              end: Alignment.topLeft,
            ),
          ),
        ),
      ),

      // bottomNavigationBar: Row(
      //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //   crossAxisAlignment: CrossAxisAlignment.center,
      //   children: [
      //     IconButton(
      //       icon: const Icon(Icons.home, size: 30),
      //       onPressed: () {
      //         //write your script
      //       },
      //     ),
      //
      //     IconButton(
      //       icon: const Icon(Icons.emergency_share, size: 30),
      //       onPressed: () {
      //         //write your script
      //       },
      //     ),
      //
      //     IconButton(
      //       icon: const Icon(Icons.navigation, size: 30),
      //       onPressed: () {
      //         //write your script
      //       },
      //     ),
      //
      //     IconButton(
      //       icon: const Icon(Icons.contact_phone_rounded, size: 30),
      //       onPressed: () {
      //         //write your script
      //       },
      //     ),
      //
      //     IconButton(
      //       icon: const Icon(Icons.near_me, size: 30),
      //       onPressed: () {
      //         //write your script
      //       },
      //     ),
      //
      //     IconButton(
      //       icon: const Icon(Icons.location_on, size: 30,),
      //       onPressed: () {
      //         //write your script
      //       },
      //     ),
      //   ],
      //   // This trailing comma makes auto-formatting nicer for build methods.
      // ),

      bottomNavigationBar: BottomNavigationBar(

        currentIndex: _currentIndex,
        selectedItemColor: Colors.lightBlueAccent[200],
        onTap: _onItemTapped,

        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home, size: 30,),
            label: 'Home',
            backgroundColor: Colors.lightBlueAccent[200],
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.emergency_share, size: 30,),
            label: 'SOS Share',
            backgroundColor: Colors.lightGreenAccent[700],
          ),


          BottomNavigationBarItem(
            icon: Icon(Icons.navigation, size: 30,),
            label: 'Navigation',
            backgroundColor: Colors.lightGreenAccent[700],
          ),


          BottomNavigationBarItem(
            icon: Icon(Icons.share_location_sharp, size: 30,),
            label: 'Share Location',
            backgroundColor: Colors.lightBlueAccent[200],
          ),



          BottomNavigationBarItem(
            icon: Icon(Icons.person_4, size: 30,),
            label: 'Contacts',
            backgroundColor: Colors.lightBlueAccent[200],
          ),


          BottomNavigationBarItem(
            icon: Icon(Icons.near_me_rounded, size: 30,),
            label: 'Near Me',
            backgroundColor: Colors.lightGreenAccent[700],
          ),

        ],

        elevation: 50,


        // items: const [
        //   BottomNavigationBarItem(
        //     label: 'Home',
        //     icon: Icon(Icons.home, size: 30),
        //     /* title: Text('Home') */
        //   ),
        //
        //   BottomNavigationBarItem(
        //     label: 'Share Location',
        //     icon: Icon(Icons.place, size: 30),
        //     /* title: Text('Inbox') */
        //   ),
        //
        //   BottomNavigationBarItem(
        //     label: 'Friends',
        //     icon: Icon(Icons.person_4, size: 30),
        //     /* title: Text('Account') */
        //   ),
        //
        //   BottomNavigationBarItem(
        //     label: 'Places',
        //     icon: Icon(Icons.near_me, size: 30),
        //     /* title: Text('Account') */
        //   ),
        //
        //   BottomNavigationBarItem(
        //     label: 'SOS',
        //     icon: Icon(Icons.emergency_share, size: 30),
        //     /* title: Text('Account') */
        //   ),
        //
        //   BottomNavigationBarItem(
        //     label: 'Navigation',
        //     icon: Icon(Icons.navigation, size: 30),
        //     /* title: Text('Account') */
        //   ),
        // ],

        // selectedItemColor: Colors.cyan,
        // elevation: 5.0,
        // unselectedItemColor: Colors.cyan[800],
        // backgroundColor: Colors.white,

      ),


      body: FlutterMap(
        options: MapOptions(
          center: latLng.LatLng(23.2156, 72.6369),

          zoom: 11,
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
    );
  }
}

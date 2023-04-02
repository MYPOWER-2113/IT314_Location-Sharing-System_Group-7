import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart' as latLng;

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int selectedPage = 0;

  final _pageOptions = [
    // HomeScreen(),
    // InboxScreen(),
    // SignInScreen()
  ];

  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("Location Sharing App"),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.arrow_drop_down_circle_sharp),
              onPressed: () {
                print("Button Pressed");
              }),

        ]
      ),

      bottomNavigationBar: BottomNavigationBar(

        items: [
          BottomNavigationBarItem(label: 'Home', icon: Icon(Icons.home, size: 30), /* title: Text('Home') */),
          BottomNavigationBarItem(label: 'Share Location', icon: Icon(Icons.place, size: 30), /* title: Text('Inbox') */),
          BottomNavigationBarItem(label: 'Friends', icon: Icon(Icons.person_4, size: 30), /* title: Text('Account') */),
          BottomNavigationBarItem(label: 'Places', icon: Icon(Icons.near_me, size: 30), /* title: Text('Account') */),
          BottomNavigationBarItem(label: 'SOS', icon: Icon(Icons.emergency_share, size: 30), /* title: Text('Account') */),
          BottomNavigationBarItem(label: 'Navigation', icon: Icon(Icons.navigation, size: 30), /* title: Text('Account') */),
        ],
        selectedItemColor: Colors.cyan,
        elevation: 5.0,
        unselectedItemColor: Colors.cyan[800],
        currentIndex: selectedPage,
        backgroundColor: Colors.white,
        onTap: (index){
          setState(() {
            selectedPage = index;
          });
        },
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

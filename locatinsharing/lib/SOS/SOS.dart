import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart' as ll;

//import 'package:flutter_dotenv/flutter_dotenv.dart';
//import 'package:mapbox_gl/mapbox_gl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:location/location.dart';
import 'package:permission_handler/permission_handler.dart' as per;
//import 'package:mapbox_gl/mapbox_gl.dart' as mpgl;
import 'package:lite_rolling_switch/lite_rolling_switch.dart';

import 'package:locatinsharing/homepage.dart';
import 'package:locatinsharing/main.dart';
import 'package:locatinsharing/FriendFamily/Contacts.dart';
import 'package:locatinsharing/Navigation/navigation.dart';
import 'package:locatinsharing/ShareLoc/ShareLoc.dart';
import 'package:locatinsharing/NearbyMe/NearbyMe.dart';


class SOS extends StatefulWidget {
  const SOS({super.key});
  @override
  State<SOS> createState() => _SOS();
}

class _SOS extends State<SOS> {

  int selectedPage = 1;

  final _pageOptions = [
    MyHomePage(),
    // Navigation(),
    // ShareLocation()
    SOS(),
    Navigation(),
    ShareLocation(),
    //Contacts(),
    //Friends()
    NearMe()
  ];

  int _currentIndex = 1;

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
      backgroundColor: Colors.teal[50],
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.black,
        title: Text('Emergency SOS Messaging'),
      ),
      body: Align(
        alignment: Alignment.topCenter,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("SOS messaging",style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.black
            ),
            ),

            Padding(
              padding: EdgeInsets.only(top: 10),
              child: LiteRollingSwitch(
                value: false,
                textOn: 'Yes',
                textOff: 'No',
                colorOn: Colors.greenAccent,
                colorOff: Colors.redAccent,
                iconOn: Icons.check,
                iconOff: Icons.power_settings_new,
                animationDuration: Duration(milliseconds: 400),
                onChanged: (bool state) {
                  print('turned ${(state) ? 'yes' : 'no'}');
                },
                onTap: (bool state) {
                  print('turned ${(state) ? 'yes' : 'no'}');
                },
                onDoubleTap: (bool state) {
                  print('turned ${(state) ? 'yes' : 'no'}');
                },
                onSwipe: (bool state) {
                  print('turned ${(state) ? 'yes' : 'no'}');
                },
              ),
            )
          ],

        ),
      ),
      bottomNavigationBar: BottomNavigationBar(

        currentIndex: _currentIndex,
        selectedItemColor: Colors.deepPurpleAccent,
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

      ),
    );
  }
}
import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get_storage/get_storage.dart';
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
import 'package:locatinsharing/Navigation/screens/navigation.dart';
import 'package:locatinsharing/ShareLoc/ShareLoc.dart';
import 'package:locatinsharing/NearbyMe/NearbyMe.dart';

import '../../Slide_nav_bar/Slide_Page.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'package:flutter_android_volume_keydown/flutter_android_volume_keydown.dart';

int _volumeButtonPressCount = 0;
DateTime _lastVolumeButtonPressTime = DateTime.now();

class SOS extends StatefulWidget {
  const SOS({super.key});

  @override
  State<SOS> createState() => _SOS();
}

class _SOS extends State<SOS> {
  int selectedPage = 1;

  final _pageOptions = [
    MyHomePage(),
    SOS(),
    Navigation(),
    ShareLocation(),
    Contacts(),
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

  // for switch state start here
  bool isSwitched = false;
  final switchData = GetStorage();

  @override
  void initState() {
    super.initState();

    if (switchData.read('isSwitched') != null) {
      setState(() {
        isSwitched = switchData.read('isSwitched');
      });
    }
  }

  // for switch state ends here

  // -----> if switch is on activate volume button to take input

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const DrawerScreen(),
      appBar: AppBar(
        title: Text("SOS Emergency"),

        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.notifications_none,
              size: 30,
            ),
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
        selectedItemColor: Colors.blue[900],
        onTap: _onItemTapped,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              size: 30,
            ),
            label: 'Home',
            backgroundColor: Colors.greenAccent.shade200,
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.emergency_share,
              size: 30,
            ),
            label: 'SOS Share',
            backgroundColor: Colors.blueAccent.shade100,
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.navigation,
              size: 30,
            ),
            label: 'Navigation',
            backgroundColor: Colors.greenAccent.shade200,
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.share_location_sharp,
              size: 30,
            ),
            label: 'ShareLocation',
            backgroundColor: Colors.blueAccent.shade100,
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person_4,
              size: 30,
            ),
            label: 'Contacts',
            backgroundColor: Colors.greenAccent.shade200,
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.near_me_rounded,
              size: 30,
            ),
            label: 'Near Me',
            backgroundColor: Colors.blueAccent.shade100,
          ),
        ],
        elevation: 50,
        selectedFontSize: 15,
      ),
      body: Align(
        alignment: Alignment.topCenter,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "SOS messaging",
              style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
            Padding(
              padding: EdgeInsets.only(top: 10),
              child: LiteRollingSwitch(
                value: isSwitched,
                textOn: 'On',
                textOff: 'Off',
                colorOn: Colors.greenAccent,
                colorOff: Colors.redAccent,
                iconOn: Icons.check,
                iconOff: Icons.power_settings_new,
                animationDuration: Duration(milliseconds: 400),
                onChanged: (value) {
                  setState(() {
                    isSwitched = value;
                    switchData.write('isSwitched', isSwitched);
                    // if(value) {
                    //   VolumeButtonListener();
                    // }
                  });
                },
                onTap: (bool state) {
                  print('turned ${(state) ? 'yes' : 'no'}');
                  // if(state) {
                  //   VolumeButtonListener();
                  // }
                },
                onDoubleTap: (bool state) {
                  print('turned ${(state) ? 'yes' : 'no'}');
                },
                onSwipe: (bool state) {
                  print('turned ${(state) ? 'yes' : 'no'}');
                },
              ),
            ),
            if (isSwitched) // Display this only if the switch is turned on
              Container(
                margin: EdgeInsets.symmetric(vertical: 20),
                child: Text('The switch is turned on!'),
              ),
          ],
        ),
      ),
    );
  }
}

// class VolumeButtonListener extends State<SOS> {
//   @override
//   _VolumeButtonListenerState createState() => _VolumeButtonListenerState();
//
//   @override
//   Widget build(BuildContext context) {
//    TODO: implement build
//     throw UnimplementedError();
//   }
// }
//
// class _VolumeButtonListenerState extends State<VolumeButtonListener> {
//   // Track the number of times the volume button has been pressed
//
//   // Handle the volume button press
//   void _handleVolumeButtonPress() {
//     setState(() {
//       _volumeButtonPressCount++;
//     });
//       // Volume button has been pressed three or more times, do something here
//       // For example, show a toast message or perform an action
//       DateTime now = DateTime.now();
//       if (now.difference(_lastVolumeButtonPressTime) > Duration(seconds: 5)) {
//         // reset the press count if the last press was more than 2 seconds ago
//         _volumeButtonPressCount = 0;
//       }
//       else {
//         _lastVolumeButtonPressTime = now;
//         if (_volumeButtonPressCount >= 3) {
//           print('Volume button pressed three or more times');
//           // send message
//
//           _volumeButtonPressCount = 0;
//         }
//       }
//     }
//
//
//   @override
//   Widget build(BuildContext context) {
//     return RawKeyboardListener(
//       focusNode: FocusNode(),
//       onKey: (RawKeyEvent event) {
//         while (event is RawKeyDownEvent) {
//           while (event. == PhysicalKeyboardKey.audioVolumeDown ||
//               event.physicalKey == PhysicalKeyboardKey.audioVolumeUp) {
//             // Call the volume button press handler
//             _handleVolumeButtonPress();
//           }
//         }
//       },
//       child: Container(
//         // Your app's UI goes here
//         child: Text('Press the volume button three times'),
//       ),
//     );
//   }
// }

class _MyAppState extends State<SOS> {
  StreamSubscription<HardwareButton>? subscription;

  @override
  void initState() {
    super.initState();
  }

  void startListening() {
    subscription = FlutterAndroidVolumeKeydown.stream.listen((event) {
      if (event == HardwareButton.volume_down) {
        print("Volume down received");
      } else if (event == HardwareButton.volume_up) {
        print("Volume up received");
      }
    });
  }

  void stopListening() {
    subscription?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Plugin example app'),
      ),
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
                onPressed: startListening,
                child: const Text("Start listening")),
            ElevatedButton(
                onPressed: stopListening, child: const Text("Stop listening")),
          ],
        ),
      ),
    );
  }
}

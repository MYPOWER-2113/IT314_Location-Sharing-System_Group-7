import 'dart:async';
import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get_storage/get_storage.dart';
import 'package:latlong2/latlong.dart' as ll;
import 'package:flutter/widgets.dart';

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

import 'package:flutter_sms/flutter_sms.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../Navigation/helper/shared_prefs.dart';

//listen to volume buttons
import 'package:volume_watcher/volume_watcher.dart';

import 'SOS_Contacts.dart';


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

  final long = getCurrentLatLngFromSharedPrefs().longitude,lat = getCurrentLatLngFromSharedPrefs().latitude;
  List<String> recepients=["9664842368"];
  void _sendSOS(List<String> recepitent) async{
    //List<String> recepients=[recipitent];
    // await BackgroundSms.sendMessage(
    // phoneNumber: "+919313601005", message: "Hey . Test message", simSlot: 1);
    await sendSMS(message:"Hi there this is message from my app. My location is https://www.google.com/maps/@$lat,$long,20z",recipients:recepients);
  }

  // void _sendMessage(String phoneNumber, String message ) async {
  //   var result = await BackgroundSms.sendMessage(
  //       phoneNumber: phoneNumber, message: message, simSlot: 1);
  //   if (result == SmsStatus.sent) {
  //     print("Sent");
  //   } else {
  //     print("Failed");
  //   }
  // }

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

    if(switchData.read('isSwitched') != null)
    {
      setState(() {
        isSwitched = switchData.read('isSwitched');
      });
    }

    //Volume button code ( didn't work due to handleVolumeButtonPressed() )

    // _volumeWatcher = VolumeWatcher(onVolumeChangeListener: (_) => _handleVolumeButtonPressed());
    // _volumeWatcher.
  }

  // void dispose() {
  //   _timer?.cancel();
  //   super.dispose();
  // }
  //
  // void _handleVolumeButtonPressed() {
  //   if (isSwitched) {
  //     setState(() {
  //       _counter++;
  //       if (_counter == 1) {
  //         _timer = Timer(Duration(seconds: 2), _resetCounter);
  //       } else if (_counter == 3) {
  //         _performAction();
  //         _resetCounter();
  //       }
  //     });
  //   }
  // }
  // void _resetCounter() {
  //   setState(() {
  //     _counter = 0;
  //     _timer?.cancel();
  //   });
  // }
  //
  // void _performAction() {
  //   // Do something when the volume button is pressed 3 times within 2 seconds
  //   _sendSOS("9998349915");
  // }

  // for switch state ends here


  // -----> if switch is on activate volume button to take input

  // buttons
  // late VolumeWatcher _volumeWatcher;
  // int _counter = 0;
  // late Timer _timer;

  @override
  Widget build(BuildContext context) {
    if(isSwitched)
      if(recepients.isEmpty)
        return sosContact();
    return Scaffold(
      drawer: const DrawerScreen(),
      appBar: AppBar(
        title: Text("SOS Emergency"),

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
        selectedItemColor: Colors.blue[900],
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

            if (!isSwitched) // Display this only if the switch is turned off
              Container(
                height: 100,
                alignment: Alignment.center,
                child: Container(
                  width: 280,
                  height: 100,
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      'SOS allows you to immediately send your current location to your selected contact.',
                      maxLines: 3,
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
              ),

            if (isSwitched) // Display this only if the switch is turned on
              Container(
                margin: EdgeInsets.symmetric(vertical: 20),
              ),

            if (isSwitched) // Display this only if the switch is turned on
              Container(
                height: 150,
                alignment: Alignment.center,
                child: Container(
                  width: 280,
                  height: 150,
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      'SOS is ON. Press this button in case of emergency. It will automatically send your location to your selected contact',
                      maxLines: 3,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                      fontSize: 20,
                    ),
                    ),
                  ),
                ),
              ),
            if (isSwitched)
              Ink(
                  decoration: ShapeDecoration(

                    color: Colors.black,
                    shape: CircleBorder(),
                  ),
                  child: IconButton(
                    icon: Icon(
                      Icons.all_inclusive,
                      color: Colors.blueAccent,
                    ),
                    iconSize: 150.0,
                    splashColor: Colors.redAccent,
                    padding: EdgeInsets.all(40.0),
                    onPressed: () {
                      _sendSOS(recepients);
                      // _sendMessage("=919313601005","Test Message",);
                      // _sendSOS(valueChoose);
                    },
                  )),
            Padding(
              padding: EdgeInsets.all(25.0),
            ),

            if(recepients.isNotEmpty)
              ElevatedButton(
                child: Text('Edit SOS Contacts'),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => sosContact()),
                  );
                }
              ),
          ],
        ),
      ),
    );
  }
}

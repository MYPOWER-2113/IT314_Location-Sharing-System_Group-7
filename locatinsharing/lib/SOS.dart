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

import 'homepage.dart';
import 'main.dart';

class SOS extends StatefulWidget {
  const SOS({super.key});

  @override
  State<SOS> createState() => _SOS();
}

class _SOS extends State<SOS> {
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
            Text("Switch on SOS messaging",style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.black
            ),
            ),

            Padding(
              padding: EdgeInsets.only(top: 10),
              child: LiteRollingSwitch(
                value: true,
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
    );
  }
}

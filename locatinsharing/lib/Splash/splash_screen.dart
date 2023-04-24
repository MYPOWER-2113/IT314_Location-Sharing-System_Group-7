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

class MySplashScreen extends StatefulWidget {
  const MySplashScreen({Key? key}) : super(key: key);

  @override
  State<MySplashScreen> createState() => _MySplashScreenState();
}

class _MySplashScreenState extends State<MySplashScreen> {

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  startTimer()
  {
    Timer(const Duration(seconds: 3), () async{
      // send user to home screen

      Navigator.push(context, MaterialPageRoute(builder: (c) => Provider.of<UserProvider>(context).user.token.isEmpty ? const MyHomePage() : const MyHomePage()));
      // Navigator.push(context,
      //     MaterialPageRoute(builder: (c) => MyHomePage())
      // );
    });
  }

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
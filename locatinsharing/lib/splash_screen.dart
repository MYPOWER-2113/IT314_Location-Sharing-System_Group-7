import 'dart:async';

import 'package:flutter/material.dart';
import'package:locatinsharing/signin.dart';

class MySplashScreen extends StatefulWidget {
  const MySplashScreen({Key? key}) : super(key: key);

  @override
  State<MySplashScreen> createState() => _MySplashScreenState();
}

class _MySplashScreenState extends State<MySplashScreen> {

  startTimer()
  {
    Timer(const Duration(seconds: 3), () async{
        // send user to home screen
      Navigator.push(context, MaterialPageRoute(builder: (c) => Signin()));
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    startTimer();
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
            Image.asset("images/Logo_Vertical_White.png"),

            const SizedBox(height: 10,),
            const Text("Location Sharing App",
            style : TextStyle(
              fontSize: 20,
              color : Colors.white,
              fontWeight: FontWeight.bold
            )
            )
          ],
        ),
      ),
    );
  }
}

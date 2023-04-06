import 'dart:async';

import 'package:flutter/material.dart';
import'package:locatinsharing/signin.dart';
import 'homepage.dart';

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
      Navigator.push(context, MaterialPageRoute(builder: (c) => MyHomePage()));
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
            Image.asset("images/Asset 5.png", width: 250, height: 250,),

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

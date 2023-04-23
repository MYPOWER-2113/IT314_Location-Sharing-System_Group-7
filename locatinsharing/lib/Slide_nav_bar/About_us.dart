import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutUs extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
        appBar: AppBar(
          title: const Text('About Us'),
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

        body:SingleChildScrollView(
          child: Column(
            children: [

              //Name and Logo
              Container(
                width: screenWidth,
                padding: EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'Location Sharing System',
                      style: Theme.of(context).textTheme.headline5,
                    ),
                    SizedBox(height: 15),
                    Image.asset(
                      'images/Logo_Horizontal_White.png',
                      width: 200,
                      // height: 100,
                    ),
                  ],
                ),
              ),

              //brief summary
              Container(
                  width: screenWidth,
                  padding: EdgeInsets.all(8),
                  child: Text(
                    'A location-sharing system is an Android application allowing users to share their real-time locations with others. This Android application uses GPS technology to determine a user\'s location and share it with others through social media or a messaging system. This application allows users to create groups and share their location with their family and friends. This application can be accessed through a variety of devices such as smartphones, tablets, and laptops.',
                    style: Theme.of(context).textTheme.bodyText2,
                  )
              ),

              // //statement and values
              // Container(
              //     width: screenWidth,
              //     padding: EdgeInsets.all(8),
              //     child: Column(
              //       crossAxisAlignment: CrossAxisAlignment.start,
              //       children: [
              //         Text(
              //           'Mission Statement:',
              //           style: Theme.of(context).textTheme.headline6,
              //         ),
              //         SizedBox(height: 8),
              //         Text(
              //           'Our mission is to provide high-quality products and services to our customers.',
              //           style: Theme.of(context).textTheme.bodyText2,
              //         ),
              //         SizedBox(height: 16),
              //         Text(
              //           'Values:',
              //           style: Theme.of(context).textTheme.headline6,
              //         ),
              //         SizedBox(height: 8),
              //         ListTile(
              //           leading: Icon(Icons.check),
              //           title: Text('Customer satisfaction is our top priority'),
              //         ),
              //         ListTile(
              //           leading: Icon(Icons.check),
              //           title: Text('We strive for continuous improvement'),
              //         ),
              //         ListTile(
              //           leading: Icon(Icons.check),
              //           title: Text('We value honesty and integrity in all our actions'),
              //         ),
              //       ],
              //     )
              // ),

              //contact information
              Container(
                  width: screenWidth,
                  padding: EdgeInsets.all(8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Contact Us:',
                        style: Theme.of(context).textTheme.headline6,
                      ),
                      SizedBox(height: 8),
                      ListTile(
                        leading: Icon(Icons.email_rounded),
                        title: Text('202001063@daiict.ac.in'),
                      ),
                      ListTile(
                        leading: Icon(Icons.email_rounded),
                        title: Text('202001081@daiict.ac.in'),
                      ),
                    ],
                  )
              ),
            ],
          ),
        )
    );
  }
}

class Testimonial {
  final String author;
  final String text;

  Testimonial(this.author, this.text);
}
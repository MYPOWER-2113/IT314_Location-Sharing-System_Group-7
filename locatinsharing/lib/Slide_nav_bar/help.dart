import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Help extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
        appBar: AppBar(
          title: const Text('Help'),
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.blueAccent.shade100,
                  Colors.greenAccent.shade200
                ],
                begin: Alignment.bottomRight,
                end: Alignment.topLeft,
              ),
            ),
          ),
        ),
        body: SingleChildScrollView(
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Frequently Asked Questions',
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    SizedBox(height: 16.0),
                    Text(
                      'Q: How do I share my location with someone?\nA: Tap the "Share Location" button on the main screen, choose the person you want to share your location with, and tap "Send".',
                    ),
                    SizedBox(height: 16.0),
                    Text(
                      'Q: Can I choose who I share my location with?\nA: Yes, you can choose specific people to share your location with or create groups to share your location with multiple people.',
                    ),
                    SizedBox(height: 16.0),
                    Text(
                      'Q: How do I stop sharing my location with someone?\nA: Tap the "Stop Sharing" button on the main screen, choose the person you want to stop sharing your location with, and tap "Confirm".',
                    ),
                    SizedBox(height: 16.0),
                    Text(
                      'Q: Can I set a time limit for location sharing?\nA: Yes, you can choose to share your location for a specific duration of time when you send the location sharing request.',
                    ),
                    SizedBox(height: 16.0),
                    Text(
                      'Q: How do I see the location of the person I am sharing my location with?\nA: Tap the "View Map" button on the main screen, select the person whose location you want to view, and their location will be displayed on the map.',
                    ),
                    SizedBox(height: 16.0),
                    Text(
                      'Q: What happens if I turn off location sharing or my phone dies?\nA: Your location will no longer be shared with others and they will not be able to see your current location until you turn on location sharing again.',
                      style: Theme.of(context).textTheme.bodyText2,
                    ),
                  ],
                ),
                width: screenWidth,
                padding: EdgeInsets.all(8),
              ),
            ],
          ),
        ));
  }
}

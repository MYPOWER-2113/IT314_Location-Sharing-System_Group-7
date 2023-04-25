import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  bool locationSharingEnabled;
  bool receiveNotifications;

  SettingsPage(
      {required this.locationSharingEnabled,
      required this.receiveNotifications});

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 16.0),
          SwitchListTile(
            title: Text('Enable Location Sharing'),
            value: widget.locationSharingEnabled,
            onChanged: (bool value) {
              setState(() {
                widget.locationSharingEnabled = value;
              });
            },
          ),
          SizedBox(height: 16.0),
          SwitchListTile(
            title: Text('Receive Notifications'),
            value: widget.receiveNotifications,
            onChanged: (bool value) {
              setState(() {
                widget.receiveNotifications = value;
              });
            },
          ),
        ],
      ),
    );
  }
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool locationSharingEnabled = true;
  bool receiveNotifications = true;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Location Sharing App',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Location Sharing App'),
        ),
        body: Center(
          child: ElevatedButton(
            child: Text('Settings'),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SettingsPage(
                    locationSharingEnabled: locationSharingEnabled,
                    receiveNotifications: receiveNotifications,
                  ),
                ),
              ).then((value) {
                setState(() {
                  locationSharingEnabled = value['locationSharingEnabled'];
                  receiveNotifications = value['receiveNotifications'];
                });
              });
            },
          ),
        ),
      ),
    );
  }
}

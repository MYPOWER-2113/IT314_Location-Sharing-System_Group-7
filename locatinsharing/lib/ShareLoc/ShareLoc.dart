import 'package:fast_contacts/fast_contacts.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/src/widgets/basic.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:latlong2/latlong.dart' as latLng;
import 'package:locatinsharing/Navigation/helper/shared_prefs.dart';
import 'package:permission_handler/permission_handler.dart';

// import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:locatinsharing/homepage.dart';
import 'package:locatinsharing/main.dart';
import 'package:locatinsharing/Navigation/screens/navigation.dart';
import 'package:locatinsharing/SOS/SOS.dart';
import 'package:locatinsharing/ShareLoc/ShareLoc.dart';
import 'package:locatinsharing/NearbyMe/NearbyMe.dart';
import 'package:locatinsharing/FriendFamily/Contacts.dart';

import '../../Slide_nav_bar/Slide_Page.dart';

import 'package:flutter_sms/flutter_sms.dart';

class ShareLocation extends StatefulWidget {
  @override
  State<ShareLocation> createState() => ShareMyLocation();
}


class ShareMyLocation extends State<ShareLocation> {
  late Future<List<Contact>> _future;
  Contact? _selectedUser;
  @override
  void initState() {
    super.initState();
    _future = getContacts();
  }
  int selectedPage = 3;

  final _pageOptions = [
    MyHomePage(),
    SOS(),
    Navigation(),
    ShareLocation(),
    Contacts(),
    NearMe()
  ];

  int _currentIndex = 3;

  String valueChoose = "Select Contacts";
  String numChoose="+919313601005";
  final long = getCurrentLatLngFromSharedPrefs().longitude,lat = getCurrentLatLngFromSharedPrefs().latitude;

  void _sendSMS(String recipitent) async {
    List<String> recepients = [recipitent];
    await sendSMS(
        message:
            "My current location is  https://www.google.com/maps/@$lat,$long,20z",
        recipients: recepients);
  }

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
  Widget build(BuildContextontext) {
    return Scaffold(
      drawer: const DrawerScreen(),
      appBar: AppBar(
        title: Text("Share Location"),

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

      body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children:<Widget>[
            Container(
              margin: EdgeInsets.all(15.0),
              padding: EdgeInsets.all(8.0),
              decoration:BoxDecoration(
                  borderRadius:BorderRadius.circular(12),
                  color:Colors.grey
              ),
              child: FutureBuilder<List<Contact>>(
                  future: _future,
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    }

                    if (snapshot.data == null) {
                      return const CircularProgressIndicator();
                    }

                    return Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          const Text(
                            'Select user:',
                            style: TextStyle(fontSize: 23),
                          ),
                          SizedBox(
                            width: 400,
                            child: DropdownButton<Contact>(
                                onChanged: (newvalue) {
                                  setState(() {
                                    _selectedUser = newvalue;
                                    valueChoose = newvalue!.phones[0];
                                  });
                                },
                              value: _selectedUser,
                              iconSize: 50,
                              items: [
                                ...snapshot.data!.map(
                                      (user) => DropdownMenuItem(
                                    value: user,
                                    child: Row(
                                      children: [
                                        Text('${user.displayName} '),
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
            ),
            Container(
              margin: EdgeInsets.all(12.0),
              padding: EdgeInsets.all(8.0),
              decoration:BoxDecoration(
                  borderRadius:BorderRadius.circular(8),
              ),
              child: TextButton(
                  style: TextButton.styleFrom(
                      primary: Colors.purpleAccent,
                      backgroundColor: Colors.blue, // Background Color
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0))
                  ),
                  onPressed: (){
                    if(valueChoose != "Select Contacts") {
                      _sendSMS(valueChoose);
                      Fluttertoast.showToast(
                          msg: "Location Shared",
                          toastLength: Toast.LENGTH_LONG,
                          gravity: ToastGravity.CENTER,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.red,
                          textColor: Colors.white,
                          fontSize: 10.0
                      );
                    }
                  }, child: Text("SEND", style: TextStyle(color: Colors.white,fontSize: 25),)),
            )
          ]
      ),
    );
  }

  Future<List<Contact>> getContacts() async {
    bool isGranted = await Permission.contacts.status.isGranted;
    if (!isGranted) {
      isGranted = await Permission.contacts.request().isGranted;
    }
    if (isGranted) {
      return await FastContacts.allContacts;
    }
    return [];
  }
  }

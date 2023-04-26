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

// import 'package:sms/contact.dart';
import 'package:flutter_sms/flutter_sms.dart';

// import 'package:flutter_s';
// import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
//
// String baseUrl = "https://LocationSharing.com";
// String path = "/";
// double lat = 37.7749;
// double long = -122.4194;
//
// Uri _link = Uri.parse(baseUrl + path + "?lat=$lat&long=$long");
// // print(_link.toString());

class ShareLocation extends StatefulWidget {
  @override
  State<ShareLocation> createState() => ShareMyLocation();
}

class People {
  @override
  String? _name, _number;

  People(String? name, String? number) {
    _name = name;
    _number = number;
  }
}

class MenuItem {
  final String text;
  final IconData icon;

  const MenuItem({
    required this.text,
    required this.icon,
  });
}

class MenuItems {
  static const List<MenuItem> itemFirst = [itemProfile, itemSettings];
  static const List<MenuItem> itemSecond = [itemSignout];
  static const itemSettings = MenuItem(text: "Settings", icon: Icons.settings);
  static const itemProfile = MenuItem(text: "Your Profile", icon: Icons.person);
  static const itemSignout = MenuItem(text: "Sign Out", icon: Icons.logout);
}

PopupMenuItem<MenuItem> buildItem(MenuItem item) => PopupMenuItem<MenuItem>(
      value: item,
      child: Row(
        children: [
          Icon(item.icon, color: Colors.black, size: 20),
          const SizedBox(width: 12),
          Text(item.text),
        ],
      ),
    );

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
  int indexx = 0;
  List ppl=[
    "Select Contacts",
    "+919664842368","+917014850582","+916353553548","+919313601005"];

  List listItem = [
    "Select Contacts",
    "Vedant",
    "Ronit",
    "Hem",
    "Aditya"
  ];

  // final _latlong = getCurrentLatLngFromSharedPrefs();
  final long = getCurrentLatLngFromSharedPrefs().longitude,lat = getCurrentLatLngFromSharedPrefs().latitude;

  void _sendSMS(String recipitent) async {
    List<String> recepients = [recipitent];
    await sendSMS(
        message:
            "HI there, Its a test message from flutter. The Google map link is as follows https://www.google.com/maps/@$lat,$long,20z",
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

        actions: <Widget>[
          PopupMenuButton<MenuItem>(
            itemBuilder: (context) => [
              ...MenuItems.itemFirst.map(buildItem).toList(),
              PopupMenuDivider(),
              ...MenuItems.itemSecond.map(buildItem).toList(),
            ],
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

      body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children:<Widget>[
            Container(
              // margin: EdgeInsets.all(15.0),
              // padding: EdgeInsets.all(8.0),
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
                      padding: const EdgeInsets.all(0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          const Text(
                            'Select user:',
                            style: TextStyle(fontSize: 23),
                          ),
                          SizedBox(
                            // height: 64,
                            // width: 400,
                            child: DropdownButton<Contact>(

                              /*onChanged: (user) =>
                                  setState(() => _selectedUser = user),*/
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
                                        //Image.network(user.avatar),
                                        Text('${user.displayName} ${user.phones[0]}'),
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
                      // _sendSMS(_selectedUser!.phones[0]);
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

  /*body: Align(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 20,
            ),
            Padding(
                padding: EdgeInsets.all(16.10),
                child: Padding(
                    padding: const EdgeInsets.all(3.0),

                      child: Column(
                        children: [
                          SizedBox(
                            height: 3,
                          ),
                          // ButtonBar(
                          //   overflowDirection: VerticalDirection.down,
                          //   overflowButtonSpacing: 5,
                          //   alignment: MainAxisAlignment.spaceEvenly,
                          //   children: [
                          //
                          //     ElevatedButton(
                          //         // onPressed: (){ },
                          //         // color: _hasBeenPressed1 ? Colors.blue : Colors.black,
                          //         // 3
                          //         onPressed: () => {
                          //           setState(() {
                          //             _hasBeenPressed1 = !_hasBeenPressed1;
                          //           })
                          //         },
                          //         child: Text ('Share Live Locaion')),
                          //     ElevatedButton(onPressed: (){}, child: Text ('Share Current Locaion'))
                          //   ],
                          // ),

                          DropdownButton(
                            value: valueChoose,
                            // hint: Te,
                            hint: Text("Select Contact: "),
                            dropdownColor: Colors.grey,
                            icon: Icon(Icons.arrow_drop_down),
                            elevation: 16,
                            iconSize: 40,
                            isExpanded: true,
                            underline: SizedBox(),
                            style: TextStyle(color: Colors.black, fontSize: 22),
                            onChanged: (String? newvalue) {
                              setState(() {
                                valueChoose = newvalue!;
                                // String vl = newvalue!;
                                // valueChoose = vl.substring(14);
                                // // valueChoose = newvalue! ;
                                // numChoose = vl.substring(0,14);
                              });
                            },
                            items: listItem.map((valueItem) {
                              return DropdownMenuItem<String>(
                                value: valueItem,
                                child: Text(valueItem),
                              );
                            }).toList(),
                          ),


                          SizedBox(height: 70),
                          TextButton(
                              style: TextButton.styleFrom(
                                  primary: Colors.purpleAccent,
                                  backgroundColor: Colors.blue, // Background Color
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0))
                              ),
                              onPressed: (){
                                if(valueChoose != "Select Contacts") {
                                  _sendSMS(numChoose);
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
                        ],
                      ),
                    )),
            // Padding(
            //   padding: const EdgeInsets.fromLTRB(0, 120, 0, 0),
            //   child: TextButton(
            //       style: TextButton.styleFrom(
            //           primary: Colors.purpleAccent,
            //           backgroundColor: Colors.blue, // Background Color
            //           shape: RoundedRectangleBorder(
            //               borderRadius: BorderRadius.circular(8.0))),
            //       onPressed: () {
            //         if (valueChoose != "Select Contacts") {
            //           _sendSMS(valueChoose);
            //           Fluttertoast.showToast(
            //               msg: "Location Shared",
            //               toastLength: Toast.LENGTH_LONG,
            //               gravity: ToastGravity.CENTER,
            //               timeInSecForIosWeb: 1,
            //               backgroundColor: Colors.red,
            //               textColor: Colors.white,
            //               fontSize: 10.0);
            //         }
            //       },
            //       child: Text(
            //         "SEND",
            //         style: TextStyle(color: Colors.white, fontSize: 25),
            //       )),
            // )
          ],
        ),
      ),*/
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

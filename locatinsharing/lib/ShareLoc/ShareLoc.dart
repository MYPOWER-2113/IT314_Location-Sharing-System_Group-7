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
// import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:locatinsharing/homepage.dart';
import 'package:locatinsharing/main.dart';
import 'package:locatinsharing/Navigation/navigation.dart';
import 'package:locatinsharing/SOS/SOS.dart';
import 'package:locatinsharing/ShareLoc/ShareLoc.dart';
import 'package:locatinsharing/NearbyMe/NearbyMe.dart';
import 'package:locatinsharing/FriendFamily/Contacts.dart';


class ShareLocation extends StatefulWidget {
  @override
  State<ShareLocation> createState() => ShareMyLocation();
}


class ShareMyLocation extends State<ShareLocation> {
  @override
  void initState() {
    super.initState();
    // initializeLocationAndSave();
  }

  int selectedPage = 3;

  final _pageOptions = [
    MyHomePage(),
    SOS(),
    Navigation(),
    ShareLocation(),
    Contacts(),
    // SOSSHare()
    // Friends()
    NearMe()
  ];

  int _currentIndex = 3;

  String? valueChoose;
  List listItem = [
    "Contact1","Contact2","Contact3","Contact4","Contact5"
  ];

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
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(

        onTap: _onItemTapped,

        currentIndex: selectedPage,



        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home, size: 30,),
            label: 'Home',
            backgroundColor: Colors.lightBlueAccent[200],
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.emergency_share, size: 30,),
            label: 'SOS Share',
            backgroundColor: Colors.lightGreenAccent[700],
          ),


          BottomNavigationBarItem(
            icon: Icon(Icons.navigation, size: 30,),
            label: 'Navigation',
            backgroundColor: Colors.lightGreenAccent[700],
          ),


          BottomNavigationBarItem(
            icon: Icon(Icons.share_location_sharp, size: 30,),
            label: 'Share Location',
            backgroundColor: Colors.lightBlueAccent[200],
          ),



          BottomNavigationBarItem(
            icon: Icon(Icons.person_4, size: 30,),
            label: 'Contacts',
            backgroundColor: Colors.lightBlueAccent[200],
          ),


          BottomNavigationBarItem(
            icon: Icon(Icons.near_me_rounded, size: 30,),
            label: 'Near Me',
            backgroundColor: Colors.lightGreenAccent[700],
          ),

        ],

        elevation: 50,
        selectedItemColor: Colors.deepPurple[600],


      ),

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 150,),
            Padding(padding: EdgeInsets.all(16.10),
                child: Padding(
                  padding: const EdgeInsets.all(180.0),
                  child: Container(
                    padding: EdgeInsets.only(left: 16,right: 16),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey, width: 2),
                        borderRadius: BorderRadius.circular(12)
                    ),
                    child: DropdownButton(
                      value: valueChoose,
                      hint: Text("Select Contact: "),
                      dropdownColor: Colors.grey,
                      icon: Icon(Icons.arrow_drop_down),
                      elevation: 16,
                      iconSize: 40,
                      isExpanded: true,
                      underline: SizedBox(),
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 22
                      ),
                      onChanged: (String? newvalue){
                        setState(() {
                          valueChoose = newvalue! ;
                        });
                      },
                      items: listItem.map((valueItem) {
                        return DropdownMenuItem<String>(
                          value: valueItem,
                          child: Text(valueItem),
                        );
                      }).toList(),
                    ),
                  ),

                )
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(65, 20, 0, 0),
              child: TextButton(
                  style: TextButton.styleFrom(
                      primary: Colors.purpleAccent,
                      backgroundColor: Colors.blue, // Background Color
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0))
                  ),
                  onPressed: (){
                    Fluttertoast.showToast(
                        msg: "Location Shared",
                        toastLength: Toast.LENGTH_LONG,
                        gravity: ToastGravity.CENTER,
                        timeInSecForIosWeb: 2,
                        backgroundColor: Colors.red,
                        textColor: Colors.white,
                        fontSize: 30.0
                    );
                  }, child: Text("SEND", style: TextStyle(color: Colors.white,fontSize: 25),)),
            )
          ],
        ),



      ),



      // body: FlutterMap(
      //   options: MapOptions(
      //     center: latLng.LatLng(23.2156, 72.6369),
      //
      //     zoom: 11,
      //   ),
      //   nonRotatedChildren: [
      //     AttributionWidget.defaultWidget(
      //       source: 'OpenStreetMap contributors',
      //       onSourceTapped: null,
      //     ),
      //   ],
      //   children: [
      //     TileLayer(
      //       urlTemplate: 'https://api.mapbox.com/styles/v1/ronitjain04/clfxzfjit000301qflgwwr3ip/tiles/256/{z}/{x}/{y}@2x?access_token=pk.eyJ1Ijoicm9uaXRqYWluMDQiLCJhIjoiY2xmeHdsdGt1MHY5ajNpczZwZ2gzZ2U3YiJ9.4YWhnln8WAvbrzSEKYf_Jg',
      //       additionalOptions: {
      //         'accessToken': 'pk.eyJ1Ijoicm9uaXRqYWluMDQiLCJhIjoiY2xmeHdsdGt1MHY5ajNpczZwZ2gzZ2U3YiJ9.4YWhnln8WAvbrzSEKYf_Jg',
      //         'id': 'mapbox.mapbox-streets-v8'
      //       },
      //     ),
      //   ],
      //
      // ),

    );
  }
}
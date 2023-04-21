// import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart' as latLng;
// import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:location/location.dart';
import 'package:permission_handler/permission_handler.dart' as per;

import 'package:locatinsharing/homepage.dart';
import 'package:locatinsharing/main.dart';
import 'package:locatinsharing/Navigation/screens/navigation.dart';
import 'package:locatinsharing/SOS/SOS.dart';
import 'package:locatinsharing/ShareLoc/ShareLoc.dart';
import 'package:locatinsharing/NearbyMe/NearbyMe.dart';


class Contacts extends StatefulWidget {
  const Contacts({Key? key}) : super(key: key);

  @override
  State<Contacts> createState() => _ContactsState();
}

class _ContactsState extends State<Contacts> {

  //navigation bar

  int selectedPage = 4;

  final _pageOptions = [
    MyHomePage(),
    SOS(),
    Navigation(),
    ShareLocation(),
    Contacts(),
    NearMe()
  ];

  int _currentIndex = 4;

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => _pageOptions[index]),
    );
  }

  //contacts
  // List<Contact> contacts = [];

  // @override
  // void initState() {
  //   super.initState();
  //   getAllContacts();
  // }
  //
  // getAllContacts() async {
  //   List<Contact> _contacts = (await ContactsService.getContacts()).toList();
  //   setState(() {
  //     contacts = _contacts;
  //   });
  // }

  @override
  // ignore: prefer_const_literals_to_create_immutables
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(

        leading: IconButton(
          icon: Icon(Icons.menu),
          onPressed: () {},
        ),

        title: Text("Contacts"),

        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.notifications_none, size: 30,),
            onPressed: () {},
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
        selectedItemColor: Colors.teal[900],
        onTap: _onItemTapped,

        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home, size: 30,),
            label: 'Home',
            backgroundColor: Colors.greenAccent.shade200,
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.emergency_share, size: 30,),
            label: 'SOS Share',
            backgroundColor: Colors.blueAccent.shade100,
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.navigation, size: 30,),
            label: 'Navigation',
            backgroundColor: Colors.greenAccent.shade200,
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.share_location_sharp, size: 30,),
            label: 'ShareLocation',
            backgroundColor: Colors.blueAccent.shade100,
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.person_4, size: 30,),
            label: 'Contacts',
            backgroundColor: Colors.greenAccent.shade200,
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.near_me_rounded, size: 30,),
            label: 'Near Me',
            backgroundColor: Colors.blueAccent.shade100,
          ),
        ],

        elevation: 50,
        selectedFontSize: 15,
      ),

      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          children: <Widget>[
            Text(
              'Contact List',
            ),
            // ListView.builder(
            //   shrinkWrap: true,
            //   itemCount: contacts.length,
            //   itemBuilder: (context, index) {
            //     Contact contact = contacts[index];
            //     // return ListTile(
            //     //   title: Text(contact.displayName),
            //     //   subtitle: Text(
            //     //       contact.phones
            //     //           .elementAt(0)
            //     //           .value
            //     //   ),
            //     // );
            //   },
            // ),
          ],
        ),
      ),
    );
  }
}



// import 'package:contacts_service/contacts_service.dart';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart' as latLng;
// import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:location/location.dart';
import 'package:permission_handler/permission_handler.dart' as per;
import 'package:flutter_contacts/flutter_contacts.dart';

import 'package:locatinsharing/homepage.dart';
import 'package:locatinsharing/main.dart';
import 'package:locatinsharing/Navigation/screens/navigation.dart';
import 'package:locatinsharing/SOS/SOS.dart';
import 'package:locatinsharing/ShareLoc/ShareLoc.dart';
import 'package:locatinsharing/NearbyMe/NearbyMe.dart';
import '../../Slide_nav_bar/Slide_Page.dart';


class Contacts extends StatefulWidget {
  const Contacts({Key? key}) : super(key: key);

  @override
  State<Contacts> createState() => _ContactsState();
}

class _ContactsState extends State<Contacts> {

  List<Contact>? contacts ;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getContact();
  }

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


  void getContact() async {
    if (await FlutterContacts.requestPermission()) {
      contacts = await FlutterContacts.getContacts(
          withProperties: true, withPhoto: true);

      setState(() {});
    }
  }
  @override
  // ignore: prefer_const_literals_to_create_immutables
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const DrawerScreen(),
      appBar: AppBar(
        title: Text("Contacts"),

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

      body: (contacts) == null
        ? Center(child: CircularProgressIndicator())
        : ListView.builder(
          itemCount: contacts!.length,
        itemBuilder: (BuildContext context, int index){
          Uint8List? image = contacts![index].photo;
          String number = (contacts![index].phones.isNotEmpty) ? (contacts![index].phones.first.number) : "--";
            return ListTile(
              leading: (contacts![index].photo == null)
                  ? const CircleAvatar(child: Icon(Icons.person))
                  : CircleAvatar(backgroundImage: MemoryImage(image!)),
              title: Text(contacts![index].name.first),
              subtitle: Text(number),
            );
        }
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

        ));


  }
}



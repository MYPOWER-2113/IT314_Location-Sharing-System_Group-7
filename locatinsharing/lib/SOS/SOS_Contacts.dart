import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fast_contacts/fast_contacts.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:locatinsharing/Signin_Signup/signin.dart';
import 'package:locatinsharing/Signin_Signup/utils.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import '../Signin_Signup/user_provider.dart';
import '../constants.dart';
import 'SOS.dart';

class sosContact extends StatefulWidget {
  const sosContact({Key? key}) : super(key: key);

  @override
  State<sosContact> createState() => _sosContactState();
}

class _sosContactState extends State<sosContact> {
  late Future<List<Contact>> _future;
  Contact? _selectedUser1, _selectedUser2, _selectedUser3;

  @override
  void initState() {
    super.initState();
    _future = getContacts();
  }

  @override
  Widget build(BuildContextontext) {
    return Scaffold(
      appBar: AppBar(
        title: Text("SOS Contacts"),

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
      body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Container(
              margin: EdgeInsets.all(15.0),
              padding: EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12), color: Colors.grey.shade300),
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
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          const Text(
                            'Select user:',
                          ),
                          SizedBox(
                            height: 50,
                            child: DropdownButton<Contact>(
                              onChanged: (user) =>
                                  setState(() => _selectedUser1 = user),
                              value: _selectedUser1,
                              items: [
                                ...snapshot.data!.map(
                                  (user) => DropdownMenuItem(
                                    value: user,
                                    child: Row(
                                      children: [
                                        //Image.network(user.avatar),
                                        Text('${user.displayName}'),
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
              margin: EdgeInsets.all(15.0),
              padding: EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12), color: Colors.grey.shade300),
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
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          const Text(
                            'Select user:',
                          ),
                          SizedBox(
                            height: 50,
                            child: DropdownButton<Contact>(
                              onChanged: (user) =>
                                  setState(() => _selectedUser2 = user!),
                              value: _selectedUser2,
                              items: [
                                ...snapshot.data!.map(
                                  (user) => DropdownMenuItem(
                                    value: user,
                                    child: Row(
                                      children: [
                                        //Image.network(user.avatar),
                                        Text('${user.displayName}'),
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
              margin: EdgeInsets.all(15.0),
              padding: EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12), color: Colors.grey.shade300),
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
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          const Text(
                            'Select user:',
                          ),
                          SizedBox(
                            height: 50,
                            child: DropdownButton<Contact>(
                              onChanged: (user) =>
                                  setState(() => _selectedUser3 = user!),
                              value: _selectedUser3,
                              items: [
                                ...snapshot.data!.map(
                                  (user) => DropdownMenuItem(
                                    value: user,
                                    child: Row(
                                      children: [
                                        //Image.network(user.avatar),
                                        Text('${user.displayName}'),
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
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
              ),
              child: TextButton(
                  style: TextButton.styleFrom(
                      primary: Colors.purpleAccent,
                      backgroundColor: Colors.blue, // Background Color
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0))),
                  onPressed: () {
                    // if(valueChoose != "Select Contacts") {
                    //   _sendSMS(_selectedUser!.phones[0]);
                    //   Fluttertoast.showToast(
                    //       msg: "Location Shared",
                    //       toastLength: Toast.LENGTH_LONG,
                    //       gravity: ToastGravity.CENTER,
                    //       timeInSecForIosWeb: 1,
                    //       backgroundColor: Colors.red,
                    //       textColor: Colors.white,
                    //       fontSize: 10.0;
                    //   );
                    // }
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(builder: (context) => Signin()),
                    // );
                    makeSOSlist();
                  },
                  child: Text(
                    "SEND",
                    style: TextStyle(color: Colors.white, fontSize: 25),
                  )),
            )
          ]),
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

  void makeSOSlist() async {
    if (_selectedUser1 == null &&
        _selectedUser2 == null &&
        _selectedUser3 == null) {
      showSnackBar(
        context,
        'Please select at least one contact!',
      );
      return;
    } else {
      List SOSlist = [
        _selectedUser1?.phones[0].toString(),
        _selectedUser2?.phones[0].toString(),
        _selectedUser3?.phones[0].toString()
      ];
      try {
        final user = Provider.of<UserProvider>(context, listen: false).user;
        http.Response res = await http.post(
          Uri.parse('${Constants.uri}/SOSnumber'),
          body: jsonEncode({'email': user.email, 'SOSnumber': SOSlist}),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
        );

        httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () {
            showSnackBar(
              context,
              'Contacts updated successfully!',
            );
            Navigator.push(
                context, new MaterialPageRoute(builder: (context) => SOS()));
          },
        );
      } catch (e) {
        showSnackBar(context, e.toString());
      }
    }
  }
}

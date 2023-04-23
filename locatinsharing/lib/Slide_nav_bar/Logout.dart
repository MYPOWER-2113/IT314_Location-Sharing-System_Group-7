import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';


class Logout extends StatelessWidget {
  // const Logout({Key? key}) : super(key: key);

  // final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> _confirmSignOut(BuildContext context) async {
    final bool confirm = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Log Out'),
          content: Text('Are you sure you want to log out?'),
          actions: <Widget>[
            TextButton(
              child: Text('No'),
              onPressed: () {
                Navigator.of(context).pop(false);
              },
            ),
            TextButton(
              child: Text('Yes'),
              onPressed: () async {
                Navigator.of(context).pop(true);
              },
            ),
          ],
        );
      },
    );

    if (confirm == true) {
      // await _auth.signOut();
      Navigator.pushNamedAndRemoveUntil(
        context,
        '/signin',
            (route) => false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Logout'),
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

      body: const Center(
          child: Text('Logout')
      ),
    );
  }
}


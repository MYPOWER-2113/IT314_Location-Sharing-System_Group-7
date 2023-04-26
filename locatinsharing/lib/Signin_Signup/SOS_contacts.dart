import 'package:flutter/material.dart';
import 'package:fast_contacts/fast_contacts.dart';
import 'package:permission_handler/permission_handler.dart';

class sosContact extends StatefulWidget {
  const sosContact({Key? key}) : super(key: key);

  @override
  State<sosContact> createState() => _sosContactState();
}

class _sosContactState extends State<sosContact> {

  late Future<List<Contact>> _future;
  Contact? _selectedUser;
  @override
  void initState() {
    super.initState();
    _future = getContacts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Center(
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
                      height: 64,
                      child: DropdownButton<Contact>(
                        onChanged: (user) =>
                            setState(() => _selectedUser = user),
                        value: _selectedUser,
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
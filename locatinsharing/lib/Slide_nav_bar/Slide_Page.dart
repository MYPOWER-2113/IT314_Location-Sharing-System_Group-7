import 'package:flutter/material.dart';
import 'package:locatinsharing/Slide_nav_bar/About_us.dart';
import 'package:locatinsharing/Slide_nav_bar/Logout.dart';
import 'package:locatinsharing/Signin_Signup/user.dart';
import 'package:provider/provider.dart';
import '../Signin_Signup/user_provider.dart';
import 'Settings.dart';
import 'help.dart';

class DrawerScreen extends StatelessWidget {
  const DrawerScreen({Key? key}) : super(key: key);

  final List drawerMenuListname = const [
    {
      "leading": Icon(
        Icons.animation_rounded,
        color: Colors.blueAccent,
      ),
      "title": "About Us",
      "trailing": Icon(Icons.chevron_right),
      "action_id": 1,
    },
    {
      "leading": Icon(
        Icons.help,
        color: Colors.blueAccent,
      ),
      "title": "Help",
      "trailing": Icon(Icons.chevron_right),
      "action_id": 2,
    },
    {
      "leading": Icon(
        Icons.settings,
        color: Colors.blueAccent,
      ),
      "title": "Settings",
      "trailing": Icon(Icons.chevron_right),
      "action_id": 3,
    },
    {
      "leading": Icon(
        Icons.exit_to_app,
        color: Colors.blueAccent,
      ),
      "title": "Log Out",
      "trailing": Icon(Icons.chevron_right),
      "action_id": 4,
    },
  ];

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;
    return SafeArea(
      child: SizedBox(
        width: 280,
        child: Drawer(
          child: ListView(
            // Remove padding
            padding: EdgeInsets.zero,
            children: [
              UserAccountsDrawerHeader(
                accountName:
                    Text(user.name, style: const TextStyle(fontSize: 18)),
                accountEmail:
                    Text(user.email, style: const TextStyle(fontSize: 14)),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.blueAccent.shade100,
                      Colors.greenAccent.shade200
                    ],
                    begin: Alignment.bottomRight,
                    end: Alignment.topLeft,
                  ),
                  // image: DecorationImage(
                  //     fit: BoxFit.fill,
                  //     // image: NetworkImage('https://oflutter.com/wp-content/uploads/2021/02/profile-bg3.jpg')
                  // ),
                ),
              ),
              // child: ListView(
              //   children: [
              //     const ListTile(
              //       leading: CircleAvatar(
              //         backgroundImage: NetworkImage(
              //             "https://www.channelfutures.com/files/2019/10/Focus-877x432.jpg"),
              //       ),
              //       title: Text(
              //         "BL Kumawat",
              //         style: TextStyle(
              //           color: Colors.black,
              //         ),
              //       ),
              //       subtitle: Text(
              //         "7014333352",
              //         style: TextStyle(
              //           color: Colors.black,
              //         ),
              //       ),
              //     ),
              //     const SizedBox(
              //       height: 1,
              //     ),
              ...drawerMenuListname.map((sideMenuData) {
                return ListTile(
                  leading: sideMenuData['leading'],
                  title: Text(
                    sideMenuData['title'],
                  ),
                  trailing: sideMenuData['trailing'],
                  onTap: () {
                    Navigator.pop(context);
                    if (sideMenuData['action_id'] == 1) {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => AboutUs(),
                        ),
                      );
                    } else if (sideMenuData['action_id'] == 2) {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => Help(),
                        ),
                      );
                    } else if (sideMenuData['action_id'] == 3) {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => SettingsPage(
                            locationSharingEnabled: true,
                            receiveNotifications: false,
                          ),
                        ),
                      );
                    } else if (sideMenuData['action_id'] == 4) {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => Logout(),
                        ),
                      );
                    }
                  },
                );
              }).toList(),
            ],
          ),
        ),
      ),
    );
  }
}

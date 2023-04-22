import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart' as latLng;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:locatinsharing/Splash/splash_screen.dart';
import 'package:provider/provider.dart';

import 'Signin_Signup/auth.dart';
import 'Signin_Signup/user_provider.dart';

late SharedPreferences sharedPreferences;

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   sharedPreferences = await SharedPreferences.getInstance();
//   await dotenv.load(fileName: "assets/config/.env");
//   runApp(const MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Mapbox Flutter',
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData(brightness: Brightness.light),
//       darkTheme: ThemeData(brightness: Brightness.dark),
//       themeMode: ThemeMode.dark,
//       home: const MySplashScreen(),
//     );
//   }
// }


void main() async
{
  WidgetsFlutterBinding.ensureInitialized();
  sharedPreferences = await SharedPreferences.getInstance();
  await dotenv.load(fileName: "assets/config/.env");
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserProvider()),
      ],
      child: MyApp
        (
          child : MaterialApp(
            title: 'Location Sharing App',
            theme: ThemeData(

              // Define the default brightness and colors.
              brightness: Brightness.light,
              primaryColor: Colors.lightBlue[400],

              // Define the default font family.
              fontFamily: 'Gotham',

              textTheme: const TextTheme(
                displayLarge: TextStyle(fontSize:40.0, fontWeight: FontWeight.bold),
                titleLarge: TextStyle(fontSize: 25.0, /*fontStyle: FontStyle.italic*/),
                bodyMedium: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
              ),
            ),

            darkTheme: ThemeData(
              brightness: Brightness.dark,
              primaryColor: Colors.blueAccent,
            ),
            home: MySplashScreen(),
            debugShowCheckedModeBanner: false,
          )
      ),
    ),
  );
}

class MyApp extends StatefulWidget {
  final Widget? child;

  MyApp({this.child});

  static void restartApp(BuildContext context)
  {
    context.findAncestorStateOfType<_MyAppState>()!.restartApp();
  }

  @override
  State<MyApp> createState() => _MyAppState();
}


class _MyAppState extends State<MyApp> {

  Key key = UniqueKey();
  void restartApp()
  {
    setState(() {
      key = UniqueKey();
    });
  }

  @override
  Widget build(BuildContext context) {
    return KeyedSubtree(
        key: key,
        child: widget.child!);
  }

  final AuthService authService = AuthService();

  @override
  void initState() {
    super.initState();
    authService.getUserData(context);
  }
}
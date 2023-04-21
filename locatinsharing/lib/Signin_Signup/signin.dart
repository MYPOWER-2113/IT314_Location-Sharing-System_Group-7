import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/src/widgets/basic.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:http/http.dart' as http;
import 'package:locatinsharing/homepage.dart';
import 'package:locatinsharing/main.dart';
import 'package:locatinsharing/Navigation/screens/navigation.dart';
import 'package:locatinsharing/SOS/SOS.dart';
import 'package:locatinsharing/ShareLoc/ShareLoc.dart';
import 'package:locatinsharing/NearbyMe/NearbyMe.dart';
import 'auth.dart';
import 'user.dart';
import 'package:locatinsharing/Signin_Signup/signup.dart';
import 'package:locatinsharing/Signin_Signup/custom_textfield.dart';

class Signin extends StatefulWidget {
  const Signin({Key? key}) : super(key: key);

  @override
  State<Signin> createState() => _SigninState();
}

class _SigninState extends State<Signin> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final AuthService authService = AuthService();

  void signinUser() {
    authService.signInUser(
      context: context,
      email: emailController.text,
      password: passwordController.text,
    );
  }
  // Future save() async{
  //   var res = await http.post(
  //     Uri.parse("http://10.200.8.251:8080/signin"),headers: <String,String>{'Context-Type':'application/jason;charSet=UTF-8'},
  //
  //     body: <String,String>{
  //       'email': user.email,
  //       'password':user.password
  //     }
  //   );
  //   print(res.body);
  //   Navigator.push(context, new MaterialPageRoute(builder: (context)=>MyHomePage()));
  // }

  //User user = User('', '');

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          // Positioned(
          //     top: 0,
          //     child: SvgPicture.asset('images/Login.png', width: 400, height: 150)
          // ),

          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('images/Login.png'), fit: BoxFit.cover),
            ),

            alignment: Alignment.center,
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 150,),

                  // Text(
                  //   "Signing", style: GoogleFonts.pacifico(fontWeight: FontWeight.bold, fontSize: 50, color: Colors.blue),
                  // ),

                  const SizedBox(height: 235,),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    child: CustomTextField(
                      controller: emailController,
                      hintText: 'Enter your email',
                    ),
                  ),

                  const SizedBox(height: 40),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    child: CustomTextField(
                      controller: passwordController,
                      hintText: 'Enter your password',
                    ),
                  ),

                  const SizedBox(height: 40),
                  ElevatedButton(
                    onPressed: signinUser,
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.blue),
                      textStyle: MaterialStateProperty.all(
                        const TextStyle(color: Colors.white),
                      ),
                      minimumSize: MaterialStateProperty.all(
                        Size(MediaQuery.of(context).size.width / 2.5, 50),
                      ),
                    ),
                    child: const Text(
                      "Login",
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.fromLTRB(40, 2, 0, 0),
                    child: Row(
                      children: [
                        Text("Not have account ?  ", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),),

                        InkWell(
                          onTap: () {
                            Navigator.push(context, new MaterialPageRoute(builder: (context)=>Signup()));
                          },

                            child: Text("SignUp", style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),))
                      ],
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      )
    );
  }
}

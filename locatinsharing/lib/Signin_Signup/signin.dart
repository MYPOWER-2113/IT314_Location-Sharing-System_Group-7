import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/src/widgets/basic.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:http/http.dart' as http;
import 'package:locatinsharing/homepage.dart';
import 'package:locatinsharing/main.dart';
import 'package:locatinsharing/Navigation/navigation.dart';
import 'package:locatinsharing/SOS/SOS.dart';
import 'package:locatinsharing/ShareLoc/ShareLoc.dart';
import 'package:locatinsharing/NearbyMe/NearbyMe.dart';
import 'user.dart';
import 'package:locatinsharing/Signin_Signup/signup.dart';

class Signin extends StatefulWidget {
  const Signin({Key? key}) : super(key: key);

  @override
  State<Signin> createState() => _SigninState();
}

class _SigninState extends State<Signin> {
  final _formKey = GlobalKey<FormState>();

  Future save() async{
    var res = await http.post(
      Uri.parse("http://localhost:8080/signin"),headers: <String,String>{'Context-Type':'application/jason;charSet=UTF-8'},

      body: <String,String>{
        'email': user.email,
        'password':user.password
      }
    );

    print(res.body);
    Navigator.push(context, new MaterialPageRoute(builder: (context)=>MyHomePage()));
  }

  User user = User('', '');

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

                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: TextFormField(
                      controller: TextEditingController(text: user.email),
                      onChanged: (value){
                        user.email = value;
                      },
                      validator: (value){
                        if(value!.isEmpty){
                          return 'Email field can\'t be empty';
                        }

                        else  if(RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                            .hasMatch(value)){
                          return null;
                        }

                        else{
                          return 'Enter valid email';
                        }
                      },

                      decoration: InputDecoration(
                        fillColor: Colors.grey.shade50,
                        filled: true,
                        hintText: 'Email',
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: BorderSide(color: Colors.blue)
                        ),

                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: BorderSide(color: Colors.blue)
                        ),

                        errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: BorderSide(color: Colors.red)
                        ),

                        focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: BorderSide(color: Colors.red)
                        ),
                      ),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.all(20.0),

                    child: TextFormField(
                      controller: TextEditingController(text: user.password),
                      onChanged: (value){
                        user.password = value;
                      },

                      validator: (value){
                        if(value!.isEmpty){
                          return 'Password field can\'t be empty';
                        }

                        else{
                          return null;
                        }
                      },

                      decoration: InputDecoration(

                        fillColor: Colors.grey.shade50,
                        filled: true,

                        hintText: 'Password',

                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: BorderSide(color: Colors.blue)
                        ),

                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: BorderSide(color: Colors.blue)
                        ),

                        errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: BorderSide(color: Colors.red)
                        ),

                        focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: BorderSide(color: Colors.red)
                        ),
                      ),
                    ),
                  ),

                  Padding(padding: EdgeInsets.all(16.0),

                    child: Container(
                      height: 40,
                      width: 400,
                      child: TextButton(
                          style: TextButton.styleFrom(
                            primary: Colors.purpleAccent,
                            backgroundColor: Colors.greenAccent[600], // Background Color
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0))
                          ),
                          onPressed: () {
                            if(_formKey.currentState!.validate()){
                              save();
                            }
                            else{
                              print("not ok");
                            }
                          },
                            child: Text(
                              'Sign in',
                              style: TextStyle(
                                  fontSize: 27,
                                  fontWeight: FontWeight.w700,
                                color: Colors.white,
                              ),
                            ),
                      ),
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

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/src/widgets/basic.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:http/http.dart' as http;
import 'package:locatinsharing/Signin_Signup/signin.dart';
import 'package:locatinsharing/homepage.dart';
import 'user.dart';
import 'auth.dart';
import 'custom_textfield.dart';

class Signup extends StatefulWidget {
  const Signup({Key? key}) : super(key: key);

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final _formKey = GlobalKey<FormState>();
  // Future save() async{
  //   var res = await http.post(Uri.parse("http://10.200.8.251:8080/signup"),headers: <String,String>{'Context-Type':'application/jason;charSet=UTF-8'},
  //       body: <String,String>{
  //         'email': user.email,
  //         'password':user.password
  //       }
  //   );
  //
  //   print(res.body);
  //   Navigator.push(context, new MaterialPageRoute(builder: (context)=>Signin()));
  // }

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController numberController = TextEditingController();
  final AuthService authService = AuthService();

  void signupUser() {
    //print("in auth");
    authService.signUpUser(
      context: context,
      email: emailController.text,
      password: passwordController.text,
      name: nameController.text,
      number: numberController.text,
    );
  }

  //User user = User('', '');
  @override
  Widget build(BuildContext context) {
    // return Scaffold(
    //     body: Stack(
    //       children: [
    //         Positioned(
    //             top: 0,
    //             child: SvgPicture.asset('images/Signin.png', width: 400, height: 150)),
    //         Container(
    //           alignment: Alignment.center,
    //           child: Form(
    //             key: _formKey,
    //             child: Column(
    //               mainAxisAlignment: MainAxisAlignment.start,
    //               crossAxisAlignment: CrossAxisAlignment.center,
    //               children: [
    //                 const SizedBox(height: 150,),
    //                 Text("Signiup", style: GoogleFonts.pacifico(fontWeight: FontWeight.bold, fontSize: 50, color: Colors.blue),
    //                 ),
    //
    //                 const SizedBox(height: 20),
    //                 Container(
    //                   margin: const EdgeInsets.symmetric(horizontal: 20),
    //                   child: CustomTextField(
    //                     controller: nameController,
    //                     hintText: 'Enter your Name',
    //                   ),
    //                 ),
    //
    //                 const SizedBox(height: 20),
    //                 Container(
    //                   margin: const EdgeInsets.symmetric(horizontal: 20),
    //                   child: CustomTextField(
    //                     controller: emailController,
    //                     hintText: 'Enter your email',
    //                   ),
    //                 ),
    //
    //                 const SizedBox(height: 20),
    //                 Container(
    //                   margin: const EdgeInsets.symmetric(horizontal: 20),
    //                   child: CustomTextField(
    //                     controller: passwordController,
    //                     hintText: 'Enter your password',
    //                   ),
    //                 ),
    //
    //                 const SizedBox(height: 20),
    //                 Container(
    //                   margin: const EdgeInsets.symmetric(horizontal: 20),
    //                   child: CustomTextField(
    //                     controller: numberController,
    //                     hintText: 'Enter your mobile number',
    //                   ),
    //                 ),
    //
    //                 const SizedBox(height: 40),
    //                 ElevatedButton(
    //                   onPressed: signupUser,
    //                   style: ButtonStyle(
    //                     backgroundColor: MaterialStateProperty.all(Colors.blue),
    //                     textStyle: MaterialStateProperty.all(
    //                       const TextStyle(color: Colors.white),
    //                     ),
    //                     minimumSize: MaterialStateProperty.all(
    //                       Size(MediaQuery.of(context).size.width / 2.5, 50),
    //                     ),
    //                   ),
    //                   child: const Text(
    //                     "Signup",
    //                     style: TextStyle(color: Colors.white, fontSize: 16),
    //                   ),
    //                 ),
    //                 Padding(
    //                   padding: const EdgeInsets.fromLTRB(65, 20, 0, 0),
    //                   child: Row(
    //                     children: [
    //                       Text("Already have account ?  ", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),),
    //                       InkWell(
    //                           onTap: (){
    //                             Navigator.push(context, new MaterialPageRoute(builder: (context)=>Signin()));
    //                           },
    //                           child: Text("Signin", style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),))
    //                     ],
    //                   ),
    //                 )
    //               ],
    //             ),
    //           ),
    //         )
    //       ],
    //     )
    // );

    return Scaffold(
      body: ListView(
        children: [
          Column(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: Stack(
                  children: [
                    Positioned(
                      top: 0,
                      right: 0,
                      left: 0,
                      child: Container(
                        height: 143.0,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            // begin: Alignment.topCenter,
                            colors: [Colors.blueAccent.shade100, Colors.greenAccent.shade200],
                            begin: Alignment.bottomRight,
                            end: Alignment.topLeft,
                          ),

                          image: DecorationImage(
                            image: AssetImage(
                              "![](../../images/Logo_Icon_Transparent.png)",
                            ),
                            fit: BoxFit.fitWidth,
                          ),
                        ),

                        child: Container(
                          margin: const EdgeInsets.symmetric(
                              horizontal: 30.0, vertical: 39),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Register",
                                  style: GoogleFonts.inter(
                                      fontSize: 28,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600)),
                              const SizedBox(
                                height: 10.0,
                              ),
                              Text(
                                  "Enter your personal details to create your account",
                                  style: GoogleFonts.inter(
                                      fontSize: 12,
                                      color: Colors.white,
                                      fontWeight: FontWeight.normal)),
                            ],
                          ),
                        ),
                      ),
                    ),

                    Positioned(
                      top: 130,
                      right: 0,
                      left: 0,
                      child: Container(
                        height: 669,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(
                            Radius.circular(
                              16.0,
                            ),
                          ),
                        ),
                        child: Column(
                          children: [
                            Container(
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 30, vertical: 30),
                              child: TextFormField(
                                controller: nameController,
                                decoration: InputDecoration(
                                  labelText: 'Enter your Name',
                                  labelStyle: GoogleFonts.poppins(
                                      fontSize: 12,
                                      fontWeight: FontWeight.normal,
                                    color: Colors.grey,
                                  ),
                                  enabledBorder: const UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.blueGrey,
                                    ),
                                  ),
                                ),
                                onChanged: (value) {},
                              ),
                            ),

                            Container(
                              margin: const EdgeInsets.symmetric(
                                horizontal: 30,
                              ),
                              child: TextFormField(
                                controller: emailController,
                                keyboardType: TextInputType.emailAddress,
                                decoration: InputDecoration(
                                  labelText: 'Email Address',
                                  labelStyle: GoogleFonts.poppins(
                                      fontSize: 12,
                                      fontWeight: FontWeight.normal,
                                    color: Colors.grey,
                                  ),
                                  enabledBorder: const UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.blueGrey,
                                    ),
                                  ),
                                ),
                                onChanged: (value) {},
                              ),
                            ),

                            Container(
                              margin: const EdgeInsets.only(
                                  left: 30, right: 30, top: 30),
                              child: TextFormField(
                                controller: numberController,
                                keyboardType: TextInputType.phone,
                                decoration: InputDecoration(
                                  labelText: 'Phone Number',
                                  labelStyle: GoogleFonts.poppins(
                                      fontSize: 12,
                                      fontWeight: FontWeight.normal,
                                    color: Colors.grey,
                                  ),
                                  enabledBorder: const UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.blueGrey,
                                    ),
                                  ),
                                ),
                                onChanged: (value) {},
                              ),
                            ),

                            Container(
                              margin: const EdgeInsets.only(
                                  left: 30, right: 30, top: 30),
                              child: TextFormField(
                                controller: passwordController,
                                keyboardType: TextInputType.text,
                                obscureText: true,
                                decoration: InputDecoration(
                                  labelText: 'Password',
                                  labelStyle: GoogleFonts.poppins(
                                      fontSize: 12,
                                      fontWeight: FontWeight.normal,
                                    color: Colors.grey,
                                  ),
                                  enabledBorder: const UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.blueGrey,
                                    ),
                                  ),
                                ),
                                onChanged: (value) {},
                              ),
                            ),

                            const SizedBox(
                              height: 59.0,
                            ),

                            SizedBox(
                              width: 325,
                              height: 50,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.greenAccent,
                                  shape: RoundedRectangleBorder(
                                    borderRadius:
                                    BorderRadius.circular(50), // <-- Radius
                                  ),
                                ),
                                onPressed: () {
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                        const MyHomePage()),
                                  );
                                },

                                child: Text(
                                  "Sign Up",
                                  style: GoogleFonts.poppins(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                            ),

                            const SizedBox(
                              height: 50.0,
                            ),

                            Container(
                              height: 20,
                              width: 200,
                              decoration: const BoxDecoration(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(
                                    16.0,
                                  ),
                                ),
                              ),

                              child: Row(
                                children: [
                                  Text(
                                    "Have an account?",
                                    style: GoogleFonts.poppins(
                                        fontSize: 13,
                                        fontWeight: FontWeight.normal,
                                      color: Colors.black
                                    ),
                                  ),

                                  InkWell(
                                    onTap: () {
                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                            const Signin()),
                                      );
                                    },
                                    child: Text(
                                      " Sign In",
                                      style: GoogleFonts.poppins(
                                          fontSize: 13,
                                          color: Colors.greenAccent,
                                          fontWeight: FontWeight.normal),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

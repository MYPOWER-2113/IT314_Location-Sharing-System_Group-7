import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/src/widgets/basic.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:http/http.dart' as http;
import 'package:locatinsharing/Signin_Signup/signin.dart';
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

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final AuthService authService = AuthService();

  void signupUser() {
    //print("in auth");
    authService.signUpUser(
      context: context,
      email: emailController.text,
      password: passwordController.text,
      //name: nameController.text,
    );
  }

  //User user = User('', '');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
          children: [
            Positioned(
                top: 0,
                child: SvgPicture.asset('images/Signin.png', width: 400, height: 150)),
            Container(
              alignment: Alignment.center,
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 150,),
                    Text("Signiup", style: GoogleFonts.pacifico(fontWeight: FontWeight.bold, fontSize: 50, color: Colors.blue),
                    ),
                    const SizedBox(height: 25,),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 20),
                      child: CustomTextField(
                        controller: emailController,
                        hintText: 'Enter your email',
                      ),
                    ),

                    const SizedBox(height: 20),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 20),
                      child: CustomTextField(
                        controller: passwordController,
                        hintText: 'Enter your password',
                      ),
                    ),

                    const SizedBox(height: 40),
                    ElevatedButton(
                      onPressed: signupUser,
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
                        "Signup",
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(65, 20, 0, 0),
                      child: Row(
                        children: [
                          Text("Already have account ?  ", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),),
                          InkWell(
                              onTap: (){
                                Navigator.push(context, new MaterialPageRoute(builder: (context)=>Signin()));
                              },
                              child: Text("Signin", style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),))
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

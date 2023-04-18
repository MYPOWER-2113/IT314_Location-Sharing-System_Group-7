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
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: TextFormField(
                        controller: emailController,
                        onChanged: (String value){
                          //user.email = value;
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
                      padding: const EdgeInsets.all(16.0),
                      child: TextFormField(
                        controller: passwordController,
                        onChanged: (String value){
                          //user.password = value;
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
                        height: 50,
                        width: 400,
                        child: TextButton(
                            style: TextButton.styleFrom(
                                primary: Colors.purpleAccent,
                                backgroundColor: Colors.blue, // Background Color
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0))
                            ),
                            onPressed: (){

                              if(_formKey.currentState!.validate()){
                                signupUser;
                              }
                              else{
                                print("not ok");
                              }
                            }, child: Text("Signup", style: TextStyle(color: Colors.white),)),
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

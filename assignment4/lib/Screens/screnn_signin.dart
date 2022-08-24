import 'dart:ffi';

import 'package:assignment4/Screens/screen_home.dart';
import 'package:assignment4/Screens/screen_signup.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:assignment4/reusable/reusable.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

//Creating Functionality for sign in page

class _SignInScreenState extends State<SignInScreen> {
  TextEditingController _passwordtextConroller = TextEditingController();
  TextEditingController _emailTextController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(
                20, MediaQuery.of(context).size.height * 0.2, 20, 0),
            child: Column(children: <Widget>[
              Text("Login", style: TextStyle(fontSize: 24)),
              SizedBox(
                height: 30,
              ),
              //Using reuable Textfield
              reusableTextField("Enter Username", Icons.verified_user, false,
                  _emailTextController),
              SizedBox(
                height: 20,
              ),
              //Using reuable Textfield
              reusableTextField(
                  "Enter Password", Icons.lock, true, _passwordtextConroller),
              SizedBox(
                height: 20,
              ),
              //Using reuable Button
              loginSignUpButton(context, true, () {
                FirebaseAuth.instance
                    .signInWithEmailAndPassword(
                        email: _emailTextController.text,
                        password: _passwordtextConroller.text)
                    .then((value) {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => HomeScreem()));
                }).onError((error, stackTrace) {
                  print("Error ${error.toString()}");
                });
              }),
              signUpOption()
            ]),
          ),
        ),
      ),
    );
  }

  Row signUpOption() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("Don't have account?", style: TextStyle(color: Colors.blue)),
        GestureDetector(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => SignUpScreen()));
          },
          child: const Text(
            "Sign up",
            style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
          ),
        )
      ],
    );
  }
}

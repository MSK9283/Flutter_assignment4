import 'dart:ffi';
import 'package:assignment4/Screens/screen_home.dart';
import 'package:assignment4/Screens/screen_signup.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:assignment4/reusable/reusable.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

//Creating signup functionality

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController _passwordtextConroller = TextEditingController();
  TextEditingController _emailTextController = TextEditingController();
  TextEditingController _usernametextConroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        title: const Text(
          "Sign up",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(
          child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.fromLTRB(
              20, MediaQuery.of(context).size.height * 0.2, 20, 0),
          child: Column(
            children: <Widget>[
              Text("Sign up", style: TextStyle(fontSize: 24)),
              const SizedBox(
                height: 20,
              ),
              //Using reuable Textfield
              reusableTextField("Enter Username", Icons.person_outline_rounded,
                  false, _usernametextConroller),
              const SizedBox(
                height: 20,
              ),
              //Using reuable Textfield
              reusableTextField("Enter Email Id", Icons.person_outline_rounded,
                  false, _emailTextController),
              const SizedBox(
                height: 20,
              ),
              //Using reuable Textfield
              reusableTextField("Enter Password", Icons.lock_outline, false,
                  _passwordtextConroller),
              //Using reuable button
              loginSignUpButton(context, false, () {
                FirebaseAuth.instance
                    .createUserWithEmailAndPassword(
                        email: _emailTextController.text,
                        password: _passwordtextConroller.text)
                    .then((value) {
                  print("Created New Account");
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => HomeScreem()));
                }).onError((error, stackTrace) {
                  print("Erro ${error.toString()}");
                });
              })
            ],
          ),
        ),
      )),
    );
  }
}

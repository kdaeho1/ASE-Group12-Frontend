import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:journey_sharing_application/log-in-page.dart';
import 'package:journey_sharing_application/sign-up-page.dart';
import 'package:journey_sharing_application/source-location-map.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    // home: WelcomeScreen(),
    home: SourceMapWidget(),
  ));
}

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          // TO MAKE THE WIDTH AS BIG AS THE PARENT ALLOWS
          width: double.infinity,
          // TO MAKE THE HEIGHT AS BIG AS THE SCREEN
          height: MediaQuery.of(context).size.height,
          padding: EdgeInsets.symmetric(horizontal: 30, vertical: 50),
          child: Column(
            // SPACE BETWEEN THE ITEMS
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Column(
                children: <Widget>[
                  // HEADING
                  const Text(
                    "CS7CS3 - Group 12",
                    // CENTER THE HEADING
                    textAlign: TextAlign.center,
                    // STYLE THE HEADING
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                    ),
                  ),

                  const SizedBox(
                    height: 20,
                  ),

                  // SECOND TEXT - UNDER THE HEADING
                  Text("Welcome to Journey Sharing Application. This application has been designed for Advanced Software Engineering Group Project",
                  // CENTER THE HEADING
                  textAlign: TextAlign.center,
                  // STYLE THE HEADING
                  style: TextStyle(
                    color: Colors.grey[700],
                    fontSize: 20,
                  ),)
                ],
              ),

              // TCD LOGO IMAGE
              Container(
                height: MediaQuery.of(context).size.height / 3,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/tcd.png")
                  )
                ),
              ),

              // BUTTONS
              Column(
                children: <Widget>[
                  // A BUTTON WHICH TAKES USERS TO THE LOGIN PAGE
                  MaterialButton(
                    minWidth: double.infinity,
                    height: 60,
                    onPressed: () {
                      // CALLS LoginClass CLASS IN login.dart
                      Navigator.push(context, MaterialPageRoute(builder: (context) => LoginClass()));
                    },
                    // STYLE AND LAYOUT THE BUTTON
                    shape: RoundedRectangleBorder(
                      side: const BorderSide(
                        color: Colors.black
                      ),
                      borderRadius: BorderRadius.circular(50)
                    ),
                    child: const Text(
                      "Login",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 18
                      ),
                    ),
                  ),

                  // A BUTTON WHICH TAKES USERS TO THE SIGN UP PAGE
                  const SizedBox(height:20),
                  MaterialButton(
                    minWidth: double.infinity,
                    height: 60,
                    onPressed: (){
                      // CALLS SignupPage CLASS IN signup.dart
                      Navigator.push(context, MaterialPageRoute(builder: (context)=> SignUpClass()));
                    },
                    // STYLE AND LAYOUT THE BUTTON
                    color: const Color(0xff0095FF),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50)
                    ),
                    child: const Text(
                      "Sign up",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 18
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

// DONEEEEEE
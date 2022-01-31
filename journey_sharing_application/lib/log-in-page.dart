import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class LoginClass extends StatelessWidget {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  FocusNode myFocusNode = FocusNode();

  void getHttp() async {
    var formData = FormData.fromMap({
      // 'username': usernameController.text,
      'email': emailController.text,
      // 'gender':dropdownValue,
      'password': passwordController.text,
      // 'confirmpassword': confirmPasswordController.text,
    });
    // usernameController.text="";
    // usernameController.text="";
    Response response = await Dio().post('http://192.168.49.1:5000/login', data: formData);
    print(response.data.toString());
    myFocusNode.requestFocus();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // STYLE THE LOGIN PAGE BACKGROUND
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      // STYLE THE TOP BAR
      appBar: AppBar(
        elevation: 0,
        brightness: Brightness.light,
        backgroundColor: Colors.white,
        // BACK BUTTON IN LOGIN PAGE - NAVIGATE TO THE MAIN WELCOME PAGE
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios,
          size: 20,
          color: Colors.black,),
        ),
      ),

      body: Container(
        // TO MAKE THE HEIGHT AS BIG AS THE SCREEN
        height: MediaQuery.of(context).size.height,
        // TO MAKE THE WIDTH AS BIG AS THE PARENT ALLOWS
        width: double.infinity,
        child: Column(
          // SPACE BETWEEN THE ITEMS
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Expanded(child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    // STYLE THE HEADING IN LOGIN PAGE
                    const Text("Please Login",
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold
                      ),
                    ),

                    SizedBox(height: 20,),

                    // STYLE THE TEXT BELOW THE HEADING
                    Text("Start and share your journey by\nlogging into your account",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20,
                        color:Colors.grey[700]
                      ),
                    )
                  ],
                ),

                Padding(
                  // SPACE BEWTEEN THE TEXTS AND THE INPUT FIELDS
                  padding: EdgeInsets.symmetric(horizontal: 40),

                  // THE INPUT FILED FOR EMAIL AND PASSWORD
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.all(15),
                        child: TextField(
                          // obscureText: true,
                          controller: emailController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Email',
                            hintText: 'Enter Email',
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(15),
                        child: TextField(
                          obscureText: true,
                          controller: passwordController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Password',
                            hintText: 'Enter Password',
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                Padding(
                  // SPACE BEWTEEN THE INPUT FIELDS AND BUTTON
                  padding: EdgeInsets.symmetric(horizontal: 40),

                  // BUTTON
                  child: Container(
                    padding: EdgeInsets.only(top: 3, left: 3),

                    // STYLE THE BORDER OF THEBUTTON
                    decoration:
                      BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        border: const Border(
                          bottom: BorderSide(color: Colors.black),
                          top: BorderSide(color: Colors.black),
                          left: BorderSide(color: Colors.black),
                          right: BorderSide(color: Colors.black),
                        )
                      ),

                      // STYLE THE BUTTON
                      child: MaterialButton(
                        minWidth: double.infinity,
                        height: 60,
                        onPressed: () {
                          print(emailController.text);
                          print(passwordController.text);
                          getHttp();
                        },
                        color: Color(0xff0095FF),
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),

                        // TEXT ON THE BUTTON
                        child: const Text(
                          "Login", style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 20,
                          color: Colors.white,
                          ),
                        ),
                      ),
                  ),
                ),
                // TCD LOGO IMAGE
                Container(
                  padding: EdgeInsets.only(top: 100),
                  height: 200,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/tcd.png"),
                      fit: BoxFit.fitHeight
                    ),
                  ),
                )
              ],
            ))
          ],
        ),
      ),
    );
  }
}

// DONEEEEEEEEEE
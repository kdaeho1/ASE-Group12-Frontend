import 'package:flutter/material.dart';

class LoginClass extends StatelessWidget {
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
                    Text("Start and share your journey by logging into your account",
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
                      inputFile(label: "Email"),
                      inputFile(label: "Password", obscureText: true)
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
                          print(email);
                          print(password);
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

                // MESSAGE FOR SIGNING IN IF USER DOESN'T HAVE AN ACCOUNT
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const <Widget>[
                    Text("New to Journey Sharing Application?"),
                    Text(" Please create an account",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                      ),
                    )
                  ],
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

// VARIABLES FOR STORING THE TEXTFIELDS VALUES
String email = '';
String password = '';

// THIS IS A WIDGET FOR THE TEXT FIELD
Widget inputFile({label, obscureText = false})
{
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Text(
        label,
        style: const TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w400,
          color:Colors.black87
        ),
      ),

      const SizedBox(
        height: 5,
      ),

      TextField(
        // GET VALUES FROM TEXTFIELDS
        onChanged: (value) {
          if (label == "Email") {
            email = value;
          } else if (label == "Password") {
            password = value;
          }
        },
        obscureText: obscureText,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(vertical: 0,
          horizontal: 10),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.blue.shade300
            ),
          ),

          border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blue.shade300)
          )
        ),
      ),

      SizedBox(height: 10,)
    ],
  );
}

// DONEEEEEEEEEE
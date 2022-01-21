import 'package:flutter/material.dart';

class SignUpClass extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // STYLE THE LOGIN PAGE BACKGROUND
      resizeToAvoidBottomInset: true,
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

      // SINCE THERE ARE MANY ITEMS ON THIS PAGE, I MADE IT SCROLLABLE
      body: SingleChildScrollView(
        child: Container(
          // PADDING AT THE TOP OF THE PAGE
          padding: EdgeInsets.symmetric(horizontal: 40),

          // TO MAKE THE HEIGHT AS BIG AS THE SCREEN
          height: MediaQuery.of(context).size.height - 50,
          // TO MAKE THE WIDTH AS BIG AS THE PARENT ALLOWS
          width: double.infinity,
          // SPACE BETWEEN THE ITEMS
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Column(
                children: <Widget>[
                  // STYLE THE HEADING IN SIGN UP PAGE
                  const Text("Please Sign up",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  SizedBox(height: 20,),

                  // STYLE THE TEXT BELOW THE HEADING
                  Text("Create an account by filling the form below",
                    style: TextStyle(
                        fontSize: 20,
                        color:Colors.grey[700]
                    ),
                  )
                ],
              ),

              // THE FORM - INPUT FIELDS
              Column(
                children: <Widget>[
                  inputFile(label: "Username"),
                  inputFile(label: "Email"),
                  inputFile(label: "Password", obscureText: true),
                  inputFile(label: "Confirm Password ", obscureText: true),
                ],
              ),

              Container(
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
                  onPressed: () {},
                  color: Color(0xff0095FF),
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),

                  // TEXT ON THE BUTTON
                  child: const Text(
                    "Sign up",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),

              // MESSAGE FOR SIGNING IN IF USER DOESN'T HAVE AN ACCOUNT
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const <Widget>[
                  Text("Already a member?"),
                  Text(" Please login to your account",
                    style:TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 18
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

// DONEEEEEE
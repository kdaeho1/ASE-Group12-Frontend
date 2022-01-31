import 'package:flutter/material.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:dio/dio.dart';

class SignUpClass extends StatelessWidget {
  // String? selectedValue;
  final List<String> genderItems = [
    'Male',
    'Female',
  ];

  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  FocusNode myFocusNode = FocusNode();
  String dropdownValue = '';

  void getHttp() async {
    var formData = FormData.fromMap({
      'username': usernameController.text,
      'email': emailController.text,
      // 'gender':dropdownValue,
      'password': passwordController.text,
      // 'confirmpassword': confirmPasswordController,
    });
    usernameController.text="";
    usernameController.text="";
    Response response = await Dio().post('http://192.168.49.1:5000/register', data: formData);
    print(response.data.toString());
    myFocusNode.requestFocus();
  }

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
                    textAlign: TextAlign.center,
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
                  Padding(
                    padding: EdgeInsets.all(15),
                    child: TextField(
                      controller: usernameController,
                      focusNode: myFocusNode,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Username',
                        hintText: 'Enter Your Username',
                      ),
                    ),
                  ),
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
                  DropdownButtonFormField2(
                    decoration: InputDecoration(
                      //Add isDense true and zero Padding.
                      //Add Horizontal padding using buttonPadding and Vertical padding by increasing buttonHeight instead of add Padding here so that The whole TextField Button become clickable, and also the dropdown menu open under The whole TextField Button.
                      isDense: true,
                      contentPadding: EdgeInsets.zero,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      //Add more decoration as you want here
                      //Add label If you want but add hint outside the decoration to be aligned in the button perfectly.
                    ),
                    isExpanded: true,
                    hint: const Text(
                      'Select Your Gender',
                      style: TextStyle(fontSize: 14),
                    ),
                    icon: const Icon(
                      Icons.arrow_drop_down,
                      color: Colors.black45,
                    ),
                    iconSize: 30,
                    buttonHeight: 60,
                    buttonPadding: const EdgeInsets.only(left: 20, right: 10),
                    dropdownDecoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    items: genderItems
                        .map((item) =>
                        DropdownMenuItem<String>(
                          value: item,
                          child: Text(
                            item,
                            style: const TextStyle(
                              fontSize: 14,
                            ),
                          ),
                        ))
                        .toList(),
                    validator: (value) {
                      if (value == null) {
                        return 'Please select gender.';
                      }
                    },
                    onChanged: (value) {
                      //Do something when changing the item if you want.
                      dropdownValue  = value.toString();
                    },
                    onSaved: (value) {
                    },
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
                  Padding(
                    padding: EdgeInsets.all(15),
                    child: TextField(
                      obscureText: true,
                      controller: confirmPasswordController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Confirm Password',
                        hintText: 'Enter Password Again',
                      ),
                    ),
                  ),
                ],
              ),

              Container(
                padding: EdgeInsets.only(top: 3, left: 3),

                // STYLE THE BORDER OF THE BUTTON
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
                    print("***************");
                    print(usernameController.text);
                    print(emailController.text);
                    print(dropdownValue);
                    print(passwordController.text);
                    print(confirmPasswordController.text);
                    getHttp();
                  },
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
            ],
          ),
        ),
      ),
    );
  }
}

// DONEEEEEEEE
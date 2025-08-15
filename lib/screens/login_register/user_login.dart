import 'dart:convert';

import 'package:counter_app/components/common/custome_button.dart';
import 'package:counter_app/components/common/input.dart';
import 'package:counter_app/constants/colors.dart';
import 'package:counter_app/constants/imgReq.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserLogin extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return LoginState();
  }
}

class LoginState extends State<UserLogin> {
  final userName = TextEditingController();
  final passwd = TextEditingController();
  bool isHide = true;
  bool isReminder = false;
  Map<String, String> errors = {"nameErr": '', "passwdErr": ''};

  void handleValidation() {
    bool valid = true;
    FocusScope.of(context).unfocus();
    if (userName.text.isEmpty) {
      valid = false;
      handleErrors('Enter Your Name', 'nameErr');
    }
    if (passwd.text.isEmpty) {
      valid = false;
      handleErrors('Enter Your Password', 'passwdErr');
    }
    if (valid) {
      handleUserLogin();
    }
  }

  void handleUserLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userData = prefs.getString('user_token'); // Stored JSON data

    if (userData == null) {
      handleErrors('No user data found', 'nameErr');
      return;
    }

    // Decode JSON
    Map<String, dynamic> token = jsonDecode(userData);

    String? storedMobile = token['mobile'];
    String? storedPassword = token['passwd'];

    print(storedPassword);

    if (storedMobile == userName.text && storedPassword == passwd.text) {
      Navigator.pushReplacementNamed(context, '/dashboard');
    } else if (storedMobile != userName.text) {
      handleErrors('User Not Found', 'nameErr');
    } else if (storedPassword != passwd.text) {
      handleErrors('Invalid Password', 'passwdErr');
    } else {
      handleErrors('Something went wrong', 'generalErr');
    }
  }

  void handleErrors(error, input) {
    setState(() {
      errors[input] = error;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: WhiteColor,
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(20),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Container(
                      width: MediaQuery.of(context).size.width - 100,
                      height: MediaQuery.of(context).size.width - 100,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(imgReq['login']),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    "Login",
                    style: GoogleFonts.montserrat(
                      color: PrimaryColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 35,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    "Please Sign in to continue",
                    style: GoogleFonts.montserrat(
                      color: PrimaryColor,
                      fontWeight: FontWeight.w500,
                      fontSize: 15,
                    ),
                  ),
                  SizedBox(height: 30),
                  Input(
                    placeholder: 'Mobile Number',
                    prefixIcon: Icons.person,
                    controller: userName,
                    onChanged: (value) {
                      handleErrors('', 'nameErr');
                    },
                    errors: errors['nameErr'],
                  ),
                  SizedBox(height: 20),
                  Input(
                    controller: passwd,
                    placeholder: 'Password',
                    prefixIcon: Icons.lock,
                    suffixIcon: isHide
                        ? Icons.remove_red_eye_outlined
                        : Icons.remove_red_eye_sharp,
                    secureText: isHide,
                    onChanged: (value) {
                      handleErrors('', 'passwdErr');
                    },
                    errors: errors['passwdErr'],
                    onPressed: () {
                      setState(() {
                        isHide = !isHide;
                      });
                    },
                  ),
                  SizedBox(height: 20),
                  Row(
                    children: [
                      Checkbox(
                        activeColor: PrimaryColor,
                        value: isReminder,
                        onChanged: (val) {
                          setState(() => isReminder = val ?? false);
                        },
                      ),
                      Text(
                        "Remember me next time",
                        style: GoogleFonts.montserrat(fontSize: 14),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  CustomeButton(
                    label: 'SIGN IN',
                    onPressed: () {
                      handleValidation();
                    },
                  ),
                  SizedBox(height: 20),
                  Center(
                    child: RichText(
                      text: TextSpan(
                        text: "Don't have account ?",
                        style: GoogleFonts.montserrat(
                          fontSize: 13,
                          color: Colors.black,
                        ),
                        children: [
                          TextSpan(
                            text: ' Sign Up',
                            style: GoogleFonts.montserrat(
                              fontWeight: FontWeight.bold,
                              fontSize: 13,
                              color: Colors.black,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Navigator.pushReplacementNamed(
                                  context,
                                  '/register',
                                );
                              },
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

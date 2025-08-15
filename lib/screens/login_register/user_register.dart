import 'dart:convert';

import 'package:counter_app/components/common/custome_button.dart';
import 'package:counter_app/components/common/input.dart';
import 'package:counter_app/constants/colors.dart';
import 'package:counter_app/constants/imgReq.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserRegister extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return RegisterState();
  }
}

class RegisterState extends State<UserRegister> {
  final userName = TextEditingController();
  final passwd = TextEditingController();
  final mobile = TextEditingController();

  bool isHide = false;
  Map<String, String> errors = {
    "nameErr": '',
    "passwdErr": '',
    "mobileErr": '',
  };

  void handleValidation() {
    bool valid = true;
    FocusScope.of(context).unfocus();
    if (userName.text.isEmpty) {
      valid = false;
      handleErrors('Enter Your Name', 'nameErr');
    } else if (userName.text.trim() == '') {
      valid = false;
      handleErrors('Invalid Name', 'nameErr');
    }
    if (mobile.text.isEmpty) {
      valid = false;
      handleErrors('Enter Your Mobile Number', 'mobileErr');
    } else if (mobile.text.trim() == '') {
      valid = false;
      handleErrors('Invalid Mobile Number', 'nameErr');
    }
    if (passwd.text.isEmpty) {
      valid = false;
      handleErrors('Enter Your Password', 'passwdErr');
    } else if (passwd.text.trim() == '') {
      valid = false;
      handleErrors('Invalid Password', 'nameErr');
    }
    if (valid) {
      handleUserRegister();
    }
  }

  void handleUserRegister() async {
    final res = await SharedPreferences.getInstance();
    Map<String, String> userData = {
      "name": userName.text.trim(),
      "mobile": mobile.text.trim(),
      "passwd": passwd.text.trim(),
    };
    String jsonString = jsonEncode(userData);
    await res.setString('user_token', jsonString);
    Navigator.pushReplacementNamed(context, '/login');
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
                          image: AssetImage(imgReq['register']),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    "Register",
                    style: GoogleFonts.montserrat(
                      color: PrimaryColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 35,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    "Please register to login",
                    style: GoogleFonts.montserrat(
                      color: PrimaryColor,
                      fontWeight: FontWeight.w500,
                      fontSize: 15,
                    ),
                  ),
                  SizedBox(height: 30),
                  Input(
                    placeholder: 'Username',
                    prefixIcon: Icons.person,
                    controller: userName,
                    onChanged: (value) {
                      handleErrors('', 'nameErr');
                    },
                    errors: errors['nameErr'],
                  ),
                  SizedBox(height: 20),
                  Input(
                    placeholder: 'Mobile Number',
                    prefixIcon: Icons.phone,
                    keyboardType: TextInputType.number,
                    controller: mobile,
                    onChanged: (value) {
                      handleErrors('', 'mobileErr');
                    },
                    errors: errors['mobileErr'],
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
                  CustomeButton(
                    label: 'SIGN UP',
                    onPressed: () {
                      handleValidation();
                    },
                  ),
                  SizedBox(height: 20),
                  Center(
                    child: RichText(
                      text: TextSpan(
                        text: "Alreadt have account ?",
                        style: GoogleFonts.montserrat(
                          fontSize: 13,
                          color: Colors.black,
                        ),
                        children: [
                          TextSpan(
                            text: ' Sign In',
                            style: GoogleFonts.montserrat(
                              fontWeight: FontWeight.bold,
                              fontSize: 13,
                              color: Colors.black,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Navigator.pushReplacementNamed(
                                  context,
                                  '/login',
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

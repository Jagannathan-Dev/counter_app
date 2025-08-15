import 'package:counter_app/components/common/custome_button.dart';
import 'package:counter_app/constants/colors.dart';
import 'package:counter_app/constants/imgReq.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginIndex extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: WhiteColor,
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: MediaQuery.of(context).size.width - 100,
                height: MediaQuery.of(context).size.width - 100,
                decoration: BoxDecoration(
                  image: DecorationImage(image: AssetImage(imgReq['index'])),
                ),
              ),
            ),
            SizedBox(height: 20),
            Text(
              "Let's\nGet Startd",
              style: GoogleFonts.montserrat(
                fontWeight: FontWeight.bold,
                fontSize: 40,
              ),
            ),
            SizedBox(height: 5),
            Text(
              "Everthing Start from here",
              style: GoogleFonts.montserrat(fontWeight: FontWeight.w500),
            ),
            SizedBox(height: 25),
            CustomeButton(
              label: 'Login',
              onPressed: () {
                Navigator.pushNamed(context, '/login');
              },
            ),
            SizedBox(height: 10),
            CustomeButton(
              label: 'Register',
              isVisible: true,
              onPressed: () {
                Navigator.pushNamed(context, '/register');
              },
            ),
          ],
        ),
      ),
    );
  }
}

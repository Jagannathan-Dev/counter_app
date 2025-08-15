import 'package:counter_app/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomeButton extends StatelessWidget {
  final String label;
  final bool isVisible;
  final VoidCallback onPressed;

  const CustomeButton({
    super.key,
    required this.label,
    this.isVisible = false,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final bgColor = isVisible ? WhiteColor : PrimaryColor;
    final textColor = isVisible ? PrimaryColor : WhiteColor;
    return InkWell(
      onTap: onPressed,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        decoration: BoxDecoration(
          color: bgColor,
          border: Border.all(width: 1, color: PrimaryColor),
          borderRadius: BorderRadius.circular(100),
        ),
        alignment: Alignment.center,
        child: Text(
          label,
          style: GoogleFonts.montserrat(
            fontWeight: FontWeight.bold,
            fontSize: 18,
            color: textColor,
          ),
        ),
      ),
    );
  }
}

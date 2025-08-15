import 'package:flutter/material.dart';

class Input extends StatelessWidget {
  final String placeholder;
  final TextEditingController? controller;
  final bool secureText;
  final TextInputType keyboardType;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final Function(String)? onChanged;
  final VoidCallback? onPressed;
  final String? errors;
  final int? maxLength;

  const Input({
    super.key,
    required this.placeholder,
    this.controller,
    this.keyboardType = TextInputType.text,
    this.prefixIcon,
    this.suffixIcon,
    this.secureText = false,
    this.onChanged,
    this.onPressed,
    this.errors,
    this.maxLength,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextField(
        controller: controller,
        obscureText: secureText,
        keyboardType: keyboardType,
        onChanged: onChanged,
        maxLength: maxLength,
        textAlignVertical: TextAlignVertical.center,
        decoration: InputDecoration(
          prefixIcon: prefixIcon != null ? Icon(prefixIcon) : null,
          hintText: placeholder,
          suffixIcon: suffixIcon != null
              ? IconButton(onPressed: onPressed, icon: Icon(suffixIcon))
              : null,
          errorText: errors != '' ? errors : null,
          contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
          filled: true,
          fillColor: Color(0xfff2f2f2),
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(30),
          ),
        ),
      ),
    );
  }
}

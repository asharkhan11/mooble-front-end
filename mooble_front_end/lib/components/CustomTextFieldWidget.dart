
import 'package:flutter/material.dart';

class Customtextfieldwidget extends StatelessWidget {

  final TextEditingController textEiditingController;
  final String labelText;
  final Icon prefixIcon;
  final bool obscureText;
  const Customtextfieldwidget({super.key, required this.labelText, required this.prefixIcon, required this.textEiditingController, this.obscureText = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: TextField(
        controller: textEiditingController,
        obscureText: obscureText,
        decoration: InputDecoration(

          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0)
          ),
          
          labelText: labelText,
          
          prefixIcon: prefixIcon,
        ),
      ),
    );
  }
}
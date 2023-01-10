import 'package:flutter/material.dart';

class NonFilledFormField extends StatelessWidget {
  const NonFilledFormField({
    Key? key,
    required this.screenWidth,
    required this.controller,
    required this.labelText,
    this.obscureText = false,
    this.hintText = '',
    this.keyboardType = TextInputType.text,
  }) : super(key: key);

  final double screenWidth;
  final TextEditingController controller;
  final String labelText;
  final String hintText;
  final bool obscureText;
  final TextInputType keyboardType;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: screenWidth * 0.8,
      child: TextFormField(
        keyboardType: keyboardType,
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
          enabledBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(10.0),
            ),
            borderSide: BorderSide(
              color: Colors.black,
              width: 3.0,
              style: BorderStyle.solid,
            ),
          ),
          focusedBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(10.0),
            ),
            borderSide: BorderSide(
              color: Colors.black,
              width: 3.0,
              style: BorderStyle.solid,
            ),
          ),
          labelText: labelText,
          hintText: hintText,
          labelStyle: const TextStyle(
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}

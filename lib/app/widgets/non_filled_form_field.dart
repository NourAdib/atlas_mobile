import 'package:flutter/material.dart';

class NonFilledFormField extends StatelessWidget {
  const NonFilledFormField({
    Key? key,
    required this.screenWidth,
    required this.controller,
    required this.labelText,
    this.obscureText = false,
    this.hintText = '',
    this.height = 0,
    this.maxLine = 1,
    this.maxLength = 100,
    this.keyboardType = TextInputType.text,
    this.enabled = true,
  }) : super(key: key);

  final double screenWidth;
  final TextEditingController controller;
  final String labelText;
  final String hintText;
  final bool obscureText;
  final TextInputType keyboardType;
  final double height;
  final int maxLine;
  final int maxLength;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    return maxLine == 1
        ? SizedBox(
            width: screenWidth * 0.8,
            child: TextFormField(
              keyboardType: keyboardType,
              controller: controller,
              obscureText: obscureText,
              enabled: enabled,
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
                disabledBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10.0),
                  ),
                  borderSide: BorderSide(
                    color: Colors.black,
                    width: 3.0,
                    style: BorderStyle.solid,
                  ),
                ),
              ),
            ))
        : SizedBox(
            width: screenWidth * 0.8,
            child: TextFormField(
              keyboardType: keyboardType,
              controller: controller,
              obscureText: obscureText,
              maxLines: maxLine,
              maxLength: maxLength,
              enabled: enabled,
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
                disabledBorder: const OutlineInputBorder(
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

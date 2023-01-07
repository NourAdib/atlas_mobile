import 'package:atlas_mobile/pages/registration_or_login_screen/controller/registration_or_login_screen_controller.dart';
import 'package:flutter/material.dart';

class LargeButton extends StatelessWidget {
  const LargeButton({
    Key? key,
    required this.c,
    required this.onPressed,
    required this.color,
    required this.displayText,
    required this.displayTextColor,
  }) : super(key: key);

  final RegistrationOrLoginScreenController c;
  final Function() onPressed;
  final Color color;
  final String displayText;
  final Color displayTextColor;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        onPressed();
      },
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(
          color,
        ),
        minimumSize: MaterialStateProperty.all<Size>(
          Size(c.width * 0.7, c.height * 0.07),
        ),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
      ),
      child: Text(
        displayText,
        style: TextStyle(
          fontSize: 21,
          fontWeight: FontWeight.normal,
          color: displayTextColor,
        ),
      ),
    );
  }
}

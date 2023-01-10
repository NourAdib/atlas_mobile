import 'package:flutter/material.dart';

class PageTitle extends StatelessWidget {
  const PageTitle({
    Key? key,
    required this.screenWidth,
    required this.displayText,
  }) : super(key: key);

  final double screenWidth;
  final String displayText;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: screenWidth * 0.95,
      margin: EdgeInsets.symmetric(
        horizontal: screenWidth * 0.02,
        vertical: screenWidth * 0.03,
      ),
      padding: EdgeInsets.symmetric(
        horizontal: screenWidth * 0.05,
        vertical: screenWidth * 0.05,
      ),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: const Color(0xFFEFCB68),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        displayText,
        style: const TextStyle(
          fontSize: 17,
          fontWeight: FontWeight.w600,
          color: Colors.black,
        ),
      ),
    );
  }
}

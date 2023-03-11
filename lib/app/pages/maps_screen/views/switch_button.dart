import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CircleButton extends StatelessWidget {
  const CircleButton({
    Key? key,
    required this.onPressed,
    required this.size,
    required this.color,
    required this.borderColor,
    required this.icon,
    required this.iconSize,
    required this.iconColor,
  }) : super(key: key);

  final Function() onPressed;
  final double size;
  final Color color;
  final Color borderColor;
  final String icon;
  final double iconSize;
  final Color iconColor;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        onPressed();
      },
      style: ButtonStyle(
        shape: MaterialStateProperty.all(CircleBorder()),
        backgroundColor: MaterialStateProperty.all<Color>(
          color,
        ),
        minimumSize: MaterialStateProperty.all<Size>(
          Size(size, size),
        ),
        side: MaterialStateProperty.all<BorderSide>(
          BorderSide(
            color: borderColor,
            width: 2,
          ),
        ),
      ),
      child: SvgPicture.asset(
        icon,
        color: iconColor,
        width: iconSize,
        height: iconSize,
      ),
    );
  }
}

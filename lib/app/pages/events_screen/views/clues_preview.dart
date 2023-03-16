import 'dart:developer';

import 'package:atlas_mobile/app/model/event_clue.model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CluesPreview extends StatelessWidget {
  final EventClue eventClue;
  final double height;

  const CluesPreview({
    required this.eventClue,
    required this.height,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Get.defaultDialog(
        title: 'Clue Details',
        content: Text(eventClue.text ?? ''),
        confirm: ElevatedButton(
          onPressed: () => Get.back(),
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(
              const Color(0xFF182335),
            ),
            minimumSize: MaterialStateProperty.all<Size>(
              Size(Get.width * 0.46, Get.height * 0.07),
            ),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
          ),
          child: const Icon(
            Icons.check,
            color: Colors.white,
          ),
        ),
      ),
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
        decoration: BoxDecoration(
          color: const Color(0xFFFFF6E9),
          border: Border.all(
            color: const Color(0xFF182335),
            width: 3,
            style: BorderStyle.solid,
          ),
          borderRadius: BorderRadius.circular(10),
          boxShadow: const [
            BoxShadow(
              color: Color.fromRGBO(0, 0, 0, 0.25),
              blurRadius: 4,
              offset: Offset(0, 4), // changes position of shadow
            )
          ],
        ),
        child: Container(
          alignment: Alignment.center,
          child: Text(eventClue.text ?? ''),
        ),
      ),
    );
  }
}

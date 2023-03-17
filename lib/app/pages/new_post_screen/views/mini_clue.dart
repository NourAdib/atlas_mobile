import 'package:atlas_mobile/app/services/event/event.service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/new_post_controller.dart';

class MiniCluePreview extends StatelessWidget {
  final ClueDto clue;
  final double height;
  MiniCluePreview({required this.clue, required this.height, super.key});

  final NewPostController c = Get.find<NewPostController>();

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => c.openCluePreviewDialog(clue),
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
          child: Text(clue.text ?? ''),
        ),
      ),
    );
  }
}

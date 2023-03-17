import 'package:atlas_mobile/app/model/memory.model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';

import '../../home_screen/views/post_image.dart';
import '../controller/profile_screen_controller.dart';

class MemoryPreview extends StatelessWidget {
  final Memory memory;
  MemoryPreview({
    required this.memory,
    Key? key,
  }) : super(key: key);

  final ProfileScreenController c = Get.find<ProfileScreenController>();

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        c.openMemoryDetails(memory);
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 5),
        decoration: BoxDecoration(
          color: const Color(0xFFFFF6E9),
          border: Border.all(
            color: const Color(0xFF182335),
            width: 3,
            style: BorderStyle.solid,
          ),
          borderRadius: BorderRadius.circular(15),
          boxShadow: const [
            BoxShadow(
              color: Color.fromRGBO(0, 0, 0, 0.25),
              blurRadius: 4,
              offset: Offset(0, 4), // changes position of shadow
            )
          ],
        ),
        child: PostImage(
          imageUrl: memory.imageUrl!,
          caption: '',
          height: c.height,
        ),
      ),
    );
  }
}

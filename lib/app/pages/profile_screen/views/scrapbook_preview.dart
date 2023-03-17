import 'package:atlas_mobile/app/model/scrapbook.model.dart';
import 'package:atlas_mobile/app/pages/profile_screen/views/scrapbook_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/profile_screen_controller.dart';
import 'post_image.dart';

class ScrapbookPreview extends StatelessWidget {
  final Scrapbook scrapbook;
  ScrapbookPreview({
    required this.scrapbook,
    Key? key,
  }) : super(key: key);

  final ProfileScreenController c = Get.find<ProfileScreenController>();

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        c.openScrapbookDetails(scrapbook.id!);
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
        child: ScrapbookImage(
          imageUrl: scrapbook.posts!.isEmpty
              ? ''
              : c.getScrapbookThumbnail(scrapbook.posts ?? []),
          caption: scrapbook.caption!,
          height: c.height,
        ),
      ),
    );
  }
}

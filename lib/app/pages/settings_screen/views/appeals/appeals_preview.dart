import 'package:atlas_mobile/app/model/appeal.model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../controller/appeals_controller.dart';

class AppealPreview extends StatelessWidget {
  final Appeal appeal;
  AppealPreview({required this.appeal, super.key});

  final AppealsController c = Get.find<AppealsController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
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
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Filed on: ${c.getParsedDate(appeal.createdAt!)}',
                style: const TextStyle(
                  fontSize: 14,
                ),
              ),
              Text(
                appeal.status.toString().capitalizeFirst ?? '',
                style: TextStyle(
                  fontSize: 18,
                  color: appeal.status.toString() == 'pending review'
                      ? const Color(0xFFE6A800)
                      : appeal.status.toString() == 'accepted'
                          ? const Color(0xFF00BFA6)
                          : const Color(0xFFE93445),
                ),
              ),
            ],
          ),
          SvgPicture.asset('assets/images/right_arrow_icon.svg')
        ],
      ),
    );
  }
}

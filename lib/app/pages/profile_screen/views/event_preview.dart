import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../model/event.model.dart';
import '../controller/profile_screen_controller.dart';

class EventPreview extends StatelessWidget {
  final Event event;
  EventPreview({
    required this.event,
    Key? key,
  }) : super(key: key);

  final ProfileScreenController c = Get.find<ProfileScreenController>();

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => c.openEventDetails(event),
      child: Container(
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
            Text(
              event.name ?? '',
              style: const TextStyle(
                fontSize: 18,
              ),
            ),
            SvgPicture.asset('assets/images/right_arrow_icon.svg')
          ],
        ),
      ),
    );
  }
}

import 'package:atlas_mobile/app/model/follow_request.model.dart';
import 'package:atlas_mobile/app/pages/settings_screen/controller/follow_requests_controller.dart';
import 'package:atlas_mobile/app/widgets/user_avatar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class FollowRequestWidget extends StatelessWidget {
  final FollowRequest request;
  FollowRequestWidget({super.key, required this.request});

  final FollowRequestsController c = Get.find<FollowRequestsController>();

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
          Row(
            children: [
              UserAvatar(
                height: c.height * 0.05,
                width: c.height * 0.05,
                profilePictureUrl: request.requestedBy?.profilePictureUrl ?? '',
                minRadius: 20,
              ),
              const SizedBox(
                width: 10,
              ),
              Text(
                request.requestedBy?.username ?? '',
                style: const TextStyle(
                  fontSize: 18,
                ),
              ),
            ],
          ),
          request.status == 'pending'
              ? Row(
                  children: [
                    ElevatedButton(
                      onPressed: () async {
                        await c.rejectFollowRequest(request.id ?? '');
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                          const Color(0xFF182335),
                        ),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                      ),
                      child: const Icon(
                        Icons.cancel_outlined,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(width: c.width * 0.03),
                    ElevatedButton(
                      onPressed: () async {
                        await c.acceptFollowRequest(request.id ?? '');
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                          const Color(0xFFEFCB68),
                        ),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                      ),
                      child: const Icon(
                        Icons.check,
                        color: Colors.black,
                      ),
                    ),
                  ],
                )
              : Container(
                  padding: const EdgeInsets.all(10),
                  margin:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                  decoration: BoxDecoration(
                    color: request.status == 'accepted'
                        ? const Color(0xFFEFCB68)
                        : const Color(0xFF182335),
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: const [
                      BoxShadow(
                        color: Color.fromRGBO(0, 0, 0, 0.25),
                        blurRadius: 4,
                        offset: Offset(0, 4), // changes position of shadow
                      )
                    ],
                  ),
                  child: Text(
                    request.status?.capitalizeFirst ?? '',
                    style: TextStyle(
                      fontSize: 18,
                      color: request.status == 'accepted'
                          ? Colors.black
                          : Colors.white,
                    ),
                  ),
                ),
        ],
      ),
    );
  }
}

import 'package:atlas_mobile/app/widgets/event_details/event_details_controller.dart';
import 'package:atlas_mobile/app/widgets/loading_indicator.dart';
import 'package:atlas_mobile/app/widgets/non_filled_form_field.dart';
import 'package:atlas_mobile/app/widgets/topBar/topbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../main/controller/navigation_controller.dart';
import '../../model/event.model.dart';
import '../navbar.dart';

class EventDetailsScreen extends StatelessWidget {
  final Event event;

  const EventDetailsScreen({Key? key, required this.event}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final EventDetailsScreenController c =
        Get.put(EventDetailsScreenController());

    c.setEvent(event);
    c.getUserProfile();
    return Scaffold(
      appBar: const TopBar(
        pageTile: "Event",
        hasBackButton: true,
      ),
      bottomNavigationBar: Obx(() => Container(
            margin: EdgeInsets.symmetric(
              horizontal: c.width * 0.02,
              vertical: c.width * 0.03,
            ),
            child: c.isLoading.value
                ? null
                : ElevatedButton(
                    onPressed: () {
                      if (c.isOwner.value) {
                        Get.defaultDialog(
                            title: 'Delete Event',
                            middleText:
                                'Are you sure you want to delete this event?',
                            textConfirm: 'Yes',
                            textCancel: 'No',
                            confirmTextColor: const Color(0xFFFFFFFF),
                            cancelTextColor: const Color(0xFF182335),
                            buttonColor: const Color(0xFFEF694D),
                            onConfirm: () {
                              c.deleteEvent(event.id!);
                              Get.back();
                            });
                      } else if (!c.isOwner.value &&
                          !c.joined.value &&
                          !c.full.value) {
                        Get.defaultDialog(
                            title: 'Join Event',
                            middleText:
                                'Are you sure you want to join this event?',
                            textConfirm: 'Yes',
                            textCancel: 'No',
                            confirmTextColor: const Color(0xFFFFFFFF),
                            cancelTextColor: const Color(0xFF182335),
                            buttonColor: const Color(0xFFEF694D),
                            onConfirm: () {
                              c.joinEvent(event.id!);
                            });
                      } else if (c.joined.value) {
                        Get.defaultDialog(
                            title: 'Join Event',
                            middleText: 'You have already joined this event',
                            textConfirm: 'Ok',
                            confirmTextColor: const Color(0xFFFFFFFF),
                            buttonColor: const Color(0xFFEF694D),
                            onConfirm: () {
                              Get.back();
                            });
                      }
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                        const Color(0xFFEF694D),
                      ),
                      minimumSize: MaterialStateProperty.all<Size>(
                        Size(c.width * 0.46, c.height * 0.07),
                      ),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                    ),
                    child: c.isOwner.value
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                                SvgPicture.asset(
                                    "assets/images/trash_delete_icon.svg"),
                                SizedBox(width: c.width * 0.02),
                                const Text(
                                  "Delete",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20,
                                  ),
                                )
                              ])
                        : c.joined.value
                            ? Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                    const Icon(Icons.lock, color: Colors.black),
                                    SizedBox(width: c.width * 0.02),
                                    const Text(
                                      "Joined",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 20,
                                      ),
                                    )
                                  ])
                            : c.full.value
                                ? Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                        const Icon(Icons.lock,
                                            color: Colors.black),
                                        SizedBox(width: c.width * 0.02),
                                        const Text(
                                          "Event is Full",
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 20,
                                          ),
                                        )
                                      ])
                                : const Text(
                                    "Join",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 20,
                                    ),
                                  ),
                  ),
          )),
      body: SafeArea(
        child: Obx(
          (() => Center(
                child: c.isLoading.value
                    ? const LoadingIndicator()
                    : Column(
                        children: [
                          SizedBox(height: c.height * 0.05),
                          NonFilledFormField(
                            screenWidth: c.width,
                            controller: c.nameController,
                            labelText: "Event Name",
                            enabled: false,
                          ),
                          SizedBox(height: c.height * 0.05),
                          NonFilledFormField(
                            screenWidth: c.width,
                            controller: c.descriptionController,
                            labelText: "Description",
                            maxLength: 200,
                            maxLine: 4,
                            enabled: false,
                          ),
                          SizedBox(height: c.height * 0.025),
                          NonFilledFormField(
                            screenWidth: c.width,
                            controller: c.dateController,
                            labelText: "Date",
                            enabled: false,
                          ),
                          SizedBox(height: c.height * 0.05),
                          NonFilledFormField(
                            screenWidth: c.width,
                            controller: c.visibilityController,
                            labelText: "Visibility",
                            enabled: false,
                          ),
                        ],
                      ),
              )),
        ),
      ),
    );
  }
}

import 'package:atlas_mobile/app/widgets/navbar.dart';
import 'package:atlas_mobile/app/widgets/topBar/topbar.dart';
import 'package:atlas_mobile/main/controller/navigation_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../model/event.model.dart';
import '../controller/event_details_contoller.dart';

class EventDetailsScreen extends StatelessWidget {
  final Event event;
  EventDetailsScreen({
    required this.event,
    Key? key,
  }) : super(key: key);

  final NavigationController navigationController =
      Get.find<NavigationController>();

  final EventDetailsController c = Get.put(EventDetailsController());

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      c.setEvent(event);
      c.getUserProfile();
    });

    return Scaffold(
        bottomNavigationBar: Obx(
          () => Navbar(
            currentIndex: navigationController.selectedIndex.value,
            onItemTap: navigationController.onItemTap,
          ),
        ),
        appBar: const TopBar(
          pageTile: 'Event',
          hasBackButton: true,
        ),
        body: Obx(
          () => SafeArea(
            child: SizedBox(
                width: Get.width,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 10,
                          ),
                          SizedBox(
                            width: c.width * 0.8,
                            child: TextFormField(
                              readOnly: true,
                              decoration: InputDecoration(
                                enabledBorder: const OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10.0),
                                  ),
                                  borderSide: BorderSide(
                                    color: Colors.black,
                                    width: 3.0,
                                    style: BorderStyle.solid,
                                  ),
                                ),
                                focusedBorder: const OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10.0),
                                  ),
                                  borderSide: BorderSide(
                                    color: Colors.black,
                                    width: 3.0,
                                    style: BorderStyle.solid,
                                  ),
                                ),
                                labelText: "Event Name",
                                hintText: event.name ?? '',
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.always,
                                labelStyle: const TextStyle(
                                  color: Colors.black,
                                ),
                                hintStyle: const TextStyle(
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          SizedBox(
                            width: c.width * 0.8,
                            child: TextFormField(
                              readOnly: true,
                              decoration: InputDecoration(
                                enabledBorder: const OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10.0),
                                  ),
                                  borderSide: BorderSide(
                                    color: Colors.black,
                                    width: 3.0,
                                    style: BorderStyle.solid,
                                  ),
                                ),
                                focusedBorder: const OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10.0),
                                  ),
                                  borderSide: BorderSide(
                                    color: Colors.black,
                                    width: 3.0,
                                    style: BorderStyle.solid,
                                  ),
                                ),
                                labelText: "Event Description",
                                hintText: event.description ?? '',
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.always,
                                labelStyle: const TextStyle(
                                  color: Colors.black,
                                ),
                                hintStyle: const TextStyle(
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          SizedBox(
                            width: c.width * 0.8,
                            child: TextFormField(
                              readOnly: true,
                              decoration: InputDecoration(
                                enabledBorder: const OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10.0),
                                  ),
                                  borderSide: BorderSide(
                                    color: Colors.black,
                                    width: 3.0,
                                    style: BorderStyle.solid,
                                  ),
                                ),
                                focusedBorder: const OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10.0),
                                  ),
                                  borderSide: BorderSide(
                                    color: Colors.black,
                                    width: 3.0,
                                    style: BorderStyle.solid,
                                  ),
                                ),
                                labelText: "Number of Participants",
                                hintText:
                                    ' ${event.participants?.length}/${event.numberOfParticipants}',
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.always,
                                labelStyle: const TextStyle(
                                  color: Colors.black,
                                ),
                                hintStyle: const TextStyle(
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          SizedBox(
                            width: c.width * 0.8,
                            child: TextFormField(
                              readOnly: true,
                              decoration: InputDecoration(
                                enabledBorder: const OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10.0),
                                  ),
                                  borderSide: BorderSide(
                                    color: Colors.black,
                                    width: 3.0,
                                    style: BorderStyle.solid,
                                  ),
                                ),
                                focusedBorder: const OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10.0),
                                  ),
                                  borderSide: BorderSide(
                                    color: Colors.black,
                                    width: 3.0,
                                    style: BorderStyle.solid,
                                  ),
                                ),
                                labelText: "Event Date",
                                hintText: c.getParsedDate(event.date!),
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.always,
                                labelStyle: const TextStyle(
                                  color: Colors.black,
                                ),
                                hintStyle: const TextStyle(
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          SizedBox(
                            width: c.width * 0.8,
                            child: TextFormField(
                              readOnly: true,
                              decoration: InputDecoration(
                                enabledBorder: const OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10.0),
                                  ),
                                  borderSide: BorderSide(
                                    color: Colors.black,
                                    width: 3.0,
                                    style: BorderStyle.solid,
                                  ),
                                ),
                                focusedBorder: const OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10.0),
                                  ),
                                  borderSide: BorderSide(
                                    color: Colors.black,
                                    width: 3.0,
                                    style: BorderStyle.solid,
                                  ),
                                ),
                                labelText: "Hosted by",
                                hintText: event.creator?.username ?? '',
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.always,
                                labelStyle: const TextStyle(
                                  color: Colors.black,
                                ),
                                hintStyle: const TextStyle(
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          c.isOwner.value
                              ? InkWell(
                                  onTap: () {
                                    c.goToCluesPage();
                                  },
                                  child: Container(
                                    margin: EdgeInsets.symmetric(
                                      horizontal: 7,
                                      vertical: c.width * 0.05,
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        const Text(
                                          'Clues',
                                          style: TextStyle(
                                            color: Color(0xFFEF694D),
                                            fontSize: 16,
                                          ),
                                        ),
                                        SizedBox(width: c.width * 0.02),
                                        SvgPicture.asset(
                                          'assets/images/right_arrow_icon.svg',
                                          color: const Color(0xFFEF694D),
                                          height: 10,
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                              : const SizedBox(),
                          c.isOwner.value
                              ? InkWell(
                                  onTap: () {
                                    c.goToGoalPage();
                                  },
                                  child: Container(
                                    margin: EdgeInsets.symmetric(
                                      horizontal: 7,
                                      vertical: c.width * 0.05,
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        const Text(
                                          'Goal',
                                          style: TextStyle(
                                            color: Color(0xFFEF694D),
                                            fontSize: 16,
                                          ),
                                        ),
                                        SizedBox(width: c.width * 0.02),
                                        SvgPicture.asset(
                                          'assets/images/right_arrow_icon.svg',
                                          color: const Color(0xFFEF694D),
                                          height: 10,
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                              : const SizedBox(),
                        ],
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(
                          horizontal: 7,
                        ),
                        child: ElevatedButton(
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
                                    c.deleteEvent();
                                  });
                            } else if (!c.isOwner.value &&
                                !c.hasJoined.value &&
                                !c.isFull.value) {
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
                                    c.joinEvent();
                                  });
                            } else if (c.hasJoined.value) {
                              Get.defaultDialog(
                                  title: 'Join Event',
                                  middleText:
                                      'You have already joined this event',
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
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
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
                              : c.hasJoined.value
                                  ? Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                          const Icon(Icons.lock,
                                              color: Colors.black),
                                          SizedBox(width: c.width * 0.02),
                                          const Text(
                                            "Joined",
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 20,
                                            ),
                                          )
                                        ])
                                  : c.isFull.value
                                      ? Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
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
                      ),
                    ])),
          ),
        ));
  }
}

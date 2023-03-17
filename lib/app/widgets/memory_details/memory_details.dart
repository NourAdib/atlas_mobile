import 'package:atlas_mobile/app/model/memory.model.dart';
import 'package:atlas_mobile/app/widgets/loading_indicator.dart';
import 'package:atlas_mobile/app/widgets/navbar.dart';
import 'package:atlas_mobile/app/widgets/topBar/topbar.dart';
import 'package:atlas_mobile/app/widgets/user_avatar.dart';
import 'package:atlas_mobile/main/controller/navigation_controller.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../circle_button.dart';
import 'memory_details_controller.dart';

class MemoryDetailsScreen extends StatelessWidget {
  final Memory memory;

  const MemoryDetailsScreen({Key? key, required this.memory}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final MemoryDetailsScreenController c =
        Get.put(MemoryDetailsScreenController());

    final NavigationController navigationController =
        Get.put(NavigationController());

    c.setMemory(memory);

    return Scaffold(
        appBar: const TopBar(
          pageTile: 'Memory',
          hasBackButton: true,
        ),
        bottomNavigationBar: Obx(() => Navbar(
              currentIndex: navigationController.selectedIndex.value,
              onItemTap: navigationController.onItemTap,
            )),
        body: SafeArea(
            child: Obx(
          () => Container(
            margin: const EdgeInsets.symmetric(horizontal: 7),
            child: Stack(children: [
              ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: CachedNetworkImage(
                    fit: BoxFit.cover,
                    height: c.height,
                    width: c.width,
                    imageUrl: memory.imageUrl!,
                    fadeInDuration: const Duration(milliseconds: 0),
                    placeholder: (context, url) => const LoadingIndicator(),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  )),
              Positioned(
                  left: 5,
                  top: 5,
                  child: Container(
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          color: const Color(0xFFEFCB68),
                          border: Border.all(
                              color: const Color(0xFF182335), width: 2),
                          borderRadius: BorderRadius.circular(10)),
                      child: Row(
                        children: [
                          UserAvatar(
                              profilePictureUrl:
                                  memory.user?.profilePictureUrl ?? '',
                              width: c.width * 0.05,
                              height: c.height * 0.05),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(memory.user!.username!),
                        ],
                      ))),
              Positioned(
                right: 5,
                bottom: 10,
                child: c.isOwner.value
                    ? CircleButton(
                        onPressed: () {
                          Get.defaultDialog(
                              title: 'Delete Memory',
                              middleText:
                                  'Are you sure you want to delete this memory?',
                              textConfirm: 'Yes',
                              textCancel: 'No',
                              confirmTextColor: const Color(0xFFFFFFFF),
                              cancelTextColor: const Color(0xFF182335),
                              buttonColor: const Color(0xFFEF694D),
                              onConfirm: () {
                                c.deleteMemory(memory.id!);
                              });
                        },
                        size: 60.0,
                        color: const Color(0xFFEF694D),
                        borderColor: const Color(0xFF182335),
                        icon: "assets/images/trash_delete_icon.svg",
                        iconSize: 40,
                        iconColor: const Color(0xFF182335),
                      )
                    : Container(),
              )
            ]),
          ),
        )));
  }
}

import 'package:atlas_mobile/app/widgets/loading_indicator.dart';
import 'package:atlas_mobile/app/widgets/navbar.dart';
import 'package:atlas_mobile/app/widgets/topBar/topbar.dart';
import 'package:atlas_mobile/main/controller/navigation_controller.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../maps_screen/views/switch_button.dart';
import '../controller/memory_screen_controller.dart';

class MemoryScreen extends StatelessWidget {
  const MemoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final MemoryScreenController c = Get.put(MemoryScreenController());
    final NavigationController navigationController =
        Get.put(NavigationController());
    return Scaffold(
        appBar: const TopBar(pageTile: 'Memory'),
        bottomNavigationBar: Obx(() => Navbar(
            currentIndex: navigationController.selectedIndex.value,
            onItemTap: navigationController.onItemTap)),
        body: SafeArea(
            child: Obx(
          (() => Center(
                child: c.isLoading.value
                    ? const LoadingIndicator()
                    : Container(
                        margin: const EdgeInsets.symmetric(horizontal: 7),
                        child: Stack(children: [
                          ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: CachedNetworkImage(
                                imageUrl: c.memory.value.imageUrl!,
                                fadeInDuration: const Duration(milliseconds: 0),
                                placeholder: (context, url) =>
                                    const LoadingIndicator(),
                                errorWidget: (context, url, error) =>
                                    const Icon(Icons.error),
                              )),
                          Positioned(
                            right: 5,
                            bottom: 10,
                            child: CircleButton(
                              onPressed: () {
                                c.deleteMemory(c.memory.value.id!);
                              },
                              size: 60.0,
                              color: const Color(0xFFEF694D),
                              borderColor: const Color(0xFF182335),
                              icon: "assets/images/trash_delete_icon.svg",
                              iconSize: 40,
                              iconColor: const Color(0xFF182335),
                            ),
                          )
                        ]),
                      ),
              )),
        )));
  }
}

import 'package:atlas_mobile/app/pages/maps_screen/controller/ar_screen_controller.dart';
import 'package:atlas_mobile/app/widgets/circle_button.dart';
import 'package:atlas_mobile/app/widgets/loading_indicator.dart';
import 'package:atlas_mobile/app/widgets/navbar.dart';
import 'package:atlas_mobile/app/widgets/topBar/topbar.dart';
import 'package:atlas_mobile/main/controller/navigation_controller.dart';
import 'package:ar_flutter_plugin/ar_flutter_plugin.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ArScreen extends StatefulWidget {
  const ArScreen({Key? key}) : super(key: key);

  @override
  State<ArScreen> createState() => _ArScreen();
}

class _ArScreen extends State<ArScreen> {
  @override
  Widget build(BuildContext context) {
    var isLoading = false.obs;
    final ArScreenController c = Get.put(ArScreenController());
    final NavigationController navigationController =
        Get.find<NavigationController>();

    c.getMemories(isLoading);
    return Scaffold(
      appBar: const TopBar(
        pageTile: 'AR',
      ),
      bottomNavigationBar: Obx(
        () => Navbar(
          currentIndex: navigationController.selectedIndex.value,
          onItemTap: navigationController.onItemTap,
        ),
      ),
      body: SafeArea(
        child: Obx(
          (() => Center(
                child: isLoading.value
                    ? const LoadingIndicator()
                    : Container(
                        margin: const EdgeInsets.symmetric(horizontal: 7),
                        child: Stack(children: [
                          ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child:
                                  ARView(onARViewCreated: c.onARViewCreated)),
                          Positioned(
                            right: 5,
                            bottom: 10,
                            child: CircleButton(
                              onPressed: () {
                                Get.toNamed('/maps');
                                c.exitAR();
                              },
                              size: 60.0,
                              color: const Color(0xFFEFCB68),
                              borderColor: const Color(0xFF182335),
                              icon: "assets/images/map_search_icon.svg",
                              iconSize: 40,
                              iconColor: const Color(0xFF182335),
                            ),
                          )
                        ]),
                      ),
              )),
        ),
      ),
    );
  }
}

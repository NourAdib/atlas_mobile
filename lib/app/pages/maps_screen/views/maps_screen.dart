import 'package:atlas_mobile/app/pages/maps_screen/controller/maps_screen_controller.dart';
import 'package:atlas_mobile/app/widgets/circle_button.dart';
import 'package:atlas_mobile/app/widgets/loading_indicator.dart';
import 'package:atlas_mobile/app/widgets/navbar.dart';
import 'package:atlas_mobile/app/widgets/topBar/topbar.dart';
import 'package:atlas_mobile/main/controller/navigation_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';

class MapsScreenScreen extends StatelessWidget {
  const MapsScreenScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var isLoading = false.obs;
    final NavigationController navigationController =
        Get.find<NavigationController>();

    final MapsScreenController c = Get.put(MapsScreenController());

    c.getMemories(isLoading);
    return Scaffold(
      appBar: const TopBar(
        pageTile: 'Map',
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
                      child: Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: FlutterMap(
                              options: MapOptions(
                                center: LatLng(c.currentPosition!.latitude,
                                    c.currentPosition!.longitude),
                                zoom: 18,
                                interactiveFlags: InteractiveFlag.all -
                                    InteractiveFlag.rotate -
                                    InteractiveFlag.pinchZoom,
                              ),
                              children: [
                                TileLayer(
                                  urlTemplate:
                                      'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                                  userAgentPackageName:
                                      'dev.fleaflet.flutter_map.example',
                                  additionalOptions: const {"name": "en"},
                                ),
                                MarkerLayer(markers: c.markers)
                              ],
                            ),
                          ),
                          Positioned(
                            right: 5,
                            bottom: 10,
                            child: CircleButton(
                                onPressed: () {
                                  Get.toNamed('/ar');
                                },
                                size: 60.0,
                                color: const Color(0xFFEFCB68),
                                borderColor: const Color(0xFF182335),
                                icon: "assets/images/camera_icon.svg",
                                iconSize: 40,
                                iconColor: const Color(0xFF182335)),
                          )
                        ],
                      ),
                    ),
            )),
      )),
    );
  }
}

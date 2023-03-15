import 'package:atlas_mobile/app/pages/maps_screen/controller/maps_screen_controller.dart';
import 'package:atlas_mobile/app/widgets/circle_button.dart';
import 'package:atlas_mobile/app/widgets/loading_indicator.dart';
import 'package:atlas_mobile/app/widgets/navbar.dart';
import 'package:atlas_mobile/app/widgets/topBar/topbar.dart';
import 'package:atlas_mobile/main/controller/navigation_controller.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_marker_popup/flutter_map_marker_popup.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';

import '../../../widgets/map_popup.dart';

class MapsScreen extends StatefulWidget {
  const MapsScreen({Key? key}) : super(key: key);

  @override
  State<MapsScreen> createState() => _MapsScreen();
}

class _MapsScreen extends State<MapsScreen> {
  @override
  Widget build(BuildContext context) {
    var isLoading = false.obs;

    final NavigationController navigationController =
        Get.find<NavigationController>();

    final MapsScreenController c = Get.put(MapsScreenController());

    c.startUp(isLoading);
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
                                  center: c.currentPosition.value,
                                  zoom: 18,
                                  interactiveFlags: InteractiveFlag.all -
                                      InteractiveFlag.rotate -
                                      InteractiveFlag.doubleTapZoom,
                                  onTap: (_, __) =>
                                      c.popupLayerController.hideAllPopups()),
                              children: [
                                TileLayer(
                                  urlTemplate:
                                      'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                                  subdomains: const ['a', 'b', 'c'],
                                  maxZoom: 20,
                                  maxNativeZoom: 19,
                                ),
                                MarkerLayer(
                                  markers: c.currentMarker.value,
                                ),
                                PopupMarkerLayerWidget(
                                  options: PopupMarkerLayerOptions(
                                      popupController: c.popupLayerController,
                                      markers: c.markers.value,
                                      markerRotateAlignment:
                                          PopupMarkerLayerOptions
                                              .rotationAlignmentFor(
                                                  AnchorAlign.top),
                                      popupBuilder: (_, Marker marker) {
                                        if (c.selectedValue.value ==
                                            'memories') {
                                          return MemoryMarkerPopup(
                                              memory: c.data.value[c
                                                  .markers.value
                                                  .indexOf(marker)]);
                                        } else if (c.selectedValue.value ==
                                            'clues') {
                                          return ClueMarkerPopup(
                                              clue: c.data.value[c.markers.value
                                                  .indexOf(marker)]);
                                        } else {
                                          return EventMarkerPopup(
                                              event: c.data.value[c
                                                  .markers.value
                                                  .indexOf(marker)]);
                                        }
                                      }),
                                )
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
                          ),
                          Positioned(
                            left: 5,
                            top: 10,
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton2<String>(
                                value: c.selectedValue.value,
                                items: c.dropdownMenuItems,
                                dropdownStyleData: const DropdownStyleData(
                                  width: 120,
                                ),
                                customButton: Container(
                                  padding: const EdgeInsets.only(
                                      left: 10, right: 5, top: 5, bottom: 5),
                                  decoration: BoxDecoration(
                                      color: const Color(0xFF182335),
                                      borderRadius: BorderRadius.circular(7)),
                                  child: Row(
                                    children: [
                                      Text(
                                        c.selectedValue.value.capitalizeFirst!,
                                        style: const TextStyle(
                                            color: Colors.white, fontSize: 18),
                                      ),
                                      const Icon(
                                        Icons.arrow_drop_down,
                                        color: Colors.white,
                                      )
                                    ],
                                  ),
                                ),
                                onChanged: (String? value) {
                                  if (c.selectedValue.value != value) {
                                    c.selectedValue.value = value!;
                                    c.startUp(isLoading);
                                  }
                                },
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
            )),
      )),
    );
  }
}

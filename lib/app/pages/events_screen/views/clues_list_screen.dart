import 'package:atlas_mobile/app/pages/events_screen/controller/event_details_contoller.dart';
import 'package:atlas_mobile/app/widgets/loading_indicator.dart';
import 'package:atlas_mobile/app/widgets/navbar.dart';
import 'package:atlas_mobile/app/widgets/topBar/topbar.dart';
import 'package:atlas_mobile/main/controller/navigation_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'clues_preview.dart';

class CluesListScreen extends StatelessWidget {
  CluesListScreen({super.key});

  final NavigationController navigationController =
      Get.put(NavigationController());

  final EventDetailsController c = Get.put(EventDetailsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TopBar(
        pageTile: 'Clues',
        hasBackButton: true,
      ),
      bottomNavigationBar: Obx(
        () => Navbar(
          currentIndex: navigationController.selectedIndex.value,
          onItemTap: navigationController.onItemTap,
        ),
      ),
      body: SafeArea(
          child: Obx(
        () => c.isLoading.value
            ? const LoadingIndicator()
            : Column(
                children: [
                  Expanded(
                    child: GridView.builder(
                      itemCount: c.cluesList.length,
                      controller: c.cluesScrollController,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: 2,
                        mainAxisSpacing: 2,
                      ),
                      padding: const EdgeInsets.all(10),
                      itemBuilder: ((context, index) {
                        return CluesPreview(
                          eventClue: c.cluesList[index],
                          height: c.height,
                        );
                      }),
                    ),
                  ),
                  SizedBox(
                    height: c.height * 0.05,
                  ),
                ],
              ),
      )),
    );
  }
}

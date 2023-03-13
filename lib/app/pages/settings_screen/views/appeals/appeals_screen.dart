import 'package:atlas_mobile/app/pages/settings_screen/controller/appeals_controller.dart';
import 'package:atlas_mobile/app/widgets/loading_indicator.dart';
import 'package:atlas_mobile/app/widgets/navbar.dart';
import 'package:atlas_mobile/app/widgets/topBar/topbar.dart';
import 'package:atlas_mobile/main/controller/navigation_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import 'appeals_preview.dart';

class AppealsScreen extends StatelessWidget {
  const AppealsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final NavigationController navigationController =
        Get.put(NavigationController());

    final AppealsController c = Get.put(AppealsController());

    WidgetsBinding.instance.addPostFrameCallback((_) {
      c.getUserAppeals();
    });

    return Scaffold(
      appBar: const TopBar(
        pageTile: 'Appeals',
        hasBackButton: true,
      ),
      bottomNavigationBar: Obx(
        () => Navbar(
          currentIndex: navigationController.selectedIndex.value,
          onItemTap: navigationController.onItemTap,
        ),
      ),
      body: SafeArea(
        child: Obx(() => c.isLoading.value
            ? const LoadingIndicator()
            : Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: c.appealsList.length,
                      controller: c.appealsScrollController,
                      padding: const EdgeInsets.all(10),
                      itemBuilder: ((context, index) {
                        return AppealPreview(
                          appeal: c.appealsList[index],
                        );
                      }),
                    ),
                  ),
                  c.appealsHasNextPage.value
                      ? ElevatedButton(
                          onPressed: () async {
                            await c.getMoreAppeals();
                          },
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                              const Color(0xFF182335),
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
                          child: const Text(
                            'Load More',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                            ),
                          ),
                        )
                      : const SizedBox(),
                ],
              )),
      ),
    );
  }
}

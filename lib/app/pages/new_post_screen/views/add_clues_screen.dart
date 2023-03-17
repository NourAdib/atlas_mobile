import 'package:atlas_mobile/app/widgets/loading_indicator.dart';
import 'package:atlas_mobile/app/widgets/navbar.dart';
import 'package:atlas_mobile/app/widgets/topBar/topbar.dart';
import 'package:atlas_mobile/main/controller/navigation_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../controller/new_post_controller.dart';
import 'mini_clue.dart';

class CluesSelectionScreen extends StatelessWidget {
  CluesSelectionScreen({super.key});

  final NavigationController navigationController =
      Get.put(NavigationController());

  final NewPostController c = Get.find<NewPostController>();

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
                  c.clues.isEmpty
                      ? InkWell(
                          onTap: () => c.addClueToCluesList(),
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            margin: const EdgeInsets.symmetric(
                                vertical: 5, horizontal: 5),
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
                                  offset: Offset(
                                    0,
                                    4,
                                  ), // changes position of shadow
                                )
                              ],
                            ),
                            child: SvgPicture.asset(
                              'assets/images/add_icon.svg',
                              height: c.height * 0.1,
                              width: c.width * 0.1,
                            ),
                          ),
                        )
                      : Expanded(
                          child: GridView.builder(
                            itemCount: c.clues.length + 1,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              crossAxisSpacing: 2,
                              mainAxisSpacing: 2,
                            ),
                            padding: const EdgeInsets.all(10),
                            itemBuilder: ((context, index) {
                              if (index < c.clues.length) {
                                return MiniCluePreview(
                                  clue: c.clues[index],
                                  height: c.height,
                                );
                              }
                              if (index >= c.clues.length) {
                                return InkWell(
                                  onTap: () => c.addClueToCluesList(),
                                  child: Container(
                                    padding: const EdgeInsets.all(10),
                                    margin: const EdgeInsets.symmetric(
                                        vertical: 5, horizontal: 5),
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
                                          offset: Offset(0,
                                              4), // changes position of shadow
                                        )
                                      ],
                                    ),
                                    child: SvgPicture.asset(
                                      'assets/images/add_icon.svg',
                                      height: c.height * 0.1,
                                      width: c.width * 0.1,
                                    ),
                                  ),
                                );
                              }
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

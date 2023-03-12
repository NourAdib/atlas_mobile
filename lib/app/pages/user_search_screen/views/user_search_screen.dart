import 'package:atlas_mobile/app/pages/user_search_screen/controller/user_search_controller.dart';
import 'package:atlas_mobile/app/pages/user_search_screen/views/user_search_preview.dart';
import 'package:atlas_mobile/app/widgets/loading_indicator.dart';
import 'package:atlas_mobile/app/widgets/navbar.dart';
import 'package:atlas_mobile/app/widgets/topBar/topbar.dart';
import 'package:atlas_mobile/main/controller/navigation_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class UserSearchScreen extends StatelessWidget {
  const UserSearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final NavigationController navigationController =
        Get.put(NavigationController());

    final UserSearchScreenController c = Get.put(UserSearchScreenController());
    return Scaffold(
      appBar: const TopBar(
        pageTile: 'Search',
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
                child: c.isLoading.value
                    ? const LoadingIndicator()
                    : Column(
                        children: [
                          const SizedBox(height: 10),
                          Container(
                            margin: const EdgeInsets.symmetric(horizontal: 7),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                SizedBox(
                                  width: c.width * 0.78,
                                  height: c.width * 0.15,
                                  child: TextFormField(
                                    controller: c.searchController,
                                    onChanged: (_) => c.searchUsers(),
                                    decoration: const InputDecoration(
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(10.0),
                                        ),
                                        borderSide: BorderSide(
                                          color: Colors.black,
                                          width: 3.0,
                                          style: BorderStyle.solid,
                                        ),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(10.0),
                                        ),
                                        borderSide: BorderSide(
                                          color: Colors.black,
                                          width: 3.0,
                                          style: BorderStyle.solid,
                                        ),
                                      ),
                                      hintStyle: TextStyle(
                                        color: Colors.black,
                                      ),
                                      hintText: 'Search User',
                                    ),
                                  ),
                                ),
                                InkWell(
                                  onTap: () => c.searchUsers(),
                                  child: Container(
                                    width: c.width * 0.15,
                                    height: c.width * 0.15,
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 3),
                                    padding: const EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      color: const Color(0xFF182335),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: SvgPicture.asset(
                                      'assets/images/explore_icon.svg',
                                      width: 25,
                                      height: 25,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 20),
                          Expanded(
                            child: ListView.builder(
                              itemCount: c.users.length,
                              itemBuilder: (BuildContext context, int index) {
                                return UserSearchPreview(
                                  user: c.users[index],
                                );
                              },
                            ),
                          ),
                        ],
                      ),
              )),
        ),
      ),
    );
  }
}

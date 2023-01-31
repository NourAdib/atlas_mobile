import 'dart:developer';

import 'package:atlas_mobile/app/pages/home_screen/controller/home_screen_controller.dart';
import 'package:atlas_mobile/app/widgets/loading_indicator.dart';
import 'package:atlas_mobile/app/widgets/topBar/topbar.dart';
import 'package:atlas_mobile/app/widgets/navbar.dart';
import 'package:atlas_mobile/main/controller/navigation_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'post_view.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final HomeScreenController c = Get.put(HomeScreenController());
    final NavigationController navigationController =
        Get.put(NavigationController());
    return Scaffold(
      appBar: const TopBar(
        pageTile: 'Home',
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
                    : RefreshIndicator(
                        onRefresh: () => c.reloadFeed(),
                        child: ListView.builder(
                          controller: c.scrollController,
                          itemCount: c.feedPosts.value.length,
                          itemBuilder: (context, index) {
                            return PostView(
                              post: c.feedPosts.value[index],
                            );
                          },
                        ),
                      ),
              )),
        ),
      ),
    );
  }
}

import 'package:atlas_mobile/app/pages/settings_screen/controller/follow_requests_controller.dart';
import 'package:atlas_mobile/app/pages/settings_screen/views/follow_requests/follow_request.dart';
import 'package:atlas_mobile/app/widgets/navbar.dart';
import 'package:atlas_mobile/app/widgets/topBar/topbar.dart';
import 'package:atlas_mobile/main/controller/navigation_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FollowRequestsScreen extends StatelessWidget {
  const FollowRequestsScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final NavigationController navigationController =
        Get.put(NavigationController());

    final FollowRequestsController c = Get.put(FollowRequestsController());

    c.getFollowRequests();

    return Scaffold(
        appBar: const TopBar(
          pageTile: 'Follow Requests',
          hasBackButton: true,
        ),
        bottomNavigationBar: Obx(
          () => Navbar(
            currentIndex: navigationController.selectedIndex.value,
            onItemTap: navigationController.onItemTap,
          ),
        ),
        body: Obx(
          () => ListView.builder(
            controller: c.scrollController,
            itemCount: c.followRequests.value.length,
            itemBuilder: (context, index) {
              return FollowRequestWidget(
                request: c.followRequests.value[index],
              );
            },
          ),
        ));
  }
}

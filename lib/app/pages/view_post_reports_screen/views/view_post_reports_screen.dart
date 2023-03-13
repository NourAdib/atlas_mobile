import 'package:atlas_mobile/app/pages/view_post_reports_screen/controller/view_post_reports_controller.dart';
import 'package:atlas_mobile/app/widgets/loading_indicator.dart';
import 'package:atlas_mobile/app/widgets/navbar.dart';
import 'package:atlas_mobile/app/widgets/topBar/topbar.dart';
import 'package:atlas_mobile/main/controller/navigation_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'report_preview.dart';

class ViewPostReportsScreen extends StatelessWidget {
  final String postId;
  const ViewPostReportsScreen({required this.postId, super.key});

  @override
  Widget build(BuildContext context) {
    final NavigationController navigationController =
        Get.put(NavigationController());

    final ViewPostReportsController c = Get.put(ViewPostReportsController());

    WidgetsBinding.instance.addPostFrameCallback((_) {
      c.setPostId(postId);
      c.getPostReports();
    });

    return Scaffold(
      appBar: const TopBar(
        pageTile: 'Post Reports',
        hasBackButton: true,
      ),
      bottomNavigationBar: Obx(
        () => Navbar(
          currentIndex: navigationController.selectedIndex.value,
          onItemTap: navigationController.onItemTap,
        ),
      ),
      body: Obx(() => c.isLoading.value
          ? const LoadingIndicator()
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: c.reportsList.length,
                    controller: c.reportsScrollController,
                    padding: const EdgeInsets.all(10),
                    itemBuilder: ((context, index) {
                      return ReportPreview(
                        report: c.reportsList[index],
                      );
                    }),
                  ),
                ),
                c.reportsHasNextPage.value
                    ? ElevatedButton(
                        onPressed: () async {
                          await c.getMoreReports();
                        },
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                            const Color(0xFF182335),
                          ),
                          minimumSize: MaterialStateProperty.all<Size>(
                            Size(c.width * 0.46, c.height * 0.07),
                          ),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
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
    );
  }
}

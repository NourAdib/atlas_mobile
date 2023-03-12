import 'package:atlas_mobile/app/model/post.model.dart';
import 'package:atlas_mobile/app/model/scrapbook.model.dart';
import 'package:atlas_mobile/app/widgets/loading_indicator.dart';
import 'package:atlas_mobile/app/widgets/navbar.dart';
import 'package:atlas_mobile/app/widgets/scrapbook_details/mini_post_preview.dart';
import 'package:atlas_mobile/app/widgets/scrapbook_details/scrapbook_details_controller.dart';
import 'package:atlas_mobile/app/widgets/topBar/topbar.dart';
import 'package:atlas_mobile/main/controller/navigation_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import 'mini_scrapbook_preview.dart';

class ScrapbooksSelectionScreen extends StatelessWidget {
  final Post post;
  ScrapbooksSelectionScreen({required this.post, super.key});

  final NavigationController navigationController =
      Get.put(NavigationController());

  final ScrapbookDetailsScreenController c =
      Get.put(ScrapbookDetailsScreenController());

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      c.getUserScrapbooks();
    });

    return Scaffold(
      appBar: const TopBar(
        pageTile: 'Scrap',
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
                      itemCount: c.scrapbooksList.length,
                      controller: c.scrapbooksScrollController,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: 2,
                        mainAxisSpacing: 2,
                      ),
                      padding: const EdgeInsets.all(10),
                      itemBuilder: ((context, index) {
                        return MiniScrapbookPreview(
                          scrapbook: c.scrapbooksList[index],
                          height: c.height,
                          postId: post.id!,
                          thumbnail: c.getScrapbookThumbnail(
                              c.scrapbooksList[index].posts ?? []),
                          onTap: c.addPostToScrapbookWithId,
                        );
                      }),
                    ),
                  ),
                  SizedBox(
                    height: c.height * 0.05,
                  ),
                  c.scrapbookHasNextPage.value
                      ? ElevatedButton(
                          onPressed: () async {
                            await c.getMoreScrapbooks();
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
              ),
      )),
    );
  }
}

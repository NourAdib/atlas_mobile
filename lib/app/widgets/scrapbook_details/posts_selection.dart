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

class PostsSelectionScreen extends StatelessWidget {
  final Scrapbook scrapbook;
  PostsSelectionScreen({required this.scrapbook, super.key});

  final NavigationController navigationController =
      Get.put(NavigationController());

  final ScrapbookDetailsScreenController c =
      Get.put(ScrapbookDetailsScreenController());

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      c.getUserPosts();
    });

    return Scaffold(
      appBar: const TopBar(
        pageTile: 'Scrapbook',
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
                      itemCount: c.userPostsList.length,
                      controller: c.userPostsController,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: 2,
                        mainAxisSpacing: 2,
                      ),
                      padding: const EdgeInsets.all(10),
                      itemBuilder: ((context, index) {
                        return MiniPostPreview(
                          post: c.userPostsList[index],
                          height: c.height,
                          scrapbookId: scrapbook.id!,
                          onTap: c.addPostToScrapbook,
                        );
                      }),
                    ),
                  ),
                  SizedBox(
                    height: c.height * 0.05,
                  ),
                  c.postHasNextPage.value
                      ? ElevatedButton(
                          onPressed: () async {
                            await c.getMorePosts();
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

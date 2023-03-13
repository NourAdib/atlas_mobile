import 'package:atlas_mobile/app/model/scrapbook.model.dart';
import 'package:atlas_mobile/app/pages/profile_screen/views/scrapbook_image.dart';
import 'package:atlas_mobile/app/widgets/loading_indicator.dart';
import 'package:atlas_mobile/app/widgets/navbar.dart';
import 'package:atlas_mobile/app/widgets/scrapbook_details/mini_post_preview.dart';
import 'package:atlas_mobile/app/widgets/topBar/topbar.dart';
import 'package:atlas_mobile/main/controller/navigation_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import 'scrapbook_details_controller.dart';

class ScrapbookDetailsScreen extends StatelessWidget {
  final Scrapbook scrapbook;
  final double height;
  final double width;

  const ScrapbookDetailsScreen(
      {required this.scrapbook,
      required this.height,
      required this.width,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final NavigationController navigationController =
        Get.put(NavigationController());

    final ScrapbookDetailsScreenController c =
        Get.put(ScrapbookDetailsScreenController());

    WidgetsBinding.instance.addPostFrameCallback((_) {
      c.setScrapbook(scrapbook);
      c.getUserProfile();
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
        child: Obx(() => c.isLoading.value
            ? const LoadingIndicator()
            : Column(
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(
                      vertical: 5,
                      horizontal: 7,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFF6E9),
                      border: Border.all(
                        color: const Color(0xFF182335),
                        width: 3,
                        style: BorderStyle.solid,
                      ),
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: const [
                        BoxShadow(
                          color: Color.fromRGBO(0, 0, 0, 0.25),
                          blurRadius: 4,
                          offset: Offset(0, 4), // changes position of shadow
                        )
                      ],
                    ),
                    child: ScrapbookImage(
                      imageUrl: scrapbook.posts!.isEmpty
                          ? ''
                          : c.getScrapbookThumbnail(scrapbook.posts ?? []),
                      caption: scrapbook.caption!,
                      height: c.height * 0.3,
                      fit: BoxFit.fill,
                    ),
                  ),
                  Expanded(
                    child: GridView.builder(
                      itemCount: c.postsList.length + 1,
                      controller: c.postsScrollController,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: 2,
                        mainAxisSpacing: 2,
                      ),
                      padding: const EdgeInsets.all(10),
                      itemBuilder: ((context, index) {
                        if (index < c.postsList.length) {
                          return MiniPostPreview(
                            post: c.postsList[index],
                            height: c.height,
                            scrapbookId: scrapbook.id!,
                            onTap: c.onPostClick,
                          );
                        }
                        if (index >= c.postsList.length) {
                          return InkWell(
                            onTap: () => c.addPost(),
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
                                        0, 4), // changes position of shadow
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
                  )
                ],
              )),
      ),
    );
  }
}

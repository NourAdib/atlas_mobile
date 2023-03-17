import 'package:atlas_mobile/app/widgets/loading_indicator.dart';
import 'package:atlas_mobile/app/widgets/non_filled_form_field.dart';
import 'package:atlas_mobile/app/widgets/topBar/topbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/new_post_controller.dart';
import '../controller/review_new_memory_controller.dart';

class ReviewMemory extends StatelessWidget {
  const ReviewMemory({super.key});

  @override
  Widget build(BuildContext context) {
    final NewPostController newPostController = Get.find<NewPostController>();

    final ReviewNewMemoryController c = Get.put(ReviewNewMemoryController());

    WidgetsBinding.instance.addPostFrameCallback((_) {
      c.setMemoryPath(newPostController.memoryPath.value);
    });
    return Scaffold(
      appBar: const TopBar(
        pageTile: 'New Memory',
        hasBackButton: true,
      ),
      bottomNavigationBar: Container(
        margin: EdgeInsets.symmetric(
          horizontal: c.width * 0.02,
          vertical: c.width * 0.03,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ElevatedButton(
              onPressed: () {
                c.goToPrreviousScreen();
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(
                  const Color(0xFFEFCB68),
                ),
                minimumSize: MaterialStateProperty.all<Size>(
                  Size(c.width * 0.46, c.height * 0.07),
                ),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
              child: const Icon(
                Icons.arrow_back_ios,
                color: Colors.black,
              ),
            ),
            SizedBox(width: c.width * 0.03),
            ElevatedButton(
              onPressed: () async {
                await c.createMemory();
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(
                  const Color(0xFF182335),
                ),
                minimumSize: MaterialStateProperty.all<Size>(
                  Size(c.width * 0.46, c.height * 0.07),
                ),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
              child: const Icon(
                Icons.check,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
      body: SafeArea(
          child: Obx(
        () => c.isLoading.value
            ? const LoadingIndicator()
            : SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(height: Get.height * 0.04),
                    NonFilledFormField(
                        screenWidth: Get.width,
                        controller: c.locationTextFieldController,
                        labelText: "Location"),
                    SizedBox(height: Get.height * 0.04),
                    Column(
                      children: [
                        const Text("Visibility"),
                        SizedBox(height: Get.height * 0.009),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Obx(
                              () => InkWell(
                                onTap: () {
                                  c.choosePublic();
                                },
                                child: Container(
                                  alignment: Alignment.center,
                                  width: Get.width * 0.232,
                                  height: Get.height * 0.053,
                                  decoration: BoxDecoration(
                                      color: c.public.value
                                          ? const Color(0xffEFCB68)
                                          : const Color(0xffFFF6E9),
                                      borderRadius: BorderRadius.circular(10),
                                      boxShadow: c.public.value
                                          ? const [
                                              BoxShadow(
                                                  color: Colors.black,
                                                  blurRadius: 2.5)
                                            ]
                                          : const [
                                              BoxShadow(
                                                  color: Colors.black,
                                                  blurRadius: 1)
                                            ]),
                                  child: const Text("Public"),
                                ),
                              ),
                            ),
                            Obx(
                              () => InkWell(
                                onTap: () {
                                  c.choosePrivate();
                                },
                                child: Container(
                                  alignment: Alignment.center,
                                  width: Get.width * 0.232,
                                  height: Get.height * 0.053,
                                  decoration: BoxDecoration(
                                      color: c.private.value
                                          ? const Color(0xffEFCB68)
                                          : const Color(0xffFFF6E9),
                                      borderRadius: BorderRadius.circular(10),
                                      boxShadow: c.private.value
                                          ? const [
                                              BoxShadow(
                                                  color: Colors.black,
                                                  blurRadius: 2.5)
                                            ]
                                          : const [
                                              BoxShadow(
                                                  color: Colors.black,
                                                  blurRadius: 1)
                                            ]),
                                  child: const Text("Private"),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
      )),
    );
  }
}

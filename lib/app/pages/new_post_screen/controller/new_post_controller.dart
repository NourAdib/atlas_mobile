import 'package:atlas_mobile/app/utility/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class NewPostController extends GetxController {
  var width = Get.width;
  var height = Get.height;
  XFile? scrap;
  XFile? memory;
  var noImageSelected = true.obs;
  var scrapPath = ''.obs;
  var memoryPath = ''.obs;
  goToPrreviousScreen() {
    Get.back();
  }

  pickImageScrap() async {
    Get.bottomSheet(
      Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: const Icon(color: Colors.black, Icons.camera_alt),
            title: const Text('Camera'),
            onTap: () async {
              scrap = await ImagePickerService.pickImageFromCamera();
              if (scrap != null) {
                noImageSelected.value = false;
                scrapPath.value = scrap!.path;
                Get.toNamed('/reviewScrap');
              } else {
                goToPrreviousScreen();
              }
            },
          ),
          ListTile(
            leading: const Icon(color: Colors.black, Icons.photo),
            title: const Text('Gallery'),
            onTap: () async {
              scrap = await ImagePickerService.pickImageFromGallery();
              if (scrap != null) {
                noImageSelected.value = false;
                scrapPath.value = scrap!.path;
                Get.toNamed('/reviewScrap');
              } else {
                goToPrreviousScreen();
              }
            },
          ),
        ],
      ),
      backgroundColor: Color(0xffEFCB68),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
    );
  }

  pickImageMemory() async {
    Get.bottomSheet(
      Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: const Icon(color: Colors.black, Icons.camera_alt),
            title: const Text('Camera'),
            onTap: () async {
              memory = await ImagePickerService.pickImageFromCamera();
              if (memory != null) {
                noImageSelected.value = false;
                memoryPath.value = memory!.path;
                Get.toNamed('/reviewMemory');
              } else {
                goToPrreviousScreen();
              }
            },
          ),
        ],
      ),
      backgroundColor: Color(0xffEFCB68),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
    );
  }

  createEvent() async {
    Get.toNamed('/createEvent');
  }

  createScrapbook() async {
    Get.toNamed('/createScrapbook');
  }
}

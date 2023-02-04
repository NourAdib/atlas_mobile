import 'package:atlas_mobile/app/utility/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class NewPostController extends GetxController {
  var width = Get.width;
  var height = Get.height;
  XFile? scrap;
  var noImageSelected = true.obs;
  var imagePath = ''.obs;

  goToPrreviousScreen() {
    Get.back();
  }

  pickImage() async {
    Get.bottomSheet(
      Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: const Icon(color: Colors.black, Icons.camera_alt),
            title: const Text('Camera'),
            onTap: () async {
              scrap = await ImagePickerService.pickImageFromCamera();
              noImageSelected.value = false;
              imagePath.value = scrap!.path;
            },
          ),
          ListTile(
            leading: const Icon(color: Colors.black, Icons.photo),
            title: const Text('Gallery'),
            onTap: () async {
              scrap = await ImagePickerService.pickImageFromGallery();
              noImageSelected.value = false;
              imagePath.value = scrap!.path;
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
}

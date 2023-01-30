import 'package:get/get.dart';

class ProfileScreenController extends GetxController {
  var width = Get.width;
  var height = Get.height;

  Tabs currentSelectedTab = Tabs.Scraps;

  goToScrapsTab() {
    currentSelectedTab = Tabs.Scraps;
  }

  goToMemoriesTab() {
    currentSelectedTab = Tabs.Memories;
  }

  goToEventsTab() {
    currentSelectedTab = Tabs.Events;
  }

  goToScrapbookTab() {
    currentSelectedTab = Tabs.Scrapbook;
  }

  goToPreviousScreen() {
    Get.back();
  }

  getUserDetails() {}

  getPosts() {}
}

enum Tabs { Memories, Scrapbook, Events, Scraps }

import 'package:atlas_mobile/app/pages/profile_screen/controller/profile_screen_controller.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';

void main() {
  group("ProfileScreenController Tests", () {
    late ProfileScreenController controller;

    setUp(() {
      controller = Get.put(ProfileScreenController());
    });

    tearDown(() {
      Get.delete<ProfileScreenController>();
    });

    test('Initial values should be correct', () {
      expect(controller.isLoading.value, false);
      expect(controller.isDisplayingPosts.value, false);
      expect(controller.isDisplayingMemories.value, false);
      expect(controller.isDisplayingScrapbooks.value, false);
      expect(controller.isDisplayingEvents.value, false);
      expect(controller.postHasNextPage.value, false);
      expect(controller.scrapbookHasNextPage.value, false);
      expect(controller.memoryHasNextPage.value, false);
      expect(controller.eventHasNextPage.value, false);
      expect(controller.joinedEventHasNextPage.value, false);
      expect(controller.isJoinedEventsSelected.value, false);
    });

    test('Toggle loading should change the isLoading value', () {
      controller.toggleLoading();
      expect(controller.isLoading.value, true);
      controller.toggleLoading();
      expect(controller.isLoading.value, false);
    });
  });
}

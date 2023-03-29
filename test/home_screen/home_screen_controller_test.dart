import 'package:atlas_mobile/app/model/post.model.dart';
import 'package:atlas_mobile/app/pages/home_screen/controller/home_screen_controller.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'home_screen_controller_test.mocks.dart';

@GenerateMocks([Post])
void main() {
  Get.testMode = true;
  group('HomeScreenController Tests', () {
    late HomeScreenController controller;

    setUp(() {
      controller = HomeScreenController();
      Get.put(controller);
    });

    tearDown(() {
      Get.reset();
    });

    test('Initial values test', () {
      expect(controller.selectedIndex.value, 0);
      expect(controller.feedPosts.length, 0);
      expect(controller.isLoading.value, true);
      expect(controller.hasNextPage.value, false);
    });

    test('onItemTap test', () {
      controller.onItemTap(2);
      expect(controller.selectedIndex.value, 2);
    });
  });
}

import 'package:atlas_mobile/app/pages/home_screen/views/home_screen.dart';
import 'package:atlas_mobile/app/widgets/navbar.dart';
import 'package:atlas_mobile/app/widgets/topBar/topbar.dart';
import 'package:atlas_mobile/app/widgets/loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';

void main() {
  Get.testMode = true;
  group('HomeScreen Widget Tests', () {
    testWidgets('HomeScreen UI test', (WidgetTester tester) async {
      await tester.pumpWidget(const GetMaterialApp(home: HomeScreen()));

      expect(find.byType(Navbar), findsOneWidget);
    });

    testWidgets('Initial UI with no feed posts', (WidgetTester tester) async {
      await tester.pumpWidget(const GetMaterialApp(home: HomeScreen()));

      expect(find.byType(TopBar), findsOneWidget);
    });
  });
}

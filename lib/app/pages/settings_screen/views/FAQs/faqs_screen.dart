import 'package:atlas_mobile/app/pages/settings_screen/controller/faqs_controller.dart';
import 'package:atlas_mobile/app/widgets/navbar.dart';
import 'package:atlas_mobile/app/widgets/topBar/topbar.dart';
import 'package:atlas_mobile/main/controller/navigation_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class FAQsScreen extends StatelessWidget {
  const FAQsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final NavigationController navigationController =
        Get.put(NavigationController());

    final FAQsController c = Get.put(FAQsController());

    return Scaffold(
      appBar: const TopBar(
        pageTile: 'Help Center',
        hasBackButton: true,
      ),
      bottomNavigationBar: Obx(
        () => Navbar(
          currentIndex: navigationController.selectedIndex.value,
          onItemTap: navigationController.onItemTap,
        ),
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          children: [
            InkWell(
              onTap: () => c.openLoginFAQ(),
              child: Container(
                padding: const EdgeInsets.all(10),
                margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
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
                      offset: Offset(0, 4), // changes position of shadow
                    )
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'I Can\'t Log In',
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                    SvgPicture.asset('assets/images/right_arrow_icon.svg')
                  ],
                ),
              ),
            ),
            InkWell(
              onTap: () => c.openReportFAQ(),
              child: Container(
                padding: const EdgeInsets.all(10),
                margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
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
                      offset: Offset(0, 4), // changes position of shadow
                    )
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'How to Report a Problem',
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                    SvgPicture.asset('assets/images/right_arrow_icon.svg')
                  ],
                ),
              ),
            ),
            InkWell(
              onTap: () => c.replayOnboarding(),
              child: Container(
                padding: const EdgeInsets.all(10),
                margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
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
                      offset: Offset(0, 4), // changes position of shadow
                    )
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Replay Onboarding',
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                    SvgPicture.asset('assets/images/right_arrow_icon.svg')
                  ],
                ),
              ),
            ),
          ],
        ),
      )),
    );
  }
}

import 'package:atlas_mobile/app/pages/settings_screen/controller/settings_controller.dart';
import 'package:atlas_mobile/app/widgets/navbar.dart';
import 'package:atlas_mobile/app/widgets/topBar/topbar.dart';
import 'package:atlas_mobile/main/controller/navigation_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class ContactUsScreen extends StatelessWidget {
  const ContactUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final NavigationController navigationController =
        Get.put(NavigationController());

    final SettingsController c = Get.put(SettingsController());

    return Scaffold(
      appBar: const TopBar(
        pageTile: 'Contact Us',
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
                onTap: () => c.launchURL('mailto:bossmancorp@protonmail.com'),
                child: Container(
                  padding: const EdgeInsets.all(10),
                  margin:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
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
                        'Email',
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
                onTap: () => c.launchURL('tel: +971 550000000'),
                child: Container(
                  padding: const EdgeInsets.all(10),
                  margin:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
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
                        'Phone',
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
        ),
      ),
    );
  }
}

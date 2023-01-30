import 'package:atlas_mobile/app/widgets/topBar/topbar_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class TopBar extends StatelessWidget implements PreferredSizeWidget {
  final double height;
  final String pageTile;

  const TopBar({
    required this.pageTile,
    this.height = kToolbarHeight,
  });

  @override
  Size get preferredSize => Size.fromHeight(height);

  @override
  Widget build(BuildContext context) {
    final TopBarController c = Get.put(TopBarController());

    return SafeArea(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 3, vertical: 7),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SvgPicture.asset(
              'assets/images/logo.svg',
              semanticsLabel: 'Atlas Logo',
              width: c.width * 0.15,
            ),
            Expanded(
              child: Container(
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                  color: Color(0xFFEFCB68),
                  borderRadius: BorderRadius.all(
                    Radius.circular(10.0),
                  ),
                ),
                child: Text(
                  pageTile,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            InkWell(
              onTap: () => c.goToSettingsPage(),
              child: Container(
                width: c.width * 0.15,
                height: c.width * 0.15,
                margin: const EdgeInsets.symmetric(horizontal: 3),
                padding: const EdgeInsets.all(2),
                decoration: BoxDecoration(
                  color: const Color(0xFF182335),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: SvgPicture.asset(
                  'assets/images/settings_icon.svg',
                  color: const Color(0xFFF5F5F5),
                  width: 35,
                  height: 35,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

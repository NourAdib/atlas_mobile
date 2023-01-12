import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class Navbar extends StatelessWidget {
  const Navbar({
    Key? key,
    required this.currentIndex,
    required this.onItemTap,
  }) : super(key: key);

  final int currentIndex;
  final Function(int) onItemTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(7),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: BottomNavigationBar(
          backgroundColor: const Color(0xFF182335),
          showSelectedLabels: false,
          showUnselectedLabels: false,
          type: BottomNavigationBarType.fixed,
          items: [
            BottomNavigationBarItem(
              activeIcon: Container(
                padding: const EdgeInsets.all(2),
                decoration: BoxDecoration(
                  color: const Color(0xFFEFCB68),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: SvgPicture.asset(
                  'assets/images/maps_icon.svg',
                  color: const Color(0xFF182335),
                  width: 35,
                  height: 35,
                ),
              ),
              backgroundColor: const Color(0xFFEFCB68),
              icon: Container(
                padding: const EdgeInsets.all(2),
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: SvgPicture.asset(
                  'assets/images/maps_icon.svg',
                  color: Colors.white,
                  width: 35,
                  height: 35,
                ),
              ),
              label: 'Maps',
            ),
            BottomNavigationBarItem(
              activeIcon: Container(
                padding: const EdgeInsets.all(2),
                decoration: BoxDecoration(
                  color: const Color(0xFFEFCB68),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: SvgPicture.asset(
                  'assets/images/explore_icon.svg',
                  color: const Color(0xFF182335),
                  width: 35,
                  height: 35,
                ),
              ),
              backgroundColor: const Color(0xFFEFCB68),
              icon: Container(
                padding: const EdgeInsets.all(2),
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: SvgPicture.asset(
                  'assets/images/explore_icon.svg',
                  color: Colors.white,
                  width: 35,
                  height: 35,
                ),
              ),
              label: 'Explore',
            ),
            BottomNavigationBarItem(
              activeIcon: Container(
                padding: const EdgeInsets.all(2),
                decoration: BoxDecoration(
                  color: const Color(0xFFEFCB68),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: SvgPicture.asset(
                  'assets/images/home_icon.svg',
                  color: const Color(0xFF182335),
                  width: 35,
                  height: 35,
                ),
              ),
              backgroundColor: const Color(0xFFEFCB68),
              icon: Container(
                padding: const EdgeInsets.all(2),
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: SvgPicture.asset(
                  'assets/images/home_icon.svg',
                  color: Colors.white,
                  width: 35,
                  height: 35,
                ),
              ),
              label: 'Home',
              tooltip: 'Feed',
            ),
            BottomNavigationBarItem(
              activeIcon: Container(
                padding: const EdgeInsets.all(2),
                decoration: BoxDecoration(
                  color: const Color(0xFFEFCB68),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: SvgPicture.asset(
                  'assets/images/new_post_icon.svg',
                  color: const Color(0xFF182335),
                  width: 35,
                  height: 35,
                ),
              ),
              backgroundColor: const Color(0xFFEFCB68),
              icon: Container(
                padding: const EdgeInsets.all(2),
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: SvgPicture.asset(
                  'assets/images/new_post_icon.svg',
                  color: Colors.white,
                  width: 35,
                  height: 35,
                ),
              ),
              label: 'New Post',
            ),
            BottomNavigationBarItem(
              activeIcon: Container(
                padding: const EdgeInsets.all(2),
                decoration: BoxDecoration(
                  color: const Color(0xFFEFCB68),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: SvgPicture.asset(
                  'assets/images/user_profile_icon.svg',
                  color: const Color(0xFF182335),
                  width: 35,
                  height: 35,
                ),
              ),
              backgroundColor: const Color(0xFFEFCB68),
              icon: Container(
                padding: const EdgeInsets.all(2),
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: SvgPicture.asset(
                  'assets/images/user_profile_icon.svg',
                  color: Colors.white,
                  width: 35,
                  height: 35,
                ),
              ),
              label: 'User Profile',
            ),
          ],
          currentIndex: currentIndex,
          onTap: onItemTap,
        ),
      ),
    );
  }
}

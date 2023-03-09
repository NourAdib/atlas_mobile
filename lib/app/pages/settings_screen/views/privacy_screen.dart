import 'package:atlas_mobile/app/widgets/navbar.dart';
import 'package:atlas_mobile/app/widgets/topBar/topbar.dart';
import 'package:atlas_mobile/main/controller/navigation_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PrivacyScreen extends StatelessWidget {
  const PrivacyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final NavigationController navigationController =
        Get.put(NavigationController());

    return Scaffold(
      appBar: const TopBar(
        pageTile: 'Policy',
        hasBackButton: true,
      ),
      bottomNavigationBar: Obx(
        () => Navbar(
          currentIndex: navigationController.selectedIndex.value,
          onItemTap: navigationController.onItemTap,
        ),
      ),
      body: SingleChildScrollView(
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: const [
              Text('Terms of Service',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              SizedBox(height: 10),
              Text(
                'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Facilisis mauris sit amet massa vitae tortor. Velit dignissim sodales ut eu sem integer vitae justo. Molestie a iaculis at erat pellentesque adipiscing commodo. Iaculis nunc sed augue lacus viverra vitae congue eu consequat. Arcu dui vivamus arcu felis bibendum. Amet porttitor eget dolor morbi non arcu. Duis convallis convallis tellus id interdum velit laoreet id donec. Interdum velit euismod in pellentesque massa placerat duis. Quis viverra nibh cras pulvinar mattis. Blandit turpis cursus in hac habitasse platea dictumst quisque sagittis. Pulvinar mattis nunc sed blandit. Scelerisque purus semper eget duis. Ac tortor vitae purus faucibus ornare suspendisse. At augue eget arcu dictum varius duis at consectetur. Eu scelerisque felis imperdiet proin fermentum leo. Venenatis lectus magna fringilla urna porttitor rhoncus dolor. In tellus integer feugiat scelerisque varius.',
                style: TextStyle(
                  fontSize: 12,
                ),
              ),
              SizedBox(height: 10),
              Text(
                'Privacy Policy',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text(
                  'Pellentesque sit amet porttitor eget dolor. Id neque aliquam vestibulum morbi. Ac auctor augue mauris augue neque gravida. Nulla pellentesque dignissim enim sit amet venenatis urna cursus. Dictumst quisque sagittis purus sit. Neque ornare aenean euismod elementum nisi quis eleifend quam adipiscing. Sed blandit libero volutpat sed cras ornare arcu dui vivamus. Netus et malesuada fames ac turpis egestas. A lacus vestibulum sed arcu non odio euismod lacinia at. Ut tellus elementum sagittis vitae et leo. Viverra aliquet eget sit amet tellus. Orci porta non pulvinar neque laoreet. Phasellus egestas tellus rutrum tellus pellentesque eu tincidunt. Nisl vel pretium lectus quam id leo in vitae turpis. Lectus nulla at volutpat diam ut venenatis tellus. Elementum pulvinar etiam non quam lacus suspendisse faucibus. Scelerisque purus semper eget duis at. Velit ut tortor pretium viverra suspendisse potenti nullam ac. Nisl pretium fusce id velit. Mi',
                  style: TextStyle(
                    fontSize: 12,
                  )),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:atlas_mobile/app/pages/settings_screen/controller/settings_controller.dart';
import 'package:atlas_mobile/app/pages/settings_screen/controller/subscription_controller.dart';
import 'package:atlas_mobile/app/widgets/loading_indicator.dart';
import 'package:atlas_mobile/app/widgets/navbar.dart';
import 'package:atlas_mobile/app/widgets/topBar/topbar.dart';
import 'package:atlas_mobile/main/controller/navigation_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class SubscriptionScreen extends StatelessWidget {
  const SubscriptionScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final NavigationController navigationController =
        Get.put(NavigationController());

    final SubscriptionController c = Get.put(SubscriptionController());

    c.getUserProfile();

    return Scaffold(
        appBar: const TopBar(
          pageTile: 'Subscription',
          hasBackButton: true,
        ),
        bottomNavigationBar: Obx(
          () => Navbar(
            currentIndex: navigationController.selectedIndex.value,
            onItemTap: navigationController.onItemTap,
          ),
        ),
        body: Obx(
          () => c.isLoading.value
              ? const LoadingIndicator()
              : SafeArea(
                  child: SingleChildScrollView(
                    child: Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: c.width * 0.02,
                          ),
                          Text(
                            'Currently On: ${c.currentPlan.value} Plan',
                            style: const TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: c.width * 0.02,
                          ),
                          Container(
                            padding: const EdgeInsets.all(10),
                            margin: const EdgeInsets.symmetric(
                                vertical: 5, horizontal: 5),
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
                                  offset: Offset(
                                      0, 4), // changes position of shadow
                                )
                              ],
                            ),
                            child: Column(
                              children: [
                                const Text(
                                  'Lorem ipsum dolor sit amet.',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(
                                  height: c.width * 0.1,
                                ),
                                const Text(
                                  'Cum rerum voluptatem et modi omnis sit vitae dolore et molestiae  consequatur. Qui enim repellendus id adipisci assumenda in voluptas sunt est officia voluptas et nostrum accusamus qui quos internos hic blanditiis omnis.',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 18,
                                  ),
                                ),
                                SizedBox(
                                  height: c.width * 0.1,
                                ),
                                const Text(
                                  'Quo labore blanditiis ut voluptatibus quis qui facere porro et magnam repudiandae sit nihil reprehenderit et quia illum. Vel recusandae voluptatem aut nihil similique aut itaque illum eos commodi laudantium et ducimus quos!',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 18,
                                  ),
                                ),
                                SizedBox(
                                  height: c.width * 0.1,
                                ),
                                c.isPremium.value
                                    ? ElevatedButton(
                                        onPressed: () => c.unsubscribe(),
                                        style: ButtonStyle(
                                          backgroundColor:
                                              MaterialStateProperty.all(
                                            Colors.black,
                                          ),
                                        ),
                                        child: const Text('Unsubscribe'),
                                      )
                                    : ElevatedButton(
                                        onPressed: () => c.subscribe(),
                                        style: ButtonStyle(
                                          backgroundColor:
                                              MaterialStateProperty.all(
                                            Colors.black,
                                          ),
                                        ),
                                        child: const Text(
                                            'Subscribe for 30.00AED/Month'),
                                      )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
        ));
  }
}

import 'package:atlas_mobile/pages/registration_or_login_screen/controller/registration_or_login_screen_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class LogoStripes extends StatelessWidget {
  const LogoStripes({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final RegistrationOrLoginScreenController c = Get.find();
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(0),
                topRight: Radius.circular(0),
                bottomLeft: Radius.circular(54),
                bottomRight: Radius.circular(54),
              ),
              boxShadow: [
                BoxShadow(
                  color: Color.fromRGBO(0, 0, 0, 0.25),
                  blurRadius: 4,
                  offset: Offset(0, 4), // changes position of shadow
                )
              ]),
          child: SvgPicture.asset(
            'assets/images/logo_color_stripes_blue.svg',
            semanticsLabel: 'Atlas Colors Stripes',
            width: c.stripeWidth,
            height: c.stripeHeight,
          ),
        ),
        Container(
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(0),
                topRight: Radius.circular(0),
                bottomLeft: Radius.circular(54),
                bottomRight: Radius.circular(54),
              ),
              boxShadow: [
                BoxShadow(
                  color: Color.fromRGBO(0, 0, 0, 0.25),
                  blurRadius: 4,
                  offset: Offset(0, 4), // changes position of shadow
                )
              ]),
          child: SvgPicture.asset(
            'assets/images/logo_color_stripes_orange.svg',
            semanticsLabel: 'Atlas Colors Stripes',
            width: c.stripeWidth * 0.8,
            height: c.stripeHeight * 0.8,
          ),
        ),
        Container(
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(0),
                topRight: Radius.circular(0),
                bottomLeft: Radius.circular(54),
                bottomRight: Radius.circular(54),
              ),
              boxShadow: [
                BoxShadow(
                  color: Color.fromRGBO(0, 0, 0, 0.25),
                  blurRadius: 4,
                  offset: Offset(0, 4), // changes position of shadow
                )
              ]),
          child: SvgPicture.asset(
            'assets/images/logo_color_stripes_yellow.svg',
            semanticsLabel: 'Atlas Colors Stripes',
            width: c.stripeWidth * 0.55,
            height: c.stripeHeight * 0.55,
          ),
        ),
        Container(
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(0),
                topRight: Radius.circular(0),
                bottomLeft: Radius.circular(54),
                bottomRight: Radius.circular(54),
              ),
              boxShadow: [
                BoxShadow(
                  color: Color.fromRGBO(0, 0, 0, 0.25),
                  blurRadius: 4,
                  offset: Offset(0, 4), // changes position of shadow
                )
              ]),
          child: SvgPicture.asset(
            'assets/images/logo_color_stripes_white.svg',
            semanticsLabel: 'Atlas Colors Stripes',
            width: c.stripeWidth * 0.25,
            height: c.stripeHeight * 0.25,
          ),
        ),
      ],
    );
  }
}

import 'package:atlas_mobile/pages/login_screen/controller/login_screen_controller.dart';
import 'package:atlas_mobile/pages/registration_or_login_screen/views/large_button.dart';
import 'package:atlas_mobile/pages/registration_or_login_screen/views/logo_stripes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final LoginScreenController c = Get.put(LoginScreenController());

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const LogoStripes(),
              Container(
                margin: EdgeInsets.only(top: c.width * 0.1),
                child: SvgPicture.asset(
                  'assets/images/logo.svg',
                  semanticsLabel: 'Atlas Logo',
                  width: c.width * 0.3,
                ),
              ),
              Container(
                margin: EdgeInsets.only(
                    top: c.width * 0.075, bottom: c.width * 0.05),
                child: const Text(
                  'atlas.',
                  style: TextStyle(
                    fontSize: 37,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              SizedBox(
                width: c.width * 0.8,
                child: TextFormField(
                  controller: c.emailTextFieldController,
                  decoration: const InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10.0),
                      ),
                      borderSide: BorderSide(
                        color: Colors.black,
                        width: 3.0,
                        style: BorderStyle.solid,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10.0),
                      ),
                      borderSide: BorderSide(
                        color: Colors.black,
                        width: 3.0,
                        style: BorderStyle.solid,
                      ),
                    ),
                    labelText: 'Email',
                    labelStyle: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
              SizedBox(height: c.height * 0.025),
              SizedBox(
                width: c.width * 0.8,
                child: TextFormField(
                  controller: c.passwordTextFieldController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10.0),
                      ),
                      borderSide: BorderSide(
                        color: Colors.black,
                        width: 3.0,
                        style: BorderStyle.solid,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10.0),
                      ),
                      borderSide: BorderSide(
                        color: Colors.black,
                        width: 3.0,
                        style: BorderStyle.solid,
                      ),
                    ),
                    labelText: 'password',
                    labelStyle: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
              SizedBox(height: c.height * 0.05),
              LargeButton(
                c: Get.find(),
                onPressed: () {
                  c.login();
                },
                color: const Color(0xFFEFCB68),
                displayText: 'Login',
                displayTextColor: Colors.black,
              )
            ],
          ),
        ),
      ),
    );
  }
}

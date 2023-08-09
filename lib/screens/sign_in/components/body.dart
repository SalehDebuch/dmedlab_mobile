// ignore_for_file: unused_import

import 'package:dmed_lab/screens/reset_password/resetPassword.dart';
import 'package:dmed_lab/screens/sign_in/components/sign_form.dart';
import 'package:flutter/material.dart';

import '../../../components/no_account_text.dart';
import '../../../services/general_services/size_config.dart';
import '../../sign_up/sign_up_screen.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(new FocusNode());
      },
      child: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: SizeConfig.screenHeight * 0.04),
                  Text(
                    "أهلا بك من جديد",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "يمكنك تسجيل الدخول باستخدام الحساب\n الالكتروني وكلمة المرور ",
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: SizeConfig.screenHeight * 0.06),
                  SignForm(),
                  SizedBox(height: SizeConfig.screenHeight * 0.04),
                  SizedBox(height: 20),
                  NoAccountText(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
//  Row(
                    // mainAxisAlignment: MainAxisAlignment.center,
                    // children: [
                      // SocalCard(
                      //   icon: "assets/icons/google-icon.svg",
                      //   press: () {},
                      // ),
                      // SocalCard(
                      //   icon: "assets/icons/facebook-2.svg",
                      //   press: () {},
                      // ),
                      // SocalCard(
                      //   icon: "assets/icons/twitter.svg",
                      //   press: () {},
                  //     // ),
                  //   ],
                  // ),
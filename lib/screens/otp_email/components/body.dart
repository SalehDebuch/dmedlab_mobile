import '../../../components/blank_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../global/colors.dart';
import '../../../global/global.dart';
import '../../../services/auth/email_verification_service.dart';
import '../../../services/general_services/size_config.dart';
import '../../../theme.dart';
import 'otp_form.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: getProportionateScreenWidth(20)),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: SizeConfig.screenHeight * 0.05),
                  SvgPicture.asset(
                    'assets/images/frame.svg',
                  ),
                  // buildTimer(),
                  SizedBox(height: SizeConfig.screenHeight * 0.05),
                  OtpForm(),
                  SizedBox(height: SizeConfig.screenHeight * 0.1),
                  GestureDetector(
                    onTap: () async {
                      var email = await storage.read(key: 'email');

                      await EmailVerification()
                          .sendVerificationEmail(email!, context);
                    },
                    child: Text(
                      "إعادة ارسال رمز التحقق",
                      style: textTheme().displaySmall!.copyWith(
                          color: kPrimaryColr,
                          decoration: TextDecoration.underline),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
        BlankContainer()
      ],
    );
  }
}
  // Row buildTimer() {
  //   return Row(
  //     mainAxisAlignment: MainAxisAlignment.center,
  //     children: [
  //       TweenAnimationBuilder(
  //         tween: Tween(begin: 60.0, end: 0.0),
  //         duration: Duration(seconds: 120),
  //         builder: (_, dynamic value, child) => Text(
  //           "00:${value.toInt()}",
  //           style: TextStyle(color: kPrimaryColr),
  //         ),
  //       ),
  //       // SizedBox(width: 3),
  //       // Text("تنتهي صلاحية هذا الكود خلال"), //This code will expired in
  //     ],
  //   );
  // }


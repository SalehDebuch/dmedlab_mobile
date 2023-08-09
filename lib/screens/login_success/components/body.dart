import 'package:flutter/material.dart';
import '../../sign_in/sign_in_screen.dart';

import '../../../services/general_services/size_config.dart';
import '../../splash_screen/components/button.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Center(
      child: Column(
        children: [
          SizedBox(height: SizeConfig.screenHeight * 0.04),
          Image.asset(
            "assets/images/success.png",
            height: SizeConfig.screenHeight * 0.4, //40%
          ),
          SizedBox(height: SizeConfig.screenHeight * 0.08),
          Text(
            "تم تسجيل الحساب بنجاح",
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          Spacer(),
          SizedBox(
            width: SizeConfig.screenWidth * 0.6,
            child: CustomeButton(
              text: "  استمرار",
              press: () {
                Navigator.pushNamedAndRemoveUntil(
                    context, SignInScreen.routeName, (route) => false);
              },
            ),
          ),
          Spacer(),
        ],
      ),
    );
  }
}

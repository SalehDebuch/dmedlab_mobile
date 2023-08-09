import 'package:flutter/material.dart';

import '../../global/colors.dart';
// ignore: unused_import
import '../../global/global.dart';
import '../../services/general_services/unfocus_service.dart';
import '../../services/general_services/size_config.dart';
import 'reset_password_form.dart';

class ResetPassword extends StatelessWidget {
  static String routeName = "/reset_password";

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return GestureDetector(
      onTap: () => unfocus(context),
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("اعادة تعيين كلمة السر "),
        ),
        body: SafeArea(
          child: SizedBox(
            width: double.infinity,
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: getProportionateScreenWidth(20)),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(height: SizeConfig.screenHeight * 0.04),
                    Text("تعيين كلمة السر", style: headingStyle),
                    Text(
                      "أدخل كلمة المرور الجديدة  \n",
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: SizeConfig.screenHeight * 0.08),
                    ResetPasswordForm(),
                    SizedBox(height: SizeConfig.screenHeight * 0.08),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

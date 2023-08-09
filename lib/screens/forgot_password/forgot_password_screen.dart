import 'package:flutter/material.dart';

import '../../services/general_services/size_config.dart';
import '../../theme.dart';
import 'body.dart';

class ForgotPasswordScreen extends StatelessWidget {
  static String routeName = "/forgot_password";
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: true,
        title: Text(
          'نسيت كلمة المرور',
          style: textTheme().displayLarge,
        ), //Forgot Password
      ),
      body: Body(),
    );
  }
}

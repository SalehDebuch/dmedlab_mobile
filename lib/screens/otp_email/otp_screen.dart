import 'package:flutter/material.dart';

import '../../services/general_services/size_config.dart';
import '../../theme.dart';
import 'components/body.dart';

class OtpEmailScreen extends StatelessWidget {
  static String routeName = "/otp_email";
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        centerTitle: true,
        title: Text("تأكيد الحساب", style: textTheme().displayLarge),
      ),
      body: Body(),
    );
  }
}

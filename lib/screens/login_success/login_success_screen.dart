import 'package:flutter/material.dart';

import 'components/body.dart';

class LoginSuccessScreen extends StatelessWidget {
  static String routeName = "/login_success";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //leading: SizedBox(),
        title: Align(
          child: Text("تم تسجيل الحساب بنجاح"),
          alignment: Alignment.center,
        ),
      ),
      body: Body(),
    );
  }
}

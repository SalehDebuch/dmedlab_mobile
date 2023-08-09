import 'package:flutter/material.dart';

import '../global/colors.dart';
import '../screens/sign_up/sign_up_screen.dart';
import '../theme.dart';

class NoAccountText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "ليس لديك حساب سابق؟ ",
          style: textTheme().displayLarge!.copyWith(color: kPrimaryColr),
        ),
        SizedBox(width: 5),
        InkWell(
          onTap: () => Navigator.pushNamed(context, SignUpScreen.routeName),
          child: Text(
            "انشاء حساب ",
            style: textTheme().displayLarge!.copyWith(color: Colors.black),
          ),
        ),
      ],
    );
  }
}

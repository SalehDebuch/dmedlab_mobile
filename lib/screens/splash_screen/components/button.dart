import '../../../theme.dart';
import 'package:flutter/material.dart';

import '../../../global/colors.dart';

String? text;

class CustomeButton extends StatelessWidget {
  const CustomeButton({
    Key? key,
    this.text,
    this.press,
  }) : super(key: key);
  final String? text;
  final Function? press;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: SizedBox(
        height: 60,
        child: TextButton(
          style: TextButton.styleFrom(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50.0)),
              backgroundColor: kPrimaryColr),
          onPressed: press as void Function()?,
          child: Text(
            text!,
            style: textTheme().displayLarge,
          ),
        ),
      ),
    );
  }
}

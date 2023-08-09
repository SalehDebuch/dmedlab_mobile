import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomSurffixIcon extends StatelessWidget {
  const CustomSurffixIcon({
    Key? key,
    required this.svgIcon,
    this.onPressed,
  }) : super(key: key);

  final String svgIcon;
  final onPressed;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(
        0,
        20,
        20,
        20,
      ),
      child: GestureDetector(
        onTap: onPressed,
        child: SvgPicture.asset(
          svgIcon,
          height: 20,
        ),
      ),
    );
  }
}

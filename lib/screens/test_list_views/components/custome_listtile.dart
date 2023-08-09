import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../global/colors.dart';
import '../../../theme.dart';

class CustomListTile extends StatelessWidget {
  final String icon;
  final String title;
  final VoidCallback onTap;

  const CustomListTile({
    required this.title,
    required this.onTap,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: ListTile(
        leading: SvgPicture.asset('assets/images/$icon.svg'),
        title: Text(
          title,
          textAlign: TextAlign.right,
          textDirection: TextDirection.rtl,
          style: textTheme().bodyMedium!.copyWith(color: kPrimaryColr),
        ),
        onTap: onTap,
      ),
    );
  }
}

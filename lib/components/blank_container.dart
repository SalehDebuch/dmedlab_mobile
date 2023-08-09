import 'package:flutter/material.dart';

import '../global/colors.dart';

class BlankContainer extends StatelessWidget {
  const BlankContainer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0.0,
      left: 0.0,
      right: 0.0,
      child: Container(
        height: MediaQuery.of(context).size.height * 0.087,
        decoration: BoxDecoration(
          color: kPrimaryColr,
          borderRadius: BorderRadius.only(
            topRight: Radius.elliptical(50, 50),
            topLeft: Radius.circular(50),
          ),
        ),
      ),
    );
  }
}

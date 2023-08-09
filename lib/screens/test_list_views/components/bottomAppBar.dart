import 'package:flutter/material.dart';
import '../../../global/colors.dart';
import '../../../global/global.dart';
import 'iconButton.dart';

class CustomBottomAppBar extends StatelessWidget {
  const CustomBottomAppBar({
    Key? key,
    required this.onHomeTap,
    required this.onFavoriteTap,
    required this.onProfileTap,
    required this.onBookmarkTap,
    required this.onSearchTap,
  }) : super(key: key);

  final VoidCallback onHomeTap;
  final VoidCallback onFavoriteTap;
  final VoidCallback onProfileTap;
  final VoidCallback onBookmarkTap;
  final VoidCallback onSearchTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 8),
      decoration: BoxDecoration(
          color: kPrimaryColr,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(50), topRight: Radius.circular(50))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          // Expanded(
          //   child: Column(
          //     mainAxisSize: MainAxisSize.min,
          //     mainAxisAlignment: MainAxisAlignment.center,
          //     children: <Widget>[
          //       Icon(Icons.home, size: 30, color: Colors.white),
          //       SizedBox(height: 4.0),
          //       Text(
          //         HomeIconeText,
          //         style: TextStyle(
          //             color: Colors.white,
          //             fontSize: 14,
          //             fontWeight: FontWeight.bold),
          //       ),
          //     ],
          //   ),
          // ),
          BottomIcon(
            color: kInactiveBottomIcons,
            icon: 'star',
            iconText: FavoriteIconeText,
            onTap: onFavoriteTap,
          ),
          // Expanded(
          //   child: Align(
          //     alignment: Alignment.center,
          //     child: Padding(
          //       padding: const EdgeInsets.only(right: 8),
          //       child: SvgPicture.asset(
          //         "assets/icons/doctor.svg",
          //         width: 50,
          //       ),
          //     ),
          //   ),
          // ),
          BottomIcon(
            color: kInactiveBottomIcons,
            icon: 'person',
            iconText: ProfileIconeText,
            onTap: onProfileTap,
          ),
          BottomIcon(
            color: kInactiveBottomIcons,
            icon: 'search',
            iconText: SearchIconeText,
            onTap: onSearchTap,
          ),
        ],
      ),
    );
  }
}

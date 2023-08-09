import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../theme.dart';

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
    return BottomAppBar(
      color: Color(0xFF2F8F9D),
      shape: CircularNotchedRectangle(),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: <Widget>[
            // Expanded(
            //   child: BottomIcon(
            //     icon: 'Icons.home',
            //     iconText: "Home",
            //     onTap: onHomeTap,
            //   ),
            // ),
            Expanded(
              child: BottomIcon(
                icon: 'star',
                iconText: "Favorite",
                onTap: onFavoriteTap,
              ),
            ),
            SizedBox(width: 48.0), // Gap for the profile icon
            Expanded(
              child: BottomIcon(
                icon: 'person',
                iconText: "Bookmarks",
                onTap: onBookmarkTap,
              ),
            ),
            Expanded(
              child: BottomIcon(
                icon: 'search',
                iconText: "Search",
                onTap: onSearchTap,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BottomIcon extends StatelessWidget {
  const BottomIcon({
    Key? key,
    required this.icon,
    required this.iconText,
    required this.onTap,
    this.color,
    this.textColor = Colors.white,
  }) : super(key: key);

  final String icon;
  final String iconText;
  final VoidCallback onTap;
  final Color? color;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          // Icon(icon, size: 30, color: color),
          SvgPicture.asset(
            'assets/images/$icon.svg',
            // height: 30,
            // color: Colors.black,
          ),
          SizedBox(height: 4.0),
          Text(
            iconText,
            style: textTheme().bodyMedium,
          ),
        ],
      ),
    );
  }
}

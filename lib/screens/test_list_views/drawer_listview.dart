import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../global/colors.dart';
import '../../global/global.dart';
import '../drawer_pages/about_app_screen.dart';
import '../drawer_pages/terms_and_conditions.dart';
import '../../theme.dart';

import '../../services/dialog_service/logout_dialog.dart';
import '../../services/dialog_service/show_upgrade_dialog.dart';
import '../profile/profile_screen.dart';
import 'components/custome_listtile.dart';

class DrawerListview extends StatefulWidget {
  const DrawerListview({Key? key}) : super(key: key);

  @override
  State<DrawerListview> createState() => _DrawerListviewState();
}

class _DrawerListviewState extends State<DrawerListview> {
  String? isUpgradedAccount;

  void initState() {
    readisUpgradedAccount();

    super.initState();
  }

  void readisUpgradedAccount() async {
    isUpgradedAccount = await storage.read(key: "isUpgradedAccount");
    setState(() {}); // add this line to update the UI
  }

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: ListView(
        children: [
          CustomListTile(
            icon: 'person',
            title: 'الملف الشخصي ',
            onTap: () {
              Navigator.pushNamed(context, ProfileScreen.routeName);
            },
          ),
          // Divider(color: Colors.grey[300], thickness: 1),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: ListTile(
              selected: false,
              leading: SvgPicture.asset('assets/images/card.svg'),
              title: isUpgradedAccount == 'true'
                  ? Text(
                      'الحساب مفعًل',
                      style:
                          textTheme().bodyMedium!.copyWith(color: kPrimaryColr),
                      textAlign: TextAlign.right,
                      textDirection: TextDirection.rtl,
                    )
                  : Text(
                      'تفعيل الحساب',
                      style:
                          textTheme().bodyMedium!.copyWith(color: kPrimaryColr),
                      textAlign: TextAlign.right,
                      textDirection: TextDirection.rtl,
                    ),
              onTap: isUpgradedAccount == 'true'
                  ? () async {}
                  : () async {
                      ShowDialogProvider().showLockedTestDialog(context);
                    },
            ),
          ),
          // Divider(color: Colors.grey[300], thickness: 1),
          CustomListTile(
            icon: 'info',
            title: 'حول التطبيق',
            onTap: () {
              //   showComingSoonDialog(context);
              Navigator.pushNamed(context, AboutAppPage.routeName);
            },
          ),
          // Divider(color: Colors.grey[300], thickness: 1),
          // CustomListTile(
          //   icon: Icons.settings,
          //   title: ' الإعدادات ',
          //   onTap: () {
          //     showComingSoonDialog(context);
          //   },
          // ),
          // Divider(color: Colors.grey[300], thickness: 1),

          // CustomListTile(
          //   icon: Icons.help_outline,
          //   title: 'دليل المستخدم ',
          //   onTap: () {
          //     showComingSoonDialog(context);
          //   },
          // ),
          // Divider(color: Colors.grey[300], thickness: 1),
          CustomListTile(
            icon: 'policy',
            title: 'الشروط والأحكام',
            onTap: () {
              Navigator.pushNamed(context, TermsAndConditionsPage.routeName);
            },
          ),
          // Divider(color: Colors.grey[300], thickness: 1),

          CustomListTile(
            icon: 'logout',
            title: 'تسجيل الخروج',
            onTap: () async {
              onLogOut(context);
            },
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';

import '../../global/global.dart';
import '../../theme.dart';

class AboutAppPage extends StatelessWidget {
  static String routeName = '/about_app';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'حول التطبيق',
          style: textTheme().bodyLarge,
        ),
      ),
      body: SingleChildScrollView(
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  appNameArabic,
                  style:
                      textTheme().displaySmall!.copyWith(color: Colors.black),
                ),
                SizedBox(height: 16),
                Text(
                  appVersion,
                  style: textTheme().bodyMedium!.copyWith(color: Colors.black),
                ),
                SizedBox(height: 16),
                // Text(
                //   'الوصف:',
                //   style:
                //       textTheme().displaySmall!.copyWith(color: Colors.black),
                // ),
                // SizedBox(height: 8),
                Text(
                  appDescription,
                  style: textTheme().bodyMedium!.copyWith(color: Colors.black),
                ),
                SizedBox(height: 8),
                Text(
                  'المؤلفون :',
                  style:
                      textTheme().displaySmall!.copyWith(color: Colors.black),
                ),
                SizedBox(height: 8),
                Text(
                  appauthorDescription1,
                  style: textTheme().bodyMedium!.copyWith(color: Colors.black),
                ),
                Text(
                  appauthorDescription2,
                  style: textTheme().bodyMedium!.copyWith(color: Colors.black),
                ),
                Text(
                  appauthorDescription3,
                  style: textTheme().bodyMedium!.copyWith(color: Colors.black),
                ),
                SizedBox(height: 8),
                Text(
                  'حول المطور:',
                  style:
                      textTheme().displaySmall!.copyWith(color: Colors.black),
                ),
                SizedBox(height: 8),
                Text(
                  appDeveloperDescription,
                  style: textTheme().bodyMedium!.copyWith(color: Colors.black),
                ),
                SizedBox(height: 16),
                Text(
                  contactTitle,
                  style:
                      textTheme().displaySmall!.copyWith(color: Colors.black),
                ),
                SizedBox(height: 8),
                Text(
                  'البريد الإلكتروني: $contactEmail',
                  style: textTheme().bodyMedium!.copyWith(color: Colors.black),
                ),
                Text(
                  'الدعم الفني : $supportEmail',
                  style: textTheme().bodyMedium!.copyWith(color: Colors.black),
                ),
                SizedBox(height: 8),
                Text(
                  'رقم الهاتف: $contactPhone',
                  style: textTheme().bodyMedium!.copyWith(color: Colors.black),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

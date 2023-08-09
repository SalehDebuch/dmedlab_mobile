import 'package:flutter/material.dart';

import '../../global/global.dart';
import '../../screens/sign_in/sign_in_screen.dart';
import '../auth/auth_provider.dart';

Future<bool> onLogOut(BuildContext context) async {
  return (await showDialog(
        context: context,
        builder: (context) => Directionality(
          textDirection: TextDirection.rtl,
          child: AlertDialog(
            title: Text(ExitDialogTitle),
            content: Text(ExitDialogContent),
            actions: <Widget>[
              TextButton(
                onPressed: () async {
                  await AuthProvider().logout();
                  Navigator.pushNamedAndRemoveUntil(
                      context, SignInScreen.routeName, (route) => false);
                },
                child: Text(Yes),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: Text(No),
              ),
            ],
          ),
        ),
      )) ??
      false;
}

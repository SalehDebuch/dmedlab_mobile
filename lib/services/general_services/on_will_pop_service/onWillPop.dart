import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../global/global.dart';

Future<bool> onWillPop(BuildContext context) async {
  return (await showDialog(
        context: context,
        builder: (context) => Directionality(
          textDirection: TextDirection.rtl,
          child: AlertDialog(
            title: Text(ExitWillpopTitle),
            content: Text(ExitWillpopContent),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text(No),
              ),
              TextButton(
                onPressed: () => SystemNavigator.pop(),
                child: Text(Yes),
              ),
            ],
          ),
        ),
      )) ??
      false;
}

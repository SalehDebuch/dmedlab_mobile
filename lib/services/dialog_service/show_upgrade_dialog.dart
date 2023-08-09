import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../global/global.dart';
import 'show_Activation_options_dialog.dart';

class ShowDialogProvider with ChangeNotifier {
  bool _isUpgradedAccount = false;
  bool get isUpgradedAccount => _isUpgradedAccount;

  Future<void> getisUpgradedAccountFromStorage() async {
    final value = await storage.read(key: 'isUpgradedAccount');
    if (value == 'true') {
      _isUpgradedAccount = true;
    } else {
      _isUpgradedAccount = false;
    }
    notifyListeners();
  }

  void showLockedTestDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'ترقية الحساب',
            textAlign: TextAlign.right,
          ),
          content: Text.rich(
            TextSpan(
              text: PaymentPromotionDialog,
              children: <TextSpan>[
                TextSpan(
                  text: 'الآن',
                  style: TextStyle(
                    color: Colors.blue,
                    decoration: TextDecoration.underline,
                  ),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      showActivationOptionsDialog(context);
                    },
                ),
              ],
            ),
            textAlign: TextAlign.right,
          ),
          actions: <Widget>[
            TextButton(
              child: Text('الغاء'),
              onPressed: () {
                Navigator.of(context).pop(context);
              },
            ),
            TextButton(
              child: Text('ترقية الحساب'),
              onPressed: () async {
                showActivationOptionsDialog(context);
              },
            ),
          ],
        );
      },
    );
  }

  static ShowDialogProvider of(
    BuildContext context, {
    bool listen = true,
  }) {
    return Provider.of<ShowDialogProvider>(
      context,
      listen: listen,
    );
  }
}

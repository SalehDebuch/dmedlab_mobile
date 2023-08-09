import 'package:flutter/material.dart';

import '../../global/global.dart';

Future<void> showSuccessDialog(BuildContext context) async {
  await showDialog(
    context: context,
    builder: (BuildContext context) {
      Future.delayed(Duration(seconds: 3), () {
        Navigator.of(context).pop(true); // close the dialog
      });
      return Directionality(
        textDirection: TextDirection.rtl,
        child: AlertDialog(
          title: Text(Success),
          content: Text(ActivationSuccess),
        ),
      );
    },
  );
}

Future<void> showErrorDialog(BuildContext context) async {
  await showDialog(
    context: context,
    builder: (BuildContext context) {
      Future.delayed(Duration(seconds: 2), () {
        Navigator.of(context).pop(true); // close the dialog
      });
      return Directionality(
        textDirection: TextDirection.rtl,
        child: AlertDialog(
          title: Text(Error),
          content: Text(invalidActivationKey),
        ),
      );
    },
  );
}

Future<void> showGeneralErrorDialog(BuildContext context) async {
  await showDialog(
    context: context,
    builder: (BuildContext context) {
      Future.delayed(Duration(seconds: 2), () {
        Navigator.of(context).pop(true); // close the dialog
      });
      return Directionality(
        textDirection: TextDirection.rtl,
        child: AlertDialog(
          title: Text(Error),
          content: Text(GeneralErrorMassege),
        ),
      );
    },
  );
}

Future<void> showNoConnectionDialog(BuildContext context) async {
  await showDialog(
    context: context,
    builder: (BuildContext context) {
      Future.delayed(Duration(seconds: 2), () {
        Navigator.of(context).pop(true); // close the dialog
      });
      return Directionality(
        textDirection: TextDirection.rtl,
        child: AlertDialog(
          title: Text(Error),
          content: Text(kInternetConnectionErrorr),
        ),
      );
    },
  );
}

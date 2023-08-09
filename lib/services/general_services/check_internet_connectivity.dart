import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';

import '../../global/global.dart';
import '../../global/snackbar.dart';

Future<bool> checkInternetConnection() async {
  try {
    final result = await InternetAddress.lookup('google.com')
        .timeout(Duration(seconds: 1));
    if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
      return true;
    }
  } on SocketException catch (_) {
    return false;
  } on TimeoutException catch (_) {
    return false;
  }
  return false;
}

Future<void> checkAndShowInternetConnection(BuildContext context) async {
  bool isConnect = await checkInternetConnection();
  if (!isConnect) {
    errorSnackBar(context, kInternetConnectionErrorr);
  }
}

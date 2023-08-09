import 'dart:io';

import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../global/colors.dart';
import '../auth/auth_provider.dart';
import '../dialog_service/show_upgrade_dialog.dart';
import '../lab_test_service/fetch_test_and_favorite.dart';
import '../lab_test_service/switch_test_title_provider.dart';

Future<void> loadSSLCertificate() async {
  final data = await rootBundle.load('assets/ca/lets-encrypt-r3.pem');
  final certificate = data.buffer.asUint8List();
  SecurityContext.defaultContext.setTrustedCertificatesBytes(certificate);
}

void setSystemUIOverlayStyle() {
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      // statusBarColor: Color.fromARGB(255, 5, 77, 81),
      statusBarColor: kPrimaryColr,
      // statusBarBrightness: Brightness.dark,

      statusBarBrightness: Brightness.light,
      statusBarIconBrightness: Brightness.light,
    ),
  );
}

List<ChangeNotifierProvider> providers = [
  ChangeNotifierProvider<AuthProvider>(create: (_) => AuthProvider()),
  ChangeNotifierProvider<FavoriteProvider>(create: (_) => FavoriteProvider()),
  ChangeNotifierProvider<TestListProvider>(create: (_) => TestListProvider()),
  ChangeNotifierProvider<ShowDialogProvider>(
      create: (_) => ShowDialogProvider()),
];

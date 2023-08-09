import 'dart:io';
import 'package:device_preview/device_preview.dart';
import 'screens/sign_in/login_screen.dart';
import 'services/auth/check_user_auth.dart';
import 'routes.dart';
import 'screens/awareness/awarencess_screen.dart';
import 'screens/home/home_screen.dart';
import 'theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'global/payment.dart';
import 'services/general_services/main_service.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

bool isSeen = false;
bool isLoggedIn = false;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  ByteData data =
      await PlatformAssetBundle().load('assets/ca/lets-encrypt-r3.pem');
  SecurityContext.defaultContext
      .setTrustedCertificatesBytes(data.buffer.asUint8List());
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  setSystemUIOverlayStyle();
  Stripe.publishableKey = STRIPE_PUBLISHABLE_KEY;

  isSeen = await checkFirstSeen();
  // Check if the user is logged in
  isLoggedIn = await checkUserLoggedIn();

  runApp(MultiProvider(
    providers: providers,
    // child: MyApp(),
    child: DevicePreview(
      enabled: false, //!kReleaseMode,
      builder: (context) => MyApp(), // Wrap your app
    ),
  ));
}

class MyApp extends StatelessWidget {
  static String title = 'DMedLab';
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      locale: DevicePreview.locale(context),
      // builder: DevicePreview.appBuilder,
      builder: (BuildContext context, Widget? child) {
        return MediaQuery(
          data: MediaQuery.of(context)
              .copyWith(textScaleFactor: 1.0, boldText: false),
          child: child!,
        );
      },
      title: title,
      theme: theme(),
      initialRoute: isSeen
          ? isLoggedIn
              ? HomeScreen.routeName
              : LoginScreen.routeName
          : AwarencessScreen.routeName,

      routes: routes,
    );
  }
}

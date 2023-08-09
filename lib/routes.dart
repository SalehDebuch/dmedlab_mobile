import 'screens/abbreviation/abbreviation_screen.dart';
import 'screens/awareness/awarencess_screen.dart';
import 'screens/definition/definition_screen.dart';
import 'screens/drawer_pages/terms_and_conditions.dart';
import 'screens/favorite_test/favourite_screen.dart';
import 'screens/home/home_screen.dart';
import 'screens/lab_test_view/lab_test_view2.dart';
import 'screens/profile/profile_screen.dart';
import 'screens/sign_in/login_screen.dart';
import 'screens/sign_up/signup_screen2.dart';
import 'screens/test_list_views/components/test_list_view.dart';
import 'screens/tubes/tubes_screen.dart';
import 'package:flutter/widgets.dart';

import 'screens/drawer_pages/about_app_screen.dart';
import 'screens/login_success/login_success_screen.dart';
import 'screens/otp_email/otp_screen.dart';
import 'screens/reset_password/resetPassword.dart';
import 'screens/forgot_password/forgot_password_screen.dart';

final Map<String, WidgetBuilder> routes = {
  // SplashScreen.routeName: (context) => SplashScreen(),
  ForgotPasswordScreen.routeName: (context) => ForgotPasswordScreen(),
  OtpEmailScreen.routeName: (context) => OtpEmailScreen(),
  ForgotPasswordScreen.routeName: (context) => ForgotPasswordScreen(),

  TestListView.routeName: (context) => TestListView(),
  SignUpView.routeName: (context) => SignUpView(),
  // SignUpScreen.routeName: (context) => SignUpScreen(),
  ResetPassword.routeName: (context) => ResetPassword(),
  LoginSuccessScreen.routeName: (context) => LoginSuccessScreen(),
  // SignInScreen.routeName: (context) => SignInScreen(),
  LoginScreen.routeName: (context) => LoginScreen(),
  FavoritesScreen.routeName: (context) => FavoritesScreen(),
  ProfileScreen.routeName: (context) => ProfileScreen(),
  // TestView.routeName: (context) => TestView(),
  HomeScreen.routeName: (context) => HomeScreen(),
  LabTestView.routeName: (context) => LabTestView(),
  TubesScreen.routeName: (context) => TubesScreen(),
  //StripePayment.routeName: (context) => StripePayment(),
  AboutAppPage.routeName: (context) => AboutAppPage(),
  DefinitionScreen.routeName: (context) => DefinitionScreen(),
  AbbreviationScreen.routeName: (context) => AbbreviationScreen(),
  AwarencessScreen.routeName: (context) => AwarencessScreen(),
  TermsAndConditionsPage.routeName: (context) => TermsAndConditionsPage(),
};

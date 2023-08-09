import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'global/colors.dart';

ThemeData theme() {
  return ThemeData(
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: appBarTheme(),
    textTheme: textTheme(),
    inputDecorationTheme: inputDecorationTheme(),
    visualDensity: VisualDensity.adaptivePlatformDensity,
  );
}

InputDecorationTheme inputDecorationTheme() {
  OutlineInputBorder outlineInputBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(50),
    borderSide: BorderSide(color: kPrimaryColr, width: 5),
    // gapPadding: 10,
  );
  return InputDecorationTheme(
    // If  you are using latest version of flutter then lable text and hint text shown like this
    // if you r using flutter less then 1.20.* then maybe this is not working properly
    // if we are define our floatingLabelBehavior in our theme then it's not applayed
    // floatingLabelBehavior: FloatingLabelBehavior.always,
    contentPadding: EdgeInsets.symmetric(vertical: 20, horizontal: 42),

    enabledBorder: outlineInputBorder,
    focusedBorder: outlineInputBorder,
    border: outlineInputBorder,
  );
}

TextTheme textTheme() {
  return TextTheme(
    displayLarge: TextStyle(
      fontFamily: 'Cairo',
      fontSize: 24,
      fontWeight: FontWeight.bold,
      color: Colors.white,
    ),
    displayMedium: TextStyle(
      fontFamily: 'Cairo',
      fontSize: 22,
      fontWeight: FontWeight.bold,
      color: Colors.white,
    ),
    displaySmall: TextStyle(
      fontFamily: 'Cairo',
      fontSize: 20,
      fontWeight: FontWeight.bold,
      color: Colors.white,
    ),
    bodyLarge: TextStyle(
      fontFamily: 'Cairo',
      fontSize: 18,
      fontWeight: FontWeight.bold,
      color: Colors.white,
    ),
    bodyMedium: TextStyle(
      fontFamily: 'Cairo',
      fontSize: 16,
      fontWeight: FontWeight.bold,
      color: Colors.white,
    ),
    bodySmall: TextStyle(
      fontFamily: 'Cairo',
      fontSize: 13,
      fontWeight: FontWeight.bold,
      color: Colors.white,
    ),
    // bodyLarge: TextStyle(
    //   fontFamily: 'Cairo',
    //   fontSize: 18,
    //   fontWeight: FontWeight.bold,
    //   color: Colors.white,
    // ),
    //   bodyMedium: TextStyle(
    //     fontSize: 16,
    //     fontFamily: 'NotoKufi',
    //     fontWeight: FontWeight.bold,
    //     color: kTextColor,
    //   ),
    //   titleLarge: TextStyle(
    //     fontSize: 24,
    //     fontFamily: 'NotoKufi',
    //     fontWeight: FontWeight.bold,
    //     color: Colors.white,
    //   ),
    //   titleMedium: TextStyle(
    //     fontSize: 18,
    //     fontFamily: 'NotoKufi',
    //     fontWeight: FontWeight.bold,
    //     color: kPrimaryColr,
    //   ),
  );
}

AppBarTheme appBarTheme() {
  return AppBarTheme(
    color: kPrimaryColr,
    elevation: 0,
    centerTitle: true,
    iconTheme: IconThemeData(color: Colors.white),
    systemOverlayStyle: SystemUiOverlayStyle.dark,
    toolbarTextStyle: TextTheme(
      // titleLarge: GoogleFonts.cairo(fontSize: 22),
      titleLarge: TextStyle(color: Colors.white, fontSize: 22),
    ).bodyMedium,
    titleTextStyle: TextTheme(
      titleLarge: TextStyle(color: Colors.white, fontSize: 18),
      // titleLarge: GoogleFonts.cairo(fontSize: 18),
    ).titleLarge,
  );
}

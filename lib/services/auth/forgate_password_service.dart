import 'dart:convert';

import '../../screens/sign_in/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../global/global.dart';
import '../../global/snackbar.dart';
import '../general_services/check_internet_connectivity.dart';

class PasswordReset {
  String? otp;

  Future forgotPassword(String email, context) async {
    checkAndShowInternetConnection(context);
    String? storedToken = await storage.read(key: 'token');
    final Map<String, String> authHeaders = {
      "Authorization": "Bearer $storedToken",
      "Content-Type": "application/json"
    };

    var body = json.encode({'email': email});
    var url = Uri.parse(MainServerUrl + 'password/forgot');
    http.Response response = await http.post(
      url,
      headers: authHeaders,
      body: body,
    );

    Map myData = jsonDecode(response.body);

    otp = myData['verification_code'].toString();

    final statusCode = response.statusCode;

    if (statusCode == 200) {
      Navigator.pushReplacementNamed(context, LoginScreen.routeName,
          arguments: email);

      passSnackBar(context, "قمنا بارسال رابط اعادة تعيين كلمة السر ");
    } else if (statusCode == 401) {
      errorSnackBar(context, "الحساب غير مسجل سابقا");
    } else {
      errorSnackBar(context, "يوجد مشكلة ما يرجى اعادة المحاولة");
    }
  }

  Future<http.Response> resetPassword(
      String email, String password, String confirmedPassword, context) async {
    checkAndShowInternetConnection(context);

    Map data = {
      'email': email,
      'password': password,
      'password_confirmation': confirmedPassword,
    };
    var body = json.encode(data);
    var url = Uri.parse(MainServerUrl + 'reset');
    http.Response response = await http.post(
      url,
      headers: headers,
      body: body,
    );
    return response;
  }
}

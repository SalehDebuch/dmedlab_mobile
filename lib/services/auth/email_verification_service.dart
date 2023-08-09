import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../global/snackbar.dart';
import 'dart:convert';

import '../../global/global.dart';
import '../../screens/otp_email/otp_screen.dart';
import '../general_services/check_internet_connectivity.dart';

class EmailVerification {
  String? otp;

  Future sendVerificationEmail(String email, context) async {
    checkAndShowInternetConnection(context);

    var body = json.encode({'email': email});
    var url = Uri.parse(MainServerUrl + 'resend-verification-code');
    http.Response response = await http.post(
      url,
      headers: headers,
      body: body,
    );
    Map myData = jsonDecode(response.body);

    otp = myData['verification_code'].toString();
    storage.write(key: 'otp', value: otp!);
    final statusCode = response.statusCode;

    if (statusCode == 200) {
      Navigator.pushReplacementNamed(context, OtpEmailScreen.routeName,
          arguments: email);

      passSnackBar(context, "قمنا بارسال رمز التحقق الى حسابك الالكتروني");
    } else if (statusCode == 401) {
      errorSnackBar(context, "الحساب غير مسجل سابقا");
    } else {
      errorSnackBar(context, "يوجد مشكلة ما يرجى اعادة المحاولة");
    }
  }

  Future<http.Response> verifyEmail(
      String email, String userOtp, context) async {
    checkAndShowInternetConnection(context);

    Map data = {'email': email, 'verification_code': userOtp};
    var body = json.encode(data);
    final Map<String, String> authHeaders = {
      "Authorization": "Bearer $storedToken",
      "Content-Type": "application/json"
    };

    var url = Uri.parse(MainServerUrl + 'verify-code');
    http.Response response = await http.post(
      url,
      headers: authHeaders,
      body: body,
    );
    var myData = jsonDecode(response.body);

    otp = myData['verification_code'].toString();
    return response;
  }
}

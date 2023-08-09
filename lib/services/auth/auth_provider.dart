import 'dart:convert';

import '../../screens/sign_in/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../../global/global.dart';
import '../../global/snackbar.dart';
import '../../models/user.dart';
import '../../screens/home/home_screen.dart';
import '../general_services/check_internet_connectivity.dart';

class AuthProvider extends ChangeNotifier {
  bool _isLoggedIn = false;
  bool get authenticated => _isLoggedIn;

  late User? _user;
  late String? accessToken;
  String? otp;
  User? get user => _user;
  String? deviceName;
  String? get email => email;
  String? userOtp;
  String? storedToken;
  static String? userId;

  Future<void> deleteAccount(
      String password, BuildContext context, String? storedToken) async {
    await checkAndShowInternetConnection(context);
    final data = {"password": password};
    final body = json.encode(data);

    if (storedToken == null) {
      return;
    } else {
      try {
        final response = await http.delete(
            Uri.parse(MainServerUrl + "deleteAccount"),
            headers: {
              "Content-Type": "application/json",
              'Authorization': 'Bearer $storedToken'
            },
            body: body);
        print(response.body);
        if (response.statusCode == 200) {
          Navigator.pushNamedAndRemoveUntil(
            context,
            LoginScreen.routeName,
            (route) => false,
          );
        } else if (response.statusCode == 422) {
          errorSnackBar(context, EmailOrPasswordNotCorrect);
        } else {
          errorSnackBar(context, GeneralErrorMassege);
        }
      } catch (e) {
        // await logout();
        print(e);
      }
    }
  }

  static Future<http.Response> register(String name, String email,
      String password, String deviceName, context) async {
    await checkAndShowInternetConnection(context);

    final Map<String, dynamic> data = {
      "name": name,
      "email": email,
      "password": password,
      //  "device_name": deviceName,
    };

    final body = json.encode(data);
    final url = Uri.parse(MainServerUrl + 'register');
    final response = await http.post(
      url,
      headers: headers,
      body: body,
    );
    return response;
  }

  Future<void> getUser(String? storedToken) async {
    // print('storedToken in getuser function $storedToken');
    if (storedToken == null) {
      return;
    } else {
      try {
        final response = await http.get(
          Uri.parse(MainServerUrl + "user"),
          headers: {
            "Content-Type": "application/json",
            'Authorization': 'Bearer $storedToken'
          },
        );
        print("get user statue code is ${response.statusCode}");
        if (response.statusCode == 200) {
          _isLoggedIn = true;
          print('response.body is ${response.body}');
          _user = User.fromJson(json.decode(response.body));

          print(_user!.email);

          print(_user!.id);
          print(_user!.name);
          storage.write(key: 'name', value: _user!.name);
          storage.write(key: 'email', value: _user!.email);
          storage.write(key: 'userId', value: _user!.id.toString());
          //storage.write(key: 'isUpgradedAccount', value: _user!.isUpgradedAccount);
          notifyListeners();
        } else {
          throw Exception('Failed to get user information');
        }
      } catch (e) {
        // await logout();
        print(e);
      }
    }
  }

  Future<void> login(
      String email, String password, BuildContext context) async {
    await checkAndShowInternetConnection(context);

    // Create request body
    final data = {"email": email, "password": password};
    final body = json.encode(data);

    // Send login request
    final url = Uri.parse(MainServerUrl + 'login');
    final response = await http.post(url, headers: headers, body: body);

    // Handle response
    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);

      // Store token
      final auth = Provider.of<AuthProvider>(context, listen: false);
      storedToken = responseData['token'];
      //print("user.token is : ${user.token}");
      await storage.write(key: 'token', value: storedToken);
      await storage.read(key: 'token');
      // print('readen token from storage is $x');
      await auth.getUser(storedToken);

      // Navigate to next screen
      Navigator.pushNamedAndRemoveUntil(
        context,
        HomeScreen.routeName,
        (route) => false,
      );
    } else if (response.statusCode == 422) {
      errorSnackBar(context, EmailOrPasswordNotCorrect);
    } else {
      errorSnackBar(context, GeneralErrorMassege);
    }

    // Handle unexpected errors
  }

  Future<http.Response> logout() async {
    final storedToken = await storage.read(key: 'token');
    final response = await http.get(
      Uri.parse(MainServerUrl + "logout"),
      headers: {'Authorization': 'Bearer $storedToken'},
    );
    cleanUp();
    notifyListeners();
    return response;
  }

  void cleanUp() async {
    this._user = null;
    this._isLoggedIn = false;
    this.accessToken = null;
    this.otp = null;
    this.userOtp = null;
    await storage.delete(key: 'token');
    await storage.delete(key: 'name');
    await storage.delete(key: 'email');
    await storage.delete(key: 'userId');
    await storage.delete(key: 'isUpgradedAccount');
  }

  static AuthProvider of(BuildContext context, {bool listen = true}) {
    return Provider.of<AuthProvider>(
      context,
      listen: listen,
    );
  }
}

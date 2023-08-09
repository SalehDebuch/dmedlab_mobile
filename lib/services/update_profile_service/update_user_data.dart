import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../global/global.dart';
import '../../global/snackbar.dart';
import '../../screens/test_list_views/tests_list_screen.dart';
import '../general_services/check_internet_connectivity.dart';

Future<void> updateUserProfile(
    String id, String name, String email, BuildContext context) async {
  checkAndShowInternetConnection(context);
  await storage.write(key: 'name', value: name);
  Map data = {'name': name, 'email': email};
  final url = Uri.parse(MainServerUrl + 'users/$id');

  final http.Response response =
      await http.put(url, headers: headers, body: json.encode(data));
  if (response.statusCode == 200) {
    // The user profile was updated successfully.
    // final dynamic responseData = json.decode(response.body);
    passSnackBar(context, UpdateUserProfileSuccess);
    Navigator.pushNamedAndRemoveUntil(
        context, TestsLists.routeName, (route) => false);
  }

  // Do something with the responseData.
  else {
    // There was an error updating the user profile.
    //final dynamic errorData = json.decode(response.body);
    errorSnackBar(context, GeneralErrorMassege);
    // Do something with the errorData.
  }
}

// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:dmed_lab/global/global.dart';
// import 'package:dmed_lab/screens/test_list_views/tests_list_screen.dart';

// import '../check_internet_connectivity.dart';
// import '../dialog_service/show_accessOrFailed_activation_dialog.dart';
// import '../fetch_test_services/fetch_test_and_favorite.dart';

// Future checkActivationKey(
//     String userId, String email, String activationKey, context) async {
//   checkAndShowInternetConnection(context);

//   // final response = await http.post(
//   //   Uri.parse(MainServerUrl + 'check-activation'),
//   //   body: {
//   //     'user_id': userId,
//   //     'activation_Key': activationKey,
//   //   },
//   // );
//   // if (response.statusCode == 200) {
//   // The API call was successful
//   await storage.write(key: 'isUpgradedAccount', value: 'true');
//   await FavoriteProvider().fetchTestList();

//   //   await showSuccessDialog(context); // Show a success alert for two seconds
//   //   Navigator.pushReplacementNamed(context, TestsLists.routeName);
//   // } else if (response.statusCode == 400) {
//   //   {
//   //     // The API call failed
//   //     await showErrorDialog(context); // Show an error alert for two seconds
//   //   }
//   // }
// }

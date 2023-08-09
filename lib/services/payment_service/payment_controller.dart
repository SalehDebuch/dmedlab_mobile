import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../global/global.dart';
import '../../screens/test_list_views/tests_list_screen.dart';

import '../../models/payment.dart';
import '../dialog_service/show_accessOrFailed_activation_dialog.dart';

class StripeController {
  Future<Map<String, dynamic>> createPaymentIntent(Payment payment) async {
    final url = Uri.parse(MainServerUrl + 'payment-intent');

    try {
      final response = await http.post(
        url,
        headers: headers,
        body: jsonEncode(payment.toMap()),
      );
      if (response.statusCode == 200) {
        final responseBody = jsonDecode(response.body);
        return responseBody;
      } else {
        throw Exception('Failed to create payment intent: ${response.body}');
      }
    } catch (e) {
      throw Exception('Failed to create payment intent $e');
    }
  }

  Future<void> confirmPayment(String intentId, context, String userId) async {
    final url = Uri.parse(MainServerUrl + 'payment-confirm');
    final body = {'intent_id': intentId, 'user_id': userId};
    try {
      final response = await http.post(url, body: body);
      if (response.statusCode == 200) {
        await storage.write(key: 'isUpgradedAccount', value: 'true');
        await showSuccessDialog(
            context); // Show a success alert for two seconds
        Navigator.pushNamedAndRemoveUntil(
            context, TestsLists.routeName, (route) => false);
      }
    } catch (e) {
      throw Exception('Failed to confirm payment');
    }
  }
}

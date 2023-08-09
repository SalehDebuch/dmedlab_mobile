import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import '../test_list_views/tests_list_screen.dart';
import '../../global/global.dart';
import '../../models/payment.dart';
import '../../services/general_services/check_internet_connectivity.dart';
import '../../services/payment_service/payment_controller.dart';
import '../../services/lab_test_service/fetch_test_and_favorite.dart';

final StripeController _stripeController = StripeController();
Map<String, dynamic>? paymentIntent;

Future<void> makePayment(BuildContext context, userId, email, name) async {
  checkAndShowInternetConnection(context);
  try {
    final payment = Payment(
      amount: '2000',
      currency: 'usd',
      userEmail: email,
      name: name,
      description: 'This payment is for Arabic Lab Encyclopedia',
    );

    paymentIntent = await _stripeController.createPaymentIntent(payment);

    if (paymentIntent != null) {
      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          paymentIntentClientSecret: paymentIntent?['client_secret'],
          style: ThemeMode.light,
          merchantDisplayName: 'Arabic dmed_lab',
        ),
      );
      await Stripe.instance.presentPaymentSheet();
      await _stripeController.confirmPayment(
          paymentIntent!['id'], context, userId!);

      showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            child: SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                    maxHeight: MediaQuery.of(context).size.height * 0.6),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.check_circle, color: Colors.green, size: 50),
                      SizedBox(height: 20),
                      Text('Payment Success',
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white)),
                      SizedBox(height: 20),
                      Text(
                          'Payment of ${paymentIntent?['amount'] / 100} ${paymentIntent?['currency']} was successful.'),
                      SizedBox(height: 20),
                      TextButton(
                        onPressed: () async {
                          await storage.write(
                              key: 'isUpgradedAccount', value: 'true');
                          await FavoriteProvider().fetchAllTests();
                          Navigator.pushNamedAndRemoveUntil(
                              context, TestsLists.routeName, (route) => false);
                        },
                        child: const Text('OK'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      );
    } else {
      print('Error creating Payment Intent');
    }
  } catch (e) {
    print('Error making Payment: $e');
  }
}

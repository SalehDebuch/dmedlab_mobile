import 'package:flutter/material.dart';

import '../../global/global.dart';
import '../../screens/payment/stripe_payment.dart';
import '../storage_service/storage_service.dart';
import 'show_activation_code.dart';

String? userId;
String? email;
String? name;

showActivationOptionsDialog(BuildContext context) async {
  userId = await StorageServices().getUserID();
  email = await storage.read(key: 'email');
  name = await storage.read(key: 'name');
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Container(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              ElevatedButton(
                onPressed: () async {
                  // Navigator.pop(context);

                  await makePayment(context, userId, email!, name);
                  // show Stripe payment form
                },
                child: Text(
                  'الدفع الإلكتروني',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  padding: EdgeInsets.all(16.0),
                ),
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  // Navigator.of(context).pop(context);
                  showActivationCodeDialog(context);
                  // show activation code input form
                },
                child: Text(
                  'لديَ رمز التفعيل',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  padding: EdgeInsets.all(16.0),
                ),
              ),
              SizedBox(height: 16.0),
              TextButton(
                child: Text(
                  'إلغاء',
                  style: TextStyle(
                    fontSize: 18.0,
                    color: Colors.blue,
                  ),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        ),
      );
    },
  );
}

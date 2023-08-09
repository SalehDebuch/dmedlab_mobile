import 'package:flutter/material.dart';

Future<void> errorSnackBar(
  BuildContext context,
  String text,
) async {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    backgroundColor: Colors.red,
    content: Text(
      text,
      style: TextStyle(fontSize: 16),
      textAlign: TextAlign.center,
    ),
    duration: const Duration(seconds: 2),
  ));
}

Future<void> passSnackBar(
  BuildContext context,
  String text,
) async {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    backgroundColor: Colors.green[800],
    content: Text(
      text,
      style: TextStyle(fontSize: 16),
      textAlign: TextAlign.center,
    ),
    duration: const Duration(seconds: 2),
  ));
}

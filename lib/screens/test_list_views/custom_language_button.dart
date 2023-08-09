import 'package:flutter/material.dart';

class CustomLangugeButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  CustomLangugeButton({required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      child: Text(
        text,
        style: TextStyle(color: Colors.white, fontSize: 18),
      ),
      color: Color.fromARGB(255, 97, 101, 99),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
    );
  }
}

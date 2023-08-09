import 'package:flutter/material.dart';

import '../../global/global.dart';

class CustomSearchField extends StatefulWidget {
  final TextEditingController? controller;
  final Function(String)? onChanged;
  final FocusNode? focusNode;

  CustomSearchField({
    this.controller,
    this.onChanged,
    this.focusNode,
  });

  @override
  _CustomSearchFieldState createState() => _CustomSearchFieldState();
}

class _CustomSearchFieldState extends State<CustomSearchField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(8),
      child: SizedBox(
        height: 60,
        child: Theme(
          data: ThemeData(
            // Define a new theme for the text field
            inputDecorationTheme: InputDecorationTheme(
              border: OutlineInputBorder(),
              hintStyle: TextStyle(
                fontSize: 14,
                //  fontWeight: FontWeight.w400,
              ),
              filled: true,
            ),
          ),
          child: Row(
            children: [
              Expanded(
                child: TextFormField(
                  focusNode: widget.focusNode,
                  cursorColor: Color(0xFF2F8F9D),
                  controller: widget.controller,
                  textDirection: TextDirection.rtl,
                  textAlign: TextAlign.end,
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Color(0xFF2F8F9D), width: 2)),
                    focusColor: Color(0xFF2F8F9D),
                    border: OutlineInputBorder(),
                    suffixIcon: Icon(
                      Icons.search,
                      color: Color(0xFF2F8F9D),
                    ),
                    hintText: SearchTextFieldHint,
                    hintStyle: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                    ),
                    filled: true,
                  ),
                  onChanged: widget.onChanged,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'custom_language_button.dart';

import '../../services/lab_test_service/switch_test_title_provider.dart';

class LanguageSelector extends StatelessWidget {
  const LanguageSelector({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final testProvider = TestListProvider.of(context);
    return Padding(
      padding: const EdgeInsets.fromLTRB(5, 0, 8, 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Expanded(
            child: CustomLangugeButton(
              onPressed: (() {
                testProvider.setSelectedLanguage('en');
              }),
              text: "En",
            ),
          ),
          SizedBox(width: 20),
          Expanded(
            child: CustomLangugeButton(
              onPressed: (() {
                testProvider.setSelectedLanguage('ar');
              }),
              text: "Ar",
            ),
          ),
          SizedBox(width: 20),
          Expanded(
            child: CustomLangugeButton(
              onPressed: (() {
                testProvider.setSelectedLanguage('fr');
              }),
              text: "Fr",
            ),
          ),
          SizedBox(width: 20),
          Expanded(
            child: CustomLangugeButton(
              onPressed: (() {
                testProvider.setSelectedLanguage('de');
              }),
              text: "De",
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/test.dart';

class TestListProvider with ChangeNotifier {
  late String _selectedLanguage;
  String get selectedLanguage => _selectedLanguage;
  TestListProvider() {
    _selectedLanguage = 'en'; // Set the default language to English
  }

  void setSelectedLanguage(String lang) {
    _selectedLanguage = lang;
    notifyListeners();
  }

  String getTestName(Test item) {
    if (_selectedLanguage == 'ar') {
      return item.titleAr.toString();
    } else if (_selectedLanguage == 'fr') {
      return item.titleFr.toString();
    } else if (_selectedLanguage == 'de') {
      return item.titleDe.toString();
    } else {
      return item.titleEn.toString();
    }
  }

  static TestListProvider of(
    BuildContext context, {
    bool listen = true,
  }) {
    return Provider.of<TestListProvider>(
      context,
      listen: listen,
    );
  }

  // Other methods for your provider class
}

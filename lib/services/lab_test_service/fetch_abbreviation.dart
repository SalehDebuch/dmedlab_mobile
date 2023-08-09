import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../global/global.dart';
import '../../models/abbreviation.dart';

class AbbreviationProvider extends ChangeNotifier {
  Future<List<Abbrevaiton>> fetchAllAbbrevaitons() async {
    print('fetch abbrevaitons function run');
    String? storedToken = await storage.read(key: 'token');

    final Map<String, String> authHeaders = {
      "Authorization": "Bearer $storedToken",
      "Content-Type": "application/json"
    };

    http.Response response = await http
        .get(Uri.parse(MainServerUrl + 'abbreviations'), headers: authHeaders);

    print(response.statusCode);
    print(response.body);
    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(utf8.decode(response.bodyBytes));

      List<Abbrevaiton> abbrevaiton =
          data.map((d) => Abbrevaiton.fromJson(d)).toList();
      //storeTests(test);
      return abbrevaiton;
    } else {
      throw Exception('Failed to load test results');
    }
  }
}

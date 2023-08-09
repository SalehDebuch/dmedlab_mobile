import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../../global/global.dart';
import '../../models/test.dart';
import '../storage_service/storage_service.dart';

class FavoriteProvider extends ChangeNotifier {
  List _favIdList = [];
  List get favIdList => _favIdList;

  void toggleFavorite(int testID) {
    final isExist = _favIdList.contains(testID);
    if (isExist) {
      _favIdList.remove(testID);
    } else {
      _favIdList.add(testID);
    }
    notifyListeners();
  }

  bool isExist(int word) {
    final isExist = _favIdList.contains(word);
    return isExist;
  }

  void clearFavorite() async {
    _favIdList = [];

    notifyListeners();
  }

  Future<List<Test>> fetchAllTests() async {
    print('fetch test function run');
    String? storedToken = await storage.read(key: 'token');

    final Map<String, String> authHeaders = {
      "Authorization": "Bearer $storedToken",
      "Content-Type": "application/json"
    };

    http.Response response = await http.get(Uri.parse(MainServerUrl + 'tests'),
        headers: authHeaders);

    print(response.statusCode);
    print(response.body);
    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(utf8.decode(response.bodyBytes));

      List<Test> test = data.map((d) => Test.fromJson(d)).toList();
      //storeTests(test);
      return test;
    } else {
      throw Exception('Failed to load test results');
    }
  }

  Future<Test> fetchTest(int id) async {
    print('fetch test function run');
    String? storedToken = await storage.read(key: 'token');

    final Map<String, String> authHeaders = {
      "Authorization": "Bearer $storedToken",
      "Content-Type": "application/json"
    };

    http.Response response = await http
        .get(Uri.parse(MainServerUrl + 'tests/$id'), headers: authHeaders);

    print(response.statusCode);
    print(response.body);
    if (response.statusCode == 200) {
      var data = json.decode(utf8.decode(response.bodyBytes));

      Test test = Test.fromJson(data);

      return test;
    } else {
      throw Exception('Failed to load test results');
    }
  }

  void storeTests(List<Test> test) async {
    List<Map<String, dynamic>> data = test.map((t) => t.toJson()).toList();
    String encodedData = json.encode(data);
    await storage.write(key: 'test', value: encodedData);
  }

  void storeTest(Test test, String id) async {
    Map<String, dynamic> data = test.toJson();
    String encodedData = json.encode(data);
    await storage.write(key: id, value: encodedData);
  }

  Future<Test> readTest(String id) async {
    String? data = await storage.read(key: id);
    if (data == null) {
      Test test = await fetchTest(int.parse(id));
      storeTest(test, test.id.toString());
      return test;
    }
    Map<String, dynamic> decodedData = json.decode(data);
    Test test = Test.fromJson(decodedData);
    return test;
  }

  Future<List<Test>> readTests() async {
    String? data = await storage.read(key: 'test');
    if (data == null) {
      return [];
    }
    List<dynamic> decodedData = json.decode(data);
    List<Test> tests = decodedData.map((d) => Test.fromJson(d)).toList();
    return tests;
  }

  Future<List> initFavList(context) async {
    final userId = await StorageServices().getUserID();

    if (userId != null) {
      _favIdList = await fetchFavoriteTests(userId, context);
    }

    notifyListeners();
    return favIdList;
  }

  Future<List<Test>> favoriteTests() async {
    final allTests = await readTests();
    final favoriteTests =
        allTests.where((test) => _favIdList.contains(test.id)).toList();
    return favoriteTests;
  }

  Future<List> fetchFavoriteTests(String userId, context) async {
    try {
      final response = await http.post(
        Uri.parse(MainServerUrl + 'get-favorite-tests'),
        headers: headers,
        body: json.encode({
          "user_id": userId,
        }),
      );

      if (response.statusCode == 200) {
        List<dynamic> jsonResponse = json.decode(response.body);
        List testIds = jsonResponse.map((e) => e['test_id']).toList();
        storeFavoriteTests(testIds);
        return testIds;
      } else {
        return [];
      }
    } catch (e) {
      print('Error fetching favorite tests: $e');
      return [];
    }
  }

  Future<void> storeFavoriteTests(List testIds) async {
    List<Map<String, dynamic>> jsonData =
        testIds.map((id) => {"test_id": id}).toList();

    await storage.write(key: "favorite_tests", value: json.encode(jsonData));
  }

  Future<List> getStoredFavoriteTests() async {
    final storedJson = await storage.read(key: "favorite_tests");

    if (storedJson != null) {
      List<dynamic> jsonResponse = json.decode(storedJson);

      return jsonResponse.map((e) => e['test_id']).toList();
    } else {
      return [];
    }
  }

  static FavoriteProvider of(
    BuildContext context, {
    bool listen = true,
  }) {
    return Provider.of<FavoriteProvider>(
      context,
      listen: listen,
    );
  }
}

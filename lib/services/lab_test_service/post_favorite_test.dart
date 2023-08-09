import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../global/global.dart';

class PostFavoriteTestService {
  Future<http.Response> postFavoriteTest(
      String userId, String testId, bool isFavorite, context) async {
    try {
      Map<String, dynamic> data = {
        'user_id': userId,
        'test_id': testId,
        'is_favorite': isFavorite
      };
      final response = await http.post(
          Uri.parse(MainServerUrl + 'post-favorite-test'),
          body: jsonEncode(data),
          headers: headers);
      return response;
    } catch (error) {
      print('Error occurred while posting favorite test: $error');
      return http.Response('', 500);
    }
  }
}

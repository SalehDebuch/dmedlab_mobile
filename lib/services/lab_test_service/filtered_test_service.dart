import '../../models/test.dart';
import 'fetch_test_and_favorite.dart';

List<Test> filteredList = [];
Future<List<Test>> readenFilteredTest(String? search) async {
  //final testList = await FavoriteProvider().readTests();
  final testList = await FavoriteProvider().fetchAllTests();

  if (search == null) {
    filteredList = testList;
    return filteredList;
  } else {
    filteredList = testList.where((element) {
      return element.key != null && element.key!.contains(search);
    }).toList();

    return filteredList;
  }
}

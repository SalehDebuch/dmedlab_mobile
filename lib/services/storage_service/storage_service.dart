import '../../global/global.dart';

class StorageServices {
  Future<String?> getUserID() async {
    final userID = await storage.read(key: 'userId');
    return userID;
  }
}

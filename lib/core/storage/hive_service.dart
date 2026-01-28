import 'package:hive/hive.dart';

class HiveService {
  static const tokenBox = 'tokenBox';

  Future<void> saveToken(String token) async {
    final box = await Hive.openBox(tokenBox);
    await box.put('token', token);
  }

  Future<String?> getToken() async {
    final box = await Hive.openBox(tokenBox);
    return box.get('token');
  }
}

import 'package:hive_flutter/hive_flutter.dart';
import '../models/user_model.dart';

class HiveService {
  static const String _userBox = 'userBox';

  Future<void> init() async {
    await Hive.initFlutter();
    if (!Hive.isAdapterRegistered(0)) {
      Hive.registerAdapter(UserModelAdapter());
    }
  }

  Future<Box<UserModel>> get userBox async => await Hive.openBox<UserModel>(_userBox);

  Future<void> saveUser(UserModel user) async {
    final box = await userBox;
    await box.put(user.username, user);
  }

  Future<UserModel?> getUser(String username) async {
    final box = await userBox;
    return box.get(username);
  }
}
import 'dart:convert';

import 'package:get/get.dart';
import 'package:item_expo/module/login/models/user_model.dart';
import 'package:item_expo/services/api_service.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StorageService extends GetxService {
  final Logger _logger = Get.find();
  late SharedPreferences storage;

  @override
  void onInit() async {
    storage = await SharedPreferences.getInstance();
    _logger.d('StorageService iniciado');
    super.onInit();
  }

  set(String key, dynamic value) {
    if (value is String) {
      storage.setString(key, value);
    } else {
      storage.setString(key, jsonEncode(value.toJson()));
    }
  }

  String? get(String key) {
    final json = storage.getString(key);
    if (json != null) {
      return json;
    } else {
      return null;
    }
  }

  del(String key) {
    storage.remove(key);
  }

  bool isLogged() {
    String? isLogged = storage.getString('user');
    if (isLogged == null) return false;
    UserModel user = UserModel.fromJson(jsonDecode(isLogged));
    ApiService apiService = Get.find();
    apiService.addHeaders({'Authorization': 'Bearer ${user.token}'});
    return true;
  }

  UserModel? getUser() {
    String? user = storage.getString('user');
    if (user != null) {
      return UserModel.fromJson(jsonDecode(user));
    }
    return null;
  }
}

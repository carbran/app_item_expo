import 'dart:convert';

import 'package:get/get.dart';
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
    return false;
  }

  // bool isLogged() {
  //   String? isLogged = storage.getString('usuario');
  //   if (isLogged == null) return false;
  //   UsuarioModel usuario = UsuarioModel.fromJson(jsonDecode(isLogged));
  //   ApiService apiService = Get.find();
  //   apiService.addHeaders({'Authorization': 'Bearer ${usuario.token}'});
  //   return true;
  // }

  // UsuarioModel? getUser() {
  //   String? user = storage.getString('usuario');
  //   if (user != null) {
  //     return UsuarioModel.fromJson(jsonDecode(user));
  //   }
  //   return null;
  // }
}

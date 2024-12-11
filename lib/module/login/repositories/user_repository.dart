import 'dart:convert';

import 'package:get/get.dart';
import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:item_expo/module/login/models/user_model.dart';
import 'package:item_expo/services/api_service.dart';
import 'package:item_expo/services/storage_service.dart';
import 'package:item_expo/module/login/models/auth_model.dart';
import 'package:item_expo/routes/app_routes.dart';
import 'package:item_expo/utils/errors.dart';

class UserRepository {
  late final StorageService storageService;
  late final ApiService apiService;
  late final Logger logger;

  UserRepository() {
    apiService = Get.find();
    storageService = Get.find();
    logger = Get.find();
  }

  Future<bool> register(UserModel user) async {
    try {
      final response =
          await apiService.dio.post('/user/register', data: user.toJson());

      if (response.statusCode == 201) {
        return true;
      } else {
        return false;
      }
    } on DioException catch (e) {
      if (e.response == null) {
        throw (unknownErrorException(e));
      }

      throw (responseDioException(e));
    }
  }

  Future<bool> updateUser(UserModel user) async {
    try {
      final response =
          await apiService.dio.post('/user/update', data: user.toJsonUser());

      if (response.statusCode == 200) {
        storageService.set('user', user);
        return true;
      } else {
        return false;
      }
    } on DioException catch (e) {
      if (e.response == null) {
        throw (unknownErrorException(e));
      }

      throw (responseDioException(e));
    }
  }

  Future<bool> updatePassword(String code, String password) async {
    try {
      final response =
          await apiService.dio.post('/user/update-password-ac', data: {
        'access_code': code,
        'new_password': password,
      });

      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } on DioException catch (e) {
      if (e.response == null) {
        throw (unknownErrorException(e));
      }

      throw (responseDioException(e));
    }
  }

  Future<bool> getAccessCode(String email) async {
    try {
      final response = await apiService.dio
          .post('/user/get-access-code', data: {'email': email});

      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } on DioException catch (e) {
      if (e.response == null) {
        throw (unknownErrorException(e));
      }

      throw (responseDioException(e));
    }
  }

  Future<dynamic> login(String email, String password) async {
    try {
      UserModel user;
      AuthModel auth;

      final response = await apiService.dio.post('/auth/login', data: {
        'email': email,
        'password': password,
      });
      auth = AuthModel.fromJson(response.data);
      apiService.addHeaders({'Authorization': 'Bearer ${auth.accessToken}'});

      final resUser = await apiService.dio.post('/auth/me');
      user = UserModel.fromJson(resUser.data);
      user.token = auth.accessToken;
      user.expiresIn = auth.expiresIn;
      storageService.set('user', user);
      return resUser.data;
    } on DioException catch (e) {
      if (e.response == null) {
        throw (unknownErrorException(e));
      }

      throw (responseDioException(e));
    }
  }

  void logout() async {
    try {
      storageService.del('user');
      await apiService.dio.post('/auth/logout');
      apiService.delHeaders();
      Get.offAllNamed(Routes.login);
    } on DioException catch (e) {
      if (e.response == null) {
        throw (unknownErrorException(e));
      }

      throw (responseDioException(e));
    }
  }

  Future<bool> deleteUser(UserModel user) async {
    try {
      final response =
          await apiService.dio.post('/user/excluir-user', data: user.toJson());
      if (response.statusCode == 200) {
        storageService.del('user');
        return true;
      } else {
        return false;
      }
    } on DioException catch (e) {
      if (e.response == null) {
        throw (unknownErrorException(e));
      }

      throw (responseDioException(e));
    }
  }

  Future<Map<String, dynamic>> changePassword(
      String? email, String? oldPassword, String? newPassword) async {
    try {
      final response =
          await apiService.dio.post('/auth/update-password', data: {
        'credentials': {'email': email, 'password': oldPassword},
        'new_password': newPassword
      });

      return response.data;
    } on DioException catch (e) {
      if (e.response == null) {
        throw (unknownErrorException(e));
      }
      throw (responseDioException(e));
    }
  }

  UserModel? getUser() {
    if (storageService.isLogged()) {
      UserModel? user = UserModel();
      final json = storageService.get('user');
      if (json != null) {
        user = UserModel.fromJson(jsonDecode(json));
      }
      return user;
    }
    return null;
  }
}

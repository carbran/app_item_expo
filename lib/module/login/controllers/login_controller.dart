import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:item_expo/module/login/repositories/user_repository.dart';
import 'package:item_expo/routes/app_routes.dart';
import 'package:item_expo/services/storage_service.dart';
import 'package:item_expo/utils/errors.dart';

class LoginController extends GetxController {
  String? email;
  String? password;

  Rx<bool> waiting = Rx(false);
  Rx<bool> hidePass = Rx(true);

  late final TextEditingController passwordController;

  late final UserRepository userRepository;
  late final StorageService storageService;

  @override
  void onInit() {
    passwordController = TextEditingController();
    userRepository = Get.put(UserRepository());
    storageService = Get.put(StorageService());
    email = storageService.get('email');
    super.onInit();
  }

  void login() async {
    if (waiting.value) return;
    waiting.value = true;
    if (email == null || password == null) {
      waiting.value = false;
      Map<String, dynamic> error = {
        'data': {'message': 'Preencha todos os campos.'}
      };
      handleError(error, marginBottom: 80);
      return;
    }
    try {
      await storageService.set('email', email);
      await userRepository.login(email!, password!);
      waiting.value = false;
      Get.offAllNamed(Routes.bars);
    } catch (error) {
      waiting.value = false;
      handleError(error, marginBottom: 80);
    }
  }

  void showPassword() {
    hidePass.value = !hidePass.value;
  }
}

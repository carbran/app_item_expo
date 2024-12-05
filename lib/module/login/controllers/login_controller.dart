import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:item_expo/utils/errors.dart';

class LoginController extends GetxController {
  String? email;
  String? password;

  Rx<bool> waiting = Rx(false);
  Rx<bool> hidePass = Rx(true);

  late final TextEditingController passwordController;

  @override
  void onInit() {
    passwordController = TextEditingController();
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
  }
}

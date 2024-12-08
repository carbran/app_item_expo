import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:item_expo/utils/errors.dart';

class RegisterController extends GetxController {
  final formKey = GlobalKey<FormState>();
  String? name;
  String? telefone;
  String? email;
  String? password;
  String? confirmPassword;

  Rx<bool> waiting = Rx(false);
  Rx<bool> hidePass = Rx(true);
  Rx<bool> hideConfirmPass = Rx(true);

  late final TextEditingController passwordController;
  late final TextEditingController confirmPasswordController;

  @override
  void onInit() {
    passwordController = TextEditingController();
    confirmPasswordController = TextEditingController();
    super.onInit();
  }

  void register() async {
    if (formKey.currentState!.validate()) {
      try {
        waiting.value = true;
        // bool response = await userRepository.register(user);
        bool response = true;
        waiting.value = false;
        if (response) {
          Get.back(result: 'sucess');
        }
      } catch (error) {
        waiting.value = false;
        handleError(error, marginBottom: 80);
      }
    }
  }

  void showPassword() {
    hidePass.value = !hidePass.value;
  }

  void showConfirmPassword() {
    hideConfirmPass.value = !hideConfirmPass.value;
  }
}

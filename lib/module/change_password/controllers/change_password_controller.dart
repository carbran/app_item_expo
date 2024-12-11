import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:item_expo/module/login/models/user_model.dart';
import 'package:item_expo/module/login/repositories/user_repository.dart';
import 'package:item_expo/routes/app_routes.dart';
import 'package:item_expo/utils/errors.dart';

class ChangePasswordController extends GetxController {
  final formKey = GlobalKey<FormState>();
  late final UserRepository userRepository;
  late UserModel? user = UserModel();

  String? oldPassword;
  String? newPassword;
  String? confirmPassword;

  Rx<bool> hideOldPass = Rx(true);
  Rx<bool> hidePass = Rx(true);
  Rx<bool> hideConfirmPass = Rx(true);
  Rx<bool> waiting = Rx(false);

  @override
  void onInit() {
    super.onInit();
    userRepository = Get.put(UserRepository());
    user = userRepository.getUser();
  }

  void showOldPassword() {
    hideOldPass.value = !hideOldPass.value;
  }

  void showNewPassword() {
    hidePass.value = !hidePass.value;
  }

  void showPasswordConfirmation() {
    hideConfirmPass.value = !hideConfirmPass.value;
  }

  void changePassword() async {
    if (formKey.currentState!.validate()) {
      try {
        if (waiting.value) return;
        waiting.value = true;
        if (oldPassword == null ||
            newPassword == null ||
            confirmPassword == null) {
          waiting.value = false;
          Map<String, dynamic> e = {
            'data': {'message': 'Preencha todos os campos.'}
          };
          handleError(e, marginBottom: 80);
          return;
        }
        if (newPassword == oldPassword) {
          waiting.value = false;
          Map<String, dynamic> e = {
            'data': {'message': 'A nova senha deve ser diferente da anterior.'}
          };
          handleError(e, marginBottom: 80);
          return;
        }
        if (newPassword != confirmPassword) {
          waiting.value = false;
          Map<String, dynamic> e = {
            'data': {'message': 'As senhas não coincidem, tente novamente.'}
          };
          handleError(e, marginBottom: 80);
          return;
        }
        Map<String, dynamic> isPasswordCorrect = await userRepository
            .changePassword(user?.email, oldPassword, newPassword);
        if (isPasswordCorrect.containsKey('error')) {
          waiting.value = false;
          Map<String, dynamic> e = {
            'data': {'message': isPasswordCorrect['error'].toString()}
          };
          handleError(e, marginBottom: 80);
          return;
        }
        Get.toNamed(Routes.confirmation, arguments: {
            'type': 'change_password',
            'message': isPasswordCorrect['sucesso'].toString()
          });
      } catch (e) {
        waiting.value = false;
        handleError(e, marginBottom: 80);
      }
    }
  }
}
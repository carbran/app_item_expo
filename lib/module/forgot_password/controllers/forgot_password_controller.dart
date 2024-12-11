import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:item_expo/module/login/repositories/user_repository.dart';
import 'package:item_expo/routes/app_routes.dart';
import 'package:item_expo/utils/errors.dart';
import 'package:item_expo/utils/snackbar.dart';

class ForgotPasswordController extends GetxController {
  final formKeyUserValidation = GlobalKey<FormState>();
  final formKeyNewPassword = GlobalKey<FormState>();
  final formKeyValidationCode = GlobalKey<FormState>();

  late final UserRepository userRepository;

  late String email;
  late String password;
  late String confirmPassword;
  late String code;

  Rx<bool> waiting = Rx(false);
  Rx<bool> hidePass = Rx(true);
  Rx<bool> hideConfirmPass = Rx(true);

  Rx<int> secondsRemaining = Rx(120);
  final RxBool isTimeExpired = false.obs;
  final RxInt minutes = 0.obs;
  final RxInt seconds = 0.obs;

  late final TextEditingController emailController;
  late final TextEditingController passwordController;
  late final TextEditingController confirmPasswordController;
  late final TextEditingController codeController;

  @override
  void onInit() {
    userRepository = Get.put(UserRepository());
    emailController = TextEditingController();
    passwordController = TextEditingController();
    confirmPasswordController = TextEditingController();
    codeController = TextEditingController();
    super.onInit();
  }

  startTime() {
    secondsRemaining.value = 120;
    minutes.value = secondsRemaining.value ~/ 60;
    seconds.value = secondsRemaining.value % 60;
    isTimeExpired.value = true;

    Timer.periodic(const Duration(seconds: 1), (timer) {
      if (secondsRemaining.value > 0) {
        secondsRemaining.value--;
        minutes.value = secondsRemaining.value ~/ 60;
        seconds.value = secondsRemaining.value % 60;
      } else {
        isTimeExpired.value = false;
        timer.cancel();
      }
    });
  }

  void onPressResendCode() async {
    try {
      startTime();
      await userRepository.getAccessCode(email);
    } catch (error) {
      handleError(error, marginBottom: 80);
    }
  }

  void showPassword() {
    hidePass.value = !hidePass.value;
  }

  void showConfirmPassword() {
    hideConfirmPass.value = !hideConfirmPass.value;
  }

  void sendAccessCode() async {
    if (formKeyUserValidation.currentState!.validate()) {
      try {
        waiting.value = true;
        bool response = await userRepository.getAccessCode(email);
        waiting.value = false;
        if (response) {
          Get.offNamed(Routes.newPassword);
        }
      } catch (error) {
        waiting.value = false;
        handleError(error, marginBottom: 80);
      }
    }
  }

  void newPassword() async {
    if (formKeyNewPassword.currentState!.validate()) {
      try {
        if (password == confirmPassword) {
          Get.offNamed(Routes.validationCode);
        } else {
          showSnackbar(
              context: Get.context!,
              message:
                  'Ops! As senhas não coincidem. Por favor, tente novamente.',
              marginBottom: 80);
        }
      } catch (e) {
        waiting.value = false;
        handleError(e, marginBottom: 80);
      }
    }
  }

  void updatePassword() async {
    if (formKeyValidationCode.currentState!.validate()) {
      try {
        waiting.value = true;
        bool resposta = await userRepository.updatePassword(code, password);
        waiting.value = false;
        if (resposta) {
          Get.offNamed(Routes.confirmation, arguments: {
            'type': 'forgout_password',
            'message': 'Senha alterada com sucesso.'
          });
        }
      } catch (e) {
        waiting.value = false;
        handleError(e, marginBottom: 80);
      }
    }
  }
}

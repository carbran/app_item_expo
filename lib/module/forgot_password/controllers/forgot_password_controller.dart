import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:item_expo/module/login/repositories/user_repository.dart';
import 'package:item_expo/routes/app_routes.dart';
import 'package:item_expo/utils/errors.dart';

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

  @override
  void onInit() {
    userRepository = Get.put(UserRepository());
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
    if (formKeyUserValidation.currentState?.validate() ?? false) {
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

  void forgotPassword() async {
    
  }
}

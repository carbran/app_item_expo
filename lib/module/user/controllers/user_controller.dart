import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:item_expo/module/login/models/user_model.dart';
import 'package:item_expo/module/login/repositories/user_repository.dart';
import 'package:item_expo/routes/app_routes.dart';
import 'package:item_expo/services/profile_service.dart';
import 'package:item_expo/utils/errors.dart';

class UserController extends GetxController {
  final formUserKey = GlobalKey<FormState>();
  final formPasswordKey = GlobalKey<FormState>();

  late final UserRepository userRepository;
  late UserModel user;
  late ProfileService profile = Get.find();

  Rx<bool> waiting = Rx(false);
  Rx<bool> hideOldPass = Rx(true);
  Rx<bool> hidePass = Rx(true);
  Rx<bool> hideConfirmPass = Rx(true);

  String? oldPassword;
  String? newPassword;
  String? confirmPassword;

  late final TextEditingController oldPasswordController;
  late final TextEditingController passwordController;
  late final TextEditingController confirmPasswordController;

  @override
  void onInit() {
    oldPasswordController = TextEditingController();
    passwordController = TextEditingController();
    confirmPasswordController = TextEditingController();
    userRepository = Get.put(UserRepository());
    user = UserModel();
    super.onInit();
  }

  void updateUser() async {
    if (formUserKey.currentState!.validate()) {
      try {
        waiting.value = true;

        user.name ??= profile.user?.name;
        user.email ??= profile.user?.email;
        user.phone ??= profile.user?.phone;
        user.password ??= profile.user?.password;
        user.token ??= profile.user?.token;
        user.expiresIn ??= profile.user?.expiresIn;

        bool response = await userRepository.updateUser(user);
        profile.resetProfile();
        waiting.value = false;
        if (response) {
          Get.offNamed(Routes.confirmation, arguments: {
            'type': 'update_my_user',
            'message': 'Dados alterados com sucesso!'
          });
        }
      } catch (e) {
        waiting.value = false;
        handleError(e, marginBottom: 80);
      }
    }
  }

  void deleteUser() async {
    if (formUserKey.currentState!.validate()) {
      try {
        waiting.value = true;
        bool resposta = await userRepository.deleteUser(user);
        waiting.value = false;
        if (resposta) {
          Get.offNamed(Routes.confirmation, arguments: {
            'type': 'delete_user',
            'message': 'Usuário excluido com sucesso!'
          });
        }
      } catch (e) {
        waiting.value = false;
        handleError(e, marginBottom: 80);
      }
    }
  }

  void updatePassword() async {
    if (formPasswordKey.currentState!.validate()) {
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
            .changePassword(profile.user!.email, oldPassword, newPassword);
        if (isPasswordCorrect.containsKey('error')) {
          waiting.value = false;
          Map<String, dynamic> e = {
            'data': {'message': isPasswordCorrect['error'].toString()}
          };
          handleError(e, marginBottom: 80);
          return;
        }
        waiting.value = false;
        Get.toNamed(Routes.confirmation, arguments: {
          'type': 'change_password',
          'message': isPasswordCorrect['message'].toString()
        });
      } catch (e) {
        waiting.value = false;
        handleError(e, marginBottom: 80);
      }
    }
  }

  void showOldPassword() {
    hideOldPass.value = !hideOldPass.value;
  }

  void showPassword() {
    hidePass.value = !hidePass.value;
  }

  void showConfirmPassword() {
    hideConfirmPass.value = !hideConfirmPass.value;
  }

  void logout() {
    try {
      userRepository.logout();
      Get.offAllNamed(Routes.login);
    } catch (error) {
      handleError(error, marginBottom: 80);
    }
  }
}

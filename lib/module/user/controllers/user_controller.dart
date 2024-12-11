import 'package:get/get.dart';
import 'package:item_expo/module/login/repositories/user_repository.dart';
import 'package:item_expo/routes/app_routes.dart';
import 'package:item_expo/utils/errors.dart';

class UserController extends GetxController {
  final UserRepository userRepository = UserRepository();

  void logout() {
    try {
      userRepository.logout();
      Get.offAllNamed(Routes.login);
    } catch (error) {
      handleError(error, marginBottom: 80);
    }
  }
}

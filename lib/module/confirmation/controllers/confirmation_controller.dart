import 'package:get/get.dart';
import 'package:item_expo/module/forgot_password/controllers/forgot_password_controller.dart';
import 'package:item_expo/routes/app_routes.dart';

class ConfirmationController extends GetxController {
  late String message;
  late String? type;

  @override
  void onInit() {
    message = Get.arguments['message'];
    type = Get.arguments['type'];
    super.onInit();
  }

  @override
  void onClose() {
    if (type == 'forgot_password') {
      Get.delete<ForgotPasswordController>(force: true);
    }
    super.onClose();
  }

  void goToPage() {
    switch (type) {
      case 'update_my_user':
        Get.offNamed(Routes.bars);
      case 'change_password':
        Get.offNamed(Routes.bars);
      default:
        Get.offNamed(Routes.login);
    }
  }
}

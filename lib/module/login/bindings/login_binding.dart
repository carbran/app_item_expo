import 'package:get/get.dart';
import 'package:item_expo/module/login/controllers/login_controller.dart';

class LoginBinding implements Bindings {
@override
void dependencies() {
  Get.lazyPut<LoginController>(() => LoginController());
  }
}
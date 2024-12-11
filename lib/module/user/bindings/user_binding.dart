import 'package:get/get.dart';
import 'package:item_expo/module/user/controllers/user_controller.dart';

class UserBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UserController>(() => UserController());
  }
}

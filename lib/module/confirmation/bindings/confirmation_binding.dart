import 'package:get/get.dart';
import 'package:item_expo/module/confirmation/controllers/confirmation_controller.dart';

class ConfirmationBinding implements Bindings {
@override
void dependencies() {
  Get.lazyPut<ConfirmationController>(() => ConfirmationController());
  }
}
import 'package:get/get.dart';
import 'package:item_expo/module/create_item/controllers/create_item_controller.dart';

class CreateItemBinding implements Bindings {
@override
void dependencies() {
  Get.lazyPut<CreateItemController>(() => CreateItemController());
  }
}
import 'package:get/get.dart';
import 'package:item_expo/module/item/controllers/item_controller.dart';

class ItemBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ItemController>(() => ItemController());
  }
}

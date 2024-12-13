import 'package:get/get.dart';
import 'package:item_expo/module/update_item/controllers/update_item_controller.dart';

class UpdateItemBinding implements Bindings {
@override
void dependencies() {
  Get.lazyPut<UpdateItemController>(() => UpdateItemController());
  }
}
import 'package:get/get.dart';
import 'package:item_expo/module/update_collection/controllers/update_collection_controller.dart';

class UpdateCollectionBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UpdateCollectionController>(() => UpdateCollectionController());
  }
}

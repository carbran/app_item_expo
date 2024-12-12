import 'package:get/get.dart';
import 'package:item_expo/module/collection/controllers/collection_controller.dart';

class CollectionBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CollectionController>(() => CollectionController());
  }
}

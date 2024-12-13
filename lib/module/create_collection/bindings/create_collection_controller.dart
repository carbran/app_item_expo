import 'package:get/get.dart';
import 'package:item_expo/module/create_collection/controllers/create_collection_controller.dart';

class CreateCollectionBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CreateCollectionController>(() => CreateCollectionController());
  }
}

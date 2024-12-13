import 'package:get/get.dart';
import 'package:item_expo/module/bars/controllers/bars_controller.dart';
import 'package:item_expo/module/collection/controllers/collection_controller.dart';
import 'package:item_expo/module/create_collection/controllers/create_collection_controller.dart';
import 'package:item_expo/module/user/controllers/user_controller.dart';
import 'package:item_expo/services/profile_service.dart';

class BarsBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BarsController>(() => BarsController());
    Get.lazyPut<CreateCollectionController>(() => CreateCollectionController());
    Get.lazyPut<CollectionController>(() => CollectionController());
    Get.lazyPut<UserController>(() => UserController());
    Get.put(ProfileService());
  }
}

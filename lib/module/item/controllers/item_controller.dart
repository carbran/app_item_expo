import 'package:get/get.dart';
import 'package:item_expo/module/item/models/item_model.dart';
import 'package:item_expo/module/item/repository/item_repository.dart';

class ItemController extends GetxController {
  late String collectionName;
  late int collectionId;

  final ItemRepository _itemRepository = ItemRepository();

  Rx<bool> waiting = Rx(false);
  RxList<Item> items = <Item>[].obs;

  @override
  void onInit() {
    collectionName = Get.arguments['collection_name'];
    collectionId = Get.arguments['collection_id'];
    fetchItems(collectionId);
    super.onInit();
  }

  void fetchItems(int collectionId) async {
    waiting.value = true;
    try {
      items.value = await _itemRepository.fetchItems(id: collectionId);
    } catch (e) {
      Get.snackbar("Error", "Failed to load items");
    } finally {
      waiting.value = false;
    }
  }
}

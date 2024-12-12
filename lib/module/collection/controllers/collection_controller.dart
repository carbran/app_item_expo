import 'package:get/get.dart';
import 'package:item_expo/module/item/models/collection_model.dart';
import 'package:item_expo/module/item/models/item_model.dart';
import 'package:item_expo/module/item/repositories/collection_repository.dart';
import 'package:item_expo/module/item/repositories/item_repository.dart';

class CollectionController extends GetxController {
  final CollectionRepository _collectionRepository = CollectionRepository();
  final ItemRepository _itemRepository = ItemRepository();

  var collections = <Collection>[].obs;
  var items = <Item>[].obs;
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchCollections();
  }

  void fetchCollections() async {
    isLoading.value = true;
    try {
      collections.value = await _collectionRepository.fetchCollections();
    } catch (e) {
      Get.snackbar("Error", "Failed to load collections");
    } finally {
      isLoading.value = false;
    }
  }

  void fetchItems(int collectionId) async {
    isLoading.value = true;
    try {
      items.value = await _itemRepository.fetchItems(id: collectionId);
    } catch (e) {
      Get.snackbar("Error", "Failed to load items");
    } finally {
      isLoading.value = false;
    }
  }
}

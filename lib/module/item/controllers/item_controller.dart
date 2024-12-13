import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:item_expo/module/item/models/item_model.dart';
import 'package:item_expo/module/item/models/item_picture_model.dart';
import 'package:item_expo/module/item/repositories/item_repository.dart';
import 'package:item_expo/services/profile_service.dart';

class ItemController extends GetxController {
  late String collectionName;
  late int collectionId;

  final ItemRepository _itemRepository = ItemRepository();
  ProfileService profile = Get.find();

  Rx<bool> waiting = Rx(false);
  RxList<ItemModel> items = <ItemModel>[].obs;

  late ItemModel itemModel = ItemModel();
  late ItemPictureModel itemPictureModel = ItemPictureModel();

  late String title;

  @override
  void onInit() {
    collectionName = Get.arguments['collection_name'];
    collectionId = Get.arguments['collection_id'];
    title = 'Itens de $collectionName';
    getItemsByCollection(collectionId);
    super.onInit();
  }

  void fetchItems(int collectionId) async {
    waiting.value = true;
    try {
      items.value = await _itemRepository.fetchItems();
      profile.itemsCount.value = items.length;
    } catch (e) {
      Get.snackbar(
        "Erro",
        "Não há items nessa coleção",
        snackPosition: SnackPosition.BOTTOM,
        margin: const EdgeInsets.only(bottom: 60),
      );
    } finally {
      waiting.value = false;
    }
  }

  Future<void> getItemsByCollection(int collectionId) async {
    try {
      waiting.value = true;
      final fetchedItems =
          await _itemRepository.fetchItemsByCollection(collectionId);
      items.assignAll(fetchedItems);
    } catch (e) {
      Get.snackbar(
        "Erro",
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
        margin: const EdgeInsets.only(bottom: 60),
      );
    } finally {
      waiting.value = false;
    }
  }
}

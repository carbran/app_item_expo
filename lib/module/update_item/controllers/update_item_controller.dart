import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:item_expo/module/item/models/item_model.dart';
import 'package:item_expo/module/item/models/item_picture_model.dart';
import 'package:item_expo/module/item/repositories/item_repository.dart';
import 'package:item_expo/routes/app_routes.dart';
import 'package:item_expo/utils/errors.dart';
import 'package:item_expo/utils/snackbar.dart';

class UpdateItemController extends GetxController {
  final formUpdateItemKey = GlobalKey<FormState>();
  final ItemRepository itemRepository = ItemRepository();

  late Rx<ItemModel> item = Rx(ItemModel());
  late String? typePage;
  late String title;
  late int itemId;
  late Rx<ItemPictureModel> pictures = Rx(ItemPictureModel());

  Rx<bool> waiting = Rx(false);

  @override
  void onInit() {
    super.onInit();
    itemId = Get.arguments;
    showItem(itemId);
  }

  void updateItem() async {
    if (formUpdateItemKey.currentState!.validate()) {
      try {
        waiting.value = true;

        // item.collectionId =
        // item.pictures =
        bool response = await itemRepository.updateItem(itemId, item.value);
        waiting.value = false;
        if (response) {
          successSnackbar('Sua coleção foi criada.');
          Get.offAllNamed(Routes.bars);
        }
      } catch (error) {
        waiting.value = false;
        handleError(error, marginBottom: 80);
      }
    }
  }
  
  Future<void> showItem(int itemId) async {
    waiting.value = true;
    try {
      List<ItemModel> itemList =
          await itemRepository.showItems(itemId);
      item.value = itemList[0];

      if (item.value.pictures != null) {
        pictures.value = item.value.pictures![0];
      }
    } catch (e) {
      errorSnackbar('Falha no carregamento das coleções. $e');
    } finally {
      waiting.value = false;
    }
  }
}

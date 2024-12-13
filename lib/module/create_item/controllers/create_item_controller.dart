import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:item_expo/module/item/models/item_model.dart';
import 'package:item_expo/module/item/repositories/item_repository.dart';
import 'package:item_expo/routes/app_routes.dart';
import 'package:item_expo/utils/errors.dart';
import 'package:item_expo/utils/snackbar.dart';
import 'package:item_expo_theme_package/item_expo_colors.dart';

class CreateItemController extends GetxController {
  final formCreateItemKey = GlobalKey<FormState>();
  final ItemRepository itemRepository = ItemRepository();

  late ItemModel item;
  late String? typePage;
  late String title;

  final selectedUnit = 'cm'.obs;
  final selectedDate = DateTime.now().obs;
  Rx<DateTime> startDate =
      Rx(DateTime.now().subtract(const Duration(days: 30)));

  Rx<bool> waiting = Rx(false);

  @override
  void onInit() {
    super.onInit();
    item = ItemModel();
  }

  void createItem() async {
    if (formCreateItemKey.currentState!.validate()) {
      try {
        waiting.value = true;

        // item.collectionId =
        // item.pictures =
        bool response = await itemRepository.createItem(item);
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

  void selectStartDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: startDate.value,
      firstDate: DateTime(1901),
      lastDate: DateTime(2101),
      builder: (context, child) {
        return Theme(
            data: ThemeData.light().copyWith(
              colorScheme: const ColorScheme.light(
                onPrimary: ItemExpoColors.white,
                onSurface: ItemExpoColors.black,
                primary: ItemExpoColors.darkPurple,
                surface: ItemExpoColors.white,
              ),
            ),
            child: child!);
      },
    );
    if (picked != null && picked != startDate.value) {
      startDate.value = picked;
    }
  }
}

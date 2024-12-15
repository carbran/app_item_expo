import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:item_expo/module/create_item/enums/condition_enum.dart';
import 'package:item_expo/module/create_item/enums/size_type_enum.dart';
import 'package:item_expo/module/item/models/item_model.dart';
import 'package:item_expo/module/item/models/item_picture_model.dart';
import 'package:item_expo/module/item/repositories/item_repository.dart';
import 'package:item_expo/routes/app_routes.dart';
import 'package:item_expo/utils/errors.dart';
import 'package:item_expo/utils/snackbar.dart';
import 'package:item_expo_theme_package/item_expo_colors.dart';

class CreateItemController extends GetxController {
  final formCreateItemKey = GlobalKey<FormState>();
  final ItemRepository itemRepository = ItemRepository();

  late ItemModel item;
  late ItemPictureModel itemPictureModel;
  late int collectionId;

  Rx<DateTime> selectedDate = Rx(DateTime.now());

  Rx<bool> waiting = Rx(false);

  final picker = ImagePicker();
  var selectedImage = Rx<File?>(null);
  var selectedImageBase64 = Rx<String?>(null);

  @override
  void onInit() {
    super.onInit();
    collectionId = Get.arguments;
    item = ItemModel();
    itemPictureModel = ItemPictureModel();
  }

  void createItem() async {
    if (formCreateItemKey.currentState!.validate()) {
      try {
        waiting.value = true;

        item.collectionId = collectionId;
        item.acquisitionDate = selectedDate.value;
        item.pictures = [];
        item.pictures?.add(itemPictureModel);
        bool response = await itemRepository.createItem(item);
        waiting.value = false;
        if (response) {
          successSnackbar('Sua Item foi adicionado a coleção.');
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
      initialDate: selectedDate.value,
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
    if (picked != null && picked != selectedDate.value) {
      selectedDate.value = picked;
    }
  }

  Future<void> getImage(ImageSource src) async {
    waiting.value = true;

    try {
      final pickedFile = await picker.pickImage(source: src);

      if (pickedFile != null) {
        final CroppedFile? cropped = await ImageCropper().cropImage(
          sourcePath: pickedFile.path,
          aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1),
          compressQuality: 100,
          maxHeight: 700,
          maxWidth: 700,
          compressFormat: ImageCompressFormat.jpg,
        );

        if (cropped != null) {
          File file = File(cropped.path);

          final bytes = await file.readAsBytes();
          final base64 = base64Encode(bytes);

          selectedImage.value = file;
          selectedImageBase64.value = base64;

          itemPictureModel.imageData = selectedImageBase64.value;
        }
      }
    } finally {
      waiting.value = false;
    }
  }

  void clearImage() {
    selectedImage.value = null;
    selectedImageBase64.value = null;
  }

  int enumSizeNameToNum(String name) {
    final sizeType = SizeTypeEnum.values.firstWhere((e) => e.name == name);
    return sizeType.index;
  }

  int enumConditionNameToNum(String name) {
    final condition = ConditionEnum.values.firstWhere((e) => e.name == name);
    return condition.index;
  }
}

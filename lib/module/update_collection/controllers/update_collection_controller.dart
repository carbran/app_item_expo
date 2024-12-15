import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:item_expo/module/collection/models/category_model.dart';
import 'package:item_expo/module/collection/models/collection_model.dart';
import 'package:item_expo/module/collection/repositories/category_repository.dart';
import 'package:item_expo/module/collection/repositories/collection_repository.dart';
import 'package:item_expo/routes/app_routes.dart';
import 'package:item_expo/services/profile_service.dart';
import 'package:item_expo/utils/errors.dart';
import 'package:item_expo/utils/snackbar.dart';

class UpdateCollectionController extends GetxController {
  final formUpdateCollectionKey = GlobalKey<FormState>();
  final CollectionRepository collectionRepository = CollectionRepository();
  final CategoryRepository categoryRepository = CategoryRepository();

  late Rx<CollectionModel> collection = Rx(CollectionModel());
  late String? typePage;
  late String title;
  late int collectionId;

  RxList<CategoryModel> categories = RxList<CategoryModel>();
  RxList<CategoryModel> selectedCategories = RxList<CategoryModel>();

  ProfileService profileService = Get.find();

  Rx<bool> waiting = Rx(false);

  @override
  void onInit() {
    super.onInit();
    fetchCategories();
    collectionId = Get.arguments;
    showCollection(collectionId);
  }

  Future<void> fetchCategories() async {
    waiting.value = true;
    try {
      categories.value = await categoryRepository.fetchCategories();
    } catch (e) {
      errorSnackbar('Falha no carregamento das coleções.');
    } finally {
      waiting.value = false;
    }
  }

  Future<void> showCollection(int collectionId) async {
    waiting.value = true;
    try {
      List<CollectionModel> collectionList =
          await collectionRepository.showCollections(collectionId);
      collection.value = collectionList[0];

      if (collection.value.categories != null) {
        selectedCategories.value = collection.value.categories!;
      }
    } catch (e) {
      errorSnackbar('Falha no carregamento das coleções. $e');
    } finally {
      waiting.value = false;
    }
  }

  void toggleCategorySelection(CategoryModel category) {
    if (selectedCategories.contains(category)) {
      selectedCategories.remove(category);
    } else {
      selectedCategories.add(category);
    }
  }

  void updateCollection() async {
    if (formUpdateCollectionKey.currentState!.validate()) {
      try {
        waiting.value = true;

        collection.value.categories = selectedCategories;
        bool response = await collectionRepository.updateCollection(
            collectionId, collection.value);
        waiting.value = false;
        if (response) {
          successSnackbar('Sua coleção foi atualizada.');
          Get.offAllNamed(Routes.bars);
        }
      } catch (error) {
        waiting.value = false;
        handleError(error, marginBottom: 80);
      }
    }
  }

  void deleteCollection() async {
    try {
      waiting.value = true;

      collection.value.categories = selectedCategories;
      bool response = await collectionRepository.deleteCollection(collectionId);
      waiting.value = false;
      if (response) {
        successSnackbar('Sua coleção foi atualizada.');
        Get.offAllNamed(Routes.bars);
      }
    } catch (error) {
      waiting.value = false;
      handleError(error, marginBottom: 80);
    }
  }
}

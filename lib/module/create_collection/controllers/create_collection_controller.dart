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

class CreateCollectionController extends GetxController {
  final formCreateCollectionKey = GlobalKey<FormState>();
  final CollectionRepository collectionRepository = CollectionRepository();
  final CategoryRepository categoryRepository = CategoryRepository();

  late CollectionModel collection;
  late String? typePage;
  late String title;

  RxList<CategoryModel> categories = RxList<CategoryModel>();
  RxList<CategoryModel> selectedCategories = RxList<CategoryModel>();

  ProfileService profileService = Get.find();

  Rx<bool> waiting = Rx(false);

  @override
  void onInit() {
    super.onInit();
    collection = CollectionModel();
    fetchCategories();
  }

  Future<void> fetchCategories() async {
    waiting.value = true;
    try {
      categories.value = await categoryRepository.fetchCategories();
    } catch (e) {
      Get.snackbar("Error", "Failed to load collections");
    } finally {
      waiting.value = false;
    }
  }

  void createCollection() async {
    if (formCreateCollectionKey.currentState!.validate()) {
      try {
        waiting.value = true;

        collection.userId = profileService.user!.id;
        collection.categories = selectedCategories;
        bool response = await collectionRepository.createCollection(collection);
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

  void toggleCategorySelection(CategoryModel category) {
    if (selectedCategories.contains(category)) {
      selectedCategories.remove(category);
    } else {
      selectedCategories.add(category);
    }
  }
}

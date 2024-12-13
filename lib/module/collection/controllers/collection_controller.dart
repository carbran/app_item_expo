import 'dart:async';

import 'package:get/get.dart';
import 'package:item_expo/module/collection/models/collection_model.dart';
import 'package:item_expo/module/collection/models/category_model.dart';
import 'package:item_expo/module/collection/repositories/category_repository.dart';
import 'package:item_expo/module/collection/repositories/collection_repository.dart';
import 'package:item_expo/services/profile_service.dart';

class CollectionController extends GetxController {
  final CollectionRepository collectionRepository = CollectionRepository();
  final CategoryRepository categoryRepository = CategoryRepository();
  final ProfileService profile = Get.find();

  RxList<CollectionModel> collections = <CollectionModel>[].obs;
  RxList<CategoryModel> categories = <CategoryModel>[].obs;
  RxList<CategoryModel> selectedCategories = <CategoryModel>[].obs;

  Rx<bool> waiting = Rx(false);

  @override
  void onInit() {
    super.onInit();
    fetchCollections();
    fetchCategories();
  }

  Future<void> fetchCollections() async {
    waiting.value = true;
    try {
      collections.value = await collectionRepository.fetchCollections();
      profile.collectionsCount.value = collections.length;
    } catch (error) {
      Get.snackbar("Error", "Failed to load collections");
    } finally {
      waiting.value = false;
    }
  }

  Future<void> fetchCategories() async {
    waiting.value = true;
    try {
      categories.value = await categoryRepository.fetchCategories();
      profile.categories.value = categories.map((e) => e.name).join(', ');
    } catch (error) {
      Get.snackbar("Error", "Failed to load collections");
    } finally {
      waiting.value = false;
    }
  }

  String itemAmount() {
    return profile.itemsCount.value > 1
        ? '${profile.itemsCount.value} itens'
        : '${profile.itemsCount.value} item';
  }

  String collectionAmount() {
    return profile.collectionsCount.value > 1
        ? '${profile.collectionsCount.value} coleções'
        : '${profile.collectionsCount.value} coleção';
  }
}

import 'dart:async';

import 'package:get/get.dart';
import 'package:item_expo/module/collection/models/collection_model.dart';
import 'package:item_expo/module/collection/models/category_model.dart';
import 'package:item_expo/module/collection/repositories/category_repository.dart';
import 'package:item_expo/module/collection/repositories/collection_repository.dart';
import 'package:item_expo/services/profile_service.dart';
import 'package:item_expo/utils/snackbar.dart';

class CollectionController extends GetxController {
  final CollectionRepository collectionRepository = CollectionRepository();
  final CategoryRepository categoryRepository = CategoryRepository();
  final ProfileService profile = Get.find();

  RxList<CollectionModel> collections = <CollectionModel>[].obs;
  RxList<CategoryModel> categories = <CategoryModel>[].obs;
  RxList<CategoryModel> selectedCategories = <CategoryModel>[].obs;
  RxMap<int, String?> images = <int, String?>{}.obs;

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
      errorSnackbar("Falha ao carregar coleções");
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
      errorSnackbar("Falha ao carregar categorias");
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

  Future<void> getImage(int? id) async {
    try {
      final img = await collectionRepository.getItemWithCollection(id);
      if (img != null) {
        images[id!] = img;
      }
    } catch (error) {
      errorSnackbar('Erro ao trazer imagem para coleção');
    }
  }
}

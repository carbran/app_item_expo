import 'package:get/get.dart';
import 'package:item_expo/module/collection/models/collection_model.dart';
import 'package:item_expo/module/collection/repositories/collection_repository.dart';
import 'package:item_expo/services/profile_service.dart';

class CollectionController extends GetxController {
  final CollectionRepository _collectionRepository = CollectionRepository();
  final ProfileService profile = Get.find();

  RxList<Collection> collections =  <Collection>[].obs;
  Rx<bool> waiting = Rx(false);

  @override
  void onInit() {
    super.onInit();
    fetchCollections();
  }

  void fetchCollections() async {
    waiting.value = true;
    try {
      collections.value = await _collectionRepository.fetchCollections();
    } catch (e) {
      Get.snackbar("Error", "Failed to load collections");
    } finally {
      waiting.value = false;
    }
  }
}

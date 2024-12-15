import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:item_expo/module/item/models/item_model.dart';
import 'package:item_expo/services/api_service.dart';
import 'package:item_expo/services/storage_service.dart';
import 'package:item_expo/utils/errors.dart';
import 'package:logger/logger.dart';

class ItemRepository {
  late final StorageService storageService;
  late final ApiService apiService;
  late final Logger logger;

  ItemRepository() {
    apiService = Get.find();
    storageService = Get.find();
    logger = Get.find();
  }

  Future<List<ItemModel>> fetchItems() async {
    try {
      final response = await apiService.dio.get('/items');

      return (response.data as List)
          .map((item) => ItemModel.fromJson(item))
          .toList();
    } on DioException catch (e) {
      if (e.response == null) {
        throw (unknownErrorException(e));
      }
      throw (responseDioException(e));
    }
  }

  Future<List<ItemModel>> showItems(int id) async {
    try {
      final response = await apiService.dio.get('/items/$id');

      return (response.data as List)
          .map((item) => ItemModel.fromJson(item))
          .toList();
    } on DioException catch (e) {
      if (e.response == null) {
        throw (unknownErrorException(e));
      }
      throw (responseDioException(e));
    }
  }

  Future<bool> createItem(ItemModel item) async {
    try {
      final response = await apiService.dio.post('/items', data: item.toJson());

      if (response.statusCode == 201) {
        return true;
      } else {
        return false;
      }
    } on DioException catch (e) {
      if (e.response == null) {
        throw (unknownErrorException(e));
      }
      throw (responseDioException(e));
    }
  }

  Future<bool> updateItem(int id, ItemModel item) async {
    try {
      final response =
          await apiService.dio.put('/items/$id', data: item.toJson());

      if (response.statusCode == 201) {
        return true;
      } else {
        return false;
      }
    } on DioException catch (e) {
      if (e.response == null) {
        throw (unknownErrorException(e));
      }
      throw (responseDioException(e));
    }
  }

  Future<bool> deleteItem(int id) async {
    try {
      final response = await apiService.dio.delete('/items/$id');

      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } on DioException catch (e) {
      if (e.response == null) {
        throw (unknownErrorException(e));
      }
      throw (responseDioException(e));
    }
  }

  Future<List<ItemModel>> fetchItemsByCollection(int collectionId) async {
    try {
      final response = await apiService.dio.post('/items/withCollectionId',
          data: {'collection_id': collectionId});

      return (response.data as List)
          .map((item) => ItemModel.fromJson(item))
          .toList();
    } on DioException catch (e) {
      if (e.response == null) {
        throw (unknownErrorException(e));
      }
      throw (responseDioException(e));
    }
  }
}

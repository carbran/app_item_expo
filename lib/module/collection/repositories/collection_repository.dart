import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:item_expo/module/collection/models/collection_model.dart';
import 'package:item_expo/services/api_service.dart';
import 'package:item_expo/services/storage_service.dart';
import 'package:item_expo/utils/errors.dart';
import 'package:logger/logger.dart';

class CollectionRepository {
  late final StorageService storageService;
  late final ApiService apiService;
  late final Logger logger;

  CollectionRepository() {
    apiService = Get.find();
    storageService = Get.find();
    logger = Get.find();
  }

  Future<List<Collection>> fetchCollections() async {
    try {
      final response = await apiService.dio.get('/collections');
      
      return (response.data as List)
          .map((collection) => Collection.fromJson(collection))
          .toList();
    } on DioException catch (e) {
      if (e.response == null) {
        throw (unknownErrorException(e));
      }
      throw (responseDioException(e));
    }
  }

  Future<Collection> createCollection(Collection collection) async {
    try {
      final response = await apiService.dio.post('/collections', data: collection.toJson());

      return Collection.fromJson(response.data);
    } on DioException catch (e) {
      if (e.response == null) {
        throw (unknownErrorException(e));
      }
      throw (responseDioException(e));
    }
  }

  Future<Collection> updateCollection(int id, Collection collection) async {
    try {
      final response = await apiService.dio.put('/collections/$id', data: collection.toJson());

      return Collection.fromJson(response.data);
    } on DioException catch (e) {
      if (e.response == null) {
        throw (unknownErrorException(e));
      }
      throw (responseDioException(e));
    }
  }

  Future<void> deleteCollection(int id) async {
    try {
      await apiService.dio.delete('/collections/$id');

    } on DioException catch (e) {
      if (e.response == null) {
        throw (unknownErrorException(e));
      }
      throw (responseDioException(e));
    }
  }
}

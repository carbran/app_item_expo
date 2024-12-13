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

  Future<List<CollectionModel>> fetchCollections({int id = 0}) async {
    try {
      final dynamic response;
      if (id > 0) {
        response = await apiService.dio.get('/collections/$id');
      } else {
        response = await apiService.dio.get('/collections');
      }

      return (response.data as List)
          .map((collection) => CollectionModel.fromJson(collection))
          .toList();
    } on DioException catch (e) {
      if (e.response == null) {
        throw (unknownErrorException(e));
      }
      throw (responseDioException(e));
    }
  }

  Future<bool> createCollection(CollectionModel collection) async {
    try {
      final response =
          await apiService.dio.post('/collections', data: collection.toJson());

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

  Future<CollectionModel> updateCollection(
      int id, CollectionModel collection) async {
    try {
      final response = await apiService.dio
          .put('/collections/$id', data: collection.toJson());

      return CollectionModel.fromJson(response.data);
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

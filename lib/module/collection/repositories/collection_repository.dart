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

  Future<List<CollectionModel>> fetchCollections() async {
    try {
      final response = await apiService.dio.get('/collections');

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

  Future<List<CollectionModel>> showCollections(int id) async {
    try {
      final response = await apiService.dio.get('/collections/$id');

      if (response.data is Map<String, dynamic>) {
        final collection = CollectionModel.fromJson(response.data);

        return [collection];
      } else {
        throw Exception(
            "Resposta inesperada da API: ${response.data.runtimeType}");
      }
    } on DioException catch (e) {
      // Trata exceções específicas do Dio
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

  Future<bool> updateCollection(int id, CollectionModel collection) async {
    try {
      final response = await apiService.dio
          .put('/collections/$id', data: collection.toJson());

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

  Future<bool> deleteCollection(int id) async {
    try {
      final response = await apiService.dio.delete('/collections/$id');

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

  Future<String?> getItemWithCollection(int? id) async {
    try {
      final response =
          await apiService.dio.get('/collections/first-item-image/$id');

      if (response.statusCode == 200 && response.data != []) {
        return response.data['image_data'];
      }
      return null;
    } on DioException catch (e) {
      if (e.response == null) {
        throw (unknownErrorException(e));
      }
      throw (responseDioException(e));
    }
  }
}

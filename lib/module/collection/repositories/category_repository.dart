import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:item_expo/module/collection/models/category_model.dart';
import 'package:item_expo/services/api_service.dart';
import 'package:item_expo/services/storage_service.dart';
import 'package:item_expo/utils/errors.dart';
import 'package:logger/logger.dart';

class CategoryRepository {
  late final StorageService storageService;
  late final ApiService apiService;
  late final Logger logger;

  CategoryRepository() {
    apiService = Get.find();
    storageService = Get.find();
    logger = Get.find();
  }

  Future<List<CategoryModel>> fetchCategories() async {
    try {
      final response = await apiService.dio.get('/categories');
      
      return (response.data as List)
          .map((category) => CategoryModel.fromJson(category))
          .toList();
    } on DioException catch (e) {
      if (e.response == null) {
        throw (unknownErrorException(e));
      }
      throw (responseDioException(e));
    }
  }

  Future<CategoryModel> createCategory(CategoryModel category) async {
    try {
      final response = await apiService.dio.post('/categories', data: category.toJson());

      return CategoryModel.fromJson(response.data);
    } on DioException catch (e) {
      if (e.response == null) {
        throw (unknownErrorException(e));
      }
      throw (responseDioException(e));
    }
  }

  Future<CategoryModel> updateCategory(int id, CategoryModel category) async {
    try {
      final response = await apiService.dio.put('/categories/$id', data: category.toJson());

      return CategoryModel.fromJson(response.data);
    } on DioException catch (e) {
      if (e.response == null) {
        throw (unknownErrorException(e));
      }
      throw (responseDioException(e));
    }
  }

  Future<void> deleteCategory(int id) async {
    try {
      await apiService.dio.delete('/categories/$id');

    } on DioException catch (e) {
      if (e.response == null) {
        throw (unknownErrorException(e));
      }
      throw (responseDioException(e));
    }
  }
}

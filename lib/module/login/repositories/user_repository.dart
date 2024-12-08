import 'package:get/get.dart';
import 'package:item_expo/services/api_service.dart';
import 'package:item_expo/services/storage_service.dart';
import 'package:logger/logger.dart';

class UserRepository {
  late final StorageService storageService;
  late final ApiService apiService;
  late final Logger logger;

  UserRepository() {
    storageService = Get.find();
    apiService = Get.find();
    logger = Get.find();
  }

  //TODO: CRIAR USER REPOSITORY E MODEL

  login(String s, String t) {}

  getAccessCode(String email) {}
}

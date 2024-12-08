import 'package:dio/dio.dart';
import 'package:get/get.dart';

import 'package:item_expo/services/storage_service.dart';
import 'package:item_expo/utils/interceptors/custom_interceptor.dart';

class ApiService extends GetxService {

  late final Dio dio;
  final Map<String, dynamic> headers = {};
  bool offlineMode = false;
  late final StorageService storageService = Get.find();

  @override
  void onInit() async {
    dio = Dio(
      BaseOptions(
        baseUrl: const String.fromEnvironment('API_URL'),
        connectTimeout: const Duration(seconds: 30),
      ),
    );

    dio.interceptors.add(CustomInterceptor());

    super.onInit();
  }

  void addHeaders(Map<String, String> headers) {
    headers.addAll(headers);
    dio.options.headers = headers;
  }

  void delHeaders() {
    headers.clear();
    dio.options.headers = headers;
  }
}

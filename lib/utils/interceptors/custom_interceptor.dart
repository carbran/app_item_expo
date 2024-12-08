import 'package:dio/dio.dart' as dio;
import 'package:get/get.dart';

import 'package:item_expo/services/api_service.dart';

class CustomInterceptor extends dio.Interceptor {
  @override
  void onError(dio.DioException err, dio.ErrorInterceptorHandler handler) {
    if (err.response?.statusCode == 401) {
      Get.offAndToNamed('/login');
    } else if ([400, 402, 403, 404, 405, 300, 301, 302, 303, 304, 305, 500]
        .contains(err.response?.statusCode)) {
      handler.next(err);
    } else {
      ApiService api = Get.find();
      api.offlineMode = true;
      handler.next(err);
    }
  }
}

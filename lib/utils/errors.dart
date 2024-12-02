import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:item_expo/utils/snackbar.dart';
import 'package:item_expo_theme_package/item_expo_colors.dart';

void handleError(e,
    {
    double marginBottom = 80}) {
  if (e != null && e is Map) {
    if (e.containsKey('code') &&
        (e['code'] == 500 || e['code'] == 0) &&
        !e.containsKey('data')) {
      showSnackbar(
          context: Get.context!,
          message: 'Erro de conexão. Por favor, tente novamente.',
          marginBottom: marginBottom,
          colorSnack: ItemExpoColors.red);
    } else {
      showSnackbar(
          context: Get.context!,
          message: e['data']['message'],
          marginBottom: marginBottom);
    }
  } else {
    showSnackbar(
        context: Get.context!,
        message: 'Ocorreu um erro',
        marginBottom: marginBottom);
  }
}

Map<String, dynamic> unknownErrorException(e) => {
      'code': 0,
      'message': 'An error occured',
      'error': e ?? '',
    };

Map<String, Object> responseException(http.Response response) {
  return {
    'code': response.statusCode,
    'message': response.reasonPhrase ?? '',
    'data': response.body,
  };
}

Map<String, dynamic> responseDioException(DioException e) {
  return {
    'code': e.response?.statusCode,
    'message': e.response?.statusMessage,
    'data': e.response?.data
  };
}
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

void handleError(e, {double marginBottom = 80}) {
  if (e != null && e is Map) {
    if (e.containsKey('code') &&
        (e['code'] == 500 || e['code'] == 0) &&
        !e.containsKey('data')) {
      Get.snackbar('Erro de conexão', 'Por favor, tente novamente.',
          snackPosition: SnackPosition.BOTTOM,
          margin: const EdgeInsets.only(bottom: 60),
          backgroundColor: Colors.red,
          colorText: Colors.white);
    } else {
      Get.snackbar('Erro', e['data']['message'],
          snackPosition: SnackPosition.BOTTOM,
          margin: const EdgeInsets.only(bottom: 60),
          backgroundColor: Colors.red,
          colorText: Colors.white);
    }
  } else {
    Get.snackbar('Erro', 'Ocorreu um erro desconhecido.',
        snackPosition: SnackPosition.BOTTOM,
        margin: const EdgeInsets.only(bottom: 60),
        backgroundColor: Colors.red,
        colorText: Colors.white);
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

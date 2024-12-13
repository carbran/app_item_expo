import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:item_expo_theme_package/item_expo_colors.dart';

void successSnackbar(String message){
  Get.snackbar(
            'Sucesso',
            message,
            backgroundColor: ItemExpoColors.green,
            colorText: ItemExpoColors.black,
            snackPosition: SnackPosition.BOTTOM,
            margin: const EdgeInsets.only(bottom: 80),
          );
}

void warningSnackbar(String message){
  Get.snackbar(
            'Aviso',
            message,
            backgroundColor: Colors.yellow,
            colorText: ItemExpoColors.black,
            snackPosition: SnackPosition.BOTTOM,
            margin: const EdgeInsets.only(bottom: 80),
          );
}

void errorSnackbar(String message){
  Get.snackbar(
            'Erro',
            message,
            backgroundColor: ItemExpoColors.red,
            colorText: ItemExpoColors.white,
            snackPosition: SnackPosition.BOTTOM,
            margin: const EdgeInsets.only(bottom: 80),
          );
}
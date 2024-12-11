import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:item_expo/module/item/controllers/item_controller.dart';
import 'package:item_expo_theme_package/item_expo_colors.dart';

class ItemPage extends GetView<ItemController> {
  const ItemPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Item Teste'),
          backgroundColor: ItemExpoColors.darkPurple,
          titleTextStyle: const TextStyle(
            color: ItemExpoColors.white,
            fontWeight: FontWeight.bold,
            fontSize: 16.0,
          ),
        ),
        body: const SafeArea(child: Text('ItemController')));
  }
}

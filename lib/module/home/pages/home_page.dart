import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:item_expo/module/home/controllers/home_controller.dart';
import 'package:item_expo_theme_package/item_expo_colors.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Teste'),
        backgroundColor: ItemExpoColors.darkPurple,
        titleTextStyle: const TextStyle(
          color: ItemExpoColors.white,
          fontWeight: FontWeight.bold,
          fontSize: 16.0,
        ),
      ),
      body: const Center(
        child: SizedBox(
          child: Column(
            children: [Text('Home')],
          ),
        ),
      ),
    );
  }
}

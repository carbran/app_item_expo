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
      backgroundColor: ItemExpoColors.lightPurple,
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: ItemExpoColors.darkPurple,
        iconSize: 40,
        selectedItemColor: ItemExpoColors.white,
        unselectedItemColor: ItemExpoColors.white,
        selectedFontSize: 0,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        onTap: controller.goToPage(),
        currentIndex: controller.indexPage.value,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home_rounded,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.add_box_rounded,
            ),
            label: 'Add Item',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person_rounded,
            ),
            label: 'Usuário',
          ),
        ],
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

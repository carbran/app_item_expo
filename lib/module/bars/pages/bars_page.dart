import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:item_expo/module/bars/controllers/bars_controller.dart';

class BarsPage extends GetView<BarsController> {
  const BarsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() => controller.pages[controller.currentIndex.value]),
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
          // backgroundColor: ItemExpoColors.darkPurple,
          iconSize: 40,
          // selectedItemColor: ItemExpoColors.white,
          // unselectedItemColor: ItemExpoColors.white,
          selectedFontSize: 0,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          onTap: (index) {
            controller.changePage(index);
          },
          currentIndex: controller.currentIndex.value,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              activeIcon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.add_box_outlined),
              activeIcon: Icon(Icons.add_box_rounded),
              label: 'Add Item',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_outline_rounded),
              activeIcon: Icon(Icons.person_rounded),
              label: 'Usuário',
            ),
          ],
        ),
      ),
    );
  }
}

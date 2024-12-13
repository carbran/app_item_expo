import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:item_expo/module/collection/pages/collection_page.dart';
import 'package:item_expo/module/create_collection/pages/create_collection_page.dart';
import 'package:item_expo/module/user/pages/user_page.dart';
import 'package:item_expo/services/profile_service.dart';

class BarsController extends GetxController {
  final List<Widget> pages = [
    const CollectionPage(),
    const CreateCollectionPage(),
    const UserPage(),
  ];
  Rx<int> currentIndex = Rx(0);

  final ProfileService profile = Get.find();

  void changePage(int index) {
    currentIndex.value = index;
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:item_expo/module/collection/controllers/collection_controller.dart';

class CollectionPage extends GetView<CollectionController> {
  const CollectionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('CollectionPage')),
        body: const SafeArea(child: Text('CollectionController')));
  }
}

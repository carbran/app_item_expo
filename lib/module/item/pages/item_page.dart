import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:item_expo/module/item/controllers/item_controller.dart';

class ItemPage extends GetView<ItemController> {

  const ItemPage({super.key});

  @override
  Widget build(BuildContext context) {
    // final CollectionController controller = Get.find();

    return Scaffold(
      appBar: AppBar(
        title: Text("Items in ${{controller.collectionName}}"),
        backgroundColor: Colors.blue,
      ),
      body: Obx(() {
        if (controller.waiting.value) {
          return const Center(child: CircularProgressIndicator());
        }
        return GridView.builder(
          padding: const EdgeInsets.all(10),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
            childAspectRatio: 1,
          ),
          itemCount: controller.items.length,
          itemBuilder: (context, index) {
            final item = controller.items[index];
            return Card(
              elevation: 2,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      item.title,
                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                    if (item.subtitle != null)
                      Text(
                        item.subtitle!,
                        style: const TextStyle(fontSize: 12, color: Colors.grey),
                        textAlign: TextAlign.center,
                      ),
                  ],
                ),
              ),
            );
          },
        );
      }),
    );
  }
}

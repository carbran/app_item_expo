import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:item_expo/module/item/controllers/item_controller.dart';
import 'package:item_expo/routes/app_routes.dart';
import 'package:item_expo/shared/svg_gallery.dart';
import 'package:lottie/lottie.dart';

class ItemPage extends GetView<ItemController> {
  const ItemPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Itens de ${controller.collectionName}"),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.toNamed(Routes.createItem);
        },
        tooltip: 'Adicionar Item',
        child: const Icon(Icons.add),
      ),
      body: Obx(
        () {
          if (controller.waiting.value) {
            return Center(
                child: Lottie.asset(
              AnimGallery.loader,
              width: 60,
              height: 52,
            ));
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
                        controller.title,
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                      if (item.subtitle != null)
                        Text(
                          item.subtitle!,
                          style:
                              const TextStyle(fontSize: 12, color: Colors.grey),
                          textAlign: TextAlign.center,
                        ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

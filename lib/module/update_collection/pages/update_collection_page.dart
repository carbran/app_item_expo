import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:item_expo/module/update_collection/controllers/update_collection_controller.dart';
import 'package:item_expo/shared/svg_gallery.dart';
import 'package:item_expo/utils/validators.dart';
import 'package:item_expo_theme_package/item_expo_colors.dart';
import 'package:lottie/lottie.dart';

class UpdateCollectionPage extends GetView<UpdateCollectionController> {
  const UpdateCollectionPage({super.key});

  final _padding = const EdgeInsets.all(8.0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Alterar Coleção'),
        backgroundColor: ItemExpoColors.darkPurple,
        titleTextStyle: const TextStyle(
          color: ItemExpoColors.white,
          fontWeight: FontWeight.bold,
          fontSize: 16.0,
        ),
      ),
      body: Center(
        child: SizedBox(
          width: Get.width * 0.8,
          child: SingleChildScrollView(
            physics: const NeverScrollableScrollPhysics(),
            child: Form(
              key: controller.formUpdateCollectionKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: _padding,
                    child: Obx(
                      () => TextFormField(
                        controller: TextEditingController(
                            text: controller.collection.value.name),
                        decoration: const InputDecoration(
                          hintText: 'Nome da Coleção',
                          filled: true,
                          fillColor: ItemExpoColors.white,
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.all(
                              Radius.circular(30.0),
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: ItemExpoColors.neonPink,
                              width: 2.0,
                            ),
                            borderRadius: BorderRadius.all(
                              Radius.circular(30.0),
                            ),
                          ),
                        ),
                        style: const TextStyle(color: ItemExpoColors.black),
                        keyboardType: TextInputType.name,
                        validator: (value) => normalTextValidator(value!,
                            'O nome não pode ser vazio \nou menor que três caracteres'),
                        onChanged: (value) =>
                            controller.collection.value.name = value,
                      ),
                    ),
                  ),
                  Padding(
                    padding: _padding,
                    child: const Text(
                      'Selecione a(s) categoria(s) da sua Coleção',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: ItemExpoColors.black,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: Get.height * 0.5,
                    child: Obx(
                      () {
                        return GridView.builder(
                          key: ValueKey(controller.selectedCategories.length),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 8,
                            mainAxisSpacing: 8,
                            childAspectRatio: 3,
                          ),
                          itemCount: controller.categories.length,
                          itemBuilder: (context, index) {
                            final category = controller.categories[index];
                            final isSelected = controller.selectedCategories
                                .any((c) => c.id == category.id);
                            return GestureDetector(
                              onTap: () =>
                                  controller.toggleCategorySelection(category),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: isSelected
                                      ? ItemExpoColors.blue
                                      : Colors.grey.shade200,
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                    color: isSelected
                                        ? ItemExpoColors.blueButton
                                        : Colors.grey.shade400,
                                    width: 2,
                                  ),
                                ),
                                child: Center(
                                  child: Text(
                                    category.name,
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: ItemExpoColors.black,
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding: _padding,
                    child: Obx(
                      () => !controller.waiting.value
                          ? ElevatedButton(
                              onPressed: () => controller.updateCollection(),
                              child: const Text(
                                'Alterar coleção',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                            )
                          : Lottie.asset(
                              AnimGallery.loader,
                              width: 60,
                              height: 52,
                            ),
                    ),
                  ),
                  Padding(
                    padding: _padding,
                    child: Obx(
                      () => !controller.waiting.value
                          ? ElevatedButton(
                              style: const ButtonStyle(
                                backgroundColor: WidgetStatePropertyAll(
                                  ItemExpoColors.red,
                                ),
                              ),
                              onPressed: () => controller.deleteCollection(),
                              child: const Text(
                                'Excluir coleção',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                            )
                          : Lottie.asset(
                              AnimGallery.loader,
                              width: 60,
                              height: 52,
                            ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

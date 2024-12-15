import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:item_expo/module/create_item/controllers/create_item_controller.dart';
import 'package:item_expo/module/create_item/enums/condition_enum.dart';
import 'package:item_expo/module/create_item/enums/size_type_enum.dart';
import 'package:item_expo/shared/svg_gallery.dart';
import 'package:item_expo/utils/helpers.dart';
import 'package:item_expo/utils/snackbar.dart';
import 'package:item_expo/utils/validators.dart';
import 'package:item_expo_theme_package/item_expo_colors.dart';
import 'package:lottie/lottie.dart';

class CreateItemPage extends GetView<CreateItemController> {
  const CreateItemPage({super.key});

  final _padding = const EdgeInsets.all(8.0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastrar Item'),
        titleTextStyle: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 16.0,
        ),
      ),
      body: Center(
        child: SizedBox(
          width: Get.width * 0.8,
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Form(
              key: controller.formCreateItemKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: _padding,
                    child: TextFormField(
                      controller: TextEditingController(),
                      decoration: const InputDecoration(
                        hintText: 'Nome ou título',
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
                      validator: (value) =>
                          normalTextValidator(value, 'Campo obrigatório'),
                      onChanged: (value) => controller.item.title = value,
                    ),
                  ),
                  Padding(
                    padding: _padding,
                    child: TextFormField(
                      controller: TextEditingController(),
                      decoration: const InputDecoration(
                        hintText: 'Subtítulo',
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
                      onChanged: (value) => controller.item.subtitle = value,
                    ),
                  ),
                  Padding(
                    padding: _padding,
                    child: TextFormField(
                      controller: TextEditingController(),
                      decoration: const InputDecoration(
                        hintText: 'Autor/Criador',
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
                      onChanged: (value) => controller.item.author = value,
                    ),
                  ),
                  Obx(
                    () => Padding(
                      padding: _padding,
                      child: TextField(
                        controller: TextEditingController(
                          text: Helpers.formattedDate(
                              controller.selectedDate.value),
                        ),
                        inputFormatters: [DataInputFormatter()],
                        decoration: const InputDecoration(
                          suffixIcon: Icon(Icons.calendar_today),
                          hintText: 'Data de aquisição',
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
                        readOnly: true,
                        onTap: () {
                          controller.selectStartDate(context);
                        },
                      ),
                    ),
                  ),
                  Padding(
                    padding: _padding,
                    child: DropdownButtonFormField<String>(
                      decoration: const InputDecoration(
                        hintText: 'Condição',
                        filled: true,
                        fillColor: ItemExpoColors.white,
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.all(
                            Radius.circular(30.0),
                          ),
                        ),
                      ),
                      items: ConditionEnum.values
                          .map((e) => e.name)
                          .toList()
                          .map(
                            (unit) => DropdownMenuItem(
                              value: unit,
                              child: Text(
                                unit,
                                style: const TextStyle(
                                    color: ItemExpoColors.black),
                              ),
                            ),
                          )
                          .toList(),
                      onChanged: (value) {
                        if (value != null) {
                          controller.item.condition =
                              controller.enumConditionNameToNum(value);
                        }
                      },
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        flex: 5,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            controller: TextEditingController(),
                            decoration: const InputDecoration(
                              hintText: 'Tamanho',
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
                            onChanged: (value) => controller.item.size = value,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 5,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: DropdownButtonFormField<String>(
                            decoration: const InputDecoration(
                              hintText: 'Medida',
                              filled: true,
                              fillColor: ItemExpoColors.white,
                              border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(30.0),
                                ),
                              ),
                            ),
                            items: SizeTypeEnum.values
                                .map((e) => e.name)
                                .toList()
                                .map((unit) => DropdownMenuItem(
                                      value: unit,
                                      child: Text(
                                        unit,
                                        style: const TextStyle(
                                            color: ItemExpoColors.black),
                                      ),
                                    ))
                                .toList(),
                            onChanged: (value) {
                              if (value != null) {
                                controller.item.sizeType =
                                    controller.enumSizeNameToNum(value);
                              }
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: _padding,
                    child: TextFormField(
                      controller: TextEditingController(),
                      decoration: const InputDecoration(
                        hintText: 'Quantidade',
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
                      keyboardType: TextInputType.number,
                      onChanged: (value) =>
                          controller.item.amount = int.parse(value),
                    ),
                  ),
                  Padding(
                    padding: _padding,
                    child: Obx(
                      () => !controller.waiting.value
                          ? ElevatedButton(
                              onPressed: () => _showImageSourceModal(context),
                              child: const Text(
                                'Adicionar Imagem',
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
                              onPressed: () {
                                if (controller.selectedImageBase64.value ==
                                    null) {
                                  errorSnackbar(
                                      'Selecione uma imagem antes de continuar');
                                  return;
                                }
                                controller.createItem();
                              },
                              child: const Text(
                                'Adicionar Item',
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

  void _showImageSourceModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(16.0),
          height: 150,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ElevatedButton.icon(
                onPressed: () {
                  Get.back(); // Fecha a modal
                  controller.getImage(ImageSource.camera);
                },
                icon: const Icon(Icons.camera_alt),
                label: const Text('Câmera'),
              ),
              ElevatedButton.icon(
                onPressed: () {
                  Get.back(); // Fecha a modal
                  controller.getImage(ImageSource.gallery);
                },
                icon: const Icon(Icons.photo_library),
                label: const Text('Galeria'),
              ),
            ],
          ),
        );
      },
    );
  }
}

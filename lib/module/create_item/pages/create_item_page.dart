import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:item_expo/module/create_item/controllers/create_item_controller.dart';
import 'package:item_expo/module/create_item/enums/condition_enum.dart';
import 'package:item_expo/module/create_item/enums/size_type_enum.dart';
import 'package:item_expo/shared/svg_gallery.dart';
import 'package:item_expo/utils/helpers.dart';
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
                          text:
                              Helpers.formattedDate(controller.startDate.value),
                        ),
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
                          .map((unit) => DropdownMenuItem(
                                value: unit,
                                child: Text(unit,
                                    style: const TextStyle(
                                        color: ItemExpoColors.black)),
                              ))
                          .toList(),
                      onChanged: (value) {
                        if (value != null) {
                          controller.selectedUnit.value = value;
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
                                      child: Text(unit,
                                          style: const TextStyle(
                                              color: ItemExpoColors.black)),
                                    ))
                                .toList(),
                            onChanged: (value) {
                              if (value != null) {
                                controller.selectedUnit.value = value;
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
                          controller.item.amount = value as int?,
                    ),
                  ),
                  Padding(
                    padding: _padding,
                    child: Obx(
                      () => !controller.waiting.value
                          ? ElevatedButton(
                              onPressed: () {},
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
                              onPressed: () => controller.createItem(),
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
}

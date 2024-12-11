import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:item_expo/module/user/controllers/user_controller.dart';
import 'package:item_expo/shared/svg_gallery.dart';
import 'package:item_expo/utils/validators.dart';
import 'package:item_expo_theme_package/item_expo_colors.dart';
import 'package:lottie/lottie.dart';

class UserPage extends GetView<UserController> {
  const UserPage({super.key});

  final _padding = const EdgeInsets.all(8.0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dados do Usuário'),
        backgroundColor: ItemExpoColors.darkPurple,
        titleTextStyle: const TextStyle(
          color: ItemExpoColors.white,
          fontWeight: FontWeight.bold,
          fontSize: 16.0,
        ),
      ),
      backgroundColor: ItemExpoColors.lightPurple,
      body: Center(
        child: SizedBox(
          width: Get.width * 0.8,
          child: SingleChildScrollView(
            physics: const NeverScrollableScrollPhysics(),
            child: Form(
              key: controller.formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: _padding,
                    child: TextFormField(
                      controller: TextEditingController(
                          text: controller.profile.user?.name),
                      decoration: const InputDecoration(
                        labelText: '\n Nome',
                        labelStyle: TextStyle(
                          color: ItemExpoColors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
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
                      validator: (value) => nameValidator!(value!),
                      onChanged: (value) => controller.user.name = value,
                    ),
                  ),
                  Padding(
                    padding: _padding,
                    child: TextFormField(
                      controller: TextEditingController(
                        text: UtilBrasilFields.obterTelefone(
                            controller.profile.user?.phone ?? '00000000000'),
                      ),
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        TelefoneInputFormatter()
                      ],
                      decoration: const InputDecoration(
                        labelText: '\n Telefone',
                        labelStyle: TextStyle(
                          color: ItemExpoColors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
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
                      keyboardType: TextInputType.phone,
                      validator: (value) => telValidator!(value!),
                      onChanged: (value) => controller.user.phone = value,
                    ),
                  ),
                  Padding(
                    padding: _padding,
                    child: TextFormField(
                      controller: TextEditingController(
                          text: controller.profile.user?.email),
                      decoration: const InputDecoration(
                        labelText: '\n E-mail',
                        labelStyle: TextStyle(
                          color: ItemExpoColors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
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
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) => emailValidator!(value!),
                      onChanged: (value) => controller.user.email = value,
                    ),
                  ),
                  Padding(
                    padding: _padding,
                    child: Obx(
                      () => !controller.waiting.value
                          ? ElevatedButton(
                              style: const ButtonStyle(
                                backgroundColor: WidgetStatePropertyAll(
                                    ItemExpoColors.darkPurple),
                              ),
                              onPressed: () => controller.updateUser(),
                              child: const Text(
                                'Alterar',
                                style: TextStyle(
                                    color: ItemExpoColors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16),
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

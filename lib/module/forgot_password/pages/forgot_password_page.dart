import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:item_expo/module/forgot_password/controllers/forgot_password_controller.dart';
import 'package:item_expo/shared/svg_gallery.dart';
import 'package:item_expo/utils/validators.dart';
import 'package:item_expo_theme_package/item_expo_colors.dart';
import 'package:lottie/lottie.dart';

class ForgotPasswordPage extends GetView<ForgotPasswordController> {
  const ForgotPasswordPage({super.key});

  final _padding = const EdgeInsets.all(8.0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Esqueceu a senha?'),
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
          child: Form(
            key: controller.formKeyUserValidation,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Center(
                  child: Text(
                    'Informe seu e-mail para criar uma nova senha:',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: ItemExpoColors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ),
                Padding(
                  padding: _padding,
                  child: TextFormField(
                    controller: controller.emailController,
                    decoration: const InputDecoration(
                      hintText: 'E-mail',
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
                    onChanged: (value) => controller.email = value,
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
                            onPressed: () => controller.sendAccessCode(),
                            child: const Text(
                              'Continuar',
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
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:item_expo_theme_package/item_expo_colors.dart';
import 'package:lottie/lottie.dart';
import 'package:item_expo/module/forgot_password/controllers/forgot_password_controller.dart';
import 'package:item_expo/shared/svg_gallery.dart';
import 'package:item_expo/utils/validators.dart';

class NewPasswordPage extends GetView<ForgotPasswordController> {
  const NewPasswordPage({super.key});

  final _padding = const EdgeInsets.all(8.0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Esqueceu a senha?'),
        titleTextStyle: const TextStyle(
          color: ItemExpoColors.white,
          fontWeight: FontWeight.bold,
          fontSize: 16.0,
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: SizedBox(
            width: Get.width * 0.8,
            child: Form(
              key: controller.formKeyNewPassword,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Escolha uma nova senha',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: ItemExpoColors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  Obx(
                    () {
                      return Padding(
                        padding: _padding,
                        child: TextFormField(
                          controller: controller.passwordController,
                          decoration: InputDecoration(
                            hintText: 'Senha',
                            filled: true,
                            fillColor: ItemExpoColors.white,
                            border: const OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.all(
                                Radius.circular(30.0),
                              ),
                            ),
                            focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide(
                                color: ItemExpoColors.neonPink,
                                width: 2.0,
                              ),
                              borderRadius: BorderRadius.all(
                                Radius.circular(30.0),
                              ),
                            ),
                            suffixIcon: TextButton(
                              onPressed: () => controller.showPassword(),
                              child: Icon(
                                !controller.hidePass.value
                                    ? Icons.visibility_off_outlined
                                    : Icons.visibility_outlined,
                                color: ItemExpoColors.black,
                              ),
                            ),
                          ),
                          obscureText: controller.hidePass.value,
                          validator: (value) => passwordValidator!(value),
                          onChanged: (value) => controller.password = value,
                        ),
                      );
                    },
                  ),
                  Obx(
                    () {
                      return Padding(
                        padding: _padding,
                        child: TextFormField(
                          controller: controller.confirmPasswordController,
                          decoration: InputDecoration(
                            hintText: 'Confirmar Senha',
                            filled: true,
                            fillColor: ItemExpoColors.white,
                            border: const OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.all(
                                Radius.circular(30.0),
                              ),
                            ),
                            focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide(
                                color: ItemExpoColors.neonPink,
                                width: 2.0,
                              ),
                              borderRadius: BorderRadius.all(
                                Radius.circular(30.0),
                              ),
                            ),
                            suffixIcon: TextButton(
                              onPressed: () => controller.showConfirmPassword(),
                              child: Icon(
                                !controller.hideConfirmPass.value
                                    ? Icons.visibility_off_outlined
                                    : Icons.visibility_outlined,
                                color: ItemExpoColors.black,
                              ),
                            ),
                          ),
                          obscureText: controller.hideConfirmPass.value,
                          validator: (value) => passwordValidator!(value),
                          onChanged: (value) =>
                              controller.confirmPassword = value,
                        ),
                      );
                    },
                  ),
                  Padding(
                    padding: _padding,
                    child: Obx(
                      () => !controller.waiting.value
                          ? ElevatedButton(
                              onPressed: () => controller.newPassword(),
                              child: const Text(
                                'Continuar',
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

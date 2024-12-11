import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:item_expo/module/user/controllers/user_controller.dart';
import 'package:item_expo/shared/svg_gallery.dart';
import 'package:item_expo/utils/validators.dart';
import 'package:item_expo_theme_package/item_expo_colors.dart';
import 'package:lottie/lottie.dart';

class ChangePasswordPage extends GetView<UserController> {
  const ChangePasswordPage({super.key});

  final _padding = const EdgeInsets.all(8.0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Senha'),
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
              key: controller.formPasswordKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Obx(
                    () {
                      return Padding(
                        padding: _padding,
                        child: TextFormField(
                          controller: controller.oldPasswordController,
                          decoration: InputDecoration(
                            hintText: 'Informe a senha atual',
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
                              onPressed: () => controller.showOldPassword(),
                              child: Icon(
                                !controller.hideOldPass.value
                                    ? Icons.visibility_off_outlined
                                    : Icons.visibility_outlined,
                              ),
                            ),
                          ),
                          style: const TextStyle(color: ItemExpoColors.black),
                          obscureText: controller.hideOldPass.value,
                          validator: (value) => passwordValidator!(value),
                          onChanged: (value) => controller.oldPassword = value,
                        ),
                      );
                    },
                  ),
                  Obx(
                    () {
                      return Padding(
                        padding: _padding,
                        child: TextFormField(
                          controller: controller.passwordController,
                          decoration: InputDecoration(
                            hintText: 'Nova senha',
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
                              ),
                            ),
                          ),
                          style: const TextStyle(color: ItemExpoColors.black),
                          obscureText: controller.hidePass.value,
                          validator: (value) => passwordValidator!(value),
                          onChanged: (value) => controller.newPassword = value,
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
                            hintText: 'Confirmar nova senha',
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
                              ),
                            ),
                          ),
                          style: const TextStyle(color: ItemExpoColors.black),
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
                              style: const ButtonStyle(
                                backgroundColor: WidgetStatePropertyAll(
                                    ItemExpoColors.darkPurple),
                              ),
                              onPressed: () => controller.updatePassword(),
                              child: const Text(
                                'Alterar senha',
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

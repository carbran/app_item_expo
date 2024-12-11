import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:item_expo/module/register/controllers/register_controller.dart';
import 'package:item_expo/shared/svg_gallery.dart';
import 'package:item_expo/utils/validators.dart';
import 'package:item_expo_theme_package/item_expo_colors.dart';
import 'package:lottie/lottie.dart';

class RegisterPage extends GetView<RegisterController> {
  const RegisterPage({super.key});

  final _padding = const EdgeInsets.all(8.0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastrar Usuário'),
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
                      controller: TextEditingController(),
                      decoration: const InputDecoration(
                        hintText: 'Nome Completo',
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
                      controller: TextEditingController(),
                      decoration: const InputDecoration(
                        hintText: 'Telefone',
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
                      controller: TextEditingController(),
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
                      onChanged: (value) => controller.user.email = value,
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
                              ),
                            ),
                          ),
                          obscureText: controller.hidePass.value,
                          validator: (value) => passwordValidator!(value),
                          onChanged: (value) =>
                              controller.user.password = value,
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
                              ),
                            ),
                          ),
                          obscureText: controller.hideConfirmPass.value,
                          validator: (value) => passwordValidator!(value),
                          onChanged: (value) => controller.confirmPassword = value,
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
                              onPressed: () => Get.arguments == 'create'
                                  ? controller.register()
                                  : controller.updateUser(),
                              child: const Text(
                                'Cadastrar',
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

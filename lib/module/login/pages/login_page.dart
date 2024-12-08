import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:item_expo/module/login/controllers/login_controller.dart';
import 'package:item_expo/routes/app_routes.dart';
import 'package:item_expo/shared/svg_gallery.dart';
import 'package:item_expo/utils/validators.dart';
import 'package:item_expo_theme_package/item_expo_colors.dart';
import 'package:lottie/lottie.dart';

class LoginPage extends GetView<LoginController> {
  const LoginPage({super.key});

  final _padding = const EdgeInsets.all(8.0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ItemExpoColors.lightPurple,
      body: Center(
        child: SizedBox(
          width: Get.width * 0.8,
          child: SingleChildScrollView(
            physics: const NeverScrollableScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: _padding,
                  child: SvgPicture.asset(
                    SvgGallery.itemExpoLogo,
                    width: Get.width * 0.9,
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
                    onChanged: (value) => controller.email = value,
                  ),
                ),
                Obx(() {
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
                      onChanged: (value) => controller.password = value,
                    ),
                  );
                }),
                Padding(
                  padding: _padding,
                  child: Obx(
                    () => !controller.waiting.value
                        ? ElevatedButton(
                            style: const ButtonStyle(
                              backgroundColor: WidgetStatePropertyAll(
                                  ItemExpoColors.darkPurple),
                            ),
                            onPressed: () => controller.login(),
                            child: const Text(
                              'Entrar',
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
                TextButton(
                  onPressed: () => Get.toNamed(Routes.forgotPassword),
                  child: const Text('Esqueceu a senha'),
                ),
                TextButton(
                  onPressed: () => Get.toNamed(Routes.register),
                  child: const Text('Criar conta'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

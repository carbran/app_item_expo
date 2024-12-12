import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:item_expo_theme_package/item_expo_colors.dart';
import 'package:lottie/lottie.dart';
import 'package:item_expo/module/forgot_password/controllers/forgot_password_controller.dart';
import 'package:item_expo/shared/svg_gallery.dart';
import 'package:item_expo/utils/validators.dart';

class ValidationCodePage extends GetView<ForgotPasswordController> {
  const ValidationCodePage({super.key});

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
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
        child: SingleChildScrollView(
          child: SizedBox(
            height: Get.height - 120,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Form(
                  key: controller.formKeyValidationCode,
                  child: Column(
                    children: [
                      const Text(
                        'Informe a chave de acesso recebida no seu e-mail',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: ItemExpoColors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                      Padding(
                        padding: _padding,
                        child: TextFormField(
                          controller: controller.codeController,
                          decoration: const InputDecoration(
                            hintText: 'Código de acesso',
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
                          validator: (value) => normalTextValidator(
                              value ?? '', 'Insira o código de acesso'),
                          onChanged: (value) => controller.code = value,
                        ),
                      ),
                      Obx(
                        () => !controller.waiting.value
                            ? ElevatedButton(
                                onPressed: () => controller.updatePassword(),
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
                      const SizedBox(
                        height: 32,
                      ),
                      SizedBox(
                        height: 40,
                        child: Obx(() => AnimatedSwitcher(
                              duration: const Duration(seconds: 1),
                              child: !controller.isTimeExpired.value
                                  ? TextButton(
                                      onPressed: () =>
                                          controller.onPressResendCode(),
                                      child: const Text(
                                        'Não recebeu? Reenviar código.',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: ItemExpoColors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20,
                                        ),
                                      ),
                                    )
                                  : RichText(
                                      text: TextSpan(children: [
                                      const TextSpan(
                                        text: 'Reenviar novamente em: ',
                                        style: TextStyle(
                                          color: ItemExpoColors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20,
                                        ),
                                      ),
                                      TextSpan(
                                        text:
                                            '${controller.minutes}:${controller.seconds.toString().padLeft(2, '0')}',
                                        style: const TextStyle(
                                          color: ItemExpoColors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20,
                                        ),
                                      )
                                    ])),
                            )),
                      )
                    ],
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

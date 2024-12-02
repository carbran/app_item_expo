import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:item_expo/module/login/controllers/login_controller.dart';
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
          width: Get.width * 0.9,
          child: SingleChildScrollView(
            physics: const NeverScrollableScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: _padding,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: _padding,
                        child: SvgPicture.asset(
                          SvgGallery.itemExpoLogo,
                          width: Get.width * 0.7,
                        ),
                      ),
                      Padding(
                        padding: _padding,
                        child: Container(
                          decoration: BoxDecoration(
                            color: ItemExpoColors.white,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16.0,
                            ),
                            child: TextFormField(
                              controller: TextEditingController(),
                              decoration: const InputDecoration(
                                labelText: 'E-mail',
                                border: InputBorder.none,
                              ),
                              keyboardType: TextInputType.emailAddress,
                              validator: (value) => emailValidator!(value!),
                            ),
                          ),
                        ),
                      ),
                      Obx(
                        () {
                          return Padding(
                            padding: _padding,
                            child: Container(
                              decoration: BoxDecoration(
                                color: ItemExpoColors.white,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16.0,
                                ),
                                child: TextFormField(
                                  controller: TextEditingController(),
                                  decoration: InputDecoration(
                                    labelText: 'Senha',
                                    border: InputBorder.none,
                                    suffixIcon: TextButton(
                                      onPressed: () {
                                        controller.hidePass.value =
                                            !controller.hidePass.value;
                                      },
                                      child: Icon(
                                        !controller.hidePass.value
                                            ? Icons.visibility_off_outlined
                                            : Icons.visibility_outlined,
                                      ),
                                    ),
                                  ),
                                  obscureText: controller.hidePass.value,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                      Padding(
                        padding: _padding,
                        child: Obx(
                          () => !controller.waiting.value
                              ? ElevatedButton(
                                  onPressed: controller.login,
                                  child: const Text('Entrar'))
                              : Lottie.asset(
                                  AnimGallery.loader,
                                  width: 60,
                                  height: 52,
                                ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

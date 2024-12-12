import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:item_expo/module/confirmation/controllers/confirmation_controller.dart';
import 'package:item_expo/shared/svg_gallery.dart';
import 'package:item_expo_theme_package/item_expo_colors.dart';
import 'package:lottie/lottie.dart';

class ConfirmationPage extends GetView<ConfirmationController> {
  const ConfirmationPage({super.key});

  final _padding = const EdgeInsets.all(8.0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          width: Get.width * 0.8,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Lottie.asset(
                AnimGallery.confirmation,
                width: 130,
                height: 130,
              ),
              Text(
                controller.message,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: ItemExpoColors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              Padding(
                padding: _padding,
                child: ElevatedButton(
                  onPressed: () => controller.goToPage(),
                  child: const Text(
                    'Voltar',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

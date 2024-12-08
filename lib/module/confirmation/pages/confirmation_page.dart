import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:item_expo/module/confirmation/controllers/confirmation_controller.dart';
import 'package:item_expo/shared/svg_gallery.dart';
import 'package:item_expo_theme_package/item_expo_colors.dart';
import 'package:item_expo_theme_package/item_expo_text.dart';
import 'package:lottie/lottie.dart';

class ConfirmationPage extends GetView<ConfirmationController> {
  const ConfirmationPage({super.key});

  final _padding = const EdgeInsets.all(8.0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ItemExpoColors.lightPurple,
      body: Center(
        child: SizedBox(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Lottie.asset(
                AnimGallery.confirmation,
                width: 100,
                height: 100,
              ),
              Text(
                controller.message,
                style: ItemExpoTextStyle.bodyBold
                    .copyWith(color: ItemExpoColors.textMedium),
              ),
              Padding(
                padding: _padding,
                child: ElevatedButton(
                  style: const ButtonStyle(
                    backgroundColor:
                        WidgetStatePropertyAll(ItemExpoColors.darkPurple),
                  ),
                  onPressed: () => controller.goToPage(),
                  child: const Text(
                    'Voltar',
                    style: TextStyle(
                        color: ItemExpoColors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16),
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

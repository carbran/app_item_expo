import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:item_expo/module/forgot_password/controllers/forgot_password_controller.dart';

class NewPasswordPage extends GetView<ForgotPasswordController> {
  const NewPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
    appBar: AppBar(title: Text('NewPasswordPage')),

    body: SafeArea(
      child: Text('NewPasswordController'))
    );
  }
}
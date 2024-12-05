import 'package:get/get.dart';
import 'package:item_expo/module/login/bindings/login_binding.dart';
import 'package:item_expo/module/login/pages/login_page.dart';
import 'package:item_expo/module/register/bindings/register_binding.dart';
import 'package:item_expo/module/register/pages/register_page.dart';

abstract class Routes {
  static const home = '/home';
  static const login = '/login';
  static const register = '/register';
  static const sendCode = '/sendCode';
}

class AppPages {
  static final pages = [
    GetPage(
      name: Routes.login,
      page: () => const LoginPage(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: Routes.register,
      page: () => const RegisterPage(),
      binding: RegisterBinding(),
    ),
  ];
}

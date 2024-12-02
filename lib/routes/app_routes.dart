import 'package:get/get.dart';
import 'package:item_expo/module/login/bindings/login_binding.dart';
import 'package:item_expo/module/login/pages/login_page.dart';

abstract class Routes {
  static const home = '/home';
  static const login = '/login';
  static const cadastro = '/cadastro';
}

class AppPages {
  static final pages = [
    GetPage(
      name: Routes.login,
      page: () => const LoginPage(),
      binding: LoginBinding(),
    ),
  ];
}

import 'package:get/get.dart';
import 'package:item_expo/module/bars/bindings/bars_binding.dart';
import 'package:item_expo/module/bars/pages/bars_page.dart';
import 'package:item_expo/module/item/pages/cam_page.dart';
import 'package:item_expo/module/user/pages/change_password_page.dart';
import 'package:item_expo/module/collection/bindings/collection_binding.dart';
import 'package:item_expo/module/collection/pages/collection_page.dart';
import 'package:item_expo/module/confirmation/bindings/confirmation_binding.dart';
import 'package:item_expo/module/confirmation/pages/confirmation_page.dart';
import 'package:item_expo/module/forgot_password/pages/new_password_page.dart';
import 'package:item_expo/module/forgot_password/pages/validation_code_page.dart';
import 'package:item_expo/module/home/bindings/home_binding.dart';
import 'package:item_expo/module/home/pages/home_page.dart';
import 'package:item_expo/module/item/bindings/item_binding.dart';
import 'package:item_expo/module/item/pages/item_page.dart';
import 'package:item_expo/module/login/bindings/login_binding.dart';
import 'package:item_expo/module/login/pages/login_page.dart';
import 'package:item_expo/module/register/bindings/register_binding.dart';
import 'package:item_expo/module/register/pages/register_page.dart';
import 'package:item_expo/module/forgot_password/bindings/forgot_password_binding.dart';
import 'package:item_expo/module/forgot_password/pages/forgot_password_page.dart';
import 'package:item_expo/module/user/bindings/user_binding.dart';
import 'package:item_expo/module/user/pages/user_page.dart';

abstract class Routes {
  static const login = '/login';
  static const register = '/register';
  static const forgotPassword = '/forgotPassword';
  static const confirmation = '/confirmation';
  static const newPassword = '/newPassword';
  static const validationCode = '/validationCode';
  static const home = '/home';
  static const collection = '/collection';
  static const item = '/item';
  static const user = '/user';
  static const bars = '/bars';
  static const changePassword = '/changePassword';
  static const cam = '/cam';
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
    GetPage(
      name: Routes.forgotPassword,
      page: () => const ForgotPasswordPage(),
      binding: ForgotPasswordBinding(),
    ),
    GetPage(
      name: Routes.confirmation,
      page: () => const ConfirmationPage(),
      binding: ConfirmationBinding(),
    ),
    GetPage(
      name: Routes.newPassword,
      page: () => const NewPasswordPage(),
      binding: ForgotPasswordBinding(),
    ),
    GetPage(
        name: Routes.validationCode,
        page: () => const ValidationCodePage(),
        binding: ForgotPasswordBinding()),
    GetPage(
      name: Routes.home,
      page: () => const HomePage(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: Routes.item,
      page: () => const ItemPage(),
      binding: ItemBinding(),
    ),
    GetPage(
      name: Routes.user,
      page: () => const UserPage(),
      binding: UserBinding(),
    ),
    GetPage(
      name: Routes.bars,
      page: () => const BarsPage(),
      binding: BarsBinding(),
    ),
    GetPage(
      name: Routes.collection,
      page: () => const CollectionPage(),
      binding: CollectionBinding(),
    ),
    GetPage(
      name: Routes.changePassword,
      page: () => const ChangePasswordPage(),
      binding: UserBinding(),
    ),
    GetPage(
      name: Routes.cam,
      page: () => const CamPage(),
    ),
  ];
}

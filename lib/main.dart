import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:item_expo/app_config.dart';
import 'package:item_expo/routes/app_routes.dart';
import 'package:item_expo/services/api_service.dart';
import 'package:item_expo/services/storage_service.dart';
import 'package:item_expo_theme_package/item_expo_theme.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

void initializeMain(AppConfig appConfig) async {
  WidgetsFlutterBinding.ensureInitialized();

  // await Firebase.initializeApp();

  // if (!kDebugMode) {
  //   await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(false);
  // } else {
  //   FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;
  // }

  await SharedPreferences.getInstance();

  Get.put(Logger(printer: SimplePrinter()), permanent: true);
  Get.put(StorageService(), permanent: true);
  ApiService api = Get.put(ApiService(), permanent: true);

  await api.dio.post('/version').then((value) => null).catchError((e) {
    api.offlineMode = true;
  });

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  final StorageService storageService = Get.find();

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Item Expo',
      theme: ItemExpoTheme.lightTheme,
      darkTheme: ItemExpoTheme.darkTheme,
      themeMode: ThemeMode.system,
      initialRoute: storageService.isLogged() ? Routes.bars : Routes.login,
      getPages: AppPages.pages,
      debugShowCheckedModeBanner: false,
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('pt', 'BR'),
      ],
    );
  }
}

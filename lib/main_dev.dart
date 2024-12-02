import 'package:item_expo/app_config.dart';
import 'package:item_expo/main.dart';

void main() {
  initializeMain(
    AppConfig(
      appName: 'Item Expo [Dev]',
      flavor: Flavor.DEVELOPMENT,
    ),
  );
}

import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:item_expo/module/login/models/user_model.dart';
import 'package:item_expo/module/login/repositories/user_repository.dart';
import 'package:item_expo/services/api_service.dart';
import 'package:item_expo/utils/errors.dart';

class ProfileService extends GetxService {
  final UserRepository userRepository = UserRepository();
  final Logger _logger = Get.find();
  late final ApiService apiService = Get.find();
  RxBool offlineMode = false.obs;
  RxBool waiting = false.obs;

  late final Rx<UserModel?> _user = Rx<UserModel?>(null);
  UserModel? get user => _user.value;

  @override
  onInit() {
    _user.value = userRepository.getUser();
    _logger.d('ProfileService iniciado');
    offlineMode.value = apiService.offlineMode;
    super.onInit();
  }

  void resetOfflineMode() async {
    if (waiting.value) {
      return;
    }

    waiting.value = true;

    await apiService.dio.post('/version').then((value) {
      apiService.offlineMode = false;
    }).catchError((e) {
      apiService.offlineMode = true;
    });
    offlineMode.value = apiService.offlineMode;
    waiting.value = false;
  }

  void logout() {
    try {
      userRepository.logout();
      Get.delete<ProfileService>(force: true);
    } catch (e, stackTrace) {
      _logger.e('Erro na função logout', error: e, stackTrace: stackTrace);
      handleError(e, marginBottom: 80);
    }
  }

  void resetProfile() {
    _user.value = userRepository.getUser();
  }
}
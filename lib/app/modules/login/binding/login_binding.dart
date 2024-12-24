import 'package:get/get.dart';
import 'package:task/app/data/repositories/auth_repository.dart';
import 'package:task/app/modules/login/controllers/login_controller.dart';

class LoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => LoginController(
          authRepository: Get.find<IAuthRepository>(),
        ));
  }
}

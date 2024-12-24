import 'package:get/get.dart';
import 'package:task/app/modules/member/profile/controller/member_profiler_controller.dart';

class MemberProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => MemberProfileController(
          userRepository: Get.find(),
          authRepository: Get.find(),
        ));
  }
}

import 'package:get/get.dart';
import 'package:task/app/modules/admin/member/controllers/admin_member_controller.dart';

class AdminMemberBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AdminMemberController>(
        () => AdminMemberController(userRepository: Get.find()));
  }
}

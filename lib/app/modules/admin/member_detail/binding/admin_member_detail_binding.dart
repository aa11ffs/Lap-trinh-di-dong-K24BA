import 'package:get/get.dart';
import 'package:task/app/modules/admin/member_detail/controllers/admin_member_detail_controller.dart';

class AdminMemberDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AdminMemberDetailController>(
        () => AdminMemberDetailController(userRepository: Get.find()));
  }
}

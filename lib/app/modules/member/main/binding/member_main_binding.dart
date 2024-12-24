import 'package:get/get.dart';
import 'package:task/app/modules/member/main/controllers/member_main_controller.dart';

class MemberMainBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => MemberMainController());
  }
}

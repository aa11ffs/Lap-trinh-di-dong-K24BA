import 'package:get/get.dart';
import 'package:task/app/modules/member/summary/controllers/member_summary_controller.dart';

class MemberSummaryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => MemberSummaryController(taskRepository: Get.find()));
  }
}

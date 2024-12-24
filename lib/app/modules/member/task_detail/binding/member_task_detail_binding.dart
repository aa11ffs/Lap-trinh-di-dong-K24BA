import 'package:get/get.dart';
import 'package:task/app/modules/member/task_detail/controllers/member_task_detail_controller.dart';

class MemberTaskDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => MemberTaskDetailController(
          userRepository: Get.find(),
          taskRepository: Get.find(),
        ));
  }
}

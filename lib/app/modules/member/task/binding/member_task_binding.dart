import 'package:get/get.dart';
import 'package:task/app/modules/member/task/controllers/member_task_controller.dart';

class MemberTaskBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => MemberTaskController(
        taskRepository: Get.find(), userRepository: Get.find()));
  }
}

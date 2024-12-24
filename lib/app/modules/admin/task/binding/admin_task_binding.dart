import 'package:get/get.dart';
import 'package:task/app/modules/admin/task/controllers/admin_task_controller.dart';

class AdminTaskBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AdminTaskController(
        taskRepository: Get.find(), userRepository: Get.find()));
  }
}

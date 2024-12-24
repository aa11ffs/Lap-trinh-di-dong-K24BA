import 'package:get/get.dart';
import 'package:task/app/modules/admin/task_detail/controllers/admin_task_detail_controller.dart';

class AdminTaskDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AdminTaskDetailController(
          userRepository: Get.find(),
          taskRepository: Get.find(),
        ));
  }
}

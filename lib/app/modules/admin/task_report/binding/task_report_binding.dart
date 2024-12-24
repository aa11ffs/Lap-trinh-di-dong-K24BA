import 'package:get/get.dart';
import 'package:task/app/modules/admin/task_report/controller/task_report_controller.dart';

class TaskReportBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => TaskReportController(
          taskRepository: Get.find(),
          userRepository: Get.find(),
          geminiService: Get.find(),
        ));
  }
}

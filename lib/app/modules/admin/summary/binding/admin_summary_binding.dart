import 'package:get/get.dart';
import 'package:task/app/modules/admin/summary/controllers/admin_summary_controller.dart';

class AdminSummaryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AdminSummaryController(taskRepository: Get.find()));
  }
}

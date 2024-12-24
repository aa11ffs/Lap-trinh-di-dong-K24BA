import 'package:get/get.dart';
import 'package:task/app/data/services/local/shared_pref_service.dart';
import 'package:task/app/modules/admin/member/controllers/admin_member_controller.dart';
import 'package:task/app/modules/admin/task/controllers/admin_task_controller.dart';
import 'package:task/app/modules/admin/task_report/controller/task_report_controller.dart';
import 'package:task/app/routes/app_routes.dart';

class AdminMainController extends GetxController {
  var currentIndex = 0.obs;

  void changeTab(int index) {
    currentIndex.value = index;
    if (index == 0) {
      Get.toNamed(AppRoutes.ADMIN_TASK);
    } else if (index == 1) {
      Get.toNamed(AppRoutes.ADMIN_MEMBER);
    } else if (index == 2) {
      Get.toNamed(AppRoutes.ADMIN_TASK_REPORT);
    }
  }

  void logOut() async {
    await SharedPrefService.clearAll();
    Get.offAndToNamed(AppRoutes.LOGIN);
  }
}

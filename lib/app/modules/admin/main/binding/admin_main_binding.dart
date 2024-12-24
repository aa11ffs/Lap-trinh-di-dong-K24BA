import 'package:get/get.dart';
import 'package:task/app/modules/admin/main/controllers/admin_main_controller.dart';

class AdminMainBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AdminMainController());
  }
}

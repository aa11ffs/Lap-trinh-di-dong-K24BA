import 'package:get/get.dart';
import 'package:task/app/data/models/user_model.dart';
import 'package:task/app/data/services/local/shared_pref_service.dart';
import 'package:task/app/data/services/remote/user_service.dart';
import 'package:task/app/routes/app_routes.dart';

class MemberMainController extends GetxController {
  var currentIndex = 0.obs;
  final _userService = UserService();
  final user = UserModel().obs;
  @override
  void onInit() async {
    await _getUser();
    print('fetchUserWithTasks${user.value.tasks}');
    super.onInit();
  }

  Future<void> _getUser() async {
    final userId = await SharedPrefService.getUserId();
    user.value = await _userService.fetchUserWithTasks(userId!) ?? UserModel();
  }

  void changeTab(int index) {
    currentIndex.value = index;
    if (index == 0) {
      Get.toNamed(AppRoutes.ADMIN_TASK);
    } else if (index == 1) {
      Get.toNamed(AppRoutes.ADMIN_MEMBER);
    }
  }

  void logOut() async {
    await SharedPrefService.clearAll();
    Get.offAllNamed(AppRoutes.LOGIN);
  }
}

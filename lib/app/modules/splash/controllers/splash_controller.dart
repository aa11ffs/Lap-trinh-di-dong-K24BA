import 'package:get/get.dart';
import 'package:task/app/data/services/local/shared_pref_service.dart';
import 'package:task/app/routes/app_routes.dart';

class SplashController extends GetxController {
  final String logoTag = 'logo';
  @override
  void onInit() async {
    super.onInit();
    await _navigateBasedOnAuthStatus();
  }

  Future<void> _navigateBasedOnAuthStatus() async {
    try {
      await Future.delayed(const Duration(seconds: 2));

      final userId = await SharedPrefService.getUserId();
      final userRole = await SharedPrefService.getRole();

      if (userId != null) {
        _navigateToRoleBasedScreen(userRole);
      } else {
        Get.offAllNamed(AppRoutes.LOGIN, arguments: logoTag);
      }
    } catch (e) {
      print('Error in SplashController: $e');
      Get.offAllNamed(AppRoutes.LOGIN);
    }
  }

  void _navigateToRoleBasedScreen(String? role) {
    switch (role) {
      case 'member':
        Get.offAllNamed(AppRoutes.MEMBER_MAIN);
        break;
      case 'admin':
        Get.offAllNamed(AppRoutes.ADMIN_MAIN);
        break;
      default:
        Get.offAllNamed(AppRoutes.LOGIN);
    }
  }
}

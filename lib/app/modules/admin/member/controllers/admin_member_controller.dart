import 'package:get/get.dart';
import 'package:task/app/data/models/user_model.dart';
import 'package:task/app/data/repositories/user_repository.dart';
import 'package:task/app/routes/app_routes.dart';

class AdminMemberController extends GetxController {
  final IUserRepository _userRepository;
  AdminMemberController({required IUserRepository userRepository})
      : _userRepository = userRepository;

  final members = <UserModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    innitialData();
  }

  Future<void> innitialData() async {
    members.value = await _userRepository.getAll();
  }

  Future<void> goToMemberDetail(UserModel user) async {
    await Get.toNamed(AppRoutes.ADMIN_MEMBER_DETAIL, arguments: user)!.then(
      (value) {
        if (value != null) {
          innitialData();
        }
      },
    );
  }

  Future<void> goToCreateMember() async {
    await Get.toNamed(AppRoutes.ADMIN_MEMBER_DETAIL)!.then((value) {
      if (value != null) {
        innitialData();
      }
    });
  }
}

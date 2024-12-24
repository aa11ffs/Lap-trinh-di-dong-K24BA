import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:task/app/data/models/user_model.dart';
import 'package:task/app/data/repositories/auth_repository.dart';
import 'package:task/app/data/repositories/user_repository.dart';
import 'package:task/app/data/services/local/shared_pref_service.dart';
import 'package:task/app/routes/app_routes.dart';

class MemberProfileController extends GetxController {
  final IUserRepository _userRepository;
  final IAuthRepository _authRepository;
  MemberProfileController(
      {required IUserRepository userRepository,
      required IAuthRepository authRepository})
      : _userRepository = userRepository,
        _authRepository = authRepository;
  final memberProfileFormKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final newPasswordController = TextEditingController();
  final oldPasswordController = TextEditingController();
  final member = UserModel().obs;

  @override
  void onInit() {
    super.onInit();
    _getMember();
  }

  Future<void> _getMember() async {
    final userId = await SharedPrefService.getUserId();
    member.value = (await _userRepository.getById(userId!))!;
    nameController.text = member.value.name ?? '';
    emailController.text = member.value.email ?? '';
    phoneController.text = member.value.phoneNumber ?? '';
  }

  Future<void> updateMember() async {
    if (memberProfileFormKey.currentState!.validate()) {
      EasyLoading.show(status: 'Updating...');
      final userId = await SharedPrefService.getUserId();
      final user = await _userRepository.getById(userId!);
      final updatedUser = user!.copyWith(
        name: nameController.text,
        email: emailController.text,
        phoneNumber: phoneController.text,
      );
      await _userRepository.update(updatedUser);
      EasyLoading.showSuccess('Update success');
    }
  }

  void goToChangePassword() {
    Get.toNamed(AppRoutes.MEMBER_CHANGE_PASSWORD);
  }

  Future<void> changePassword() async {
    if (memberProfileFormKey.currentState!.validate()) {
      EasyLoading.show(status: 'Updating...');
      final userId = await SharedPrefService.getUserId();

      final result = await _authRepository.changePassword(
          userId!, oldPasswordController.text, newPasswordController.text);
      if (result == 'Password changed') {
        EasyLoading.dismiss();
        Get.back();
        newPasswordController.clear();
        oldPasswordController.clear();
        EasyLoading.showSuccess(result);
      } else {
        EasyLoading.showError(result);
      }
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    newPasswordController.dispose();
    oldPasswordController.dispose();
    super.dispose();
  }
}

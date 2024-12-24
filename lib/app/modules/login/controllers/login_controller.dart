import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:task/app/data/repositories/auth_repository.dart';
import 'package:task/app/data/services/local/shared_pref_service.dart';
import 'package:task/app/routes/app_routes.dart';

class LoginController extends GetxController {
  final IAuthRepository _authRepository;

  LoginController({required IAuthRepository authRepository})
      : _authRepository = authRepository;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  Future<void> login() async {
    if (emailController.text.isNotEmpty && passwordController.text.isNotEmpty) {
      EasyLoading.show(status: 'Logging in...');
      try {
        final result = await _authRepository.login(
            emailController.text, passwordController.text);
        if (result != null) {
          await SharedPrefService.saveUserId(result.id);
          await SharedPrefService.saveRole(result.role ?? '');

          switch (result.role) {
            case 'admin':
              Get.offAllNamed(AppRoutes.ADMIN_MAIN);
              break;
            case 'member':
              Get.offAllNamed(AppRoutes.MEMBER_MAIN);
              break;
            default:
              EasyLoading.showError('Unknown role');
          }
        } else {
          EasyLoading.showError('Email or password is incorrect');
        }
      } catch (e) {
        EasyLoading.showError('An error occurred: $e');
      } finally {
        EasyLoading.dismiss();
      }
    }
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task/app/modules/member/profile/controller/member_profiler_controller.dart';
import 'package:task/core/constants/app_style.dart';
import 'package:task/core/utils/validator.dart';
import 'package:task/core/widgets/custom_appbar.dart';
import 'package:task/core/widgets/custom_background.dart';
import 'package:task/core/widgets/custom_button.dart';
import 'package:task/core/widgets/custom_card.dart';
import 'package:task/core/widgets/custom_text_field.dart';

class MemberChangePasswordScreen extends StatelessWidget {
  MemberChangePasswordScreen({super.key});
  final MemberProfileController memberProfileController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppbar(
        title: 'Change password',
      ),
      body: CustomBackground(
        child: SingleChildScrollView(
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 20.0, vertical: 24.0),
            child: CustomCard(
              child: Form(
                child: Column(
                  children: [
                    _buildTextField('Old password',
                        memberProfileController.oldPasswordController,
                        validator: (value) =>
                            Validator.validatePassword(value!)),
                    const SizedBox(height: 24.0),
                    _buildTextField('New password',
                        memberProfileController.newPasswordController,
                        validator: (value) =>
                            Validator.validatePassword(value!)),
                    const SizedBox(height: 24.0),
                    const SizedBox(height: 24.0),
                    CustomButton(
                        label: 'Submit',
                        onPressed: memberProfileController.changePassword),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller,
      {bool isPassword = false, String? Function(String?)? validator}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: AppStyle.medium14),
        const SizedBox(height: 10),
        CustomTextField(
          controller: controller,
          isPassword: isPassword,
          validator: validator,
        ),
      ],
    );
  }
}

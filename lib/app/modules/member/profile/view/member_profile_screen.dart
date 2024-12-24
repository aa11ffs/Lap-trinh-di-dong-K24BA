import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task/app/modules/member/profile/controller/member_profiler_controller.dart';
import 'package:task/core/constants/app_color.dart';
import 'package:task/core/constants/app_style.dart';
import 'package:task/core/extensions/build_context_extension.dart';
import 'package:task/core/utils/validator.dart';
import 'package:task/core/widgets/custom_background.dart';
import 'package:task/core/widgets/custom_button.dart';
import 'package:task/core/widgets/custom_card.dart';
import 'package:task/core/widgets/custom_text_field.dart';
import 'package:task/gen/assets.gen.dart';

class MemberProfileScreen extends StatelessWidget {
  MemberProfileScreen({super.key});

  final MemberProfileController memberController = Get.find();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.unFocus,
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: CustomBackground(
          child: SingleChildScrollView(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 24.0),
              child: CustomCard(
                child: Form(
                  key: memberController.memberProfileFormKey,
                  child: Column(
                    children: [
                      _buildAvatar(),
                      _buildTextField('Name', memberController.nameController,
                          validator: (value) =>
                              Validator.validateEmpty(value!)),
                      const SizedBox(height: 24.0),
                      _buildTextField(
                          'Phone number', memberController.phoneController,
                          validator: (value) =>
                              Validator.validateEmpty(value!)),
                      const SizedBox(height: 24.0),
                      _buildTextField('Email', memberController.emailController,
                          readOnly: true,
                          validator: (value) =>
                              Validator.validateEmail(value!)),
                      const SizedBox(height: 10),
                      InkWell(
                        onTap: () {
                          memberController.goToChangePassword();
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text('Change Password!',
                                style: AppStyle.medium14.copyWith(
                                    color: Colors.blue,
                                    decoration: TextDecoration.underline,
                                    decorationThickness: 2,
                                    decorationColor: Colors.blue)),
                            const Icon(Icons.arrow_forward_sharp,
                                size: 14.0, color: Colors.blue)
                          ],
                        ),
                      ),
                      const SizedBox(height: 24.0),
                      CustomButton(
                          label: 'Update',
                          onPressed: () {
                            memberController.updateMember();
                          }),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller,
      {bool isPassword = false,
      String? Function(String?)? validator,
      bool readOnly = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: AppStyle.medium14),
        const SizedBox(height: 10),
        CustomTextField(
          controller: controller,
          isPassword: isPassword,
          validator: validator,
          readOnly: readOnly,
        ),
      ],
    );
  }

  Widget _buildAvatar() {
    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
        color: AppColor.kFFFFFF,
        border: Border.all(color: AppColor.k6E7591),
        borderRadius: BorderRadius.circular(50),
        image: DecorationImage(
          image: memberController.member.value.avatarUrl == null
              ? AssetImage(Assets.images.avatarNull.path)
              : AssetImage(memberController.member.value.avatarUrl!)
                  as ImageProvider,
        ),
      ),
    );
  }
}

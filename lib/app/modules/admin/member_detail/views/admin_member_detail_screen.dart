import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task/app/modules/admin/member_detail/controllers/admin_member_detail_controller.dart';
import 'package:task/core/constants/app_style.dart';
import 'package:task/core/extensions/build_context_extension.dart';
import 'package:task/core/utils/validator.dart';
import 'package:task/core/widgets/custom_appbar.dart';
import 'package:task/core/widgets/custom_background.dart';
import 'package:task/core/widgets/custom_button.dart';
import 'package:task/core/widgets/custom_card.dart';
import 'package:task/core/widgets/custom_dialog.dart';
import 'package:task/core/widgets/custom_text_field.dart';

class AdminMemberDetailScreen extends StatefulWidget {
  const AdminMemberDetailScreen({super.key});

  @override
  State<AdminMemberDetailScreen> createState() =>
      _AdminMemberDetailScreenState();
}

class _AdminMemberDetailScreenState extends State<AdminMemberDetailScreen> {
  final controller = Get.find<AdminMemberDetailController>();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.unFocus,
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(kToolbarHeight),
          child: CustomAppbar(
            title: controller.userModel.value.name ?? 'Add new member',
          ),
        ),
        body: CustomBackground(
          child: SingleChildScrollView(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 24.0),
              child: CustomCard(
                child: Obx(
                  () => Form(
                    key: controller.adminMemberDetailFormKey,
                    child: Column(
                      children: [
                        _buildTextField(
                            key: const Key('memberNameField'),
                            'Name',
                            controller.nameController,
                            validator: (value) =>
                                Validator.validateEmpty(value!)),
                        _buildTextField(
                            key: const Key('memberPhoneField'),
                            'Phone number',
                            controller.phoneController,
                            validator: (value) =>
                                Validator.validateEmpty(value!)),
                        _buildTextField(
                            key: const Key('memberEmailField'),
                            'Email',
                            controller.emailController,
                            validator: (value) =>
                                Validator.validateEmail(value!)),
                        _buildTextField(
                            key: const Key('memberPasswordField'),
                            'Password',
                            controller.passwordController,
                            isPassword: true,
                            validator: (value) =>
                                Validator.validatePassword(value!)),
                        const SizedBox(height: 24),
                        if (!controller.isNewMember.value)
                          Row(
                            children: [
                              Expanded(
                                child: CustomButton(
                                  key: const Key('deleteMemberButton'),
                                  label: 'Delete',
                                  backgroundColor: Colors.red,
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      useRootNavigator: true,
                                      builder: (context) {
                                        return CustomDialog(
                                            title: 'Delete',
                                            content:
                                                'Are you sure you want to delete?',
                                            onConfirm: () {
                                              controller.deleteMember(controller
                                                  .userModel.value.id);
                                            });
                                      },
                                    );
                                  },
                                ),
                              ),
                              const SizedBox(width: 10.0),
                              Expanded(
                                child: CustomButton(
                                  key: const Key('updateMemberButton'),
                                  label: 'Update',
                                  onPressed: () {
                                    controller.updateMember();
                                  },
                                ),
                              ),
                            ],
                          )
                        else
                          CustomButton(
                              key: const Key('createMemberButton'),
                              label: 'Add new member',
                              onPressed: () => controller.createMember()),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(
    String label,
    TextEditingController controller, {
    Key? key,
    bool isPassword = false,
    String? Function(String?)? validator,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: AppStyle.medium14),
        const SizedBox(height: 10),
        CustomTextField(
          key: key,
          controller: controller,
          isPassword: isPassword,
          validator: validator,
        ),
        const SizedBox(height: 24.0),
      ],
    );
  }
}

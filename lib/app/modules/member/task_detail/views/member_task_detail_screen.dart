import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task/app/modules/member/task_detail/controllers/member_task_detail_controller.dart';
import 'package:task/core/constants/app_color.dart';
import 'package:task/core/constants/app_style.dart';
import 'package:task/core/extensions/build_context_extension.dart';
import 'package:task/core/utils/validator.dart';
import 'package:task/core/widgets/custom_appbar.dart';
import 'package:task/core/widgets/custom_background.dart';
import 'package:task/core/widgets/custom_button.dart';
import 'package:task/core/widgets/custom_card.dart';
import 'package:task/core/widgets/custom_dropdown_button.dart';

class MemberTaskDetailScreen extends StatelessWidget {
  MemberTaskDetailScreen({super.key});
  final MemberTaskDetailController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    print('test${controller.task.value.title}');
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: Obx(() {
          return CustomAppbar(
            title: controller.task.value.title ?? 'Add New Task',
          );
        }),
      ),
      body: CustomBackground(
        child: GestureDetector(
          onTap: () => context.unFocus,
          child: Form(
            key: controller.memberTaskDetailFormKey,
            child: SingleChildScrollView(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 24.0),
              child: CustomCard(
                child: Obx(() {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildTitleField(),
                      const SizedBox(height: 12.0),
                      const Divider(color: AppColor.kDCE1EF),
                      const SizedBox(height: 20.0),
                      _buildTaskDescription(),
                      const SizedBox(height: 20.0),
                      _buildDropdown(
                        label: 'Status',
                        value: controller.statusSelected.value.isEmpty
                            ? null
                            : controller.statusSelected.value,
                        items: controller.status
                            .map((status) => DropdownMenuItem<String>(
                                  value: status.label,
                                  child: Text(status.label),
                                )),
                        onChanged: (value) {
                          controller.selectStatus(value!);
                        },
                        hint: 'Choose status',
                      ),
                      const SizedBox(height: 20.0),
                      _buildDeadlineField(context),
                      const SizedBox(height: 24.0),
                      CustomButton(
                          label: 'Submit',
                          onPressed: () {
                            controller.updateTask();
                          }),
                    ],
                  );
                }),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTitleField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Title', style: AppStyle.medium14),
        const SizedBox(height: 10.0),
        Text(controller.task.value.title ?? '', style: AppStyle.medium26),
      ],
    );
  }

  Widget _buildTaskDescription() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Task Description', style: AppStyle.medium14),
        const SizedBox(height: 10.0),
        Text(controller.task.value.description ?? '',
            style: AppStyle.regular14),
      ],
    );
  }

  Widget _buildDropdown({
    required String label,
    required String? value,
    required Iterable<DropdownMenuItem<String>> items,
    required ValueChanged<String?> onChanged,
    required String hint,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: AppStyle.medium14),
        const SizedBox(height: 10.0),
        CustomDropdownButton(
          validator: (value) => Validator.validateEmpty(value!),
          selectedValue: value,
          items: [
            DropdownMenuItem<String>(
              value: null,
              child:
                  Text(hint, style: const TextStyle(color: AppColor.kDCE1EF)),
            ),
            ...items,
          ],
          onChanged: onChanged,
        ),
      ],
    );
  }

  Widget _buildDeadlineField(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Deadline: ', style: AppStyle.medium14),
        Text(controller.task.value.dueDate ?? '', style: AppStyle.regular14),
      ],
    );
  }
}

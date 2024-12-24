import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task/app/modules/admin/task_detail/controllers/admin_task_detail_controller.dart';
import 'package:task/core/constants/app_color.dart';
import 'package:task/core/constants/app_style.dart';
import 'package:task/core/extensions/build_context_extension.dart';
import 'package:task/core/utils/validator.dart';
import 'package:task/core/widgets/custom_appbar.dart';
import 'package:task/core/widgets/custom_background.dart';
import 'package:task/core/widgets/custom_button.dart';
import 'package:task/core/widgets/custom_card.dart';
import 'package:task/core/widgets/custom_dialog.dart';
import 'package:task/core/widgets/custom_dropdown_button.dart';
import 'package:task/core/widgets/custom_text_field.dart';

class AdminTaskDetailScreen extends StatelessWidget {
  AdminTaskDetailScreen({super.key});
  final AdminTaskDetailController controller = Get.find();

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
            key: controller.adminTaskDetailFormKey,
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
                      _buildDropdownSection(),
                      const SizedBox(height: 20.0),
                      _buildDeadlineField(context),
                      const SizedBox(height: 24.0),
                      if (!controller.isNewTask.value)
                        Row(
                          children: [
                            Expanded(
                              child: CustomButton(
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
                                        onConfirm: () =>
                                            controller.deleteTask(),
                                      );
                                    },
                                  );
                                },
                              ),
                            ),
                            const SizedBox(width: 10.0),
                            Expanded(
                              child: CustomButton(
                                  label: 'Update',
                                  onPressed: () {
                                    controller.updateTask();
                                  }),
                            ),
                          ],
                        )
                      else
                        CustomButton(
                          key: const Key('createTaskButton'),
                          label: 'Create',
                          onPressed: () {
                            controller.createTask();
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
        CustomTextField(
          key: const Key('taskNameField'),
          controller: controller.titleController,
          validator: (value) => Validator.validateEmpty(value!),
        ),
      ],
    );
  }

  Widget _buildTaskDescription() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Task Description', style: AppStyle.medium14),
        const SizedBox(height: 10.0),
        CustomTextField(
          key: const Key('taskDescriptionField'),
          controller: controller.descriptionController,
          maxLines: 5,
          validator: (value) => Validator.validateEmpty(value!),
        ),
      ],
    );
  }

  Widget _buildDropdownSection() {
    return Row(
      children: [
        Expanded(
          flex: 3,
          child: Obx(() {
            if (controller.users.isEmpty) {
              return const CircularProgressIndicator();
            }
            return _buildDropdown(
              label: 'Assigned to',
              key: const Key('taskAssigneeField'),
              value: controller.assignToSelected.value.isEmpty
                  ? null
                  : controller.assignToSelected.value,
              items: controller.users.map((user) => DropdownMenuItem<String>(
                    value: user.id,
                    child: Text(
                      user.name ?? '--:--',
                    ),
                  )),
              onChanged: (value) {
                controller.selectAssignTo(value!);
              },
              hint: 'Choose user',
            );
          }),
        ),
        const SizedBox(width: 20.0),
        Expanded(
          flex: 3,
          child: Obx(() {
            if (controller.status.isEmpty) {
              return const CircularProgressIndicator();
            }
            return _buildDropdown(
              label: 'Status',
              key: const Key('taskStatusField'),
              value: controller.statusSelected.value.isEmpty
                  ? null
                  : controller.statusSelected.value,
              items: controller.status.map((status) => DropdownMenuItem<String>(
                    value: status.label,
                    child: Text(status.label),
                  )),
              onChanged: (value) {
                controller.selectStatus(value!);
              },
              hint: 'Choose status',
            );
          }),
        ),
      ],
    );
  }

  Widget _buildDropdown(
      {required String label,
      required String? value,
      required Iterable<DropdownMenuItem<String>> items,
      required ValueChanged<String?> onChanged,
      required String hint,
      required Key key}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: AppStyle.medium14),
        const SizedBox(height: 10.0),
        CustomDropdownButton(
          key: key,
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Deadline', style: AppStyle.medium14),
        const SizedBox(height: 10.0),
        CustomTextField(
          key: const Key('deadlineField'),
          readOnly: true,
          prefixIcon: const Icon(Icons.calendar_today),
          controller: controller.dueDateController,
          onTap: () => controller.dateSellect(context),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:task/app/data/models/status_model.dart';
import 'package:task/app/data/models/task_model.dart';
import 'package:task/app/data/models/user_model.dart';
import 'package:task/app/data/repositories/task_repository.dart';
import 'package:task/app/data/repositories/user_repository.dart';
import 'package:task/core/utils/string_format.dart';

class MemberTaskDetailController extends GetxController {
  final IUserRepository _userRepository;
  final ITaskRepository _taskRepository;

  MemberTaskDetailController({
    required IUserRepository userRepository,
    required ITaskRepository taskRepository,
  })  : _userRepository = userRepository,
        _taskRepository = taskRepository;

  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final dueDateController = TextEditingController();
  final memberTaskDetailFormKey = GlobalKey<FormState>();
  final task = TaskModel().obs;
  final users = <UserModel>[].obs;
  final status = <StatusModel>[].obs;

  final assignToSelected = ''.obs;
  final statusSelected = ''.obs;
  final isNewTask = false.obs;
  @override
  Future<void> onReady() async {
    super.onReady();
    await _getUsers();
    status.value = StatusModel.statuses;
    if (Get.arguments != null) {
      task.value = Get.arguments;
      titleController.text = task.value.title ?? '';
      descriptionController.text = task.value.description ?? '';
      assignToSelected.value = task.value.assignTo ?? '';
      dueDateController.text = task.value.dueDate ?? '';
      statusSelected.value = task.value.status ?? '';
    } else {
      isNewTask.value = true;
    }
  }

  Future<void> _getUsers() async {
    users.value = await _userRepository.getAll();
  }

  void selectAssignTo(String value) {
    assignToSelected.value = value;
  }

  void selectStatus(String value) {
    statusSelected.value = value;
  }

  void dateSellect(BuildContext context) {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2025),
    ).then((value) {
      if (value != null) {
        dueDateController.text = StringFormat.formatDate(value);
      }
    });
  }

  Future<void> createTask() async {
    if (memberTaskDetailFormKey.currentState!.validate()) {
      final taskCreate = TaskModel(
        title: titleController.text,
        description: descriptionController.text,
        assignTo: assignToSelected.value,
        dueDate: dueDateController.text,
        status: statusSelected.value,
      );
      EasyLoading.show(status: 'Creating...');
      final result = await _taskRepository.create(taskCreate);
      if (result != null) {
        EasyLoading.showSuccess('Created');
        Get.back(result: true);
      } else {
        EasyLoading.showError('Failed to create task');
      }
    }
  }

  Future<void> updateTask() async {
    if (memberTaskDetailFormKey.currentState!.validate()) {
      final taskUpdate = task.value.copyWith(
        status: statusSelected.value,
      );
      EasyLoading.show(status: 'Updating...');
      final result = await _taskRepository.update(taskUpdate);
      if (result != null) {
        EasyLoading.showSuccess('Updated');
        Get.back(result: true);
      } else {
        EasyLoading.showError('Failed to update task');
      }
    }
  }

  Future<void> deleteTask() async {
    EasyLoading.show(status: 'Deleting...');
    final result = await _taskRepository.delete(task.value.id);
    if (result) {
      EasyLoading.showSuccess('Deleted');
      Get.back(result: true);
    } else {
      EasyLoading.showError('Failed to delete task');
    }
  }
}

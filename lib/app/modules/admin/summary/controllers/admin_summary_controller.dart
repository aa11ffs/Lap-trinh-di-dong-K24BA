import 'package:get/get.dart';
import 'package:task/app/data/models/task_model.dart';
import 'package:task/app/data/repositories/task_repository.dart';
import 'package:task/app/routes/app_routes.dart';

class AdminSummaryController extends GetxController {
  final ITaskRepository _taskRepository;
  final taskByStatus = <TaskModel>[].obs;
  final status = ''.obs;

  AdminSummaryController({required ITaskRepository taskRepository})
      : _taskRepository = taskRepository;
  @override
  void onInit() {
    super.onInit();
    status.value = Get.arguments;
    getTaskByStatus(status.value);
  }

  void getTaskByStatus(String status) async {
    taskByStatus.value = await _taskRepository.getTasksByStatus(status);
  }

  Future<void> goToTaskDetail(TaskModel task) async {
    await Get.toNamed(AppRoutes.ADMIN_TASK_DETAIL, arguments: task)!.then(
      (value) {
        if (value == true) {
          onInit();
        }
      },
    );
  }
}

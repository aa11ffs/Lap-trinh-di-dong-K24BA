import 'package:get/get.dart';
import 'package:task/app/data/models/status_model.dart';
import 'package:task/app/data/models/task_model.dart';
import 'package:task/app/data/models/user_model.dart';
import 'package:task/app/data/repositories/task_repository.dart';
import 'package:task/app/data/repositories/user_repository.dart';
import 'package:task/app/routes/app_routes.dart';

class AdminTaskController extends GetxController {
  final ITaskRepository _taskRepository;
  final IUserRepository _userRepository;

  AdminTaskController({
    required ITaskRepository taskRepository,
    required IUserRepository userRepository,
  })  : _taskRepository = taskRepository,
        _userRepository = userRepository;

  final tasks = <TaskModel>[].obs;
  final status = <StatusModel>[].obs;
  final members = <UserModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    initialData();
  }

  void initialData() {
    status.value = StatusModel.statuses;
    _getTasks();
    _getMembers();
  }

  Future<void> _getTasks() async {
    tasks.value = await _taskRepository.getAll();
  }

  Future<void> _getMembers() async {
    members.value = await _userRepository.getAll();
  }

  Future<void> _goToPage(String route, {dynamic arguments}) async {
    final result = await Get.toNamed(route, arguments: arguments);
    if (result == true) {
      onInit();
    }
  }

  Future<void> goToSummary(String status) async {
    await _goToPage(AppRoutes.ADMIN_SUMMARY_TASK_DETAIL, arguments: status);
  }

  Future<void> goToTaskDetail(TaskModel? task) async {
    if (task == null) {
      await _goToPage(AppRoutes.ADMIN_TASK_DETAIL, arguments: null);
    } else {
      await _goToPage(AppRoutes.ADMIN_TASK_DETAIL, arguments: task);
    }
  }

  String getNameMemberByTask(String assignTo) {
    final member = members.firstWhere((member) => member.id == assignTo);
    return member.name ?? '--:--';
  }

  int statusCount(String status) {
    return tasks.where((task) => task.status == status).length;
  }
}

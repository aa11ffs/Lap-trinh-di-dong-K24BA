import 'package:get/get.dart';
import 'package:task/app/data/models/status_model.dart';
import 'package:task/app/data/models/task_model.dart';
import 'package:task/app/data/models/user_model.dart';
import 'package:task/app/data/repositories/task_repository.dart';
import 'package:task/app/data/repositories/user_repository.dart';
import 'package:task/app/data/services/local/shared_pref_service.dart';
import 'package:task/app/routes/app_routes.dart';

class MemberTaskController extends GetxController {
  final ITaskRepository _taskRepository;
  final IUserRepository _userRepository;

  MemberTaskController({
    required ITaskRepository taskRepository,
    required IUserRepository userRepository,
  })  : _taskRepository = taskRepository,
        _userRepository = userRepository;

  final tasks = <TaskModel>[].obs;
  final status = <StatusModel>[].obs;
  final member = UserModel().obs;

  @override
  void onInit() {
    super.onInit();
    initialData();
  }

  void initialData() {
    status.value = StatusModel.statuses;
    _getTasks();
    _getMember();
  }

  Future<void> _getTasks() async {
    final userId = await SharedPrefService.getUserId();
    tasks.value = await _taskRepository.getTasksByUser(userId!);
  }

  Future<void> _getMember() async {
    final userId = await SharedPrefService.getUserId();
    member.value = (await _userRepository.getById(userId!))!;
  }

  Future<void> _goToPage(String route, {dynamic arguments}) async {
    final result = await Get.toNamed(route, arguments: arguments);
    if (result == true) {
      onInit();
    }
  }

  Future<void> goToSummary(String status) async {
    await _goToPage(AppRoutes.MEMBER_SUMMARY_TASK_DETAIL, arguments: status);
  }

  Future<void> goToTaskDetail(TaskModel? task) async {
    if (task == null) {
      await _goToPage(AppRoutes.MEMBER_TASK_DETAIL, arguments: null);
    } else {
      await _goToPage(AppRoutes.MEMBER_TASK_DETAIL, arguments: task);
    }
  }

  int statusCount(String status) {
    return tasks.where((task) => task.status == status).length;
  }
}

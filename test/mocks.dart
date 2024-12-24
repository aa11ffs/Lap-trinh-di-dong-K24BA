// test/mocks.dart
import 'package:mockito/annotations.dart';
import 'package:task/app/data/repositories/auth_repository.dart';
import 'package:task/app/data/repositories/base/base_repository.dart';
import 'package:task/app/data/repositories/task_repository.dart';
import 'package:task/app/data/repositories/user_repository.dart';
import 'package:task/app/data/services/local/shared_pref_service.dart';
import 'package:task/app/data/services/remote/auth_service.dart';
import 'package:task/app/data/services/remote/gemini_service.dart';
import 'package:task/app/data/services/remote/task_service.dart';
import 'package:task/app/data/services/remote/user_service.dart';
import 'package:task/app/modules/admin/main/controllers/admin_main_controller.dart';
import 'package:task/app/modules/admin/member/controllers/admin_member_controller.dart';
import 'package:task/app/modules/admin/member_detail/controllers/admin_member_detail_controller.dart';
import 'package:task/app/modules/login/controllers/login_controller.dart';

@GenerateMocks([
  AuthService,
  TaskService,
  UserService,
  ITaskRepository,
  IAuthRepository,
  IUserRepository,
  GeminiService,
  LoginController,
  AdminMemberController,
  AdminMemberDetailController,
  AdminMainController
])
void main() {}

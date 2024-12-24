import 'package:get/get.dart';
import 'package:task/app/data/repositories/auth_repository.dart';
import 'package:task/app/data/repositories/task_repository.dart';
import 'package:task/app/data/repositories/user_repository.dart';
import 'package:task/app/data/services/remote/auth_service.dart';
import 'package:task/app/data/services/remote/gemini_service.dart';
import 'package:task/app/data/services/remote/task_service.dart';
import 'package:task/app/data/services/remote/user_service.dart';

class InitialBinding extends Bindings {
  @override
  void dependencies() {
    
    Get.put<UserService>(UserService());
    Get.put<TaskService>(TaskService());
    Get.put<AuthService>(AuthService());
    Get.put<GeminiService>(GeminiService());

    
    Get.put<IUserRepository>(UserRepositoryImpl(userService: Get.find()));
    Get.put<ITaskRepository>(TaskRepositoryImpl(taskService: Get.find()));
    Get.put<IAuthRepository>(AuthRepositoryImpl(authService: Get.find()));
  }
}

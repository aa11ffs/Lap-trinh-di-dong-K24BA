import 'package:task/app/data/models/user_model.dart';
import 'package:task/app/data/services/remote/auth_service.dart';

abstract class IAuthRepository {
  Future<UserModel?> login(String email, String password);
  Future<String> changePassword(
      String userId, String oldPassword, String newPassword);
}

class AuthRepositoryImpl implements IAuthRepository {
  final AuthService _authService;

  AuthRepositoryImpl({required AuthService authService})
      : _authService = authService;

  @override
  Future<UserModel?> login(String email, String password) async {
    return await _authService.login(email, password);
  }

  @override
  Future<String> changePassword(
    String userId,
    String oldPassword,
    String newPassword,
  ) async {
    return await _authService.changePassword(
      userId,
      oldPassword,
      newPassword,
    );
  }
}

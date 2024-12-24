import 'package:task/app/data/services/remote/user_service.dart';

import '../models/user_model.dart';
import 'base/base_repository.dart';

abstract class IUserRepository extends IBaseRepository<UserModel> {
  Future<UserModel?> getUserByEmail(String email);
  Future<bool> deleteUserAndTasks(String userId);
}

class UserRepositoryImpl extends BaseRepository<UserModel>
    implements IUserRepository {
  final UserService _userService;

  UserRepositoryImpl({required UserService userService})
      : _userService = userService;

  @override
  Future<UserModel?> create(UserModel model) async {
    try {
      return await _userService.create(model);
    } catch (e) {
      print('Error in UserRepository.create: $e');
      return null;
    }
  }

  @override
  Future<bool> delete(String id) async {
    try {
      await _userService.delete(id);
      return true;
    } catch (e) {
      print('Error in UserRepository.delete: $e');
      return false;
    }
  }

  @override
  Future<List<UserModel>> getAll() async {
    try {
      return await _userService.getAll();
    } catch (e) {
      print('Error in UserRepository.getAll: $e');
      return [];
    }
  }

  @override
  Future<UserModel?> getById(String id) async {
    try {
      return await _userService.getById(id);
    } catch (e) {
      print('Error in UserRepository.getById: $e');
      return null;
    }
  }

  @override
  Future<UserModel?> update(UserModel model) async {
    try {
      return await _userService.update(model);
    } catch (e) {
      print('Error in UserRepository.update: $e');
      return null;
    }
  }

  @override
  Future<UserModel?> getUserByEmail(String email) async {
    try {
      return await _userService.getUserByEmail(email);
    } catch (e) {
      print('Error in UserRepository.getUserByEmail: $e');
      return null;
    }
  }

  @override
  Future<bool> deleteUserAndTasks(String userId) async {
    try {
      await _userService.deleteUserAndTasks(userId);
      return true;
    } catch (e) {
      print('Error in UserRepository.deleteUserAndTasks: $e');
      return false;
    }
  }
}

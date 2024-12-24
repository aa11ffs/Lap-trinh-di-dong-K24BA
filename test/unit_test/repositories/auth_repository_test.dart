import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:task/app/data/models/user_model.dart';
import 'package:task/app/data/repositories/auth_repository.dart';
import '../../mocks.mocks.dart';

void main() {
  late AuthRepositoryImpl authRepository;
  late MockAuthService mockAuthService;

  setUp(() {
    mockAuthService = MockAuthService();
    authRepository = AuthRepositoryImpl(authService: mockAuthService);
  });

  group('AuthRepository', () {
    test('login should return user when credentials are valid', () async {
      const email = 'test@test.com';
      const password = 'password123';
      final expectedUser = UserModel(
        id: '1',
        email: email,
        password: password,
      );

      when(mockAuthService.login(email, password))
          .thenAnswer((_) async => expectedUser);

      final result = await authRepository.login(email, password);

      expect(result, expectedUser);
      verify(mockAuthService.login(email, password)).called(1);

      print(
          'Test "login should return user when credentials are valid" passed!');
    });

    test('login should return null when credentials are invalid', () async {
      const email = 'test@test.com';
      const password = 'wrongpassword';

      when(mockAuthService.login(email, password))
          .thenAnswer((_) async => null);

      final result = await authRepository.login(email, password);

      expect(result, null);
      verify(mockAuthService.login(email, password)).called(1);

      print(
          'Test "login should return null when credentials are invalid" passed!');
    });

    test(
        'changePassword should return success message when passwords are valid',
        () async {
      const userId = '1';
      const oldPassword = 'oldpass123';
      const newPassword = 'newpass123';
      const expectedMessage = 'Password changed';

      when(mockAuthService.changePassword(userId, oldPassword, newPassword))
          .thenAnswer((_) async => expectedMessage);

      final result =
          await authRepository.changePassword(userId, oldPassword, newPassword);

      expect(result, expectedMessage);
      verify(mockAuthService.changePassword(userId, oldPassword, newPassword))
          .called(1);

      print(
          'Test "changePassword should return success message when passwords are valid" passed!');
    });

    test(
        'changePassword should return error message when passwords are invalid',
        () async {
      const userId = '1';
      const oldPassword = 'wrongoldpass';
      const newPassword = 'newpass123';
      const expectedMessage = 'Invalid old password';

      when(mockAuthService.changePassword(userId, oldPassword, newPassword))
          .thenAnswer((_) async => expectedMessage);

      final result =
          await authRepository.changePassword(userId, oldPassword, newPassword);

      expect(result, expectedMessage);
      verify(mockAuthService.changePassword(userId, oldPassword, newPassword))
          .called(1);

      print(
          'Test "changePassword should return error message when passwords are invalid" passed!');
    });

    test('login should return error message when service throws an exception',
        () async {
      const email = 'test@test.com';
      const password = 'password123';
      const errorMessage = 'Service error';

      when(mockAuthService.login(email, password))
          .thenThrow(Exception(errorMessage));

      try {
        await authRepository.login(email, password);
      } catch (e) {
        expect(e.toString(), contains(errorMessage));
        print(
            'Test "login should return error message when service throws an exception" passed!');
      }
    });
  });
}

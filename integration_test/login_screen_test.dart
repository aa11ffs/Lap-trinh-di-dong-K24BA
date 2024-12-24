import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:mockito/mockito.dart';
import 'package:task/app/data/models/user_model.dart';
import 'package:task/app/modules/login/controllers/login_controller.dart';
import 'package:task/app/routes/app_pages.dart';
import 'package:task/app/routes/app_routes.dart';
import 'package:task/app/shared/binding/initial_binding.dart';
import 'package:task/firebase_options.dart';

import '../test/mocks.mocks.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  late MockLoginController mockLoginController;
  late LoginController loginController;

  setUp(() {
    mockLoginController = MockLoginController();
    loginController = LoginController(authRepository: MockIAuthRepository());
  });

  Widget createTestWidget() {
    return GetMaterialApp(
      initialBinding: InitialBinding(),
      initialRoute: AppRoutes.LOGIN,
      getPages: AppPages.pages,
      builder: EasyLoading.init(),
    );
  }

  testWidgets('CASE 1:ADMIN LOGIN SUCCESS', (tester) async {
    const email = 'giabinhp2003@gmail.com';
    const password = 'Binh112233';

    loginController.emailController.text = email;
    loginController.passwordController.text = password;

    when(mockLoginController.login()).thenAnswer(
        (_) async => UserModel(id: '1', email: email, role: 'admin'));

    await tester.pumpWidget(createTestWidget(),
        duration: const Duration(seconds: 3));
    await tester.pumpAndSettle();

    final emailField = find.byKey(const Key('emailField'));
    final passwordField = find.byKey(const Key('passwordField'));
    final loginButton = find.byKey(const Key('loginButton'));

    expect(emailField, findsOneWidget);
    expect(passwordField, findsOneWidget);
    expect(loginButton, findsOneWidget);

    await tester.enterText(emailField, email);
    await tester.enterText(passwordField, password);
    await tester.tap(loginButton);
    await tester.pumpAndSettle();

    expect(Get.currentRoute, AppRoutes.ADMIN_MAIN);
    print('Admin login success test -> passed!');
  });

  testWidgets('CASE 2:ADMIN LOGIN FAILED', (tester) async {
    const email = 'giabinhp2003@gmail.com';
    const password = '12345';


    loginController.emailController.text = email;
    loginController.passwordController.text = password;

    when(mockLoginController.login())
        .thenAnswer((_) async => throw Exception('Invalid credentials'));

    await tester.pumpWidget(createTestWidget(),
        duration: const Duration(seconds: 3));
    await tester.pumpAndSettle();

    final emailField = find.byKey(const Key('emailField'));
    final passwordField = find.byKey(const Key('passwordField'));
    final loginButton = find.byKey(const Key('loginButton'));

    expect(emailField, findsOneWidget);
    expect(passwordField, findsOneWidget);
    expect(loginButton, findsOneWidget);

    await tester.enterText(emailField, email);
    await tester.enterText(passwordField, password);
    await tester.tap(loginButton);
    await tester.pumpAndSettle();

    expect(Get.currentRoute, AppRoutes.LOGIN);
    expect(find.text('Email or password is incorrect'), findsOneWidget);
    print('Admin login failed test -> passed!');
  });
}

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:task/app/routes/app_pages.dart';
import 'package:task/app/routes/app_routes.dart';
import 'package:task/app/shared/binding/initial_binding.dart';
import 'package:task/core/utils/app_utils.dart';
import 'package:task/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  group('AdminMemberDetail Integration Test', () {
    testWidgets('CASE 1: Add Member success', (tester) async {
      await tester.pumpWidget(
        GetMaterialApp(
          initialBinding: InitialBinding(),
          initialRoute: AppRoutes.ADMIN_MEMBER_DETAIL,
          getPages: AppPages.pages,
          builder: EasyLoading.init(),
        ),
        duration: const Duration(seconds: 3),
      );

      await tester.pumpAndSettle();

      final nameField = find.byKey(const Key('memberNameField'));
      final emailField = find.byKey(const Key('memberEmailField'));
      final phoneField = find.byKey(const Key('memberPhoneField'));
      final passwordField = find.byKey(const Key('memberPasswordField'));
      final createMemberButton = find.byKey(const Key('createMemberButton'));

      expect(nameField, findsOneWidget);
      expect(emailField, findsOneWidget);
      expect(phoneField, findsOneWidget);
      expect(passwordField, findsOneWidget);
      expect(createMemberButton, findsOneWidget);

      await tester.enterText(
          nameField, 'test${AppUtils.generateRandomString(10)}');
      await tester.enterText(
          emailField, 'test${AppUtils.generateRandomString(10)}@test.com');
      await tester.enterText(phoneField, '1234567890');
      await tester.enterText(passwordField, 'Password123');
      await tester.tap(createMemberButton);

      await tester.pumpAndSettle();

      expect(find.text('Member created successfully'), findsOneWidget);
    });
    testWidgets('CASE 2: Add Member failed', (tester) async {
      await tester.pumpWidget(
        GetMaterialApp(
          initialBinding: InitialBinding(),
          initialRoute: AppRoutes.ADMIN_MEMBER_DETAIL,
          getPages: AppPages.pages,
          builder: EasyLoading.init(),
        ),
        duration: const Duration(seconds: 3),
      );

      await tester.pumpAndSettle();

      final nameField = find.byKey(const Key('memberNameField'));
      final emailField = find.byKey(const Key('memberEmailField'));
      final phoneField = find.byKey(const Key('memberPhoneField'));
      final passwordField = find.byKey(const Key('memberPasswordField'));
      final createMemberButton = find.byKey(const Key('createMemberButton'));

      expect(nameField, findsOneWidget);
      expect(emailField, findsOneWidget);
      expect(phoneField, findsOneWidget);
      expect(passwordField, findsOneWidget);
      expect(createMemberButton, findsOneWidget);

      await tester.enterText(nameField, 'test');
      await tester.enterText(emailField, 'ntminh16201@gmail.com');
      await tester.enterText(phoneField, '1234567890');
      await tester.enterText(passwordField, 'Password123');
      await tester.tap(createMemberButton);

      await tester.pumpAndSettle();

      expect(find.text('Email already exists'), findsOneWidget);
      print('CASE 2: Test passed');
    });
  });
  
}

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

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  group('Admin Task Detail', () {
    testWidgets('CASE 1: Add Task success', (tester) async {
      print("Test Case 1 started");
      await tester.pumpWidget(
          GetMaterialApp(
            initialBinding: InitialBinding(),
            initialRoute: AppRoutes.ADMIN_TASK_DETAIL,
            getPages: AppPages.pages,
            builder: EasyLoading.init(),
          ),
          duration: const Duration(seconds: 5));

      await tester.pumpAndSettle();

      final taskNameField = find.byKey(const Key('taskNameField'));
      final taskDescriptionField =
          find.byKey(const Key('taskDescriptionField'));
      final taskAssigneeField = find.byKey(const Key('taskAssigneeField'));
      final taskStatusField = find.byKey(const Key('taskStatusField'));
      final deadlineField = find.byKey(const Key('deadlineField'));
      final createTaskButton = find.byKey(const Key('createTaskButton'));

      expect(taskNameField, findsOneWidget);
      expect(taskDescriptionField, findsOneWidget);
      expect(taskAssigneeField, findsOneWidget);
      expect(taskStatusField, findsOneWidget);
      expect(deadlineField, findsOneWidget);
      expect(createTaskButton, findsOneWidget);

      await tester.enterText(
          taskNameField, 'Test Task Name${AppUtils.generateRandomString(10)}');
      await tester.enterText(taskDescriptionField, 'Test Task Description');

      await tester.tap(taskAssigneeField);
      await tester.pumpAndSettle();
      final assigneeOption = find.text('Tung').last;
      await tester.tap(assigneeOption);
      await tester.pumpAndSettle();

      await tester.tap(taskStatusField);
      await tester.pumpAndSettle();
      final statusOption = find.text('In Progress').last;
      await tester.tap(statusOption);
      await tester.pumpAndSettle();

      await tester.tap(deadlineField);
      await tester.pumpAndSettle();

      await tester.tap(find.text('15'));
      await tester.tap(find.text('OK'));
      await tester.pumpAndSettle();

      await tester.tap(createTaskButton);
      await tester.pumpAndSettle();

      expect(find.text('Created'), findsOneWidget);
      print("Test Case 1 finished");
    });

    testWidgets('CASE 2: Add Task failed', (tester) async {
      print("Test Case 2 started");
      await tester.pumpWidget(
          GetMaterialApp(
            initialBinding: InitialBinding(),
            initialRoute: AppRoutes.ADMIN_TASK_DETAIL,
            getPages: AppPages.pages,
            builder: EasyLoading.init(),
          ),
          duration: const Duration(seconds: 5));

      await tester.pumpAndSettle();

      final taskNameField = find.byKey(const Key('taskNameField'));
      final taskDescriptionField =
          find.byKey(const Key('taskDescriptionField'));
      final taskAssigneeField = find.byKey(const Key('taskAssigneeField'));
      final taskStatusField = find.byKey(const Key('taskStatusField'));
      final deadlineField = find.byKey(const Key('deadlineField'));
      final createTaskButton = find.byKey(const Key('createTaskButton'));

      expect(taskNameField, findsOneWidget);
      expect(taskDescriptionField, findsOneWidget);
      expect(taskAssigneeField, findsOneWidget);
      expect(taskStatusField, findsOneWidget);
      expect(deadlineField, findsOneWidget);
      expect(createTaskButton, findsOneWidget);

      await tester.enterText(taskNameField, 'Da Banh');
      await tester.enterText(taskDescriptionField, 'Test Task Description');

      await tester.tap(taskAssigneeField);
      await tester.pumpAndSettle();
      final assigneeOption = find.text('Tung').last;
      await tester.tap(assigneeOption);
      await tester.pumpAndSettle();

      await tester.tap(taskStatusField);
      await tester.pumpAndSettle();
      final statusOption = find.text('In Progress').last;
      await tester.tap(statusOption);
      await tester.pumpAndSettle();

      await tester.tap(deadlineField);
      await tester.pumpAndSettle();

      await tester.tap(find.text('15'));
      await tester.tap(find.text('OK'));
      await tester.pumpAndSettle();

      await tester.tap(createTaskButton);
      await tester.pumpAndSettle();

      expect(find.text('Failed to create task'), findsOneWidget);
      print("Test Case 2 finished");
    });
  });
}

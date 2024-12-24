import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task/app/modules/admin/main/controllers/admin_main_controller.dart';
import 'package:task/app/modules/admin/member/controllers/admin_member_controller.dart';
import 'package:task/app/modules/admin/member/views/admin_member_screen.dart';
import 'package:task/app/modules/admin/task/controllers/admin_task_controller.dart';
import 'package:task/app/modules/admin/task/views/admin_task_screen.dart';
import 'package:task/app/modules/admin/task_report/controller/task_report_controller.dart';
import 'package:task/app/modules/admin/task_report/view/task_report_screen.dart';
import 'package:task/core/constants/app_color.dart';
import 'package:task/core/widgets/custom_appbar.dart';

class AdminMainScreen extends StatelessWidget {
  AdminMainScreen({super.key});
  final adminMainController = Get.find<AdminMainController>();
  final adminMemberController = Get.find<AdminMemberController>();
  final adminTaskController = Get.find<AdminTaskController>();
  final taskReportController = Get.find<TaskReportController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(
        isMain: true,
        onLogout: () => adminMainController.logOut(),
      ),
      body: Obx(() {
        return IndexedStack(
          index: adminMainController.currentIndex.value,
          children: [
            AdminTaskScreen(),
            AdminMemberScreen(),
            TaskReportScreen(),
          ],
        );
      }),
      bottomNavigationBar: Obx(() {
        return BottomNavigationBar(
          backgroundColor: AppColor.kFFFFFF,
          currentIndex: adminMainController.currentIndex.value,
          onTap: (value) {
            adminMainController.changeTab(value);
            adminMemberController.onInit();
            adminTaskController.onInit();
          },
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Member'),
            BottomNavigationBarItem(icon: Icon(Icons.chat), label: 'Gemini'),
          ],
        );
      }),
    );
  }
}

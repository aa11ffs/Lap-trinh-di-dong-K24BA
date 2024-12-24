import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task/app/modules/member/main/controllers/member_main_controller.dart';
import 'package:task/app/modules/member/profile/controller/member_profiler_controller.dart';
import 'package:task/app/modules/member/profile/view/member_profile_screen.dart';
import 'package:task/app/modules/member/task/controllers/member_task_controller.dart';
import 'package:task/app/modules/member/task/views/member_task_screen.dart';
import 'package:task/core/constants/app_color.dart';
import 'package:task/core/widgets/custom_appbar.dart';

class MemberMainScreen extends StatelessWidget {
  MemberMainScreen({super.key});

  
  final memberMainController = Get.find<MemberMainController>();
  final memberProfileController = Get.find<MemberProfileController>();
  final memberTaskController = Get.find<MemberTaskController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(
        isMain: true,
        onLogout: () => memberMainController.logOut(),
      ),
      body: Obx(() {
        return IndexedStack(
          index: memberMainController.currentIndex.value,
          children: [
            MemberTaskScreen(),
            MemberProfileScreen(),
          ],
        );
      }),
      bottomNavigationBar: Obx(() {
        return BottomNavigationBar(
          backgroundColor: AppColor.kFFFFFF,
          currentIndex: memberMainController.currentIndex.value,
          onTap: (value) {
            memberMainController.changeTab(value);
            memberProfileController.onInit();
            memberTaskController.onInit();
          },
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.task), label: 'Task'),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
          ],
        );
      }),
    );
  }
}

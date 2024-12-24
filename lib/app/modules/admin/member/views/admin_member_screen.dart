import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task/app/modules/admin/member/controllers/admin_member_controller.dart';
import 'package:task/core/widgets/custom_background.dart';
import 'package:task/core/widgets/custom_floating_action_button.dart';
import 'package:task/core/widgets/custom_member_card.dart';

class AdminMemberScreen extends StatelessWidget {
  AdminMemberScreen({super.key});
  final controller = Get.find<AdminMemberController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: CustomFloatingActionButton(
        tag: 'addMember',
        icon: Icons.person_add_outlined,
        onPressed: () => controller.goToCreateMember(),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      body: CustomBackground(
        child: RefreshIndicator(
          onRefresh: () async {
            await controller.innitialData();
          },
          child: Obx(
            () => ListView.separated(
              key: const Key('memberList'),
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 24.0),
              itemCount: controller.members.length,
              separatorBuilder: (_, __) => const SizedBox(height: 10.0),
              itemBuilder: (context, index) {
                final data = controller.members[index];
                return CustomMemberCard(
                  userModel: data,
                  onTap: () => controller.goToMemberDetail(data),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

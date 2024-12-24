import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task/app/modules/member/summary/controllers/member_summary_controller.dart';
import 'package:task/core/widgets/custom_appbar.dart';
import 'package:task/core/widgets/custom_background.dart';
import 'package:task/core/widgets/custom_task_card.dart';

class MemberSumaryTaskDetailScreen extends StatelessWidget {
  MemberSumaryTaskDetailScreen({super.key});
  final MemberSummaryController summaryController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(title: summaryController.status.value),
      body: CustomBackground(child: Obx(() {
        return ListView.separated(
          padding: const EdgeInsets.all(20.0),
          itemCount: summaryController.taskByStatus.length,
          separatorBuilder: (_, __) => const SizedBox(height: 10.0),
          itemBuilder: (context, index) {
            final data = summaryController.taskByStatus[index];
            return CustomTaskCard(
              onTap: () => summaryController.goToTaskDetail(data),
              taskModel: data,
            );
          },
        );
      })),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task/app/modules/admin/task_report/controller/task_report_controller.dart';
import 'package:task/core/constants/app_color.dart';
import 'package:task/core/constants/app_style.dart';
import 'package:task/core/widgets/custom_background.dart';
import 'package:task/core/widgets/custom_text_field.dart';
import 'package:task/gen/assets.gen.dart';

class TaskReportScreen extends StatelessWidget {
  TaskReportScreen({super.key});
  final TaskReportController controller = Get.find();
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          title: Image.asset(
            Assets.images.googleGeminiLogo.path,
            width: 80,
          ),
          backgroundColor: Colors.transparent,
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFFDFE4F1),
                  Color(0xFFB0C7D2),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          actions: [
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.3,
              child: Obx(
                () => DropdownButtonFormField<GeminiType>(
                  value: controller.typeGemini.value,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                  ),
                  items: const [
                    DropdownMenuItem<GeminiType>(
                      value: GeminiType.report,
                      child: Text(
                        'Gemini report',
                        style: AppStyle.regular14,
                      ),
                    ),
                    DropdownMenuItem<GeminiType>(
                      value: GeminiType.chat,
                      child: Text(
                        'Gemini chat',
                        style: AppStyle.regular14,
                      ),
                    ),
                  ],
                  onChanged: (p0) {
                    controller.changeTypeGemini(p0!);
                  },
                ),
              ),
            ),
            const SizedBox(width: 10),
          ],
        ),
        body: Obx(() {
          if (controller.messages.isNotEmpty) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              _scrollController
                  .jumpTo(_scrollController.position.maxScrollExtent);
            });
          }
          return CustomBackground(
            child: Stack(
              fit: StackFit.expand,
              children: [
                ListView.builder(
                  controller: _scrollController,
                  padding: const EdgeInsets.only(bottom: 70),
                  itemCount: controller.messages.length,
                  itemBuilder: (context, index) {
                    final message = controller.messages[index];
                    return ListTile(
                        title: Align(
                      alignment: message.isSentByUser
                          ? Alignment.centerRight
                          : Alignment.centerLeft,
                      child: Container(
                        padding: const EdgeInsets.all(10.0),
                        margin: EdgeInsets.only(
                            left: message.isSentByUser ? 51 : 0,
                            right: message.isSentByUser ? 0 : 51),
                        decoration: BoxDecoration(
                          color: message.isSentByUser
                              ? AppColor.k613BE7
                              : AppColor.kFFFFFF,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          message.content,
                          style: AppStyle.regular14.copyWith(
                            color: message.isSentByUser
                                ? AppColor.kFFFFFF
                                : AppColor.k0D101C,
                          ),
                        ),
                      ),
                    ));
                  },
                ),
                Positioned(
                  bottom: 10,
                  left: 16,
                  right: 16,
                  child: Row(
                    children: [
                      Flexible(
                        child: CustomTextField(
                          controller: controller.promptController,
                          hintText: 'Type your message...',
                          fillColor: AppColor.kFFFFFF,
                        ),
                      ),
                      const SizedBox(width: 10),
                      IconButton(
                          onPressed: () {
                            controller.sendMessage();
                          },
                          icon: const Icon(Icons.send_rounded)),
                    ],
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}

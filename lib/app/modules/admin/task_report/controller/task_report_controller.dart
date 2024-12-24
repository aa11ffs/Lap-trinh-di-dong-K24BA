import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task/app/data/models/mesage_model.dart';
import 'package:task/app/data/models/user_model.dart';
import 'package:task/app/data/repositories/task_repository.dart';
import 'package:task/app/data/repositories/user_repository.dart';
import 'package:task/app/data/services/remote/gemini_service.dart';

enum GeminiType { report, chat }

class TaskReportController extends GetxController {
  final promptController = TextEditingController();
  final GeminiService _geminiService;
  final ITaskRepository _taskRepository;
  final IUserRepository _userRepository;
  var reportContent = ''.obs;
  var isLoading = false.obs;
  RxList<MessageModel> messages = <MessageModel>[].obs;
  String conversationContext = '';

  TaskReportController({
    required ITaskRepository taskRepository,
    required IUserRepository userRepository,
    required GeminiService geminiService,
  })  : _geminiService = geminiService,
        _taskRepository = taskRepository,
        _userRepository = userRepository;

  Rx<GeminiType> typeGemini = GeminiType.report.obs;

  void changeTypeGemini(GeminiType type) {
    typeGemini.value = type;
  }

  void sendMessage() {
    final prompt = promptController.text.trim();
    if (prompt.isEmpty) return;
    conversationContext += "\nUser: $prompt";
    messages.add(MessageModel(content: prompt, isSentByUser: true));
    messages.add(MessageModel(content: 'Đang trả lời...', isSentByUser: false));
    promptController.clear();

    if (typeGemini.value == GeminiType.report) {
      generateGeminiReport(conversationContext);
    } else {
      generateGeminiChat(conversationContext);
    }
  }

  Future<void> generateGeminiReport(String context) async {
    try {
      isLoading.value = true;

      final tasks = await _taskRepository.getAll();
      final users = await _userRepository.getAll();

      final dataJson = jsonEncode(
        tasks.map((task) {
          final assignedUser = users.firstWhere(
              (user) => user.id == task.assignTo,
              orElse: () => UserModel(id: '', name: ''));
          final userName = assignedUser.name ?? 'Unknown';
          return task.toGeminiFormat(userName);
        }).toList(),
      );

      print('Number of tasks: ${tasks.length}');
      print('Generated data JSON: $dataJson');
      final report = await _geminiService.generateContent(context, dataJson);

      messages.removeWhere((msg) => msg.content == 'Đang trả lời...');
      messages.add(MessageModel(content: report, isSentByUser: false));

      conversationContext += "\nGemini: $report";
    } catch (e) {
      messages.removeWhere((msg) => msg.content == 'Đang trả lời...');
      messages.add(MessageModel(content: 'Error: $e', isSentByUser: false));
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> generateGeminiChat(String context) async {
    try {
      isLoading.value = true;
      final response = await _geminiService.generateContent(context, '');

      messages.removeWhere((msg) => msg.content == 'Đang trả lời...');
      messages.add(MessageModel(content: response, isSentByUser: false));
      conversationContext += "\nGemini: $response";
    } catch (e) {
      messages.removeWhere((msg) => msg.content == 'Đang trả lời...');
      messages.add(MessageModel(content: 'Error: $e', isSentByUser: false));
    } finally {
      isLoading.value = false;
    }
  }
}

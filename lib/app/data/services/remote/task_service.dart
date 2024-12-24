import 'package:task/app/data/models/task_model.dart';
import 'package:task/app/data/providers/firebase_provider.dart';
import 'package:task/app/data/services/remote/base/base_service.dart';

class TaskService extends BaseService<TaskModel> {
  TaskService() : super(FirebaseProvider.tasksCollection);

  @override
  TaskModel fromJson(Map<String, dynamic> json) => TaskModel.fromJson(json);

  Future<List<TaskModel>> getTasksByUser(String userId) async {
    try {
      final querySnapshot = await collection
          .where('assignTo', isEqualTo: userId)
          .orderBy('createdAt', descending: true)
          .get();

      return querySnapshot.docs
          .map((doc) => TaskModel.fromJson(doc.data() as Map<String, dynamic>))
          .toList();
    } catch (e) {
      print('Error in TaskService.getTasksByUser: $e');
      return [];
    }
  }

  Future<List<TaskModel>> getTasksByStatus(String status) async {
    try {
      final querySnapshot = await collection
          .where('status', isEqualTo: status)
          .orderBy('createdAt', descending: true)
          .get();
      return querySnapshot.docs
          .map((doc) => TaskModel.fromJson(doc.data() as Map<String, dynamic>))
          .toList();
    } catch (e) {
      print('Error in TaskService.getTasksByStatus: $e');
      return [];
    }
  }

  @override
  Future<TaskModel?> create(TaskModel model) async {
    try {
      final existingTask = await collection
          .where('title', isEqualTo: model.title)
          .limit(1)
          .get();

      if (existingTask.docs.isNotEmpty) {
        print('Task with this title already exists');
        return null;
      }
      return super.create(model);
    } catch (e) {
      print('Error in TaskService.create: $e');
      return null;
    }
  }

  @override
  Future<TaskModel?> update(TaskModel model) async {
    try {
      final taskDoc = await collection.doc(model.id).get();
      if (!taskDoc.exists) {
        print('Task not found');
        return null;
      }
      return super.update(model);
    } catch (e) {
      print('Error in TaskService.update: $e');
      return null;
    }
  }

  @override
  Future<List<TaskModel>> getAll() async {
    return await super.getAll();
  }
}

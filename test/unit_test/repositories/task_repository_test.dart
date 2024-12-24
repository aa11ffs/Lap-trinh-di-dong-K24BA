import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:task/app/data/models/task_model.dart';
import 'package:task/app/data/repositories/task_repository.dart';
import '../../mocks.mocks.dart';

void main() {
  late TaskRepositoryImpl taskRepository;
  late MockTaskService mockTaskService;

  setUp(() {
    mockTaskService = MockTaskService();
    taskRepository = TaskRepositoryImpl(taskService: mockTaskService);
  });

  group('TaskRepository', () {
    test('create should return task when successful', () async {
      
      final task = TaskModel(
        title: 'Test Task',
        description: 'Test Description',
      );

      when(mockTaskService.create(task)).thenAnswer((_) async => task);

      
      final result = await taskRepository.create(task);

      
      expect(result, task);
      verify(mockTaskService.create(task)).called(1);

      
      print('Test "create should return task when successful" passed!');
    });

    test('getTasksByUser should return list of tasks', () async {
      
      final userId = '1';
      final tasks = [
        TaskModel(id: '1', title: 'Task 1', assignTo: userId),
        TaskModel(id: '2', title: 'Task 2', assignTo: userId),
      ];

      when(mockTaskService.getTasksByUser(userId))
          .thenAnswer((_) async => tasks);

      
      final result = await taskRepository.getTasksByUser(userId);

      
      expect(result.length, 2);
      expect(result, tasks);
      verify(mockTaskService.getTasksByUser(userId)).called(1);

      
      print('Test "getTasksByUser should return list of tasks" passed!');
    });

    test('getTasksByStatus should return filtered tasks', () async {
      
      const status = 'In Progress';
      final tasks = [
        TaskModel(id: '1', title: 'Task 1', status: status),
        TaskModel(id: '2', title: 'Task 2', status: status),
      ];

      when(mockTaskService.getTasksByStatus(status))
          .thenAnswer((_) async => tasks);

      
      final result = await taskRepository.getTasksByStatus(status);

      
      expect(result.length, 2);
      expect(result.every((task) => task.status == status), true);
      verify(mockTaskService.getTasksByStatus(status)).called(1);

      
      print('Test "getTasksByStatus should return filtered tasks" passed!');
    });

    test('delete should return true when successful', () async {
      
      const taskId = '1';
      when(mockTaskService.delete(taskId)).thenAnswer((_) async => true);

      
      final result = await taskRepository.delete(taskId);

      
      expect(result, true);
      verify(mockTaskService.delete(taskId)).called(1);

      
      print('Test "delete should return true when successful" passed!');
    });
  });
}

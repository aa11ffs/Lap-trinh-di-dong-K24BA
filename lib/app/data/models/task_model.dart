import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:task/core/utils/string_format.dart';
import 'package:uuid/uuid.dart';
import 'base/base_model.dart';

class TaskModel extends BaseModel {
  final String? title;
  final String? description;
  final String? dueDate;
  final String? status;
  final String? assignTo;

  TaskModel({
    String? id,
    this.title,
    this.description,
    this.dueDate,
    this.status,
    this.assignTo,
    Timestamp? createdAt,
    Timestamp? updatedAt,
  }) : super(
          id: id ?? const Uuid().v4(),
          createdAt: createdAt ?? BaseModel.getCurrentTimestamp(),
          updatedAt: updatedAt ?? BaseModel.getCurrentTimestamp(),
        );

  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'dueDate': dueDate,
      'status': status,
      'assignTo': assignTo,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  Map<String, dynamic> toGeminiFormat(String name) {
    return {
      'task_id': id,
      'task_title': title,
      'task_description': description,
      'task_due_date': dueDate,
      'task_status': status,
      'task_assigned_to': name,
      'created_at': StringFormat.formatDate(createdAt.toDate()),
      'updated_at': StringFormat.formatDate(updatedAt.toDate()),
    };
  }

  factory TaskModel.fromJson(Map<String, dynamic> json) {
    return TaskModel(
      id: json['id'] as String?,
      title: json['title'] as String?,
      description: json['description'] as String?,
      dueDate: json['dueDate'] as String?,
      status: json['status'] as String?,
      assignTo: json['assignTo'] as String?,
      createdAt: json['createdAt'] is Timestamp
          ? json['createdAt'] as Timestamp
          : BaseModel.getCurrentTimestamp(),
      updatedAt: json['updatedAt'] is Timestamp
          ? json['updatedAt'] as Timestamp
          : BaseModel.getCurrentTimestamp(),
    );
  }

  TaskModel copyWith({
    String? title,
    String? description,
    String? dueDate,
    String? status,
    String? assignTo,
  }) {
    return TaskModel(
      id: id,
      title: title ?? this.title,
      description: description ?? this.description,
      dueDate: dueDate ?? this.dueDate,
      status: status ?? this.status,
      assignTo: assignTo ?? this.assignTo,
      createdAt: createdAt,
      updatedAt: BaseModel.getCurrentTimestamp(),
    );
  }
}

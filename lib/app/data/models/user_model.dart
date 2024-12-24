import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:task/app/data/models/task_model.dart';
import 'package:uuid/uuid.dart';
import 'base/base_model.dart';

class UserModel extends BaseModel {
  final String? name;
  final String? email;
  final String? phoneNumber;
  final String? avatarUrl;
  final String? password;
  final String? role;
  final List<TaskModel>? tasks;

  UserModel({
    String? id,
    this.name,
    this.email,
    this.phoneNumber,
    this.password,
    this.avatarUrl,
    this.role = 'member',
    this.tasks,
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
      'name': name,
      'email': email,
      'phoneNumber': phoneNumber,
      'avatarUrl': avatarUrl,
      'password': password,
      'role': role,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as String?,
      name: json['name'] as String?,
      email: json['email'] as String?,
      phoneNumber: json['phoneNumber'] as String?,
      avatarUrl: json['avatarUrl'] as String?,
      password: json['password'] as String?,
      role: json['role'] as String?,
      createdAt: json['createdAt'] is Timestamp
          ? json['createdAt'] as Timestamp
          : BaseModel.getCurrentTimestamp(),
      updatedAt: json['updatedAt'] is Timestamp
          ? json['updatedAt'] as Timestamp
          : BaseModel.getCurrentTimestamp(),
      tasks: json['tasks'] != null
          ? (json['tasks'] as List)
              .map((task) => TaskModel.fromJson(task))
              .toList()
          : [],
    );
  }

  UserModel copyWith({
    String? name,
    String? email,
    String? phoneNumber,
    String? avatarUrl,
    String? password,
    String? role,
    List<TaskModel>? tasks,
  }) {
    return UserModel(
      id: id,
      name: name ?? this.name,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      password: password ?? this.password,
      role: role ?? this.role,
      createdAt: createdAt,
      updatedAt: BaseModel.getCurrentTimestamp(),
      tasks: tasks ?? this.tasks,
    );
  }
}

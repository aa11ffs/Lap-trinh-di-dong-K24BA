import 'package:cloud_firestore/cloud_firestore.dart';

abstract class BaseModel {
  final String id;
  final Timestamp createdAt;
  final Timestamp updatedAt;

  BaseModel({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
  });

  Map<String, dynamic> toJson();

  static Timestamp getCurrentTimestamp() => Timestamp.now();
}

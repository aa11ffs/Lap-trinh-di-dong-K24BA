import 'package:flutter/material.dart';

class StatusModel {
  final String label;
  final Color color;
  final Color bgrColor;


  const StatusModel({
    required this.label,
    required this.color,
    required this.bgrColor
  });

  static const List<StatusModel> statuses = [
    StatusModel(
      label: 'Open',
      color: Colors.blue,
      bgrColor: Colors.white
    ),
    StatusModel(
      label: 'In Progress',
      color: Colors.orange,
        bgrColor: Colors.white
    ),
    StatusModel(
      label: 'Completed',
      color: Colors.green,
        bgrColor: Colors.white
    ),
    StatusModel(
      label: 'Overdue',
      color: Colors.red, bgrColor: Colors.white
    ),
  ];

  static Color getColorByStatus(String status) {
    return statuses
        .firstWhere(
          (s) => s.label == status,
          orElse: () => statuses.first,
        )
        .color;
  }
} 
import 'package:flutter/material.dart';

class EmergencyEntity {
  final String id;
  final String title;
  final String number;
  final String description;
  final IconData icon;
  final Color color;

  const EmergencyEntity({
    required this.id,
    required this.title,
    required this.number,
    required this.description,
    required this.icon,
    required this.color,
  });
}
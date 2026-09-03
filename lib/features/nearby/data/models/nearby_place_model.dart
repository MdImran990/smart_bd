import 'package:flutter/material.dart';

class NearbyPlaceModel {
  final String id;
  final String name;
  final String category;
  final String distance;
  final String rating;
  final String address;
  final IconData icon;
  final bool isOpen;

  const NearbyPlaceModel({
    required this.id,
    required this.name,
    required this.category,
    required this.distance,
    required this.rating,
    required this.address,
    required this.icon,
    required this.isOpen,
  });
}
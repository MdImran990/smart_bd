import 'package:flutter/material.dart';

import '../models/service_model.dart';

class LocalServiceData {
  LocalServiceData._();

  static const List<ServiceModel> services = [
    ServiceModel(
      id: 'hospital',
      title: 'Hospital',
      icon: Icons.local_hospital_outlined,
    ),

    ServiceModel(
      id: 'pharmacy',
      title: 'Pharmacy',
      icon: Icons.local_pharmacy_outlined,
    ),

    ServiceModel(
      id: 'bank',
      title: 'Bank',
      icon: Icons.account_balance_outlined,
    ),

    ServiceModel(
      id: 'police',
      title: 'Police',
      icon: Icons.local_police_outlined,
    ),

    ServiceModel(
      id: 'fire_service',
      title: 'Fire Service',
      icon: Icons.fire_truck_outlined,
    ),

    ServiceModel(
      id: 'emergency',
      title: 'Emergency',
      icon: Icons.emergency_outlined,
    ),

    ServiceModel(
      id: 'atm',
      title: 'ATM',
      icon: Icons.atm_outlined,
    ),

    ServiceModel(
      id: 'restaurant',
      title: 'Restaurant',
      icon: Icons.restaurant_outlined,
    ),
  ];
}
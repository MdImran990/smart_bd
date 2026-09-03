import 'package:flutter/material.dart';

import '../models/emergency_service_model.dart';

class LocalEmergencyData {
  LocalEmergencyData._();

  static const List<EmergencyServiceModel> services = [
    EmergencyServiceModel(
      id: 'police',
      title: 'Police',
      number: '999',
      description: 'National Emergency Police Service',
      icon: Icons.local_police_outlined,
      color: Color(0xFF2563EB),
    ),
    EmergencyServiceModel(
      id: 'fire',
      title: 'Fire Service',
      number: '199',
      description: 'Bangladesh Fire Service & Civil Defence',
      icon: Icons.fire_truck_outlined,
      color: Color(0xFFEF4444),
    ),
    EmergencyServiceModel(
      id: 'ambulance',
      title: 'Ambulance',
      number: '199',
      description: 'National Ambulance Service',
      icon: Icons.emergency_outlined,
      color: Color(0xFF10B981),
    ),
    EmergencyServiceModel(
      id: 'rab',
      title: 'RAB',
      number: '01713-398349',
      description: 'Rapid Action Battalion',
      icon: Icons.shield_outlined,
      color: Color(0xFF8B5CF6),
    ),
    EmergencyServiceModel(
      id: 'coast_guard',
      title: 'Coast Guard',
      number: '01769-052524',
      description: 'Bangladesh Coast Guard',
      icon: Icons.sailing_outlined,
      color: Color(0xFF0EA5E9),
    ),
    EmergencyServiceModel(
      id: 'hospital',
      title: 'DMCH',
      number: '02-55165088',
      description: 'Dhaka Medical College Hospital',
      icon: Icons.local_hospital_outlined,
      color: Color(0xFFF59E0B),
    ),
  ];
}
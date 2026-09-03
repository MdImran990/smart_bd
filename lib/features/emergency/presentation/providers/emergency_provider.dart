import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/models/emergency_service_model.dart';
import '../../data/repositories/emergency_repository.dart';

final emergencyRepositoryProvider = Provider<EmergencyRepository>((ref) {
  return const EmergencyRepository();
});

final emergencyServicesProvider = Provider<List<EmergencyServiceModel>>((ref) {
  final repository = ref.watch(emergencyRepositoryProvider);
  return repository.getEmergencyServices();
});
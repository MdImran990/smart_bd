import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/models/service_model.dart';
import '../../data/repositories/service_repository.dart';

final serviceRepositoryProvider = Provider<ServiceRepository>((ref) {
  return const ServiceRepository();
});

final servicesProvider = Provider<List<ServiceModel>>((ref) {
  final repository = ref.watch(serviceRepositoryProvider);

  return repository.getServices();
});
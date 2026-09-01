import '../datasources/local_service_data.dart';
import '../models/service_model.dart';

class ServiceRepository {
  const ServiceRepository();

  List<ServiceModel> getServices() {
    return LocalServiceData.services;
  }
}
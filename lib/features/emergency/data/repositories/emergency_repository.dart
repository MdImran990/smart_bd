import '../datasources/local_emergency_data.dart';
import '../models/emergency_service_model.dart';

class EmergencyRepository {
  const EmergencyRepository();

  List<EmergencyServiceModel> getEmergencyServices() {
    return LocalEmergencyData.services;
  }
}
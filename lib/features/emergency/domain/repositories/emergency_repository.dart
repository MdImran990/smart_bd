import '../entities/emergency_entity.dart';

abstract class EmergencyRepositoryInterface {
  List<EmergencyEntity> getEmergencyServices();
}
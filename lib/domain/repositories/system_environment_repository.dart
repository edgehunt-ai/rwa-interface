import '../models/deployment_environment.dart';

abstract interface class SystemEnvironmentRepository {
  Future<DeploymentEnvironment> getEnvironment();
}

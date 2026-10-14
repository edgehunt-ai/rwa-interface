import 'package:rwa_api_client/rwa_api_client.dart' as api;

abstract interface class SystemService {
  Future<api.SystemEnvironment> getEnvironment();

  Future<List<api.AppVersionInfo>> listAppVersions({String? platform});
}

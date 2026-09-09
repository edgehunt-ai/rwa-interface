import 'package:rwa_api_client/rwa_api_client.dart' as api;

abstract interface class SystemService {
  Future<List<api.AppVersionInfo>> listAppVersions({String? platform});
}

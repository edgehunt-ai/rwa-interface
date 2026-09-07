import 'package:rwa_api_client/rwa_api_client.dart' as api;

abstract interface class SessionService {
  Future<api.PrivyClientConfig> getAuthConfig();
  Future<api.SessionResponse> createSession({String? language});
  Future<void> deleteSession();
}

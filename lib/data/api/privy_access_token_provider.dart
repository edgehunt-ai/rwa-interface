/// Boundary implemented by the app's Privy SDK integration.
///
/// [getAccessToken] should call the authenticated Privy user's
/// `getAccessToken()`. [refreshAccessToken] should refresh the Privy user and
/// then request the token again. Privy's SDK remains the only owner of refresh
/// tokens.
abstract interface class PrivyAccessTokenProvider {
  Future<String?> getAccessToken();

  Future<String?> refreshAccessToken();

  Future<void> onAuthenticationExpired();
}

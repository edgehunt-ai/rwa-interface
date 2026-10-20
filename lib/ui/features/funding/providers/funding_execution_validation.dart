import '../../../../domain/models/wallet_action_execution.dart';

/// Checks the server-owned execution against the business action the user saw.
void validateFundingExecution({
  required WalletActionExecution execution,
  required String resourceId,
  required GasPaymentMode mode,
  required int chainId,
  required String from,
  required FrozenTransaction transaction,
  WalletActionExecution? previous,
}) {
  if (execution.executionId.isEmpty ||
      execution.resourceId != resourceId ||
      execution.mode != mode ||
      execution.chainId != chainId ||
      execution.walletAddress.toLowerCase() != from.toLowerCase() ||
      execution.transaction.to.toLowerCase() != transaction.to.toLowerCase() ||
      execution.transaction.data.toLowerCase() != transaction.data.toLowerCase() ||
      execution.transaction.value != transaction.value ||
      transaction.value != '0x0' ||
      (previous != null &&
          (execution.executionId != previous.executionId ||
              execution.executionProvider != previous.executionProvider ||
              execution.nativeNonce != previous.nativeNonce ||
              execution.transaction.nonce != previous.transaction.nonce))) {
    throw StateError('Server execution failed validation');
  }
}

/// Validate both the display mirror and the actual request passed to Privy.
void validateFundingAuthorization(WalletActionExecution execution) {
  final authorization = execution.authorization;
  final expiresAt = execution.authorizationExpiresAt;
  final sponsored = execution.mode == GasPaymentMode.appSponsored;
  final now = DateTime.now().toUtc();
  if (!execution.awaitsAuthorization ||
      authorization == null ||
      expiresAt == null ||
      !expiresAt.isAfter(now) ||
      execution.gasPayment.mode != execution.mode ||
      execution.gasPayment.platformPays != sponsored ||
      authorization.version != 1 ||
      authorization.method != 'POST' ||
      !RegExp(r'^https://api\.privy\.io/v1/wallets/[a-zA-Z0-9_-]+/rpc$')
          .hasMatch(authorization.url) ||
      authorization.sponsor != sponsored ||
      authorization.referenceId != execution.executionId ||
      authorization.caip2 != 'eip155:${execution.chainId}') {
    throw StateError('Server authorization payload failed validation');
  }
  final transaction = authorization.transaction;
  final body = authorization.body;
  final params = body['params'];
  final rawTransaction = params is Map ? params['transaction'] : null;
  final requestExpiry = int.tryParse(
    authorization.headers['privy-request-expiry'] ?? '',
  );
  if (transaction.from.toLowerCase() != execution.walletAddress.toLowerCase() ||
      transaction.to.toLowerCase() != execution.transaction.to.toLowerCase() ||
      transaction.data.toLowerCase() != execution.transaction.data.toLowerCase() ||
      transaction.value != execution.transaction.value ||
      body.length != 6 ||
      body['method'] != 'eth_sendTransaction' ||
      body['chain_type'] != 'ethereum' ||
      body['sponsor'] != sponsored ||
      body['reference_id'] != execution.executionId ||
      body['caip2'] != authorization.caip2 ||
      params is! Map ||
      params.length != 1 ||
      rawTransaction is! Map ||
      rawTransaction['from'] != transaction.from ||
      rawTransaction['to'] != transaction.to ||
      rawTransaction['data'] != transaction.data ||
      rawTransaction['value'] != transaction.value ||
      rawTransaction['nonce'] != transaction.nonce ||
      rawTransaction.keys.any((key) =>
          !const {'from', 'to', 'data', 'value', 'nonce'}.contains(key)) ||
      (authorization.headers['privy-app-id'] ?? '').isEmpty ||
      (authorization.headers['privy-idempotency-key'] ?? '').isEmpty ||
      requestExpiry == null ||
      requestExpiry <= now.millisecondsSinceEpoch ||
      requestExpiry > expiresAt.millisecondsSinceEpoch) {
    throw StateError('Server authorization request differs from frozen call');
  }
  if (!sponsored) {
    final nonce = execution.nativeNonce;
    final authorizedNonce = transaction.nonce;
    if (execution.executionProvider != 'privy_native' ||
        execution.nativeDeliveryState != 'prepared' ||
        nonce == null ||
        !RegExp(r'^(0|[1-9][0-9]*)$').hasMatch(nonce) ||
        execution.transaction.nonce != nonce ||
        authorizedNonce == null ||
        !RegExp(r'^0x(0|[1-9a-f][0-9a-f]*)$').hasMatch(authorizedNonce) ||
        BigInt.parse(nonce) != BigInt.parse(authorizedNonce.substring(2), radix: 16)) {
      throw StateError('Native execution has no exact server-owned nonce');
    }
  }
}
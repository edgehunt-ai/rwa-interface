import 'package:flutter/services.dart';
import 'package:privy_flutter/privy_flutter.dart';

/// Transaction-only transport adapter for the pinned Privy Flutter 0.10.2.
/// Its public provider drops PlatformException codes while wrapping failures.
/// Use the same native request here to preserve structured refusal evidence;
/// generic RPC failures must still be treated as potentially broadcast.
/// This data-boundary transport exception is covered by channel-level tests.
Future<Result<EthereumRpcResponse>> requestPrivyTransaction(
  EmbeddedEthereumWallet wallet,
  EthereumRpcRequest request,
) async {
  if (request.method != 'eth_sendTransaction') {
    throw ArgumentError(
      'Transaction transport only accepts eth_sendTransaction',
    );
  }
  final response = await const MethodChannel('privy_flutter')
      .invokeMapMethod<String, dynamic>('ethSendRpcRequest', {
        ...request.toJson(),
        'walletAddress': wallet.address,
      });
  if (response == null || response['method'] != request.method) {
    throw const FormatException('Invalid Privy transaction response');
  }
  return Success(EthereumRpcResponse.fromJson(response));
}

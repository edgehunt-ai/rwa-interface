import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:reown_appkit/reown_appkit.dart';

import '../../app/config/privy_configuration.dart';
import '../../domain/auth/authentication.dart';
import '../../domain/auth/identity_auth_gateway.dart';

abstract interface class WalletConnector {
  Future<WalletConnection> connect(BuildContext context);
}

final class ReownWalletConnector implements WalletConnector {
  ReownWalletConnector(this._configuration);

  final ReownConfiguration _configuration;
  ReownAppKitModal? _modal;

  @override
  Future<WalletConnection> connect(BuildContext context) async {
    final modal = _modal ??= ReownAppKitModal(
      context: context,
      projectId: _configuration.validate(),
      metadata: const PairingMetadata(
        name: 'RWA Interface',
        description: 'RWA Interface wallet sign-in',
        url: 'https://rwa.dxd.ink',
        redirect: Redirect(native: 'rwa://'),
      ),
      optionalNamespaces: const {
        'eip155': RequiredNamespace(
          chains: ['eip155:1', 'eip155:56', 'eip155:42161', 'eip155:8453'],
          methods: ['personal_sign'],
          events: ['accountsChanged', 'chainChanged'],
        ),
      },
      disconnectOnDispose: false,
    );
    await modal.init();
    await modal.openModalView();

    final session = modal.session;
    final chain = modal.selectedChain;
    if (!modal.isConnected || session == null || chain == null) {
      throw const IdentityFailure(
        AuthenticationFailureCode.provider,
        retryable: true,
      );
    }
    if (!chain.chainId.startsWith('eip155:')) {
      throw const IdentityFailure(
        AuthenticationFailureCode.methodUnavailable,
        retryable: false,
      );
    }
    final address = session.getAddress('eip155');
    final chainId = chain.chainId.substring('eip155:'.length);
    if (address == null || address.isEmpty || chainId.isEmpty) {
      throw const IdentityFailure(
        AuthenticationFailureCode.provider,
        retryable: true,
      );
    }
    return _ReownWalletConnection(
      modal: modal,
      address: address,
      chainId: chainId,
    );
  }
}

final class _ReownWalletConnection implements WalletConnection {
  const _ReownWalletConnection({
    required this.modal,
    required this.address,
    required this.chainId,
  });

  final ReownAppKitModal modal;

  @override
  final String address;

  @override
  final String chainId;

  @override
  String get connectorType => 'walletconnect';

  @override
  Future<String> signPersonalMessage(String message) async {
    final signature = await modal.request(
      topic: modal.session!.topic,
      chainId: 'eip155:$chainId',
      request: SessionRequestParams(
        method: 'personal_sign',
        params: [_hexEncode(message), address],
      ),
    );
    if (signature is String && signature.isNotEmpty) return signature;
    throw const IdentityFailure(
      AuthenticationFailureCode.provider,
      retryable: true,
    );
  }

  @override
  Future<void> disconnect() => modal.disconnect();
}

String _hexEncode(String value) {
  final buffer = StringBuffer('0x');
  for (final byte in utf8.encode(value)) {
    buffer.write(byte.toRadixString(16).padLeft(2, '0'));
  }
  return buffer.toString();
}

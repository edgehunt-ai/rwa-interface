import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:reown_appkit/reown_appkit.dart';

import '../../app/config/privy_configuration.dart';
import '../../domain/auth/authentication.dart';
import '../../domain/auth/identity_auth_gateway.dart';
import '../../domain/security/sensitive_text.dart';

typedef ReownModalFactory = ReownAppKitModal Function(BuildContext context);

abstract interface class WalletConnector {
  Future<WalletConnection> connect(BuildContext context);
}

final class ReownWalletConnector implements WalletConnector {
  ReownWalletConnector(this._configuration, {this.createModal});

  final ReownConfiguration _configuration;
  final ReownModalFactory? createModal;
  ReownAppKitModal? _modal;
  Future<WalletConnection>? _pendingConnection;

  @override
  Future<WalletConnection> connect(BuildContext context) =>
      _pendingConnection ??= _connect(context).whenComplete(() {
        _pendingConnection = null;
      });

  Future<WalletConnection> _connect(BuildContext context) => _sdkCall(() async {
    if (!context.mounted) {
      throw const IdentityFailure(
        AuthenticationFailureCode.provider,
        retryable: true,
        reason:
            'The wallet login screen is no longer available. Reopen sign-in.',
      );
    }
    if (_modal case final previous? when previous.modalContext == null) {
      await previous.dispose();
      _modal = null;
    }
    if (!context.mounted) {
      throw const IdentityFailure(
        AuthenticationFailureCode.provider,
        retryable: true,
        reason: 'The wallet login screen was closed. Reopen sign-in.',
      );
    }
    final modal = _modal ??= createModal?.call(context) ?? _buildModal(context);
    await modal.init();
    // Reown 1.9.0 treats a second open as closeModal(). Its async-void close
    // callback reads List.last even when no modal screen has been mounted.
    // Never toggle an already open modal while a login is being established.
    if (modal.isOpen) {
      throw const IdentityFailure(
        AuthenticationFailureCode.provider,
        retryable: true,
        reason: 'The wallet dialog is already open. Close it and try again.',
      );
    }
    if (!context.mounted) {
      throw const IdentityFailure(
        AuthenticationFailureCode.provider,
        retryable: true,
        reason: 'The wallet login screen was closed. Reopen sign-in.',
      );
    }
    await modal.openModalView();

    final session = modal.session;
    final chain = modal.selectedChain;
    if (!modal.isConnected || session == null || chain == null) {
      throw const IdentityFailure(
        AuthenticationFailureCode.provider,
        retryable: true,
        reason: 'Wallet connection was not completed. Choose a wallet and try again.',
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
  });

  ReownAppKitModal _buildModal(BuildContext context) => ReownAppKitModal(
    context: context,
    projectId: _configuration.validate(),
    metadata: PairingMetadata(
      name: 'Nobell',
      description: 'Nobell wallet sign-in',
      url: PrivyConfiguration.relyingParty,
      redirect: Redirect(native: PrivyConfiguration.nativeAppRedirect),
    ),
    optionalNamespaces: const {
      'eip155': RequiredNamespace(
        chains: ['eip155:1', 'eip155:56', 'eip155:42161', 'eip155:8453'],
        methods: ['personal_sign', 'eth_signTypedData_v4'],
        events: ['accountsChanged', 'chainChanged'],
      ),
    },
    disconnectOnDispose: false,
  );
}

/// Reown 1.9.0 has async-void callbacks whose failures bypass await/catch.
/// Contain only this SDK operation and return a stable, readable domain error.
/// Errors after completion still reach the parent handler for observability.
Future<T> _sdkCall<T>(Future<T> Function() operation) {
  final result = Completer<T>();
  final parent = Zone.current;
  void fail(Object error, StackTrace stack) {
    if (result.isCompleted) {
      parent.handleUncaughtError(error, stack);
      return;
    }
    final failure = error is IdentityFailure
        ? error
        : IdentityFailure(
            AuthenticationFailureCode.provider,
            retryable: true,
            reason: SensitiveTextRedactor.redact(
              (error is StateError
                      ? error.message.toString()
                      : error.toString())
                  .split('\n')
                  .first,
            ),
          );
    result.completeError(failure, stack);
  }

  runZonedGuarded(() async {
    try {
      final value = await operation();
      if (!result.isCompleted) result.complete(value);
    } on Object catch (error, stack) {
      if (!result.isCompleted) fail(error, stack);
    }
  }, fail);
  return result.future;
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
  Future<String> signTypedDataV4(Map<String, Object?> typedData) async {
    final signature = await modal.request(
      topic: modal.session!.topic,
      chainId: 'eip155:$chainId',
      request: SessionRequestParams(
        method: 'eth_signTypedData_v4',
        params: [address, jsonEncode(typedData)],
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

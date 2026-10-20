import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../domain/models/wallet_action_execution.dart';
import '../../../../l10n/generated/app_localizations.dart';
import '../providers/native_execution_recovery_providers.dart';

class NativeExecutionRecoveryScreen extends ConsumerStatefulWidget {
  const NativeExecutionRecoveryScreen({super.key, required this.executionId});
  final String executionId;

  @override
  ConsumerState<NativeExecutionRecoveryScreen> createState() => _NativeExecutionRecoveryScreenState();
}

class _NativeExecutionRecoveryScreenState extends ConsumerState<NativeExecutionRecoveryScreen> {
  bool _busy = false;
  bool _failed = false;

  Future<void> _command({required bool authorize}) async {
    setState(() { _busy = true; _failed = false; });
    try {
      final commands = ref.read(nativeExecutionRecoveryCommandsProvider);
      if (authorize) {
        await commands.authorize(widget.executionId);
      } else {
        await commands.prepare(widget.executionId);
      }
    } on Object {
      if (mounted) setState(() => _failed = true);
    } finally {
      if (mounted) {
        ref.invalidate(walletExecutionEvidenceProvider(widget.executionId));
        setState(() => _busy = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final evidence = ref.watch(walletExecutionEvidenceProvider(widget.executionId));
    return Scaffold(
      appBar: AppBar(title: Text(l10n.nativeRecoveryTitle)),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text(l10n.nativeRecoveryNotice),
          SelectableText(widget.executionId),
          if (_failed) Text(l10n.nativeRecoveryUnavailable),
          OutlinedButton(
            onPressed: _busy ? null : () => ref.invalidate(walletExecutionEvidenceProvider(widget.executionId)),
            child: Text(l10n.fundsRefresh),
          ),
          evidence.when(
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (_, _) => Text(l10n.nativeRecoveryUnavailable),
            data: (execution) {
              final cancellation = execution.nativeCancellation;
              final native = execution.executionProvider == 'privy_native' &&
                  execution.mode == GasPaymentMode.userPaidNative && execution.nativeNonce != null;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(l10n.nativeRecoveryOriginal),
                  SelectableText([
                    'provider: ${execution.executionProvider ?? 'unknown'}',
                    'status: ${execution.status.name}',
                    'chain_id: ${execution.chainId}',
                    'from: ${execution.walletAddress}',
                    'to: ${execution.transaction.to}',
                    'data: ${execution.transaction.data}',
                    'value: ${execution.transaction.value}',
                    if (execution.nativeNonce != null) 'nonce: ${execution.nativeNonce}',
                    if (execution.nativeDeliveryState != null) 'delivery: ${execution.nativeDeliveryState}',
                    if (execution.txHash != null) 'tx_hash: ${execution.txHash}',
                    if (execution.failureReason != null) execution.failureReason!,
                  ].join('\n')),
                  if (execution.chainObservation != null) _observation(execution.chainObservation!),
                  if (cancellation != null) ...[
                    const Divider(),
                    Text(l10n.nativeRecoveryCancellation),
                    SelectableText([
                      cancellation.cancellationId,
                      'status: ${cancellation.status}',
                      'nonce: ${cancellation.nonce}',
                      'to: ${cancellation.to}',
                      if (cancellation.txHash != null) 'tx_hash: ${cancellation.txHash}',
                    ].join('\n')),
                    if (cancellation.chainObservation != null) _observation(cancellation.chainObservation!),
                  ],
                  if (native && (cancellation == null || cancellation.status == 'failed' ||
                      (cancellation.status == 'awaiting_user_authorization' &&
                          cancellation.authorizationExpiresAt?.isAfter(DateTime.now().toUtc()) == false)) &&
                      const {'prepared', 'dispatching'}.contains(execution.nativeDeliveryState) &&
                      !const {WalletActionExecutionState.chainConfirmed, WalletActionExecutionState.completed}.contains(execution.status))
                    OutlinedButton(
                      key: const Key('native-recovery-prepare'),
                      onPressed: _busy ? null : () => _command(authorize: false),
                      child: Text(l10n.nativeRecoveryPrepare),
                    ),
                  if (native && cancellation?.status == 'awaiting_user_authorization' &&
                      cancellation?.authorization != null && execution.nativeDeliveryState == 'dispatching')
                    OutlinedButton(
                      key: const Key('native-recovery-authorize'),
                      onPressed: _busy ? null : () => _command(authorize: true),
                      child: Text(l10n.nativeRecoveryAuthorize),
                    ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _observation(WalletChainObservation evidence) => SelectableText([
    'tx_hash: ${evidence.txHash}',
    'sender: ${evidence.sender}',
    'recipient: ${evidence.recipient}',
    'payload_hash: ${evidence.payloadHash}',
    'value: ${evidence.value}',
    'receipt_success: ${evidence.receiptSuccess}',
    'canonical: ${evidence.canonical}',
    'block: ${evidence.blockNumber}',
    'block_hash: ${evidence.blockHash}',
    'confirmations: ${evidence.confirmations}',
    'observed_at: ${evidence.observedAt.toIso8601String()}',
  ].join('\n'));
}

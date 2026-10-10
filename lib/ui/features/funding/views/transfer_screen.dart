import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:shimmer/shimmer.dart';
import 'package:nobell/app/routing/routes.dart';
import 'package:nobell/domain/models/api_failure.dart';
import 'package:nobell/domain/models/funding_catalog.dart';
import 'package:nobell/domain/models/funding_session.dart';
import 'package:nobell/domain/models/funding_transfer.dart';
import 'package:nobell/domain/models/hip3_withdrawal.dart';
import 'package:nobell/domain/models/hip3_withdrawal_preview.dart';
import 'package:nobell/domain/services/hip3_typed_data_signer.dart';
import 'package:nobell/domain/models/decimal_value.dart';
import 'package:nobell/l10n/generated/app_localizations.dart';
import 'package:nobell/ui/core/feedback/app_toast.dart';
import 'package:nobell/ui/core/feedback/inline_error_notice.dart';
import 'package:nobell/ui/core/formatters/token_amount_formatter.dart';
import 'package:nobell/ui/core/motion/animated_number_text.dart';
import 'package:nobell/ui/core/navigation/app_page_header.dart';
import 'package:nobell/ui/core/theme/app_theme.dart';
import 'package:nobell/ui/features/funding/providers/funding_transfer_providers.dart';
import 'package:nobell/ui/features/funding/providers/hip3_withdrawal_providers.dart';
import 'package:nobell/ui/features/funding/hip3_withdrawal_blocker_message.dart';
import 'package:nobell/ui/features/funding/widgets/transfer_account_pair.dart';
import 'package:nobell/ui/features/orders/views/hip3_cross_liquidation_impacts_card.dart';

/// Presents the internal Spot/Perps transfer flow.
///
/// Quotes and executes an internal Spot-to-Perps transfer through Riverpod.
class TransferScreen extends ConsumerStatefulWidget {
  const TransferScreen({super.key});

  @override
  ConsumerState<TransferScreen> createState() => _TransferScreenState();
}

class _TransferScreenState extends ConsumerState<TransferScreen> {
  final _amounts = <String, TextEditingController>{};
  final _withdrawalAmount = TextEditingController();
  bool _submitting = false;
  bool _quoting = false;
  FundingSessionSummary? _quote;
  Timer? _quoteDebounce;
  Timer? _quoteRefresh;
  Timer? _planRefresh;
  Timer? _withdrawalRefresh;
  Timer? _withdrawalPreviewDebounce;
  bool _withdrawalPreviewing = false;
  Hip3WithdrawalPreview? _withdrawalPreview;
  int _withdrawalPreviewSequence = 0;
  bool _withdrawalPolling = false;
  Hip3Withdrawal? _withdrawal;
  FundingPlan? _activePlan;
  bool _planPolling = false;
  int _quoteSequence = 0;
  String? _error;
  String? _statusMessage;
  bool _transferPending = false;
  bool _completionToastShown = false;
  bool _sendFromSpot = true;

  Map<String, String> get _allocations => {
    for (final entry in _amounts.entries)
      if ((double.tryParse(entry.value.text.trim()) ?? 0) > 0)
        entry.key: entry.value.text.trim(),
  };

  void _scheduleQuote() {
    _quoteDebounce?.cancel();
    _quoteRefresh?.cancel();
    _quoteSequence++;
    if (!_sendFromSpot) return;
    final allocations = _allocations;
    if (allocations.isEmpty) {
      setState(() {
        _quote = null;
        _quoting = false;
        _statusMessage = null;
        _transferPending = false;
        _completionToastShown = false;
      });
      return;
    }
    setState(() {
      _quote = null;
      _quoting = true;
      _error = null;
      _statusMessage = null;
      _transferPending = false;
      _completionToastShown = false;
    });
    _quoteDebounce = Timer(const Duration(milliseconds: 500), _requestQuote);
  }

  void _swapAccounts() {
    if (_submitting || _transferPending) return;
    _quoteDebounce?.cancel();
    _quoteRefresh?.cancel();
    _quoteSequence++;
    _withdrawalPreviewDebounce?.cancel();
    _withdrawalPreviewSequence++;
    setState(() {
      _sendFromSpot = !_sendFromSpot;
      _quote = null;
      _quoting = false;
      _error = null;
      _statusMessage = null;
      _withdrawal = null;
      _withdrawalPreview = null;
      _withdrawalPreviewing = false;
    });
    if (_sendFromSpot) {
      _scheduleQuote();
    } else {
      _scheduleHip3Preview();
    }
  }

  void _scheduleHip3Preview() {
    _withdrawalPreviewDebounce?.cancel();
    final sequence = ++_withdrawalPreviewSequence;
    final amount = _withdrawalAmount.text.trim();
    setState(() {
      _error = null;
      _withdrawal = null;
      _withdrawalPreview = null;
      _withdrawalPreviewing = false;
    });
    if (amount.isEmpty) return;
    try {
      final parsed = DecimalValue(amount);
      if (parsed.scale > 6 || parsed.compareTo(DecimalValue('0')) <= 0) {
        return;
      }
    } on FormatException {
      return;
    }
    setState(() => _withdrawalPreviewing = true);
    _withdrawalPreviewDebounce = Timer(
      const Duration(milliseconds: 500),
      () => _requestHip3Preview(sequence, amount),
    );
  }

  Future<void> _requestHip3Preview(int sequence, String amount) async {
    try {
      final preview = await ref
          .read(hip3WithdrawalCommandsProvider)
          .preview(amount);
      if (!mounted || sequence != _withdrawalPreviewSequence) return;
      setState(() {
        _withdrawalPreview = preview;
        _withdrawalPreviewing = false;
        _error = hip3WithdrawalBlockerMessage(
          preview,
          AppLocalizations.of(context),
        );
      });
    } catch (error) {
      if (!mounted || sequence != _withdrawalPreviewSequence) return;
      setState(() {
        _withdrawalPreviewing = false;
        _error = error is ApiFailure
            ? apiFailureMessage(
                error,
                fallback: AppLocalizations.of(context).transferFailed,
              )
            : AppLocalizations.of(context).transferFailed;
      });
    }
  }

  Future<void> _requestQuote() async {
    if (!_sendFromSpot) return;
    final allocations = _allocations;
    if (allocations.isEmpty) return;
    final amount = allocations.values
        .map(double.parse)
        .fold<double>(0, (sum, value) => sum + value);
    final sequence = ++_quoteSequence;
    setState(() {
      _quoting = true;
      _error = null;
    });
    try {
      final quote = await ref
          .read(fundingTransferCommandsProvider)
          .quoteTransfer(
            destination: 'hip3_margin',
            amount: amount.toString(),
            allocations: allocations,
          );
      if (!mounted || sequence != _quoteSequence) return;
      setState(() {
        _quote = quote;
        _applySessionStatus(quote);
      });
      _scheduleQuoteRefresh(quote, sequence);
    } catch (error) {
      if (!mounted || sequence != _quoteSequence) return;
      setState(() {
        _quote = null;
        _error = error is ApiFailure
            ? apiFailureMessage(error, fallback: 'Unable to get a quote.')
            : 'Unable to get a quote.';
      });
    } finally {
      if (mounted && sequence == _quoteSequence) {
        setState(() => _quoting = false);
      }
    }
  }

  void _scheduleQuoteRefresh(FundingSessionSummary quote, int sequence) {
    _quoteRefresh?.cancel();
    if (quote.status == 'funded' ||
        quote.status == 'expired' ||
        quote.status == 'cancelled') {
      return;
    }
    _quoteRefresh = Timer(
      const Duration(seconds: 5),
      () => _refreshQuote(quote.sessionId, sequence),
    );
  }

  Future<void> _refreshQuote(String sessionId, int sequence) async {
    if (!mounted ||
        sequence != _quoteSequence ||
        _allocations.isEmpty ||
        _submitting) {
      return;
    }
    try {
      final quote = await ref
          .read(fundingTransferCommandsProvider)
          .refreshTransferQuote(sessionId);
      if (!mounted || sequence != _quoteSequence) return;
      setState(() {
        _quote = quote;
        _applySessionStatus(quote);
      });
      _scheduleQuoteRefresh(quote, sequence);
    } catch (_) {
      if (!mounted || sequence != _quoteSequence) return;
      // Keep the last usable quote visible and retry the refresh. A transfer
      // still requires the server to accept the session version.
      final current = _quote;
      if (current != null) _scheduleQuoteRefresh(current, sequence);
    }
  }

  Future<void> _submit() async {
    if (!_sendFromSpot) {
      await _submitHip3Withdrawal();
      return;
    }
    final l10n = AppLocalizations.of(context);
    final allocations = _allocations;
    if (allocations.isEmpty) {
      setState(() => _error = l10n.transferEnterPositiveAmount);
      return;
    }
    final currentQuote = _quote;
    if (currentQuote == null || _quoting) {
      setState(() => _error = l10n.transferWaitForQuote);
      return;
    }
    if (currentQuote.status == 'funded') {
      setState(() => _applySessionStatus(currentQuote));
      return;
    }
    if (currentQuote.status == 'transferring') {
      setState(() => _applySessionStatus(currentQuote));
      return;
    }
    if (!currentQuote.canConfirmTransfer) {
      setState(() => _error = l10n.transferQuoteNotReady);
      return;
    }
    setState(() {
      _submitting = true;
      _error = null;
      _statusMessage = null;
    });
    _quoteRefresh?.cancel();
    final submitSequence = ++_quoteSequence;
    try {
      final commands = ref.read(fundingTransferCommandsProvider);
      final quote = await commands.refreshTransferQuote(currentQuote.sessionId);
      if (!mounted || submitSequence != _quoteSequence) return;
      setState(() {
        _quote = quote;
        _applySessionStatus(quote);
      });
      if (quote.status == 'funded') return;
      if (quote.status == 'transferring') {
        return;
      }
      if (!quote.canConfirmTransfer) {
        throw StateError(l10n.transferQuoteChanged);
      }
      final plan = await commands.planForSession(quote);
      await _advancePlan(plan);
    } catch (error) {
      if (!mounted) return;
      setState(() {
        _error = switch (error) {
          ApiFailure failure => apiFailureMessage(
            failure,
            fallback: l10n.transferStartFailed,
          ),
          StateError stateError => stateError.message.toString(),
          _ => l10n.transferStartFailed,
        };
        _statusMessage = null;
        _transferPending = false;
      });
    } finally {
      if (mounted) {
        setState(() => _submitting = false);
        final latestQuote = _quote;
        if (latestQuote != null && submitSequence == _quoteSequence) {
          _scheduleQuoteRefresh(latestQuote, submitSequence);
        }
      }
    }
  }

  Future<void> _submitHip3Withdrawal() async {
    final l10n = AppLocalizations.of(context);
    final amount = _withdrawalAmount.text.trim();
    try {
      final parsed = DecimalValue(amount);
      if (parsed.scale > 6 || parsed.compareTo(DecimalValue('0')) <= 0) {
        throw const FormatException('Invalid USDC amount');
      }
    } on FormatException {
      setState(() => _error = l10n.transferEnterPositiveAmount);
      return;
    }
    setState(() {
      _submitting = true;
      _error = null;
    });
    try {
      final commands = ref.read(hip3WithdrawalCommandsProvider);
      final preview = _withdrawalPreview;
      if (preview == null || preview.amount != amount || !preview.canProceed) {
        throw StateError(AppLocalizations.of(context).transferWaitForQuote);
      }
      final prepared = await commands.prepare(amount, rail: preview.rail);
      if (!mounted) return;
      if (prepared.status != 'awaiting_signature') {
        _handleWithdrawalStatus(prepared);
        return;
      }
      setState(() => _withdrawal = prepared);
      final confirmed = await showDialog<bool>(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(l10n.signAndTransfer),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${l10n.sendAmount}: ${TokenAmountFormatter.formatText(prepared.amount)} USDC',
              ),
              Text(
                '${l10n.totalFee}: ${TokenAmountFormatter.formatText(prepared.fee)} USDC',
              ),
              Text(
                '${l10n.receiveAmount}: ${TokenAmountFormatter.formatText(prepared.minimumReceived)} USDC',
              ),
              Text(l10n.hip3TransferDestination),
              SelectableText(prepared.destinationAddress),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: Text(MaterialLocalizations.of(context).cancelButtonLabel),
            ),
            FilledButton(
              onPressed: () => Navigator.pop(context, true),
              child: Text(l10n.signAndTransfer),
            ),
          ],
        ),
      );
      if (!mounted || confirmed != true) return;
      try {
        final submitted = await commands.submit(prepared);
        if (!mounted) return;
        _handleWithdrawalStatus(submitted);
      } catch (_) {
        // A lost submission response may still mean the venue accepted it.
        try {
          final latest = await commands.refresh(prepared.id);
          if (!mounted) return;
          if (latest.status != 'awaiting_signature') {
            _handleWithdrawalStatus(latest);
            return;
          }
        } catch (_) {
          // Preserve the frozen intent for a later retry.
        }
        rethrow;
      }
    } catch (error) {
      if (!mounted) return;
      setState(() {
        _error = switch (error) {
          ApiFailure failure => apiFailureMessage(
            failure,
            fallback: l10n.transferStartFailed,
          ),
          Hip3SigningFailure failure =>
            failure.reason ??
                switch (failure.code) {
                  Hip3SigningFailureCode.actionExpired =>
                    l10n.hip3SigningRequestExpired,
                  Hip3SigningFailureCode.walletUnavailable =>
                    l10n.hip3SigningWalletUnavailable,
                  Hip3SigningFailureCode.walletMismatch =>
                    l10n.walletConnectRequired,
                  Hip3SigningFailureCode.invalidPayload =>
                    l10n.hip3SigningRequestInvalid,
                  Hip3SigningFailureCode.rejected => l10n.signatureCancelled,
                  Hip3SigningFailureCode.actionNotReady =>
                    l10n.transferStartFailed,
                },
          StateError failure => failure.message.toString(),
          _ => l10n.transferStartFailed,
        };
      });
    } finally {
      if (mounted) setState(() => _submitting = false);
    }
  }

  void _handleWithdrawalStatus(Hip3Withdrawal withdrawal) {
    if (!mounted) return;
    if (withdrawal.status == 'completed') {
      _completeTransfer();
      return;
    }
    setState(() {
      _withdrawal = withdrawal;
      _transferPending = withdrawal.isPending;
      _statusMessage = withdrawal.isPending
          ? AppLocalizations.of(context).transferWaitingArrival
          : null;
      _error = withdrawal.status == 'failed' || withdrawal.status == 'expired'
          ? (withdrawal.failureReason ??
                AppLocalizations.of(context).transferFailed)
          : null;
    });
    if (withdrawal.isPending && _withdrawalRefresh == null) {
      _withdrawalRefresh = Timer.periodic(
        const Duration(seconds: 3),
        (_) => unawaited(_pollWithdrawal()),
      );
    } else if (!withdrawal.isPending) {
      _withdrawalRefresh?.cancel();
      _withdrawalRefresh = null;
    }
  }

  Future<void> _pollWithdrawal() async {
    final id = _withdrawal?.id;
    if (!mounted || id == null || _withdrawalPolling) return;
    _withdrawalPolling = true;
    try {
      final current = await ref
          .read(hip3WithdrawalCommandsProvider)
          .refresh(id);
      _handleWithdrawalStatus(current);
    } on Object {
      // Keep polling authoritative status after transient connectivity errors.
    } finally {
      _withdrawalPolling = false;
    }
  }

  Future<void> _advancePlan(FundingPlan plan) async {
    final commands = ref.read(fundingTransferCommandsProvider);
    var current = plan;
    if (current.status == FundingPlanState.alreadyFunded) {
      _completeTransfer();
      return;
    }
    if (current.isActionable) {
      final authorization = await commands.authorize(current);
      await commands.create(plan: current, authorization: authorization);
      current = await commands.refresh(current.planId);
    }
    if (!mounted) return;
    if (current.status == FundingPlanState.alreadyFunded) {
      _completeTransfer();
      return;
    }
    final pending =
        current.isExecuting ||
        current.isActionable ||
        current.legs.any((leg) => leg.transferId != null);
    setState(() {
      _activePlan = current;
      _transferPending = pending;
      _statusMessage = pending
          ? AppLocalizations.of(context).transferWaitingArrival
          : null;
      if (!pending) _error = _planFailureMessage(current);
    });
    if (pending) _startPlanPolling();
  }

  void _startPlanPolling() {
    if (_planRefresh != null || !_transferPending) return;
    _quoteRefresh?.cancel();
    _planRefresh = Timer.periodic(
      const Duration(seconds: 2),
      (_) => unawaited(_pollPlan()),
    );
    unawaited(_pollPlan());
  }

  Future<void> _pollPlan() async {
    final plan = _activePlan;
    if (!mounted || !_transferPending || _planPolling || plan == null) return;
    _planPolling = true;
    try {
      final refreshed = await ref
          .read(fundingTransferCommandsProvider)
          .reconcile(plan);
      if (!mounted) return;
      if (refreshed.status == FundingPlanState.alreadyFunded) {
        _completeTransfer();
        return;
      }
      final pending =
          refreshed.isExecuting ||
          refreshed.isActionable ||
          refreshed.legs.any((leg) => leg.transferId != null);
      setState(() {
        _activePlan = refreshed;
        _transferPending = pending;
        if (!pending) {
          _statusMessage = null;
          _error = _planFailureMessage(refreshed);
        }
      });
      if (!pending) _stopPlanPolling();
    } on Object catch (error) {
      if (mounted && error is! ApiFailure) {
        setState(() => _error = error.toString());
      }
    } finally {
      _planPolling = false;
    }
  }

  String _planFailureMessage(FundingPlan plan) {
    if (plan.blocker case final blocker? when blocker.isNotEmpty) {
      return blocker;
    }
    final l10n = AppLocalizations.of(context);
    return switch (plan.status) {
      FundingPlanState.manualReview => l10n.transferRequiresManualReview,
      FundingPlanState.failed => l10n.transferFailed,
      FundingPlanState.expired => l10n.transferQuoteExpired,
      FundingPlanState.cancelled => l10n.transferCancelled,
      FundingPlanState.blocked => l10n.transferBlocked,
      _ => l10n.transferStartFailed,
    };
  }

  void _stopPlanPolling() {
    _planRefresh?.cancel();
    _planRefresh = null;
  }

  void _completeTransfer() {
    if (!mounted || _completionToastShown) return;
    _completionToastShown = true;
    _stopPlanPolling();
    _withdrawalRefresh?.cancel();
    ref.invalidate(hip3TransferBalanceProvider);
    ref.invalidate(transferFundingAccountProvider);
    ref.invalidate(transferOptionsProvider);
    AppToast.showSuccess(
      context,
      AppLocalizations.of(context).transferCompleted,
    );
    Navigator.of(context).maybePop();
  }

  void _applySessionStatus(FundingSessionSummary session) {
    switch (session.status) {
      case 'transferring':
        _transferPending = true;
        _statusMessage = AppLocalizations.of(context).transferInProgress;
        _error = null;
      case 'funded':
        _transferPending = false;
        _statusMessage = null;
        _error = null;
        WidgetsBinding.instance.addPostFrameCallback(
          (_) => _completeTransfer(),
        );
      default:
        if (!_submitting) {
          _transferPending = false;
          _statusMessage = null;
        }
    }
  }

  @override
  void dispose() {
    _quoteDebounce?.cancel();
    _quoteRefresh?.cancel();
    _planRefresh?.cancel();
    _withdrawalRefresh?.cancel();
    _withdrawalPreviewDebounce?.cancel();
    _withdrawalAmount.dispose();
    for (final controller in _amounts.values) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppRwaColors>()!;
    final options = ref.watch(transferOptionsProvider);
    final hip3Balance = _sendFromSpot
        ? null
        : ref.watch(hip3TransferBalanceProvider);
    final l10n = AppLocalizations.of(context);
    final send = _sendFromSpot ? l10n.spot : l10n.perps;
    final receive = _sendFromSpot ? l10n.perps : l10n.spot;
    final canSubmit =
        !_submitting &&
        !_transferPending &&
        (_sendFromSpot
            ? !_quoting &&
                  _allocations.isNotEmpty &&
                  _quote?.canConfirmTransfer == true &&
                  _quote?.status != 'transferring' &&
                  _quote?.status != 'funded'
            : _withdrawalAmount.text.trim().isNotEmpty &&
                  !_withdrawalPreviewing &&
                  _withdrawalPreview?.canProceed == true &&
                  _withdrawalPreview?.amount == _withdrawalAmount.text.trim());

    return PopScope(
      canPop: !_submitting,
      child: Scaffold(
        backgroundColor: colors.canvas,
        body: SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) => SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(20, 18, 20, 20),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: constraints.maxHeight - 38,
                ),
                child: IntrinsicHeight(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      AppPageHeader(title: l10n.transfer),
                      const SizedBox(height: 16),
                      TransferAccountPair(
                        send: send,
                        receive: receive,
                        sendIsSpot: _sendFromSpot,
                        onSwap: _submitting || _transferPending
                            ? null
                            : _swapAccounts,
                      ),
                      if (_sendFromSpot) ...[
                        const SizedBox(height: 16),
                        _SectionLabel(l10n.sendAmount),
                        options.when(
                          data: (value) {
                            final positions = value.account.positions
                                .where((position) => position.eligible)
                                .toList(growable: false);
                            for (final position in positions) {
                              _amounts.putIfAbsent(position.positionId, () {
                                final controller = TextEditingController();
                                controller.addListener(_scheduleQuote);
                                return controller;
                              });
                            }
                            return _SendAmountCard(
                              positions: positions,
                              controllers: _amounts,
                            );
                          },
                          loading: () => const _TransferSkeleton(height: 216),
                          error: (error, _) => _LoadError(
                            error: error,
                            onRetry: () {
                              ref.invalidate(transferFundingAccountProvider);
                              ref.invalidate(fundingCatalogProvider);
                              ref.invalidate(transferOptionsProvider);
                            },
                          ),
                        ),
                        const SizedBox(height: 16),
                        _SectionLabel(l10n.receiveAmount),
                        options.when(
                          data: (value) {
                            final target = value.catalog?.transferTarget;
                            final asset = _quote?.targetToken ?? target?.token;
                            final network =
                                _quote?.targetNetwork ?? target?.network;
                            return _ReceiveAmountCard(
                              asset: asset ?? '-',
                              network: network ?? '-',
                              value: _quoting
                                  ? '...'
                                  : _quote?.minimumReceived ?? '',
                            );
                          },
                          loading: () => const _TransferSkeleton(height: 59),
                          error: (_, _) => const _ReceiveAmountCard(
                            asset: '-',
                            network: '-',
                            value: '',
                          ),
                        ),
                        const SizedBox(height: 16),
                        _FeeSummary(
                          quote: _quote,
                          loading: _quoting || options.isLoading,
                        ),
                      ] else ...[
                        const SizedBox(height: 16),
                        _SectionLabel(l10n.sendAmount),
                        _Hip3SendAmountCard(
                          controller: _withdrawalAmount,
                          balance: hip3Balance?.value,
                          onChanged: _scheduleHip3Preview,
                        ),
                        if (hip3Balance?.hasError ?? false)
                          _LoadError(
                            error: hip3Balance!.error!,
                            onRetry: () =>
                                ref.invalidate(hip3TransferBalanceProvider),
                          ),
                        const SizedBox(height: 16),
                        _SectionLabel(l10n.receiveAmount),
                        _ReceiveAmountCard(
                          asset: 'USDC',
                          network: 'Arbitrum',
                          value: _withdrawalPreviewing
                              ? '...'
                              : _withdrawalPreview?.minimumReceived ??
                                    _withdrawal?.minimumReceived ??
                                    '',
                        ),
                        const SizedBox(height: 16),
                        _Hip3FeeSummary(
                          preview: _withdrawalPreview,
                          withdrawal: _withdrawal,
                        ),
                        if (_withdrawalPreview
                                ?.crossLiquidationImpacts
                                .isNotEmpty ==
                            true) ...[
                          const SizedBox(height: 12),
                          Hip3CrossLiquidationImpactsCard(
                            impacts:
                                _withdrawalPreview!.crossLiquidationImpacts,
                          ),
                        ],
                      ],
                      if (_statusMessage case final message?) ...[
                        const SizedBox(height: 8),
                        Text(
                          message,
                          style: TextStyle(
                            color: Theme.of(context)
                                .extension<AppSemanticColors>()!
                                .success,
                          ),
                        ),
                      ],
                      if (_transferPending) ...[
                        const SizedBox(height: 12),
                        OutlinedButton(
                          key: const Key('transfer-close-view-later'),
                          onPressed: () =>
                              context.goNamed(AppRoutes.activityName),
                          child: Text(l10n.closeViewLater),
                        ),
                      ],
                      const Spacer(),
                      if (_error case final error?) ...[
                        const SizedBox(height: 28),
                        InlineErrorNotice(
                          key: const Key('transfer-error'),
                          message: error,
                        ),
                        const SizedBox(height: 8),
                      ] else
                        const SizedBox(height: 28),
                      SizedBox(
                        height: 48,
                        child: FilledButton(
                          onPressed: canSubmit ? _submit : null,
                          child: _submitting
                              ? const SizedBox.square(
                                  dimension: 20,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                  ),
                                )
                              : Text(
                                  _transferPending
                                      ? l10n.transferInProgress
                                      : l10n.signAndTransfer,
                                ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _SectionLabel extends StatelessWidget {
  const _SectionLabel(this.label);

  final String label;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.only(bottom: 8),
    child: Text(
      label,
      style: Theme.of(context).textTheme.bodyMedium
          ?.copyWith(fontWeight: FontWeight.w500),
    ),
  );
}

class _LoadError extends StatelessWidget {
  const _LoadError({required this.error, required this.onRetry});
  final Object error;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) => SizedBox(
    height: 96,
    child: Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            error is ApiFailure
                ? apiFailureMessage(
                    error as ApiFailure,
                    fallback: AppLocalizations.of(context)
                        .transferOptionsLoadFailed,
                  )
                : AppLocalizations.of(context).transferOptionsLoadFailed,
          ),
          TextButton.icon(
            onPressed: onRetry,
            icon: const Icon(Icons.refresh),
            label: Text(AppLocalizations.of(context).retry),
          ),
        ],
      ),
    ),
  );
}

class _TransferSkeleton extends StatelessWidget {
  const _TransferSkeleton({required this.height});

  final double height;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppRwaColors>()!;
    final compact = height < 80;
    return Semantics(
      label: AppLocalizations.of(context).loadingTransferDetails,
      child: Shimmer.fromColors(
        baseColor: colors.subtleSurface,
        highlightColor: colors.surface,
        child: Container(
          key: const Key('transfer-loading-skeleton'),
          height: height,
          padding: EdgeInsets.symmetric(
            horizontal: 16,
            vertical: compact ? 10 : 16,
          ),
          decoration: BoxDecoration(
            color: colors.surface,
            border: Border.all(color: colors.border),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              for (
                var index = 0;
                index < math.max(1, (height / 58).floor());
                index++
              )
                Row(
                  children: [
                    _SkeletonBlock(
                      width: compact ? 24 : 28,
                      height: compact ? 24 : 28,
                      circular: true,
                    ),
                    const SizedBox(width: 8),
                    const Expanded(child: _SkeletonBlock(height: 14)),
                    const SizedBox(width: 24),
                    _SkeletonBlock(
                      width: height > 80 ? 88 : 56,
                      height: height > 80 ? 32 : 14,
                    ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SkeletonBlock extends StatelessWidget {
  const _SkeletonBlock({
    this.width,
    required this.height,
    this.circular = false,
  });

  final double? width;
  final double height;
  final bool circular;

  @override
  Widget build(BuildContext context) => Container(
    width: width,
    height: height,
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(circular ? height / 2 : 6),
    ),
  );
}

class _SendAmountCard extends StatefulWidget {
  const _SendAmountCard({required this.positions, required this.controllers});

  final List<FundingSourcePosition> positions;
  final Map<String, TextEditingController> controllers;

  @override
  State<_SendAmountCard> createState() => _SendAmountCardState();

  static String _assetPath(String token) => switch (token.toUpperCase()) {
    'USDT' => 'assets/figma/funding/usdt.png',
    'ETH' => 'assets/figma/funding/eth.svg',
    _ => 'assets/figma/funding/usdc.svg',
  };
}

class _SendAmountCardState extends State<_SendAmountCard> {
  final _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppRwaColors>()!;
    return DecoratedBox(
      decoration: BoxDecoration(
        color: colors.surface,
        border: Border.all(color: colors.border),
        borderRadius: BorderRadius.circular(12),
      ),
      child: widget.positions.isEmpty
          ? Padding(
              padding: const EdgeInsets.all(16),
              child: Text(AppLocalizations.of(context).noEligibleFundingAssets),
            )
          : SizedBox(
              key: const Key('send-token-list'),
              height: math.min(72 + (widget.positions.length - 1) * 69, 279),
              child: RawScrollbar(
                controller: _scrollController,
                thumbVisibility: widget.positions.length > 4,
                radius: const Radius.circular(3),
                thickness: 4,
                child: ListView.builder(
                  controller: _scrollController,
                  padding: EdgeInsets.zero,
                  itemCount: widget.positions.length,
                  itemBuilder: (context, index) {
                    final position = widget.positions[index];
                    return _AssetAmountRow(
                      asset: position.token,
                      network: position.network,
                      available: position.availableAmount.value,
                      assetPath: _SendAmountCard._assetPath(position.token),
                      controller: widget.controllers[position.positionId]!,
                      isFirst: index == 0,
                    );
                  },
                ),
              ),
            ),
    );
  }
}

class _AssetAmountRow extends StatelessWidget {
  const _AssetAmountRow({
    required this.asset,
    required this.network,
    required this.available,
    required this.assetPath,
    required this.controller,
    required this.isFirst,
  });

  final String asset;
  final String network;
  final String available;
  final String assetPath;
  final TextEditingController controller;
  final bool isFirst;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppRwaColors>()!;
    return ConstrainedBox(
      constraints: BoxConstraints(minHeight: isFirst ? 72 : 69),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: [
            assetPath.endsWith('.svg')
                ? SvgPicture.asset(assetPath, width: 28, height: 28)
                : Image.asset(assetPath, width: 28, height: 28),
            const SizedBox(width: 4),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        asset,
                        style: const TextStyle(
                          fontSize: 13,
                          height: 18 / 13,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(width: 4),
                      Flexible(
                        child: Text(
                          '($network)',
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 11,
                            height: 14 / 11,
                            color: colors.secondaryText,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    AppLocalizations.of(context).availableAmount(
                      TokenAmountFormatter.formatText(available),
                    ),
                    style: TextStyle(
                      fontSize: 11,
                      height: 14 / 11,
                      color: colors.secondaryText,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            SizedBox(
              width: 88,
              height: 32,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: colors.subtleSurface,
                  border: Border.all(color: colors.border),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: TextField(
                  controller: controller,
                  textAlign: TextAlign.right,
                  textAlignVertical: TextAlignVertical.center,
                  keyboardType: const TextInputType.numberWithOptions(
                    decimal: true,
                  ),
                  style: TextStyle(
                    fontSize: 15,
                    height: 22 / 15,
                    fontWeight: FontWeight.w600,
                    color: colors.primaryText,
                  ),
                  decoration: const InputDecoration(
                    isDense: true,
                    filled: false,
                    border: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    contentPadding: EdgeInsets.only(
                      left: 12,
                      right: 16,
                      top: 5,
                      bottom: 5,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Hip3SendAmountCard extends StatelessWidget {
  const _Hip3SendAmountCard({
    required this.controller,
    required this.balance,
    required this.onChanged,
  });

  final TextEditingController controller;
  final String? balance;
  final VoidCallback onChanged;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppRwaColors>()!;
    return Container(
      height: 72,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: colors.surface,
        border: Border.all(color: colors.border),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          SvgPicture.asset(
            'assets/figma/funding/usdc.svg',
            width: 28,
            height: 28,
          ),
          const SizedBox(width: 4),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'USDC (Arbitrum)',
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 4),
                Text(
                  AppLocalizations.of(context).availableAmount(
                    balance == null
                        ? '-'
                        : TokenAmountFormatter.formatText(balance!),
                  ),
                  style: TextStyle(fontSize: 11, color: colors.secondaryText),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          SizedBox(
            width: 88,
            height: 32,
            child: TextField(
              key: const Key('hip3-transfer-amount'),
              controller: controller,
              onChanged: (_) => onChanged(),
              textAlign: TextAlign.right,
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              decoration: InputDecoration(
                isDense: true,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 5,
                ),
                filled: true,
                fillColor: colors.subtleSurface,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _Hip3FeeSummary extends StatelessWidget {
  const _Hip3FeeSummary({this.preview, this.withdrawal});

  final Hip3WithdrawalPreview? preview;
  final Hip3Withdrawal? withdrawal;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppRwaColors>()!;
    final feeValue = preview?.fee ?? withdrawal?.fee;
    final fee = feeValue == null
        ? '-'
        : '${TokenAmountFormatter.formatText(feeValue)} USDC';
    final details = preview?.feeDetails ?? const <Hip3WithdrawalFeeDetail>[];
    final withdrawalFee = _formatDetail(
      details,
      type: 'withdrawal',
      payer: 'user',
    );
    final networkFee = _formatDetail(details, type: 'network', payer: 'user');
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: colors.subtleSurface,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          _FeeRow(
            AppLocalizations.of(context).estimateTime,
            _formatEta(preview?.estimatedArrivalSeconds),
          ),
          const SizedBox(height: 8),
          _FeeRow(AppLocalizations.of(context).bridgeFee, withdrawalFee),
          const SizedBox(height: 8),
          _FeeRow(AppLocalizations.of(context).networkFee, networkFee),
          const SizedBox(height: 8),
          _FeeRow(AppLocalizations.of(context).totalFee, fee),
        ],
      ),
    );
  }

  static String _formatEta(int? seconds) {
    if (seconds == null) return '-';
    if (seconds < 60) return '${seconds}s';
    return '~${(seconds / 60).ceil()}min';
  }

  static String _formatDetail(
    List<Hip3WithdrawalFeeDetail> details, {
    required String type,
    required String payer,
  }) {
    for (final detail in details) {
      if (detail.type == type && detail.payer == payer) {
        final amount = detail.amount;
        if (amount == null) return '-';
        return '${TokenAmountFormatter.formatText(amount)} ${detail.currency}';
      }
    }
    return '-';
  }
}

class _ReceiveAmountCard extends StatelessWidget {
  const _ReceiveAmountCard({
    required this.asset,
    required this.network,
    required this.value,
  });

  final String asset;
  final String network;
  final String value;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppRwaColors>()!;
    return Container(
      height: 59,
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 12),
      decoration: BoxDecoration(
        color: colors.surface,
        border: Border.all(color: colors.border),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          if (_SendAmountCard._assetPath(asset).endsWith('.svg'))
            SvgPicture.asset(
              _SendAmountCard._assetPath(asset),
              width: 28,
              height: 28,
            )
          else
            Image.asset(
              _SendAmountCard._assetPath(asset),
              width: 28,
              height: 28,
            ),
          const SizedBox(width: 4),
          Text(
            asset,
            style: TextStyle(
              fontSize: 13,
              height: 18 / 13,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(width: 4),
          Expanded(
            child: Text(
              '($network)',
              style: TextStyle(
                fontSize: 11,
                height: 14 / 11,
                color: colors.secondaryText,
              ),
            ),
          ),
          AnimatedNumberText(
            TokenAmountFormatter.formatText(value),
            key: const Key('transfer-receive-amount-value'),
            style: const TextStyle(
              fontSize: 15,
              height: 22 / 15,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

class _FeeSummary extends StatelessWidget {
  const _FeeSummary({required this.quote, required this.loading});

  final FundingSessionSummary? quote;
  final bool loading;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppRwaColors>()!;
    if (loading) return const _TransferSkeleton(height: 116);
    final fees = quote?.fees;
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: colors.subtleSurface,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          _FeeRow(
            AppLocalizations.of(context).estimateTime,
            _formatEta(quote?.etaSeconds),
          ),
          const SizedBox(height: 8),
          _FeeRow(
            AppLocalizations.of(context).bridgeFee,
            _formatFee(fees?.bridgeFee, fees?.asset),
            valueKey: const Key('transfer-bridge-fee-value'),
            comparisonValue: fees?.bridgeFee,
          ),
          const SizedBox(height: 8),
          _FeeRow(
            AppLocalizations.of(context).networkFee,
            _formatFee(fees?.networkFee, fees?.asset),
            valueKey: const Key('transfer-network-fee-value'),
            comparisonValue: fees?.networkFee,
          ),
          const SizedBox(height: 8),
          _FeeRow(
            AppLocalizations.of(context).totalFee,
            _formatFee(fees?.totalFee, fees?.asset),
            valueKey: const Key('transfer-total-fee-value'),
            comparisonValue: fees?.totalFee,
          ),
        ],
      ),
    );
  }

  static String _formatEta(int? seconds) {
    if (seconds == null) return '-';
    if (seconds < 60) return '${seconds}s';
    final minutes = (seconds / 60).ceil();
    return '~${minutes}min';
  }

  static String _formatFee(String? amount, String? asset) {
    if (amount == null || asset == null) return '-';
    return '${TokenAmountFormatter.formatText(amount)} $asset';
  }
}

class _FeeRow extends StatelessWidget {
  const _FeeRow(this.label, this.value, {this.valueKey, this.comparisonValue});

  final String label;
  final String value;
  final Key? valueKey;
  final String? comparisonValue;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppRwaColors>()!;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 13,
            height: 18 / 13,
            fontWeight: FontWeight.w500,
            color: colors.secondaryText,
          ),
        ),
        valueKey == null
            ? Text(
                value,
                style: const TextStyle(
                  fontSize: 13,
                  height: 18 / 13,
                  fontWeight: FontWeight.w600,
                ),
              )
            : AnimatedNumberText(
                value,
                key: valueKey,
                comparisonValue: comparisonValue,
                style: const TextStyle(
                  fontSize: 13,
                  height: 18 / 13,
                  fontWeight: FontWeight.w600,
                ),
              ),
      ],
    );
  }
}

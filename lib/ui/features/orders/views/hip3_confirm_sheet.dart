import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../app/providers/api_providers.dart';
import '../../../../app/providers/observability_providers.dart';
import '../../../../app/providers/session_scope.dart';
import '../../../../domain/models/api_failure.dart';
import '../../../../domain/models/order.dart';
import '../../../../domain/models/order_intent.dart';
import '../../../../domain/models/order_preview.dart';
import '../../../../domain/repositories/hip3_order_execution_repository.dart';
import '../../../../domain/services/hip3_typed_data_signer.dart';
import '../../../../l10n/generated/app_localizations.dart';
import '../../../core/theme/app_theme.dart';
import '../../../../domain/models/decimal_value.dart';
import '../providers/order_providers.dart';
import 'hip3_order_messages.dart';
import 'slippage_controls.dart';

/// Confirmation step for a HIP-3 order, shown as its own modal sheet.
///
/// Dismissing the sheet returns to the order form, which is why the design has
/// no back control: the frozen quote is reviewed here and nowhere else.
class Hip3ConfirmSheet extends ConsumerStatefulWidget {
  const Hip3ConfirmSheet({super.key, required this.preview});

  final OrderPreview preview;

  @override
  ConsumerState<Hip3ConfirmSheet> createState() => _Hip3ConfirmSheetState();
}

class _Hip3ConfirmSheetState extends ConsumerState<Hip3ConfirmSheet> {
  var _submitting = false;
  var _refreshing = false;
  String? _error;
  String? _pendingOrderId;
  Timer? _expiry;
  late OrderPreview _preview = widget.preview;

  @override
  void initState() {
    super.initState();
    _armExpiry();
  }

  @override
  void dispose() {
    _expiry?.cancel();
    super.dispose();
  }

  /// A lapsed quote is re-requested rather than reported: the terms are the
  /// server's to refresh, and there is nothing for the trader to act on.
  void _armExpiry() {
    _expiry?.cancel();
    if (_pendingOrderId != null) return;
    final remaining = _preview.expiresAt?.difference(DateTime.now().toUtc());
    if (remaining != null && !remaining.isNegative) {
      _expiry = Timer(remaining, () => unawaited(_refreshQuote()));
      return;
    }
    // Already stale. Defer so the first call can come from initState without
    // calling setState before this State is mounted.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) unawaited(_refreshQuote());
    });
  }

  Future<void> _refreshQuote({OrderIntent? intent}) async {
    if (_refreshing || _submitting || !mounted) return;
    final target = intent ?? _preview.intent;
    final generation = ref.read(sessionGenerationProvider);
    // A re-quote must not erase why the last submission failed: the trader
    // still has to read it. Only pressing confirm again clears it.
    setState(() => _refreshing = true);
    try {
      // The family provider caches by intent, so the stale quote has to be
      // dropped before a new one can be requested for the same order.
      ref.invalidate(orderPreviewProvider(target));
      final next = await ref.read(orderPreviewProvider(target).future);
      if (!mounted || ref.read(sessionGenerationProvider) != generation) return;
      setState(() => _preview = next);
      _armExpiry();
    } on Object catch (error, stackTrace) {
      ref
          .read(observabilityReporterProvider)
          .recordError(
            operation: 'hip3.order.confirm.requote',
            error: error,
            stackTrace: stackTrace,
          );
      if (!mounted) return;
      setState(() => _error = hip3ErrorMessage(context, error));
    } finally {
      if (mounted) setState(() => _refreshing = false);
    }
  }

  /// The tolerance shown is the server's until the trader overrides it; an
  /// override only takes effect through a fresh quote.
  Future<void> _editSlippage(Hip3PreviewExecution execution) async {
    if (_refreshing || _submitting) return;
    final current =
        double.tryParse(execution.slippagePercent.value) ??
        double.tryParse(_preview.intent.slippage?.value ?? '') ??
        0;
    final next = await showModalBottomSheet<double>(
      context: context,
      isScrollControlled: true,
      builder: (_) => SlippageSheet(
        initialValue: current,
        inputKey: const Key('hip3-slippage-input'),
      ),
    );
    if (next == null || !mounted || next == current) return;
    await _refreshQuote(
      intent: _preview.intent.withSlippage(
        DecimalValue(next.toString(), unit: 'percent'),
      ),
    );
  }

  /// A quote past its window is refreshed, never reported.
  bool get _quoteStale =>
      _pendingOrderId == null &&
      (_preview.expiresAt == null || _preview.isExpired);

  /// Why the frozen quote can no longer be submitted, as a ready-to-show
  /// message. The quote can expire while this sheet is open.
  String? _unusableReason() {
    if (_pendingOrderId != null) return null;
    final l10n = AppLocalizations.of(context);
    if (_preview.hip3Execution == null) {
      return l10n.hip3ExecutionDetailsUnavailable;
    }
    if (!_preview.openingProtectionMatchesIntent) {
      return l10n.protectionConfirmationMismatch;
    }
    return null;
  }

  Future<void> _submit() async {
    final generation = ref.read(sessionGenerationProvider);
    bool isCurrent() =>
        mounted && ref.read(sessionGenerationProvider) == generation;
    // Pressing confirm is the only thing that clears a previous failure, so it
    // happens before any of the paths that can bail out below.
    setState(() => _error = null);
    if (_unusableReason() case final reason?) {
      setState(() => _error = reason);
      return;
    }
    if (_quoteStale) {
      await _refreshQuote();
      return;
    }
    setState(() => _submitting = true);
    try {
      var submitted = _pendingOrderId != null
          ? await ref
                .read(hip3OrderExecutionRepositoryProvider)
                .awaitActionAndSubmit(_pendingOrderId!)
          : await ref
                .read(orderCommandProvider.notifier)
                .submit(_preview.intent, previewId: _preview.previewId);
      if (!isCurrent()) return;
      if (submitted?.resource.status == TradingOrderStatus.pendingSignature) {
        _pendingOrderId = submitted!.resource.orderId;
        submitted = await ref
            .read(hip3OrderExecutionRepositoryProvider)
            .awaitActionAndSubmit(_pendingOrderId!);
      }
      if (!isCurrent()) return;
      ref.invalidate(hip3OrdersProvider);
      if (submitted == null) {
        setState(
          () => _error = 'The server did not return a submitted HIP-3 order.',
        );
        return;
      }
      if (!mounted) return;
      Navigator.of(context).pop(submitted.resource);
      return;
    } on Hip3ExecutionPending catch (pending) {
      if (!isCurrent()) return;
      setState(() {
        _pendingOrderId = pending.orderId;
        _error = pending.requiresReview
            ? AppLocalizations.of(context).hip3OrderNeedsReview
            : AppLocalizations.of(context).hip3OrderConfirming;
      });
    } on Hip3SigningFailure catch (failure) {
      if (!isCurrent()) return;
      setState(() => _error = hip3SigningError(context, failure));
    } on ApiFailure catch (failure) {
      if (!isCurrent()) return;
      setState(() => _error = hip3ErrorMessage(context, failure));
    } on Object catch (error, stackTrace) {
      ref
          .read(observabilityReporterProvider)
          .recordError(
            operation: 'hip3.order.submit',
            error: error,
            stackTrace: stackTrace,
          );
      if (!isCurrent()) return;
      setState(() => _error = hip3ErrorMessage(context, error));
    } finally {
      if (mounted) setState(() => _submitting = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final colors = Theme.of(context).extension<AppRwaColors>()!;
    final semantic = Theme.of(context).extension<AppSemanticColors>()!;
    final execution = _preview.hip3Execution;
    final isLong = _preview.intent.side == TradingSide.long;
    final direction = isLong ? l10n.long : l10n.short;
    final actionColor = isLong ? semantic.success : semantic.loss;
    final unusable = _unusableReason();
    final message = _error ?? unusable;
    final busy = _submitting || _refreshing;
    return Material(
      color: colors.surface,
      borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 32,
                  height: 4,
                  decoration: BoxDecoration(
                    color: colors.secondaryText.withValues(alpha: 0.45),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                '$direction ${_preview.intent.symbol}',
                style: TextStyle(
                  fontSize: 20,
                  height: 26 / 20,
                  fontWeight: FontWeight.w600,
                  letterSpacing: -0.2,
                  color: colors.primaryText,
                ),
              ),
              const SizedBox(height: 16),
              Container(height: 1, color: colors.subtleSurface),
              const SizedBox(height: 16),
              if (execution != null) ...[
                Text(
                  '$direction ${_preview.intent.symbol} · '
                  '${execution.type == TradingOrderType.market ? l10n.market : l10n.limit}',
                  style: TextStyle(
                    fontSize: 13,
                    height: 18 / 13,
                    fontWeight: FontWeight.w500,
                    color: colors.primaryText,
                  ),
                ),
                const SizedBox(height: 8),
                _SizeCard(execution: execution),
                const SizedBox(height: 16),
                Flexible(
                  child: SingleChildScrollView(
                    child: _Terms(
                      preview: _preview,
                      execution: execution,
                      onEditSlippage: busy
                          ? null
                          : () => unawaited(_editSlippage(execution)),
                    ),
                  ),
                ),
              ],
              if (message != null) ...[
                const SizedBox(height: 16),
                _FailureNotice(
                  key: const Key('hip3-confirm-error'),
                  message: message,
                ),
              ],
              const SizedBox(height: 28),
              SizedBox(
                width: double.infinity,
                height: 48,
                child: FilledButton(
                  key: const Key('hip3-confirm-button'),
                  style: FilledButton.styleFrom(
                    backgroundColor: actionColor,
                    disabledBackgroundColor: colors.subtleSurface,
                    disabledForegroundColor: colors.tertiaryText,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  onPressed: busy || unusable != null ? null : _submit,
                  child: busy
                      ? const SizedBox(
                          key: Key('hip3-confirm-busy'),
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : Text(
                          l10n.hip3SignAndConfirm(direction),
                          style: const TextStyle(
                            fontSize: 15,
                            height: 22 / 15,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SizeCard extends StatelessWidget {
  const _SizeCard({required this.execution});

  final Hip3PreviewExecution execution;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final colors = Theme.of(context).extension<AppRwaColors>()!;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colors.canvas,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        children: [
          Text(
            l10n.orderSizeLabel,
            style: TextStyle(
              fontSize: 12,
              height: 16 / 12,
              fontWeight: FontWeight.w600,
              color: colors.primaryText,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            '${execution.notional.value} USDC',
            style: TextStyle(
              fontSize: 20,
              height: 26 / 20,
              fontWeight: FontWeight.w600,
              letterSpacing: -0.2,
              color: colors.primaryText,
            ),
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            decoration: BoxDecoration(
              color: colors.surface,
              borderRadius: BorderRadius.circular(999),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                SvgPicture.asset(
                  'assets/figma/trade/order_margin.svg',
                  width: 12,
                  height: 12,
                ),
                const SizedBox(width: 4),
                Text(
                  l10n.hip3MarginChip('${execution.marginRequired.value} USDC'),
                  style: TextStyle(
                    fontSize: 11,
                    height: 14 / 11,
                    color: colors.secondaryText,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _Terms extends StatelessWidget {
  const _Terms({
    required this.preview,
    required this.execution,
    required this.onEditSlippage,
  });

  final OrderPreview preview;
  final Hip3PreviewExecution execution;
  final VoidCallback? onEditSlippage;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    // The entry is the price the frozen terms will execute against; the market
    // price row shows the move since the quote was taken, when there was one.
    final entry = preview.estimatedPrice ?? execution.limitPrice;
    final marketPrice = preview.marketPrice;
    final protection = execution.openingProtection;
    final takeProfit = protection?.legs
        .where((leg) => leg.takeProfit)
        .firstOrNull;
    final stopLoss = protection?.legs
        .where((leg) => !leg.takeProfit)
        .firstOrNull;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _TermRow(label: l10n.entryPrice, value: '\$${entry.value}'),
        if (marketPrice != null)
          _TermRow(
            label: l10n.marketPrice,
            value: '\$${marketPrice.value}',
            // A quote taken before the market moved shows both prices.
            leadingValue:
                preview.priceUpdated && entry.value != marketPrice.value
                ? '\$${entry.value}→'
                : null,
          ),
        _TermRow(
          label: l10n.leverage,
          value:
              '${execution.leverage.value}x・'
              '${execution.marginMode == TradingMarginMode.cross ? l10n.cross : l10n.isolated}',
        ),
        _TermRow(
          key: const Key('hip3-slippage-row'),
          label: l10n.slippage,
          value: '${execution.slippagePercent.value}%',
          icon: 'assets/figma/trade/order_slippage_edit.svg',
          onTap: onEditSlippage,
        ),
        _TermRow(
          label: l10n.estimatedFee,
          value: '${execution.estimatedFee.value} USDC',
        ),
        _TermRow(
          label: l10n.liquidationPrice,
          value: execution.liquidationPrice == null
              ? l10n.unavailable
              : '\$${execution.liquidationPrice!.value}',
        ),
        _TermRow(
          label: '${l10n.takeProfit}/${l10n.stopLoss}',
          value: takeProfit == null && stopLoss == null
              ? '—'
              : '${takeProfit == null ? '—' : '\$${takeProfit.triggerPrice.value}'}'
                    '/'
                    '${stopLoss == null ? '—' : '\$${stopLoss.triggerPrice.value}'}',
        ),
      ],
    );
  }
}

class _TermRow extends StatelessWidget {
  const _TermRow({
    super.key,
    required this.label,
    required this.value,
    this.leadingValue,
    this.icon,
    this.onTap,
  });

  final String label;
  final String value;
  final String? leadingValue;
  final String? icon;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppRwaColors>()!;
    final row = Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        // Two flex children only, so the leftover width lands between them and
        // the value reaches the right edge. A third child (or an Expanded
        // sharing the row) would split that space instead.
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: Padding(
              padding: const EdgeInsets.only(right: 16),
              child: Text(
                label,
                style: TextStyle(
                  fontSize: 13,
                  height: 18 / 13,
                  fontWeight: FontWeight.w500,
                  color: colors.secondaryText,
                ),
              ),
            ),
          ),
          // The icon belongs to the value, so the pair travels to the right
          // edge together instead of leaving a gap between them.
          Flexible(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                if (icon case final path?) ...[
                  SvgPicture.asset(path, width: 12, height: 12),
                  const SizedBox(width: 4),
                ],
                Flexible(
                  child: Text.rich(
                    TextSpan(
                      children: [
                        if (leadingValue case final leading?)
                          TextSpan(
                            text: leading,
                            style: TextStyle(color: colors.secondaryText),
                          ),
                        TextSpan(text: value),
                      ],
                    ),
                    textAlign: TextAlign.end,
                    style: TextStyle(
                      fontSize: 13,
                      height: 18 / 13,
                      fontWeight: FontWeight.w600,
                      color: colors.primaryText,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
    return onTap == null ? row : InkWell(onTap: onTap, child: row);
  }
}

class _FailureNotice extends StatelessWidget {
  const _FailureNotice({super.key, required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    final semantic = Theme.of(context).extension<AppSemanticColors>()!;
    return Semantics(
      liveRegion: true,
      label: message,
      child: Container(
        width: double.infinity,
        constraints: const BoxConstraints(minHeight: 40),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        decoration: BoxDecoration(
          color: const Color(0xFFFFEEF0),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(
          message,
          style: TextStyle(color: semantic.loss, fontSize: 12),
        ),
      ),
    );
  }
}

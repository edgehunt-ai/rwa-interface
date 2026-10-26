import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nobell/ui/core/widgets/venue_icon.dart';

import '../../../../domain/models/api_failure.dart';
import '../../../../domain/models/decimal_value.dart';
import '../../../../domain/models/hip3_action_pending.dart';
import '../../../../domain/models/order_intent.dart';
import '../../../../domain/models/position.dart';
import '../../../../domain/models/position_close_preview.dart';
import '../../../../domain/models/position_operation.dart';
import '../../../../domain/services/hip3_typed_data_signer.dart';
import '../../../../l10n/generated/app_localizations.dart';
import '../../../core/feedback/app_toast.dart';
import '../../../core/feedback/inline_error_notice.dart';
import '../../../core/feedback/loading_skeleton.dart';
import '../../../core/formatters/decimal_text_input_formatter.dart';
import '../../../core/formatters/token_amount_formatter.dart';
import '../../../core/theme/app_theme.dart';
import '../../positions/providers/position_providers.dart';
import 'hip3_segmented_control.dart';
import '../../../core/feedback/error_message.dart' as feedback;

/// Closes only the selected HIP-3 position using a reduce-only order.
class Hip3ClosePositionSheet extends ConsumerStatefulWidget {
  const Hip3ClosePositionSheet({super.key, required this.position});

  final Position position;

  @override
  ConsumerState<Hip3ClosePositionSheet> createState() => _CloseState();
}

class _CloseState extends ConsumerState<Hip3ClosePositionSheet> {
  final _quantity = TextEditingController();
  final _limitPrice = TextEditingController();
  late Position _position;
  TradingOrderType _type = TradingOrderType.market;
  double _percent = 0;
  bool _busy = false;
  bool _pending = false;
  String? _error;

  bool _hasValidInputs(int? sizeDecimals) {
    if (sizeDecimals == null) return false;
    try {
      requireWithinPosition(
        _quantity.text.trim(),
        _position.quantity.value,
        maxFractionDigits: sizeDecimals,
      );
      if (_type == TradingOrderType.limit) {
        requirePositiveDecimal(_limitPrice.text.trim());
      }
      return true;
    } on FormatException {
      return false;
    } on ArgumentError {
      return false;
    }
  }

  PositionClosePreviewRequest? _previewRequest(int? sizeDecimals) {
    if (!_hasValidInputs(sizeDecimals) ||
        _position.productId == null ||
        _position.side == PositionSide.none) {
      return null;
    }
    return (
      position: _position,
      quantity: _quantity.text.trim(),
      type: _type,
      limitPrice: _type == TradingOrderType.limit
          ? _limitPrice.text.trim()
          : null,
    );
  }

  PositionClosePreview? _usablePreview(
    AsyncValue<PositionClosePreview>? state,
  ) {
    if (state == null || state.hasError) return null;
    final preview = state.value;
    return preview == null || preview.isExpired ? null : preview;
  }

  @override
  void initState() {
    super.initState();
    _position = widget.position;
  }

  @override
  void didUpdateWidget(covariant Hip3ClosePositionSheet oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (!identical(oldWidget.position, widget.position)) {
      _position = widget.position;
      _syncPercentToPosition();
    }
  }

  @override
  void dispose() {
    _quantity.dispose();
    _limitPrice.dispose();
    super.dispose();
  }

  Future<void> _submit(
    PositionClosePreview preview,
    PositionClosePreviewRequest request,
    int sizeDecimals,
  ) async {
    if (_busy ||
        _pending ||
        preview.isExpired ||
        _previewRequest(sizeDecimals) != request) {
      return;
    }
    setState(() {
      _busy = true;
      _error = null;
    });
    try {
      final quantity = _quantity.text.trim();
      requireWithinPosition(
        quantity,
        _position.quantity.value,
        maxFractionDigits: sizeDecimals,
      );
      final limitPrice = _type == TradingOrderType.limit
          ? _limitPrice.text.trim()
          : null;
      if (limitPrice != null) {
        try {
          requirePositiveDecimal(limitPrice);
        } on FormatException {
          throw ArgumentError(AppLocalizations.of(context).validLimitPrice);
        } on ArgumentError {
          throw ArgumentError(AppLocalizations.of(context).validLimitPrice);
        }
      }
      await ref
          .read(positionCommandProvider)
          .close(
            _position.positionId,
            expectedPosition: _position,
            type: _type,
            limitPrice: limitPrice,
            quantity: quantity,
            percent: null,
            preview: preview,
            confirmBeforeSigning: false,
          );
      if (mounted) {
        AppToast.showSuccess(
          context,
          AppLocalizations.of(context).closeOrderSubmitted,
        );
        Navigator.of(context).pop();
      }
    } on Hip3ActionPending catch (error) {
      _pending = true;
      if (mounted) {
        setState(
          () =>
              _error = AppLocalizations.of(context)
                  .closeActionPending(error.actionId),
        );
      }
    } on Object catch (error) {
      final message = _specificErrorMessage(error);
      if (error is ServerFailure || error is FormatException) {
        await _refreshPositionAfterFailure();
      }
      if (mounted) {
        setState(() => _error = message);
      }
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  Future<void> _refreshPositionAfterFailure() async {
    final positionId = _position.positionId;
    ref.invalidate(positionProvider(positionId));
    ref.invalidate(positionsProvider);
    try {
      final refreshed = await ref.read(positionProvider(positionId).future);
      if (!mounted || refreshed.positionId != positionId) return;
      setState(() {
        _position = refreshed;
        _syncPercentToPosition();
      });
    } on Object {
      // Preserve the actionable close error when the reconciliation read fails.
    }
  }

  void _syncPercentToPosition() {
    final quantity = double.tryParse(_quantity.text.trim());
    final available = double.tryParse(
      absoluteQuantity(_position.quantity.value),
    );
    _percent = quantity == null || available == null || available <= 0
        ? 0
        : (quantity / available * 100).clamp(0, 100);
  }

  String _specificErrorMessage(Object error) {
    final l10n = AppLocalizations.of(context);
    if (error is ApiFailure) {
      return apiFailureMessage(error, fallback: l10n.closeFailed);
    }
    if (error is Hip3SigningFailure) {
      final reason = error.reason?.trim();
      if (reason != null && reason.isNotEmpty) return reason;
      return switch (error.code) {
        Hip3SigningFailureCode.walletMismatch => l10n.walletConnectRequired,
        Hip3SigningFailureCode.actionExpired => l10n.hip3SigningRequestExpired,
        Hip3SigningFailureCode.rejected => l10n.signatureCancelled,
        Hip3SigningFailureCode.actionNotReady => l10n.hip3OrderStillPreparing,
        Hip3SigningFailureCode.walletUnavailable =>
          l10n.hip3SigningWalletUnavailable,
        Hip3SigningFailureCode.invalidPayload => l10n.hip3SigningRequestInvalid,
      };
    }
    if (error is ArgumentError) {
      final message = error.message?.toString().trim();
      return message == null || message.isEmpty ? l10n.closeFailed : message;
    }
    if (error is FormatException) {
      final message = error.message.trim();
      return message.isEmpty ? l10n.closeRetry : message;
    }
    final message = error.toString().trim();
    if (message.isNotEmpty &&
        message != 'null' &&
        !message.startsWith('Instance of ')) {
      return message;
    }
    return l10n.closeFailed;
  }

  void _setPercent(double value, int sizeDecimals) {
    setState(() {
      _error = null;
      _percent = value;
      _quantity.text = _trimDecimal(
        percentageQuantity(
          _position.quantity.value,
          value.round().toString(),
          maxFractionDigits: sizeDecimals,
        ),
      );
    });
  }

  void _setQuantity(String value) {
    final quantity = double.tryParse(value);
    final available = double.tryParse(
      absoluteQuantity(_position.quantity.value),
    );
    setState(() {
      _error = null;
      _percent = quantity == null || available == null || available <= 0
          ? 0
          : (quantity / available * 100).clamp(0, 100);
    });
  }

  @override
  Widget build(BuildContext context) {
    ref.watch(positionCommandProvider);
    final position = _position;
    final productId = position.productId;
    final sizeDecimalsState = productId == null
        ? null
        : ref.watch(positionSizeDecimalsProvider(productId));
    if (productId != null) {
      ref.listen(positionSizeDecimalsProvider(productId), (_, next) {
        next.whenData((decimals) {
          final truncated = truncateQuantity(_quantity.text, decimals);
          if (truncated == _quantity.text) return;
          setState(() {
            _quantity.text = truncated;
            _syncPercentToPosition();
          });
        });
      });
    }
    final sizeDecimals = sizeDecimalsState?.hasError == true
        ? null
        : sizeDecimalsState?.value;
    final locked = _busy || _pending;
    final l10n = AppLocalizations.of(context);
    final previewRequest = _previewRequest(sizeDecimals);
    final previewState = previewRequest == null
        ? null
        : ref.watch(positionClosePreviewProvider(previewRequest));
    final preview = _usablePreview(previewState);
    final previewLoading = preview == null && previewState?.isLoading == true;
    final previewError = previewState?.hasError == true
        ? previewState!.error
        : null;
    final errorMessage =
        _error ??
        (productId == null || sizeDecimalsState?.hasError == true
            ? l10n.hip3TradingContextUnavailable
            : null) ??
        (previewError == null
            ? null
            : feedback.errorMessage(
                previewError,
                fallback: l10n.closePreviewUnavailable,
              ));
    final colors = Theme.of(context).extension<AppRwaColors>()!;
    final semantic = Theme.of(context).extension<AppSemanticColors>()!;
    final side = switch (position.side) {
      PositionSide.long => l10n.long,
      PositionSide.short => l10n.short,
      PositionSide.none => '—',
    };
    final pnl = preview?.estimatedRealizedPnl;
    final pnlColor = pnl == null
        ? colors.textPrimary
        : pnl.value.startsWith('-')
        ? semantic.danger
        : semantic.success;
    final productSource = position.productId
        ?.split(':')
        .first
        .trim()
        .toUpperCase();

    return Material(
      color: colors.surfaceBase,
      borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
      child: SafeArea(
        top: false,
        child: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(
            20,
            12,
            20,
            24 + MediaQuery.viewInsetsOf(context).bottom,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Center(
                child: Container(
                  width: 32,
                  height: 4,
                  decoration: BoxDecoration(
                    color: colors.textSecondary.withValues(alpha: 0.45),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      l10n.closePosition,
                      style: const TextStyle(
                        fontSize: 20,
                        height: 26 / 20,
                        fontWeight: FontWeight.w600,
                        letterSpacing: -0.2,
                      ),
                    ),
                  ),
                  _CloseTag(
                    label: 'HIP-3 Perps',
                    leading: VenueIcon(
                      'assets/figma/home_markets/venue_hyperliquid.svg',
                      width: 14,
                      height: 14,
                      fit: BoxFit.contain,
                    ),
                  ),
                  if (productSource != null && productSource.isNotEmpty) ...[
                    const SizedBox(width: 4),
                    _CloseTag(label: productSource),
                  ],
                ],
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Flexible(
                          child: Text(
                            '$side ${position.symbol}',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 17,
                              height: 26 / 17,
                              fontWeight: FontWeight.w600,
                              letterSpacing: -0.2,
                            ),
                          ),
                        ),
                        const SizedBox(width: 4),
                        _CloseTag(
                          label: position.leverage == null
                              ? '—'
                              : '${TokenAmountFormatter.formatValue(position.leverage!)}×',
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 8),
                  Hip3SegmentedControl<TradingOrderType>(
                    key: const Key('close-order-type-tabs'),
                    width: 151,
                    values: const [
                      TradingOrderType.market,
                      TradingOrderType.limit,
                    ],
                    selected: _type,
                    selectedColor: colors.surfaceBase,
                    selectedForeground: colors.textPrimary,
                    label: (value) => value == TradingOrderType.market
                        ? l10n.market
                        : l10n.limit,
                    onChanged: locked
                        ? null
                        : (value) => setState(() {
                            _type = value;
                            _error = null;
                          }),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              if (_type == TradingOrderType.limit) ...[
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  decoration: BoxDecoration(
                    color: colors.surfaceSubtle,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        l10n.price,
                        style: TextStyle(
                          fontSize: 11,
                          height: 14 / 11,
                          color: colors.textSecondary,
                        ),
                      ),
                      const SizedBox(height: 6),
                      TextField(
                        key: const Key('close-limit-price'),
                        controller: _limitPrice,
                        enabled: !locked,
                        onChanged: (_) => setState(() => _error = null),
                        keyboardType: const TextInputType.numberWithOptions(
                          decimal: true,
                        ),
                        style: TextStyle(
                          fontSize: 15,
                          height: 22 / 15,
                          fontWeight: FontWeight.w600,
                          color: colors.textPrimary,
                        ),
                        decoration: InputDecoration(
                          hintText: '0.0',
                          hintStyle: TextStyle(color: colors.textTertiary),
                          suffixText: 'USDC',
                          suffixStyle: TextStyle(
                            fontSize: 15,
                            height: 22 / 15,
                            fontWeight: FontWeight.w600,
                            color: colors.textPrimary,
                          ),
                          isDense: true,
                          filled: false,
                          contentPadding: EdgeInsets.zero,
                          border: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          disabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
              ],
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                decoration: BoxDecoration(
                  color: colors.surfaceSubtle,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          l10n.closeAmount,
                          style: TextStyle(
                            fontSize: 11,
                            height: 14 / 11,
                            color: colors.textSecondary,
                          ),
                        ),
                        const Spacer(),
                        Text(
                          '${l10n.balance}: ${TokenAmountFormatter.formatValue(DecimalValue(absoluteQuantity(position.quantity.value)))}',
                          style: const TextStyle(
                            fontSize: 12,
                            height: 16 / 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    TextField(
                      key: const Key('close-quantity'),
                      controller: _quantity,
                      enabled: !locked,
                      keyboardType: const TextInputType.numberWithOptions(
                        decimal: true,
                      ),
                      inputFormatters: sizeDecimals == null
                          ? null
                          : [
                              DecimalTextInputFormatter(
                                maxFractionDigits: sizeDecimals,
                              ),
                            ],
                      onChanged: _setQuantity,
                      style: TextStyle(
                        fontSize: 20,
                        height: 26 / 20,
                        fontWeight: FontWeight.w600,
                        letterSpacing: -0.2,
                        color: colors.textPrimary,
                      ),
                      decoration: InputDecoration(
                        hintText: '0.0',
                        hintStyle: TextStyle(color: colors.textTertiary),
                        suffixText: position.symbol,
                        suffixStyle: TextStyle(
                          fontSize: 15,
                          height: 22 / 15,
                          fontWeight: FontWeight.w600,
                          color: colors.textPrimary,
                        ),
                        isDense: true,
                        filled: false,
                        contentPadding: EdgeInsets.zero,
                        border: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                      ),
                    ),
                    const SizedBox(height: 8),
                    _ClosePercentageSlider(
                      value: _percent,
                      enabled: !locked && sizeDecimals != null,
                      onChanged: (value) => _setPercent(value, sizeDecimals!),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Divider(color: colors.surfaceSubtle),
              const SizedBox(height: 12),
              _CloseSummaryRow(
                label: l10n.value,
                value: _formatUsd(preview?.notional),
                loading: previewLoading,
              ),
              _CloseSummaryRow(
                label: l10n.entryPrice,
                value: _formatUsd(preview?.entryPrice),
                loading: previewLoading,
              ),
              _CloseSummaryRow(
                label: l10n.marketPrice,
                value: _formatUsd(preview?.markPrice),
                loading: previewLoading,
              ),
              _CloseSummaryRow(
                label: l10n.liquidationPrice,
                value: _formatUsd(preview?.liquidationPrice),
                loading: previewLoading,
              ),
              _CloseSummaryRow(
                label: l10n.estimatedClosePnl,
                value: _formatSignedUsd(pnl),
                valueColor: pnlColor,
                loading: previewLoading,
              ),
              const SizedBox(height: 8),
              if (errorMessage != null) ...[
                InlineErrorNotice(
                  key: const Key('close-error'),
                  message: errorMessage,
                ),
                const SizedBox(height: 8),
              ],
              Row(
                children: [
                  Expanded(
                    flex: 160,
                    child: OutlinedButton(
                      onPressed: locked
                          ? null
                          : () => Navigator.of(context).pop(),
                      style: OutlinedButton.styleFrom(
                        minimumSize: const Size(0, 48),
                        backgroundColor: colors.surfaceSubtle,
                      ),
                      child: Text(l10n.back),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    flex: 181,
                    child: FilledButton(
                      key: const Key('close-review'),
                      onPressed:
                          locked ||
                              !_hasValidInputs(sizeDecimals) ||
                              preview == null ||
                              position.productId == null ||
                              position.side == PositionSide.none
                          ? null
                          : () => _submit(
                              preview,
                              previewRequest!,
                              sizeDecimals!,
                            ),
                      child: _busy
                          ? const SizedBox.square(
                              dimension: 18,
                              child: CircularProgressIndicator(strokeWidth: 2),
                            )
                          : Text(l10n.signAndConfirm),
                    ),
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

String _trimDecimal(String value) {
  if (!value.contains('.')) return value;
  return value
      .replaceFirst(RegExp(r'0+$'), '')
      .replaceFirst(RegExp(r'\.$'), '');
}

class _CloseTag extends StatelessWidget {
  const _CloseTag({required this.label, this.leading});

  final String label;
  final Widget? leading;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppRwaColors>()!;
    return Container(
      height: 22,
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: colors.surfaceSubtle,
        border: Border.all(color: colors.borderSubtle),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (leading != null) ...[leading!, const SizedBox(width: 2)],
          Text(label, style: const TextStyle(fontSize: 12, height: 16 / 12)),
        ],
      ),
    );
  }
}

class _ClosePercentageSlider extends StatelessWidget {
  const _ClosePercentageSlider({
    required this.value,
    required this.enabled,
    required this.onChanged,
  });

  final double value;
  final bool enabled;
  final ValueChanged<double> onChanged;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppRwaColors>()!;
    return LayoutBuilder(
      builder: (context, constraints) {
        const badgeWidth = 42.0;
        final badgeLeft = ((constraints.maxWidth - badgeWidth) * (value / 100))
            .clamp(0, constraints.maxWidth - badgeWidth)
            .toDouble();
        return SizedBox(
          height: 24,
          child: Stack(
            alignment: Alignment.center,
            children: [
              SliderTheme(
                data: SliderTheme.of(context).copyWith(
                  activeTrackColor: colors.actionPrimary,
                  inactiveTrackColor: colors.surfaceBase,
                  disabledActiveTrackColor: colors.textTertiary,
                  disabledInactiveTrackColor: colors.surfaceBase,
                  trackHeight: 8,
                  thumbColor: colors.actionPrimary,
                  thumbShape: const RoundSliderThumbShape(
                    enabledThumbRadius: 0,
                  ),
                  overlayShape: SliderComponentShape.noOverlay,
                ),
                child: Slider(
                  key: const Key('close-percentage-slider'),
                  value: value,
                  max: 100,
                  divisions: 100,
                  onChanged: enabled ? onChanged : null,
                ),
              ),
              for (final stop in const [25.0, 50.0, 75.0])
                Positioned(
                  left: (constraints.maxWidth - 6) * (stop / 100),
                  child: IgnorePointer(
                    child: Container(
                      width: 6,
                      height: 6,
                      decoration: BoxDecoration(
                        color: colors.surfaceSubtle,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                ),
              Positioned(
                left: badgeLeft,
                child: IgnorePointer(
                  child: Container(
                    width: badgeWidth,
                    height: 18,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: colors.actionPrimary,
                      border: Border.all(color: colors.surfaceBase, width: 2),
                      borderRadius: BorderRadius.circular(9),
                    ),
                    child: Text(
                      '${value.round()}%',
                      style: TextStyle(
                        fontSize: 12,
                        height: 16 / 12,
                        fontWeight: FontWeight.w600,
                        color: colors.textInverse,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _CloseSummaryRow extends StatelessWidget {
  const _CloseSummaryRow({
    required this.label,
    required this.value,
    this.valueColor,
    this.loading = false,
  });

  final String label;
  final String value;
  final Color? valueColor;
  final bool loading;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppRwaColors>()!;
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Expanded(
            child: Text(
              label,
              style: TextStyle(
                fontSize: 13,
                height: 18 / 13,
                fontWeight: FontWeight.w500,
                color: colors.textSecondary,
              ),
            ),
          ),
          if (loading)
            Semantics(
              label: AppLocalizations.of(context).loadingLabel,
              child: const SizedBox(
                height: 18,
                child: Center(
                  child: SkeletonBlock(
                    key: Key('close-preview-loading'),
                    width: 72,
                    height: 14,
                    radius: 4,
                  ),
                ),
              ),
            )
          else
            Text(
              value,
              textAlign: TextAlign.end,
              style: TextStyle(
                fontSize: 13,
                height: 18 / 13,
                fontWeight: FontWeight.w600,
                color: valueColor,
              ),
            ),
        ],
      ),
    );
  }
}

String _formatUsd(DecimalValue? value) =>
    value == null ? '—' : TokenAmountFormatter.formatUsd(value);

String _formatSignedUsd(DecimalValue? value) {
  if (value == null) return '—';
  final negative = value.value.startsWith('-');
  final unsigned = negative ? value.value.substring(1) : value.value;
  final formatted = TokenAmountFormatter.formatUsd(DecimalValue(unsigned));
  return '${negative ? '-' : '+'}$formatted';
}

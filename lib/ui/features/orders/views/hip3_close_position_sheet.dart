import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../domain/models/decimal_value.dart';
import '../../../../domain/models/hip3_action_pending.dart';
import '../../../../domain/models/order_intent.dart';
import '../../../../domain/models/position.dart';
import '../../../../domain/models/position_operation.dart';
import '../../../../l10n/generated/app_localizations.dart';
import '../../../core/feedback/app_toast.dart';
import '../../../core/formatters/token_amount_formatter.dart';
import '../../../core/theme/app_theme.dart';
import '../../positions/providers/position_providers.dart';

/// Closes only the selected HIP-3 position using a market order.
class Hip3ClosePositionSheet extends ConsumerStatefulWidget {
  const Hip3ClosePositionSheet({super.key, required this.position});

  final Position position;

  @override
  ConsumerState<Hip3ClosePositionSheet> createState() => _CloseState();
}

class _CloseState extends ConsumerState<Hip3ClosePositionSheet> {
  final _quantity = TextEditingController(text: '0');
  double _percent = 0;
  bool _busy = false;
  bool _pending = false;
  String? _error;

  @override
  void dispose() {
    _quantity.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (_busy || _pending) return;
    setState(() {
      _busy = true;
      _error = null;
    });
    try {
      final quantity = _quantity.text.trim();
      requireWithinPosition(quantity, widget.position.quantity.value);
      await ref
          .read(positionCommandProvider)
          .close(
            widget.position.positionId,
            expectedPosition: widget.position,
            type: TradingOrderType.market,
            quantity: quantity,
            percent: null,
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
    } on ArgumentError catch (error) {
      if (mounted) setState(() => _error = '${error.message}');
    } on FormatException {
      if (mounted) {
        setState(() => _error = AppLocalizations.of(context).closeRetry);
      }
    } on Object {
      if (mounted) {
        setState(() => _error = AppLocalizations.of(context).closeFailed);
      }
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  void _setPercent(double value) {
    setState(() {
      _percent = value;
      _quantity.text = _trimDecimal(
        percentageQuantity(
          widget.position.quantity.value,
          value.round().toString(),
        ),
      );
    });
  }

  void _setQuantity(String value) {
    final quantity = double.tryParse(value);
    final available = double.tryParse(
      absoluteQuantity(widget.position.quantity.value),
    );
    setState(() {
      _percent = quantity == null || available == null || available <= 0
          ? 0
          : (quantity / available * 100).clamp(0, 100);
    });
  }

  @override
  Widget build(BuildContext context) {
    ref.watch(positionCommandProvider);
    final position = widget.position;
    final locked = _busy || _pending;
    final l10n = AppLocalizations.of(context);
    final colors = Theme.of(context).extension<AppRwaColors>()!;
    final semantic = Theme.of(context).extension<AppSemanticColors>()!;
    final side = switch (position.side) {
      PositionSide.long => l10n.long,
      PositionSide.short => l10n.short,
      PositionSide.none => '—',
    };
    final pnl = position.unrealizedPnl;
    final pnlColor = pnl == null
        ? colors.primaryText
        : pnl.value.startsWith('-')
        ? semantic.loss
        : semantic.success;
    final productSource = position.productId
        ?.split(':')
        .first
        .trim()
        .toUpperCase();

    return Material(
      color: colors.surface,
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
                    color: colors.secondaryText.withValues(alpha: 0.45),
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
                    leading: SvgPicture.asset(
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
                  Text(
                    l10n.market,
                    style: TextStyle(
                      fontSize: 13,
                      height: 18 / 13,
                      fontWeight: FontWeight.w600,
                      color: colors.secondaryText,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.fromLTRB(16, 12, 16, 10),
                decoration: BoxDecoration(
                  color: colors.subtleSurface,
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
                            color: colors.secondaryText,
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
                      onChanged: _setQuantity,
                      style: TextStyle(
                        fontSize: 20,
                        height: 26 / 20,
                        fontWeight: FontWeight.w600,
                        letterSpacing: -0.2,
                        color: colors.primaryText,
                      ),
                      decoration: InputDecoration(
                        hintText: '0.0',
                        hintStyle: TextStyle(color: colors.tertiaryText),
                        suffixText: position.symbol,
                        suffixStyle: TextStyle(
                          fontSize: 15,
                          height: 22 / 15,
                          fontWeight: FontWeight.w600,
                          color: colors.primaryText,
                        ),
                        filled: true,
                        fillColor: colors.surface,
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 10,
                        ),
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(4)),
                          borderSide: BorderSide.none,
                        ),
                        enabledBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(4)),
                          borderSide: BorderSide.none,
                        ),
                        focusedBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(4)),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    _ClosePercentageSlider(
                      value: _percent,
                      enabled: !locked,
                      onChanged: _setPercent,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Divider(color: colors.subtleSurface),
              const SizedBox(height: 12),
              _CloseSummaryRow(
                label: l10n.value,
                value: _formatUsd(position.valueUsd),
              ),
              _CloseSummaryRow(
                label: l10n.entryPrice,
                value: _formatUsd(position.entryPrice),
              ),
              _CloseSummaryRow(
                label: l10n.marketPrice,
                value: _formatUsd(position.markPrice),
              ),
              _CloseSummaryRow(
                label: 'Liq Price',
                value: _formatUsd(position.liquidationPrice),
              ),
              _CloseSummaryRow(
                label: l10n.unrealizedPnl,
                value: _formatSignedUsd(pnl),
                valueColor: pnlColor,
              ),
              const SizedBox(height: 8),
              if (_error != null)
                Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: Semantics(liveRegion: true, child: Text(_error!)),
                ),
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
                        backgroundColor: colors.subtleSurface,
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
                              position.productId == null ||
                              position.side == PositionSide.none
                          ? null
                          : _submit,
                      child: Text(_busy ? l10n.preparing : l10n.signAndConfirm),
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
        color: colors.subtleSurface,
        border: Border.all(color: colors.border),
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
                  activeTrackColor: colors.primaryAction,
                  inactiveTrackColor: colors.surface,
                  disabledActiveTrackColor: colors.tertiaryText,
                  disabledInactiveTrackColor: colors.surface,
                  trackHeight: 8,
                  thumbColor: colors.primaryAction,
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
                        color: colors.subtleSurface,
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
                      color: colors.primaryAction,
                      border: Border.all(color: colors.surface, width: 2),
                      borderRadius: BorderRadius.circular(9),
                    ),
                    child: Text(
                      '${value.round()}%',
                      style: TextStyle(
                        fontSize: 12,
                        height: 16 / 12,
                        fontWeight: FontWeight.w600,
                        color: colors.onPrimaryAction,
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
  });

  final String label;
  final String value;
  final Color? valueColor;

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
                color: colors.secondaryText,
              ),
            ),
          ),
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

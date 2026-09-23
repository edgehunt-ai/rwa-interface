import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rwa_interface/domain/models/api_failure.dart';
import 'package:rwa_interface/domain/models/position.dart';
import 'package:rwa_interface/domain/models/position_leverage_context.dart';
import 'package:rwa_interface/l10n/generated/app_localizations.dart';
import 'package:rwa_interface/ui/core/theme/app_theme.dart';
import 'package:rwa_interface/ui/core/feedback/app_toast.dart';
import 'package:rwa_interface/ui/features/orders/views/tp_sl_editor_card.dart';
import 'package:rwa_interface/ui/features/positions/providers/position_providers.dart';

class Hip3PositionSettingsSheet extends ConsumerStatefulWidget {
  const Hip3PositionSettingsSheet({super.key, required this.position});

  final Position position;

  @override
  ConsumerState<Hip3PositionSettingsSheet> createState() =>
      _Hip3PositionSettingsSheetState();
}

class _Hip3PositionSettingsSheetState
    extends ConsumerState<Hip3PositionSettingsSheet> {
  int? _leverage;
  var _submitting = false;
  String? _error;

  Future<void> _submit(PositionLeverageContext settings) async {
    final leverage = _leverage;
    if (leverage == null || _submitting) return;
    setState(() => _submitting = true);
    try {
      await ref
          .read(positionCommandProvider)
          .updateLeverage(
            widget.position,
            '$leverage',
            marginMode: settings.marginMode,
          );
      if (mounted) {
        AppToast.showSuccess(
          context,
          AppLocalizations.of(context).leverageUpdated,
        );
        Navigator.of(context).pop();
      }
    } on Object catch (error) {
      if (mounted) {
        setState(() => _error = _errorMessage(error));
      }
    } finally {
      if (mounted) setState(() => _submitting = false);
    }
  }

  String _errorMessage(Object error) {
    if (error is ApiFailure) {
      return apiFailureMessage(
        error,
        fallback: AppLocalizations.of(context).settingsUnavailable,
      );
    }
    if (error is FormatException &&
        error.message.toString().trim().isNotEmpty) {
      return error.message.toString().trim();
    }
    final message = error.toString().trim();
    return message.isEmpty || message == 'null'
        ? AppLocalizations.of(context).settingsUnavailable
        : message;
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppRwaColors>()!;
    final productId = widget.position.productId;
    final state = productId == null
        ? null
        : ref.watch(positionLeverageContextProvider(productId));
    return Material(
      color: colors.surface,
      borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
      child: SafeArea(
        top: false,
        child: state == null
            ? const _SettingsUnavailable()
            : state.when(
                loading: () => const SizedBox(
                  height: 360,
                  child: Center(child: CircularProgressIndicator()),
                ),
                error: (_, _) => const _SettingsUnavailable(),
                data: (settings) => _SettingsContent(
                  settings: settings,
                  position: widget.position,
                  leverage: _leverage,
                  submitting: _submitting,
                  errorMessage: _error,
                  onLeverageChanged: (value) =>
                      setState(() => _leverage = value),
                  onSubmit: () => _submit(settings),
                ),
              ),
      ),
    );
  }
}

class _SettingsContent extends StatelessWidget {
  const _SettingsContent({
    required this.settings,
    required this.position,
    required this.leverage,
    required this.submitting,
    required this.errorMessage,
    required this.onLeverageChanged,
    required this.onSubmit,
  });

  final PositionLeverageContext settings;
  final Position position;
  final int? leverage;
  final bool submitting;
  final String? errorMessage;
  final ValueChanged<int> onLeverageChanged;
  final VoidCallback onSubmit;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppRwaColors>()!;
    final semantic = Theme.of(context).extension<AppSemanticColors>()!;
    final l10n = AppLocalizations.of(context);
    final initial =
        int.tryParse(
          settings.current?.value ?? position.leverage?.value ?? '',
        ) ??
        1;
    final maximum = (int.tryParse(settings.maximum.value) ?? 1).clamp(1, 1000);
    final current = (leverage ?? initial).clamp(1, maximum);
    final options = <int>[
      for (final value in const [2, 5, 10, 20])
        if (value <= maximum) value,
      if (![2, 5, 10, 20].contains(maximum)) maximum,
    ];
    final selectedMode = settings.marginMode ?? position.marginMode;
    final changed = current != initial;

    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              SizedBox(
                width: 20,
                height: 34,
                child: IconButton(
                  tooltip: l10n.back,
                  padding: EdgeInsets.zero,
                  onPressed: () => Navigator.of(context).pop(),
                  icon: const Icon(Icons.chevron_left, size: 20),
                ),
              ),
              const SizedBox(width: 8),
              Text(
                l10n.positionSettingsTitle,
                style: const TextStyle(
                  fontSize: 20,
                  height: 26 / 20,
                  fontWeight: FontWeight.w600,
                  letterSpacing: -0.2,
                ),
              ),
            ],
          ),
          const SizedBox(height: 40),
          Center(
            child: Column(
              children: [
                Text(l10n.leverage, style: const TextStyle(fontSize: 13)),
                const SizedBox(height: 2),
                Text(
                  '${current}x',
                  style: const TextStyle(
                    fontSize: 28,
                    height: 32 / 28,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 28),
          if (maximum > 1)
            TpSlTickRuler(
              semanticLabel: l10n.dragToSetLeverage,
              value: current.toDouble(),
              minimum: 1,
              maximum: maximum.toDouble(),
              divisions: maximum - 1,
              enabled: settings.canChange && !submitting,
              onChanged: (value) => onLeverageChanged(value.round()),
            ),
          if (options.isNotEmpty) ...[
            const SizedBox(height: 20),
            Row(
              children: [
                for (final (index, value) in options.indexed) ...[
                  if (index > 0) const SizedBox(width: 8),
                  Expanded(
                    child: _LeverageOption(
                      value: value,
                      selected: current == value,
                      enabled: settings.canChange && !submitting,
                      onTap: () => onLeverageChanged(value),
                    ),
                  ),
                ],
              ],
            ),
          ],
          const SizedBox(height: 40),
          Text(
            '${l10n.marginMode}:',
            style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 8),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: _MarginModeCard(
                  title: l10n.cross,
                  description: l10n.crossMarginDescription,
                  selected: selectedMode == PositionMarginMode.cross,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _MarginModeCard(
                  title: l10n.isolated,
                  description: l10n.isolatedMarginDescription,
                  selected: selectedMode == PositionMarginMode.isolated,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            l10n.marginModeOpenPositionNotice,
            style: TextStyle(
              fontSize: 11,
              height: 14 / 11,
              color: colors.secondaryText,
            ),
          ),
          const SizedBox(height: 40),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFFFFF7ED),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Text(
              l10n.leverageSharedMarginWarning,
              style: TextStyle(
                fontSize: 13,
                height: 18 / 13,
                fontWeight: FontWeight.w500,
                color: semantic.warning,
              ),
            ),
          ),
          const SizedBox(height: 8),
          if (errorMessage != null) ...[
            _SettingsFailureNotice(message: errorMessage!),
            const SizedBox(height: 8),
          ],
          SizedBox(
            width: double.infinity,
            child: FilledButton(
              onPressed: !settings.canChange || !changed || submitting
                  ? null
                  : onSubmit,
              child: submitting
                  ? const SizedBox(
                      width: 18,
                      height: 18,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : Text(l10n.confirm),
            ),
          ),
        ],
      ),
    );
  }
}

class _SettingsFailureNotice extends StatelessWidget {
  const _SettingsFailureNotice({required this.message});

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

class _LeverageOption extends StatelessWidget {
  const _LeverageOption({
    required this.value,
    required this.selected,
    required this.enabled,
    required this.onTap,
  });

  final int value;
  final bool selected;
  final bool enabled;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppRwaColors>()!;
    return InkWell(
      onTap: enabled ? onTap : null,
      borderRadius: BorderRadius.circular(14),
      child: Container(
        height: 38,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: selected ? colors.selected : colors.subtleSurface,
          borderRadius: BorderRadius.circular(14),
        ),
        child: Text(
          '${value}x',
          style: TextStyle(
            fontSize: 15,
            height: 22 / 15,
            fontWeight: selected ? FontWeight.w600 : FontWeight.w400,
            color: selected ? colors.primaryText : colors.secondaryText,
          ),
        ),
      ),
    );
  }
}

class _MarginModeCard extends StatelessWidget {
  const _MarginModeCard({
    required this.title,
    required this.description,
    required this.selected,
  });

  final String title;
  final String description;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppRwaColors>()!;
    return Opacity(
      opacity: selected ? 1 : .3,
      child: Container(
        height: 88,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: colors.subtleSurface,
          borderRadius: BorderRadius.circular(14),
          border: selected ? Border.all(color: colors.primaryText) : null,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  selected ? Icons.check_circle : Icons.radio_button_unchecked,
                  size: 16,
                  color: selected ? colors.primaryText : colors.secondaryText,
                ),
                const SizedBox(width: 4),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 15,
                    height: 22 / 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              description,
              maxLines: 2,
              style: const TextStyle(fontSize: 12, height: 16 / 12),
            ),
          ],
        ),
      ),
    );
  }
}

class _SettingsUnavailable extends StatelessWidget {
  const _SettingsUnavailable();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 28, 20, 32),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            l10n.positionSettingsTitle,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 16),
          Text(l10n.settingsUnavailable),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../l10n/generated/app_localizations.dart';
import '../../../core/theme/app_theme.dart';

/// Slippage tolerance shared by the bStocks and HIP-3 order forms: the value
/// the trader sets here is what the preview request carries.
class SlippageRow extends StatelessWidget {
  const SlippageRow({
    super.key,
    required this.value,
    required this.onEdit,
    required this.editKey,
  });

  /// Identifies the edit affordance per surface so each panel keeps its own
  /// stable hook.
  final Key editKey;

  final double value;
  final VoidCallback onEdit;

  @override
  Widget build(BuildContext context) {
    const secondaryLabelColor = Color(0xFF676776);
    return Padding(
      padding: EdgeInsets.zero,
      child: Row(
        children: [
          Expanded(
            child: Text(
              AppLocalizations.of(context).slippage,
              style: const TextStyle(color: secondaryLabelColor),
            ),
          ),
          IconButton(
            key: editKey,
            tooltip: AppLocalizations.of(context).editSlippage,
            onPressed: onEdit,
            icon: const Icon(Icons.edit_outlined, size: 16),
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints.tightFor(width: 16, height: 20),
            visualDensity: VisualDensity.compact,
            style: IconButton.styleFrom(
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
          ),
          const SizedBox(width: 1),
          Text('$value%', style: const TextStyle(fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }
}

class SlippageSheet extends StatefulWidget {
  const SlippageSheet({
    super.key,
    required this.initialValue,
    required this.inputKey,
  });

  final Key inputKey;

  final double initialValue;

  @override
  State<SlippageSheet> createState() => _SlippageSheetState();
}

Future<double?> showSlippageSheet({
  required BuildContext context,
  required double initialValue,
  required Key inputKey,
}) => showModalBottomSheet<double>(
  context: context,
  isScrollControlled: true,
  backgroundColor: Colors.transparent,
  barrierColor: Colors.black.withValues(alpha: 0.44),
  builder: (_) => SlippageSheet(initialValue: initialValue, inputKey: inputKey),
);

class _SlippageSheetState extends State<SlippageSheet> {
  static const _presets = [0.1, 0.5, 1.0];

  late final TextEditingController _controller = TextEditingController(
    text: widget.initialValue.toString(),
  );
  String? _error;

  String _presetLabel(double value) => value.toStringAsFixed(1);

  bool _presetSelected(double value) =>
      double.tryParse(_controller.text.trim()) == value;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _confirm() {
    final value = double.tryParse(_controller.text.trim());
    if (value == null || !value.isFinite || value < 0 || value > 100) {
      setState(() => _error = AppLocalizations.of(context).invalidSlippage);
      return;
    }
    Navigator.of(context).pop(value);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final colors = Theme.of(context).extension<AppRwaColors>()!;
    return Material(
      key: const Key('slippage-sheet'),
      color: colors.surface,
      borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
      clipBehavior: Clip.antiAlias,
      child: SafeArea(
        top: false,
        child: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(
            20,
            20,
            20,
            24 + MediaQuery.viewInsetsOf(context).bottom,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 34,
                child: Row(
                  children: [
                    SizedBox(
                      width: 20,
                      height: 34,
                      child: IconButton(
                        key: const Key('slippage-back'),
                        tooltip: l10n.back,
                        padding: EdgeInsets.zero,
                        onPressed: () => Navigator.of(context).pop(),
                        icon: const Icon(Icons.chevron_left, size: 20),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        l10n.slippageTolerance,
                        key: const Key('slippage-sheet-title'),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 20,
                          height: 26 / 20,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Container(
                key: const Key('slippage-input-card'),
                height: 66,
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                decoration: BoxDecoration(
                  color: colors.subtleSurface,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      l10n.maximumSlippage,
                      style: TextStyle(
                        fontSize: 11,
                        height: 14 / 11,
                        color: colors.secondaryText,
                      ),
                    ),
                    const SizedBox(height: 6),
                    SizedBox(
                      height: 22,
                      child: Row(
                        children: [
                          Expanded(
                            child: TextField(
                              key: widget.inputKey,
                              controller: _controller,
                              autofocus: false,
                              keyboardType:
                                  const TextInputType.numberWithOptions(
                                    decimal: true,
                                  ),
                              textInputAction: TextInputAction.done,
                              inputFormatters: [
                                TextInputFormatter.withFunction((
                                  oldValue,
                                  newValue,
                                ) {
                                  return RegExp(
                                        r'^(?:|0|[1-9]\d{0,2})(?:\.\d{0,2})?$',
                                      ).hasMatch(newValue.text)
                                      ? newValue
                                      : oldValue;
                                }),
                              ],
                              style: TextStyle(
                                fontSize: 15,
                                height: 22 / 15,
                                fontWeight: FontWeight.w600,
                                color: colors.primaryText,
                              ),
                              decoration: const InputDecoration(
                                isDense: true,
                                filled: false,
                                contentPadding: EdgeInsets.zero,
                                border: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                focusedBorder: InputBorder.none,
                              ),
                              onChanged: (_) => setState(() => _error = null),
                              onSubmitted: (_) => _confirm(),
                            ),
                          ),
                          Text(
                            '%',
                            style: TextStyle(
                              fontSize: 15,
                              height: 22 / 15,
                              fontWeight: FontWeight.w600,
                              color: colors.secondaryText,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              if (_error case final error?) ...[
                const SizedBox(height: 6),
                Text(
                  error,
                  key: const Key('slippage-error'),
                  style: TextStyle(
                    fontSize: 11,
                    height: 14 / 11,
                    color: Theme.of(context).colorScheme.error,
                  ),
                ),
              ],
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  for (final option in _presets)
                    ChoiceChip(
                      key: ValueKey('slippage-preset-${_presetLabel(option)}'),
                      showCheckmark: false,
                      selected: _presetSelected(option),
                      selectedColor: colors.primaryAction,
                      backgroundColor: colors.surface,
                      side: BorderSide(
                        color: _presetSelected(option)
                            ? colors.primaryAction
                            : colors.border,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                      visualDensity: const VisualDensity(vertical: -1),
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      label: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            _presetLabel(option),
                            style: TextStyle(
                              fontSize: 15,
                              height: 22 / 15,
                              fontWeight: FontWeight.w600,
                              color: _presetSelected(option)
                                  ? colors.onPrimaryAction
                                  : colors.primaryText,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            '%',
                            style: TextStyle(
                              fontSize: 15,
                              height: 22 / 15,
                              fontWeight: FontWeight.w600,
                              color: _presetSelected(option)
                                  ? colors.onPrimaryAction
                                  : colors.secondaryText,
                            ),
                          ),
                        ],
                      ),
                      onSelected: (_) {
                        FocusScope.of(context).unfocus();
                        setState(() {
                          _controller.text = _presetLabel(option);
                          _controller.selection = TextSelection.collapsed(
                            offset: _controller.text.length,
                          );
                          _error = null;
                        });
                      },
                    ),
                ],
              ),
              const SizedBox(height: 28),
              Row(
                children: [
                  Expanded(
                    flex: 160,
                    child: OutlinedButton(
                      key: const Key('slippage-cancel'),
                      style: OutlinedButton.styleFrom(
                        backgroundColor: colors.subtleSurface,
                        side: BorderSide(color: colors.border),
                      ),
                      onPressed: () => Navigator.of(context).pop(),
                      child: Text(l10n.cancel),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    flex: 181,
                    child: FilledButton(
                      key: const Key('slippage-confirm'),
                      onPressed: _confirm,
                      child: Text(l10n.confirm),
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

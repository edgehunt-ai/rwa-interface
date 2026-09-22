import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../core/theme/app_theme.dart';
import '../../../../l10n/generated/app_localizations.dart';

/// Slippage tolerance shared by the bStocks and HIP-3 order forms: the value
/// the trader sets here is what the preview request carries.

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
    final colors = Theme.of(context).extension<AppRwaColors>()!;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Expanded(
            child: Text(
              AppLocalizations.of(context).slippage,
              style: TextStyle(color: colors.secondaryText),
            ),
          ),
          Text('$value%', style: const TextStyle(fontWeight: FontWeight.w600)),
          const SizedBox(width: 2),
          IconButton(
            key: editKey,
            tooltip: AppLocalizations.of(context).editSlippage,
            onPressed: onEdit,
            icon: const Icon(Icons.edit_outlined, size: 16),
            visualDensity: VisualDensity.compact,
          ),
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

class _SlippageSheetState extends State<SlippageSheet> {
  late final TextEditingController _controller = TextEditingController(
    text: widget.initialValue.toString(),
  );
  String? _error;

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
  Widget build(BuildContext context) => Material(
    borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
    child: SafeArea(
      top: false,
      child: Padding(
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
            Text(
              AppLocalizations.of(context).slippageTolerance,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            TextField(
              key: widget.inputKey,
              controller: _controller,
              autofocus: true,
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              inputFormatters: [
                TextInputFormatter.withFunction((oldValue, newValue) {
                  return RegExp(r'^(?:|0|[1-9]\d{0,2})(?:\.\d{0,2})?$')
                          .hasMatch(newValue.text)
                      ? newValue
                      : oldValue;
                }),
              ],
              decoration: InputDecoration(
                labelText: AppLocalizations.of(context).maximumSlippage,
                suffixText: '%',
                errorText: _error,
              ),
              onChanged: (_) {
                if (_error != null) setState(() => _error = null);
              },
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              children: [
                for (final option in const [0.1, 0.5, 1.0])
                  ChoiceChip(
                    label: Text('$option%'),
                    selected: _controller.text == option.toString(),
                    onSelected: (_) => setState(() {
                      _controller.text = option.toString();
                      _error = null;
                    }),
                  ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: Text(AppLocalizations.of(context).cancel),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: FilledButton(
                    onPressed: _confirm,
                    child: Text(AppLocalizations.of(context).confirm),
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

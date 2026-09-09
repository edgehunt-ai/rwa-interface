part of 'trade_screen.dart';

class PositionTpSlSheet extends ConsumerStatefulWidget {
  const PositionTpSlSheet({super.key, required this.position});

  final Position position;

  @override
  ConsumerState<PositionTpSlSheet> createState() => _PositionTpSlSheetState();
}

class _PositionTpSlSheetState extends ConsumerState<PositionTpSlSheet> {
  late final TextEditingController _takeProfit;
  late final TextEditingController _stopLoss;
  var _takeProfitEnabled = true;
  var _stopLossEnabled = true;
  var _submitting = false;
  String? _error;

  @override
  void initState() {
    super.initState();
    _takeProfit = TextEditingController(
      text: widget.position.takeProfitPrice?.value ?? '',
    );
    _stopLoss = TextEditingController(
      text: widget.position.stopLossPrice?.value ?? '',
    );
  }

  @override
  void dispose() {
    _takeProfit.dispose();
    _stopLoss.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    setState(() {
      _error = null;
      _submitting = true;
    });
    try {
      await ref
          .read(positionCommandProvider)
          .updateTpSl(
            widget.position,
            takeProfit: !_takeProfitEnabled || _takeProfit.text.trim().isEmpty
                ? null
                : _takeProfit.text.trim(),
            stopLoss: !_stopLossEnabled || _stopLoss.text.trim().isEmpty
                ? null
                : _stopLoss.text.trim(),
          );
      if (mounted) Navigator.of(context).pop();
    } on Object {
      if (mounted) {
        setState(() => _error = AppLocalizations.of(context).tpSlSaveFailed);
      }
    } finally {
      if (mounted) setState(() => _submitting = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Material(
      borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 24),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    IconButton(
                      tooltip: l10n.back,
                      onPressed: () => Navigator.of(context).pop(),
                      icon: const Icon(Icons.chevron_left),
                    ),
                    Expanded(
                      child: Text(
                        l10n.takeProfitStopLoss,
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Text('${widget.position.symbol}/USDT · Buy'),
                const SizedBox(height: 16),
                _TpSlRiskControl(
                  title: l10n.takeProfit,
                  controller: _takeProfit,
                  enabled: _takeProfitEnabled,
                  onEnabledChanged: (value) =>
                      setState(() => _takeProfitEnabled = value),
                ),
                const SizedBox(height: 12),
                _TpSlRiskControl(
                  title: l10n.stopLoss,
                  controller: _stopLoss,
                  enabled: _stopLossEnabled,
                  onEnabledChanged: (value) =>
                      setState(() => _stopLossEnabled = value),
                ),
                const SizedBox(height: 12),
                _TpSlQuantity(symbol: widget.position.symbol),
                if (_error case final error?) ...[
                  const SizedBox(height: 12),
                  Text(error),
                ],
                const SizedBox(height: 20),
                Row(
                  children: [
                    SizedBox(
                      width: 160,
                      child: OutlinedButton(
                        onPressed: _submitting
                            ? null
                            : () => Navigator.of(context).pop(),
                        child: Text(l10n.back),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: FilledButton(
                        onPressed: _submitting ? null : _save,
                        child: Text(
                          _submitting ? l10n.loadingLabel : l10n.confirm,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _TpSlQuantity extends StatelessWidget {
  const _TpSlQuantity({required this.symbol});

  final String symbol;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppRwaColors>()!;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
      decoration: BoxDecoration(
        color: colors.subtleSurface,
        border: Border.all(color: colors.border),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  'Quantity',
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                    color: colors.tertiaryText,
                  ),
                ),
              ),
              Text(
                symbol,
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w600,
                  color: colors.primaryText,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          const Slider(value: 0.2, onChanged: null),
        ],
      ),
    );
  }
}

class _TpSlRiskControl extends StatelessWidget {
  const _TpSlRiskControl({
    required this.title,
    required this.controller,
    required this.enabled,
    required this.onEnabledChanged,
  });

  final String title;
  final TextEditingController controller;
  final bool enabled;
  final ValueChanged<bool> onEnabledChanged;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppRwaColors>()!;
    return Semantics(
      container: true,
      label: title,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          border: Border.all(color: colors.border),
          borderRadius: BorderRadius.circular(14),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    title,
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                ),
                Switch(value: enabled, onChanged: onEnabledChanged),
              ],
            ),
            const Divider(height: 24),
            TextField(
              controller: controller,
              enabled: enabled,
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              decoration: InputDecoration(
                labelText: AppLocalizations.of(context).price,
                prefixText: r'$ ',
              ),
            ),
            const SizedBox(height: 8),
            Semantics(
              label: '$title ${AppLocalizations.of(context).dragToSet}',
              child: Slider(value: 0.5, onChanged: enabled ? (_) {} : null),
            ),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text('Drag to set', style: TextStyle(fontSize: 12)),
            ),
          ],
        ),
      ),
    );
  }
}

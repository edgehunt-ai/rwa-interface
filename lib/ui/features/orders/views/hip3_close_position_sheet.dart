import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../domain/models/hip3_action_pending.dart';
import '../../../../domain/models/order_intent.dart';
import '../../../../domain/models/position.dart';
import '../../../../domain/models/position_operation.dart';
import '../../positions/providers/position_providers.dart';

/// Close the selected position, never reuse a new-order form with a default coin.
class Hip3ClosePositionSheet extends ConsumerStatefulWidget {
  const Hip3ClosePositionSheet({super.key, required this.position});
  final Position position;

  @override
  ConsumerState<Hip3ClosePositionSheet> createState() => _CloseState();
}

class _CloseState extends ConsumerState<Hip3ClosePositionSheet> {
  final _quantity = TextEditingController();
  final _limit = TextEditingController();
  TradingOrderType _type = TradingOrderType.market;
  String? _percent = '100';
  bool _busy = false;
  bool _pending = false;
  String? _error;

  @override
  void dispose() {
    _quantity.dispose();
    _limit.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (_busy || _pending) return;
    setState(() {
      _busy = true;
      _error = null;
    });
    try {
      final quantity = _percent == null ? _quantity.text.trim() : null;
      if (quantity != null) {
        requireWithinPosition(quantity, widget.position.quantity.value);
      }
      if (_type == TradingOrderType.limit) {
        requirePositiveDecimal(_limit.text.trim());
      }
      await ref
          .read(positionCommandProvider)
          .close(
            widget.position.positionId,
            expectedPosition: widget.position,
            type: _type,
            limitPrice: _type == TradingOrderType.limit
                ? _limit.text.trim()
                : null,
            quantity: quantity,
            percent: _percent,
          );
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Close order submitted. Check the order for fills.'),
          ),
        );
        Navigator.of(context).pop();
      }
    } on Hip3ActionPending catch (error) {
      _pending = true;
      if (mounted) {
        setState(
          () => _error =
              'Action ${error.actionId} is still being confirmed. Resume it from pending actions; do not create another close.',
        );
      }
    } on ArgumentError catch (error) {
      if (mounted) setState(() => _error = '${error.message}');
    } on FormatException catch (error) {
      if (mounted) {
        setState(
          () => _error = '${error.message}. Refresh the position and retry.',
        );
      }
    } on Object {
      if (mounted) {
        setState(
          () => _error = 'Close was not completed. Check pending actions and refresh the position before changing this request.',
        );
      }
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    ref.watch(positionCommandProvider);
    final position = widget.position;
    final locked = _busy || _pending;
    return Material(
      borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
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
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Close ${position.symbol}',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 8),
              Text(
                '${position.productId ?? 'Unavailable product'} · ${position.side == PositionSide.long ? 'Long → Sell' : 'Short → Buy'} · ${position.leverage?.value ?? '—'}x',
              ),
              Text(
                'Position quantity: ${absoluteQuantity(position.quantity.value)} ${position.symbol}',
              ),
              const SizedBox(height: 16),
              SegmentedButton<TradingOrderType>(
                segments: const [
                  ButtonSegment(
                    value: TradingOrderType.market,
                    label: Text('Market'),
                  ),
                  ButtonSegment(
                    value: TradingOrderType.limit,
                    label: Text('Limit'),
                  ),
                ],
                selected: {_type},
                onSelectionChanged: locked
                    ? null
                    : (value) => setState(() => _type = value.single),
              ),
              if (_type == TradingOrderType.limit)
                TextField(
                  key: const Key('close-limit-price'),
                  controller: _limit,
                  enabled: !locked,
                  keyboardType: const TextInputType.numberWithOptions(
                    decimal: true,
                  ),
                  decoration: const InputDecoration(
                    labelText: 'Limit price (USDC)',
                  ),
                ),
              const SizedBox(height: 12),
              TextField(
                key: const Key('close-quantity'),
                controller: _quantity,
                enabled: !locked,
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
                onChanged: (_) => setState(() => _percent = null),
                decoration: InputDecoration(
                  labelText: 'Quantity (${position.symbol})',
                  hintText: _percent == null
                      ? null
                      : '$_percent% of current position',
                ),
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                children: [
                  for (final percent in ['25', '50', '75', '100'])
                    ChoiceChip(
                      label: Text(
                        percent == '100' ? '100% · All' : '$percent%',
                      ),
                      selected: _percent == percent,
                      onSelected: locked
                          ? null
                          : (_) => setState(() {
                              _percent = percent;
                              _quantity.clear();
                            }),
                    ),
                ],
              ),
              const SizedBox(height: 16),
              Text(
                'Entry: ${position.entryPrice?.value ?? '—'} · Mark: ${position.markPrice?.value ?? '—'}',
              ),
              Text('Liquidation: ${position.liquidationPrice?.value ?? '—'}'),
              const SizedBox(height: 8),
              const Text(
                'Reduce-only. Review the server-normalized quantity, estimated PnL and fees before signing. A limit order may remain open.',
              ),
              if (_error != null)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: Semantics(liveRegion: true, child: Text(_error!)),
                ),
              const SizedBox(height: 16),
              FilledButton(
                key: const Key('close-review'),
                onPressed:
                    _busy ||
                        _pending ||
                        position.productId == null ||
                        position.side == PositionSide.none
                    ? null
                    : _submit,
                child: Text(_busy ? 'Preparing…' : 'Review close'),
              ),
              TextButton(
                onPressed: _busy ? null : () => Navigator.of(context).pop(),
                child: const Text('Back'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

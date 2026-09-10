import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../app/providers/session_scope.dart';
import '../../../../domain/models/position.dart';
import '../../../../domain/models/session_generation.dart';
import '../../../../domain/models/hip3_action_pending.dart';
import '../providers/position_providers.dart';

class Hip3PositionLeverageSheet extends ConsumerStatefulWidget {
  const Hip3PositionLeverageSheet({super.key, required this.position});
  final Position position;
  @override
  ConsumerState<Hip3PositionLeverageSheet> createState() => _LeverageState();
}

class _LeverageState extends ConsumerState<Hip3PositionLeverageSheet> {
  final _form = GlobalKey<FormState>();
  late final _input = TextEditingController(
    text: widget.position.leverage?.value ?? '',
  );
  bool _busy = false;
  bool _pending = false;
  late final SessionGeneration _generation = ref.read(
    sessionGenerationProvider,
  );
  String? _message;
  @override
  void dispose() {
    _input.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (_busy ||
        _pending ||
        ref.read(sessionGenerationProvider) != _generation ||
        !(_form.currentState?.validate() ?? false)) {
      return;
    }
    final generation = ref.read(sessionGenerationProvider);
    setState(() {
      _busy = true;
      _message = null;
    });
    try {
      await ref
          .read(positionCommandProvider)
          .updateLeverage(widget.position, _input.text.trim());
      if (!mounted || ref.read(sessionGenerationProvider) != generation) return;
      setState(() {
        _message = 'Leverage updated. Refreshing position and trading context.';
      });
    } on Hip3ActionPending {
      if (!mounted || ref.read(sessionGenerationProvider) != generation) return;
      setState(() {
        _pending = true;
        _message = 'Leverage is not yet confirmed. Close this panel and resume the existing action in Pending actions.';
      });
    } catch (_) {
      if (!mounted || ref.read(sessionGenerationProvider) != generation) return;
      setState(() {
        _message = 'Leverage was not confirmed. Check pending actions before trying again.';
      });
    } finally {
      if (mounted && ref.read(sessionGenerationProvider) == generation) {
        setState(() {
          _busy = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // Keep the session-scoped command guard alive while this panel awaits signing.
    ref.watch(positionCommandProvider);
    final product = widget.position.productId;
    final sessionChanged = ref.watch(sessionGenerationProvider) != _generation;
    return SafeArea(
      child: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(
          20,
          20,
          20,
          20 + MediaQuery.viewInsetsOf(context).bottom,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Change ${widget.position.symbol} leverage',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            if (sessionChanged)
              const Text(
                'Account changed. Close this panel and reopen the position.',
              )
            else if (product == null)
              const Text('Trading context unavailable.')
            else
              ref
                  .watch(positionLeverageContextProvider(product))
                  .when(
                    loading: () => const LinearProgressIndicator(),
                    error: (_, _) => Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Trading context unavailable. Reload before changing leverage.',
                        ),
                        TextButton(
                          onPressed: _busy
                              ? null
                              : () => ref.invalidate(
                                  positionLeverageContextProvider(product),
                                ),
                          child: const Text('Reload'),
                        ),
                      ],
                    ),
                    data: (limits) => Form(
                      key: _form,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Current: ${limits.current == null ? 'Unavailable' : '${limits.current!.value}×'} · Maximum: ${limits.maximum.value}×',
                          ),
                          const Text(
                            'Changing leverage requires your wallet signature and keeps the current margin mode.',
                          ),
                          if (!limits.canChange)
                            const Text(
                              'Leverage changes are unavailable for this account or product.',
                            ),
                          TextFormField(
                            controller: _input,
                            enabled: !_busy && !_pending && limits.canChange,
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                              labelText: 'Leverage',
                            ),
                            validator: (value) =>
                                limits.accepts(
                                  value?.trim() ?? '',
                                  DateTime.now().toUtc(),
                                )
                                ? null
                                : 'Enter a whole number within the current maximum, or reload expired limits.',
                          ),
                          const SizedBox(height: 16),
                          TextButton(
                            onPressed: _busy
                                ? null
                                : () => ref.invalidate(
                                    positionLeverageContextProvider(product),
                                  ),
                            child: const Text('Reload limits'),
                          ),
                          FilledButton(
                            onPressed: _busy || _pending || !limits.canChange
                                ? null
                                : _submit,
                            child: Text(
                              _busy
                                  ? 'Waiting for confirmation…'
                                  : 'Review and sign',
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
            if (_message != null && !sessionChanged)
              Padding(
                padding: const EdgeInsets.only(top: 12),
                child: Semantics(liveRegion: true, child: Text(_message!)),
              ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Close'),
            ),
          ],
        ),
      ),
    );
  }
}

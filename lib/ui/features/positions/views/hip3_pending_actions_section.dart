import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../app/providers/session_scope.dart';
import '../../../../domain/models/hip3_action_pending.dart';
import '../../../../domain/models/hip3_action_summary.dart';
import '../../../../l10n/generated/app_localizations.dart';
import '../../portfolio/providers/portfolio_providers.dart';
import '../providers/position_providers.dart';

/// Operate: extend the assets page's themed, linear list. Show frozen workflow
/// identity and status before an explicit recovery action; never create an order.
/// Session-keyed state prevents a previous account's progress from leaking.
class Hip3PendingActionsSection extends ConsumerWidget {
  const Hip3PendingActionsSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) =>
      _PendingActions(key: ValueKey(ref.watch(sessionGenerationProvider)));
}

class _PendingActions extends ConsumerStatefulWidget {
  const _PendingActions({super.key});

  @override
  ConsumerState<_PendingActions> createState() => _PendingActionsState();
}

class _PendingActionsState extends ConsumerState<_PendingActions> {
  String? _busyAction;

  Future<void> _resume(Hip3ActionSummary action) async {
    if (_busyAction != null) return;
    final generation = ref.read(sessionGenerationProvider);
    final l10n = AppLocalizations.of(context);
    final commands = ref.read(positionCommandProvider);
    setState(() => _busyAction = action.actionId);
    var message = l10n.hip3PendingComplete;
    try {
      await commands.resumeHip3Action(action.actionId);
    } on Hip3ActionPending catch (pending) {
      message = pending.requiresReview
          ? l10n.hip3PendingReview
          : l10n.hip3PendingStillActive;
    } catch (_) {
      message = l10n.hip3PendingError;
    }
    if (!mounted || ref.read(sessionGenerationProvider) != generation) return;
    setState(() => _busyAction = null);
    ref.invalidate(holdingsProvider);
    ref.invalidate(holdingsOverviewProvider);
    ref.invalidate(portfolioSummaryProvider);
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    // Keep the command guard alive throughout confirmation and reconciliation.
    ref.watch(positionCommandProvider);
    final l10n = AppLocalizations.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l10n.hip3PendingTitle,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        TextButton.icon(
          onPressed: _busyAction != null
              ? null
              : () => ref.invalidate(activeHip3ActionsProvider),
          icon: const Icon(Icons.refresh),
          label: Text(l10n.hip3PendingRefresh),
        ),
        _ActionPage(
          cursor: null,
          visited: const {},
          busyAction: _busyAction,
          onResume: _resume,
        ),
      ],
    );
  }
}

class _ActionPage extends ConsumerStatefulWidget {
  const _ActionPage({
    super.key,
    required this.cursor,
    required this.visited,
    required this.busyAction,
    required this.onResume,
  });
  final String? cursor;
  final Set<String> visited;
  final String? busyAction;
  final Future<void> Function(Hip3ActionSummary) onResume;

  @override
  ConsumerState<_ActionPage> createState() => _ActionPageState();
}

class _ActionPageState extends ConsumerState<_ActionPage> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final page = ref.watch(activeHip3ActionsProvider(widget.cursor));
    return page.when(
      loading: () => Text(l10n.hip3PendingLoading),
      error: (_, _) => Text(l10n.hip3PendingLoadError),
      data: (value) {
        final actions = value.items.where(
          (action) => const {
            'setTpsl',
            'clearTpsl',
            'setLeverage',
            'closePosition',
          }.contains(action.operation),
        );
        final next = value.nextCursor;
        final hasNext =
            value.hasMore &&
            next != null &&
            next != widget.cursor &&
            !widget.visited.contains(next);
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (actions.isEmpty) Text(l10n.hip3PendingEmpty),
            for (final action in actions)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: _ActionRow(
                  action: action,
                  busyAction: widget.busyAction,
                  onResume: () => widget.onResume(action),
                ),
              ),
            if (hasNext && !_expanded)
              TextButton(
                onPressed: () => setState(() => _expanded = true),
                child: Text(l10n.hip3PendingMore),
              ),
            if (hasNext && _expanded)
              _ActionPage(
                key: ValueKey(next),
                cursor: next,
                visited: {
                  ...widget.visited,
                  if (widget.cursor != null) widget.cursor!,
                },
                busyAction: widget.busyAction,
                onResume: widget.onResume,
              ),
          ],
        );
      },
    );
  }
}

class _ActionRow extends StatelessWidget {
  const _ActionRow({
    required this.action,
    required this.busyAction,
    required this.onResume,
  });
  final Hip3ActionSummary action;
  final String? busyAction;
  final VoidCallback onResume;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final operation = switch (action.operation) {
      'setTpsl' => l10n.hip3PendingSetTpsl,
      'clearTpsl' => l10n.hip3PendingClearTpsl,
      'setLeverage' => l10n.hip3PendingLeverage,
      _ => l10n.hip3PendingClose,
    };
    final review = action.status == 'manualReview';
    final awaiting = action.status == 'awaitingSignature';
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(action.productId, style: Theme.of(context).textTheme.titleSmall),
        Text(operation),
        Text(
          review
              ? l10n.hip3PendingReview
              : awaiting
              ? l10n.hip3PendingSignature
              : action.canResumePositionAction
              ? l10n.hip3PendingProcessing
              : l10n.hip3PendingUnavailable,
        ),
        if (action.effectsApplied) Text(l10n.hip3PendingEffects),
        SelectableText(
          action.actionId,
          style: Theme.of(context).textTheme.bodySmall,
        ),
        if (action.canResumePositionAction && !review)
          OutlinedButton(
            key: ValueKey('resume-${action.actionId}'),
            onPressed: busyAction == null ? onResume : null,
            child: Text(
              busyAction == action.actionId
                  ? l10n.hip3PendingBusy
                  : awaiting
                  ? l10n.hip3PendingContinue
                  : l10n.hip3PendingCheck,
            ),
          ),
      ],
    );
  }
}

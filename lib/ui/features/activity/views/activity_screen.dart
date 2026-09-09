import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:go_router/go_router.dart';
import 'package:rwa_interface/app/routing/routes.dart';
import 'package:rwa_interface/domain/auth/authentication.dart';
import 'package:rwa_interface/domain/models/activity_record.dart';
import 'package:rwa_interface/domain/models/decimal_value.dart';
import 'package:rwa_interface/l10n/generated/app_localizations.dart';
import 'package:rwa_interface/ui/core/feedback/copyable_text.dart';
import 'package:rwa_interface/ui/core/feedback/design_state_feedback.dart';
import 'package:rwa_interface/ui/core/formatters/token_amount_formatter.dart';
import 'package:rwa_interface/ui/core/layout/app_bottom_navigation.dart';
import 'package:rwa_interface/ui/core/theme/app_theme.dart';
import 'package:rwa_interface/ui/features/activity/providers/activity_provider.dart';
import 'package:rwa_interface/ui/features/session/providers/authentication_provider.dart';

class ActivityScreen extends ConsumerStatefulWidget {
  const ActivityScreen({super.key});

  @override
  ConsumerState<ActivityScreen> createState() => _ActivityScreenState();
}

class _ActivityScreenState extends ConsumerState<ActivityScreen> {
  ActivityCategory? _category = ActivityCategory.orders;
  ActivityState? _status;

  @override
  Widget build(BuildContext context) {
    final authentication = ref.watch(authenticationProvider);
    if (authentication is AuthenticationUnauthenticated) {
      return Scaffold(
        bottomNavigationBar: const AppBottomNavigation(
          current: AppDestination.activity,
        ),
        body: SafeArea(
          child: _LoggedOutActivity(
            onLogin: () => context.pushNamed(AppRoutes.loginName),
          ),
        ),
      );
    }
    final filter = (category: _category, status: _status, cursor: null);
    final activity = ref.watch(activityProvider(filter));
    return Scaffold(
      bottomNavigationBar: const AppBottomNavigation(
        current: AppDestination.activity,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 28, 20, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                AppLocalizations.of(context).activityTitle,
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: 16),
              _CategoryTabs(
                selected: _category,
                onSelected: (value) => setState(() => _category = value),
              ),
              const SizedBox(height: 8),
              _Filters(
                status: _status,
                onStatusChanged: (value) => setState(() => _status = value),
              ),
              const SizedBox(height: 8),
              Expanded(
                child: activity.when(
                  loading: () => DesignStateFeedback(
                    state: DesignState.loading,
                    title: AppLocalizations.of(context).activityLoading,
                  ),
                  error: (_, _) => DesignStateFeedback(
                    state: DesignState.failure,
                    title: AppLocalizations.of(context).activityUnavailable,
                    message: AppLocalizations.of(context).activityRetry,
                    onRetry: () => ref.refresh(activityProvider(filter).future),
                  ),
                  data: (page) => page.items.isEmpty
                      ? DesignStateFeedback(
                          state: DesignState.empty,
                          title: AppLocalizations.of(context)
                              .activityEmptyTitle,
                          message: AppLocalizations.of(context)
                              .activityEmptyMessage,
                        )
                      : RefreshIndicator(
                          onRefresh: () async =>
                              ref.refresh(activityProvider(filter)),
                          child: _ActivityList(records: page.items),
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

class _LoggedOutActivity extends StatelessWidget {
  const _LoggedOutActivity({required this.onLogin});

  final VoidCallback onLogin;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppRwaColors>()!;
    return ListView(
      padding: const EdgeInsets.fromLTRB(20, 28, 20, 20),
      children: [
        Text(
          AppLocalizations.of(context).activityTitle,
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        SizedBox(
          height: 520,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/figma/home_markets/login_prompt.png',
                width: 180,
                height: 180,
                fit: BoxFit.contain,
              ),
              const SizedBox(height: 20),
              Text(
                'Log in to view your activity',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 8),
              Text(
                'Your orders and account activity will appear here.',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyMedium
                    ?.copyWith(color: colors.secondaryText),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: onLogin,
                  child: const Text('Log in'),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _CategoryTabs extends StatelessWidget {
  const _CategoryTabs({required this.selected, required this.onSelected});
  final ActivityCategory? selected;
  final ValueChanged<ActivityCategory?> onSelected;

  @override
  Widget build(BuildContext context) => SingleChildScrollView(
    scrollDirection: Axis.horizontal,
    child: Row(
      children: [
        _Tab(
          label: AppLocalizations.of(context).activityOrders,
          selected: selected == ActivityCategory.orders,
          onTap: () => onSelected(ActivityCategory.orders),
        ),
        _Tab(
          label: AppLocalizations.of(context).cash,
          selected: selected == ActivityCategory.funds,
          onTap: () => onSelected(ActivityCategory.funds),
        ),
        _Tab(
          label: AppLocalizations.of(context).activityFunding,
          selected: selected == ActivityCategory.signatures,
          onTap: () => onSelected(ActivityCategory.signatures),
        ),
        _Tab(
          label: AppLocalizations.of(context).activityApprovals,
          selected: selected == null,
          onTap: () => onSelected(null),
        ),
      ],
    ),
  );
}

class _Tab extends StatelessWidget {
  const _Tab({
    required this.label,
    required this.selected,
    required this.onTap,
  });
  final String label;
  final bool selected;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppRwaColors>()!;
    final textHeight = MediaQuery.textScalerOf(context).scale(18);
    return ConstrainedBox(
      constraints: const BoxConstraints(minWidth: 72),
      child: Semantics(
        selected: selected,
        button: true,
        label: label,
        child: InkWell(
          onTap: onTap,
          child: SizedBox(
            height: textHeight + 14,
            child: Column(
              children: [
                Text(
                  label,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 13,
                    height: 18 / 13,
                    fontWeight: FontWeight.w500,
                    color: selected ? colors.primaryText : colors.secondaryText,
                  ),
                ),
                const Spacer(),
                selected
                    ? Container(height: 2, width: 24, color: colors.selected)
                    : const SizedBox(height: 2),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _Filters extends StatelessWidget {
  const _Filters({required this.status, required this.onStatusChanged});
  final ActivityState? status;
  final ValueChanged<ActivityState?> onStatusChanged;
  @override
  Widget build(BuildContext context) {
    final product = _FilterButton(
      width: 120,
      label: AppLocalizations.of(context).activityAllProducts,
    );
    final type = _FilterButton(
      width: 83,
      label: AppLocalizations.of(context).activityType,
    );
    final statusButton = PopupMenuButton<ActivityState?>(
      tooltip: AppLocalizations.of(context).activityFilterStatus,
      onSelected: onStatusChanged,
      itemBuilder: (context) => [
        PopupMenuItem(
          value: null,
          child: Text(AppLocalizations.of(context).activityAllStatuses),
        ),
        PopupMenuItem(
          value: ActivityState.pending,
          child: Text(AppLocalizations.of(context).activityInProgress),
        ),
        PopupMenuItem(
          value: ActivityState.success,
          child: Text(AppLocalizations.of(context).activityCompleted),
        ),
        PopupMenuItem(
          value: ActivityState.failed,
          child: Text(AppLocalizations.of(context).activityFailed),
        ),
        PopupMenuItem(
          value: ActivityState.cancelled,
          child: Text(AppLocalizations.of(context).activityCancelled),
        ),
      ],
      child: _FilterButton(
        width: 93,
        label: status == null
            ? AppLocalizations.of(context).activityStatus
            : _statusLabel(context, status!),
      ),
    );
    final filters = [product, type, statusButton];
    final isLargeText = MediaQuery.textScalerOf(context).scale(13) > 18;
    if (isLargeText) {
      return Wrap(spacing: 8, runSpacing: 8, children: filters);
    }
    return Row(
      children: [
        product,
        const Spacer(),
        type,
        const SizedBox(width: 8),
        statusButton,
      ],
    );
  }
}

class _FilterButton extends StatelessWidget {
  const _FilterButton({required this.label, this.width});
  final String label;
  final double? width;
  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppRwaColors>()!;
    return SizedBox(
      width: width,
      height: 36,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: colors.surface,
          border: Border.all(color: colors.border),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                child: Text(
                  label,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: colors.primaryText,
                    fontSize: 13,
                    height: 18 / 13,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              const Icon(Icons.keyboard_arrow_down, size: 20),
            ],
          ),
        ),
      ),
    );
  }
}

class _ActivityList extends StatelessWidget {
  const _ActivityList({required this.records});
  final List<ActivityRecord> records;
  @override
  Widget build(BuildContext context) {
    final groups = <String, List<ActivityRecord>>{};
    for (final record in records) {
      final key = DateFormat('yyyy/MM/dd').format(record.createdAt.toLocal());
      (groups[key] ??= []).add(record);
    }
    return ListView.separated(
      physics: const AlwaysScrollableScrollPhysics(),
      itemCount: groups.length,
      separatorBuilder: (_, _) => const SizedBox(height: 16),
      itemBuilder: (_, index) {
        final entry = groups.entries.elementAt(index);
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                entry.key,
                style: Theme.of(context).textTheme.labelLarge,
              ),
            ),
            const SizedBox(height: 8),
            Card(
              margin: EdgeInsets.zero,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18),
              ),
              child: Column(
                children: [
                  for (
                    var rowIndex = 0;
                    rowIndex < entry.value.length;
                    rowIndex++
                  ) ...[
                    _ActivityRow(entry.value[rowIndex]),
                    if (rowIndex < entry.value.length - 1)
                      Divider(
                        height: 1,
                        indent: 16,
                        endIndent: 16,
                        color: Theme.of(context)
                            .extension<AppRwaColors>()!
                            .subtleSurface,
                      ),
                  ],
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}

class _ActivityRow extends StatelessWidget {
  const _ActivityRow(this.record);
  final ActivityRecord record;
  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppRwaColors>()!;
    final semantic = Theme.of(context).extension<AppSemanticColors>()!;
    final statusColor = switch (record.status) {
      ActivityState.success => semantic.success,
      ActivityState.failed => semantic.loss,
      ActivityState.pending => semantic.warning,
      _ => colors.secondaryText,
    };
    return ListTile(
      minTileHeight: 72,
      minVerticalPadding: 12,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16),
      title: Row(
        children: [
          Expanded(
            child: Text(
              record.title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          _StatusBadge(status: record.status, color: statusColor),
        ],
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${_statusLabel(context, record.status)} · ${record.context ?? record.type}',
            style: TextStyle(color: statusColor),
          ),
          if (record.reference != null)
            CopyableText(
              value: record.reference!.id,
              semanticLabel: AppLocalizations.of(context).activityCopyReference,
            ),
        ],
      ),
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            _amount(record.amount),
            style: TextStyle(
              color: statusColor,
              fontSize: 15,
              height: 22 / 15,
              fontWeight: FontWeight.w600,
            ),
          ),
          Text(
            DateFormat('HH:mm').format(record.createdAt.toLocal()),
            style: Theme.of(context).textTheme.labelSmall,
          ),
        ],
      ),
    );
  }

  String _amount(DecimalValue? amount) =>
      amount == null ? '–' : TokenAmountFormatter.formatUsd(amount);
}

class _StatusBadge extends StatelessWidget {
  const _StatusBadge({required this.status, required this.color});
  final ActivityState status;
  final Color color;
  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
    decoration: BoxDecoration(
      color: color.withValues(alpha: .12),
      borderRadius: BorderRadius.circular(10),
    ),
    child: Text(
      _statusLabel(context, status),
      style: TextStyle(fontSize: 12, color: color),
    ),
  );
}

String _statusLabel(BuildContext context, ActivityState status) {
  final l10n = AppLocalizations.of(context);
  return switch (status) {
    ActivityState.pending => l10n.activityInProgress,
    ActivityState.success => l10n.activityCompleted,
    ActivityState.failed => l10n.activityFailed,
    ActivityState.cancelled => l10n.activityCancelled,
    ActivityState.unknown => l10n.activityUnknown,
  };
}

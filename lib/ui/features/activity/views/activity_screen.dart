import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:go_router/go_router.dart';
import 'package:rwa_interface/app/routing/routes.dart';
import 'package:rwa_interface/domain/auth/authentication.dart';
import 'package:rwa_interface/domain/models/activity_record.dart';
import 'package:rwa_interface/domain/models/decimal_value.dart';
import 'package:rwa_interface/l10n/generated/app_localizations.dart';
import 'package:rwa_interface/ui/core/feedback/app_toast.dart';
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
    if (authentication is AuthenticationInitializing) {
      return Scaffold(
        bottomNavigationBar: const AppBottomNavigation(
          current: AppDestination.activity,
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 28, 20, 0),
            child: DesignStateFeedback(
              state: DesignState.loading,
              title: AppLocalizations.of(context).activityLoading,
            ),
          ),
        ),
      );
    }
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
                AppLocalizations.of(context).loginToViewActivity,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 8),
              Text(
                AppLocalizations.of(context).accountActivityAppearHere,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyMedium
                    ?.copyWith(color: colors.secondaryText),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: onLogin,
                  child: Text(AppLocalizations.of(context).logIn),
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
                AnimatedContainer(
                  duration: const Duration(milliseconds: 180),
                  curve: Curves.easeOutCubic,
                  height: 2,
                  width: selected ? 24 : 0,
                  color: selected ? colors.selected : Colors.transparent,
                ),
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
                  for (final record in entry.value) _ActivityRow(record),
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
    return _ExpandableActivityRow(
      record: record,
      statusColor: statusColor,
      amount: _amount(record.amount),
    );
  }

  String _amount(DecimalValue? amount) =>
      amount == null ? '–' : TokenAmountFormatter.formatUsd(amount);
}

class _ExpandableActivityRow extends StatefulWidget {
  const _ExpandableActivityRow({
    required this.record,
    required this.statusColor,
    required this.amount,
  });
  final ActivityRecord record;
  final Color statusColor;
  final String amount;

  @override
  State<_ExpandableActivityRow> createState() => _ExpandableActivityRowState();
}

class _ExpandableActivityRowState extends State<_ExpandableActivityRow> {
  bool expanded = false;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppRwaColors>()!;
    final record = widget.record;
    final type = _activityTypeLabel(record.type);
    final networks = _networks(record);
    return InkWell(
      onTap: record.fields.isEmpty && record.txHash == null
          ? null
          : () => setState(() => expanded = !expanded),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            SizedBox(
              height: 72,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Flexible(
                              child: Text(
                                record.title,
                                style: const TextStyle(
                                  fontSize: 15,
                                  height: 22 / 15,
                                  fontWeight: FontWeight.w600,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            const SizedBox(width: 4),
                            _TypeBadge(label: type),
                          ],
                        ),
                        const SizedBox(height: 2),
                        Row(
                          children: [
                            Text(
                              _statusLabel(context, record.status),
                              style: TextStyle(
                                fontSize: 12,
                                height: 16 / 12,
                                color: widget.statusColor,
                              ),
                            ),
                            const SizedBox(width: 4),
                            Container(
                              width: 1,
                              height: 8,
                              color: colors.subtleSurface,
                            ),
                            const SizedBox(width: 4),
                            _NetworkPath(networks: networks),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 8),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        widget.amount,
                        style: const TextStyle(
                          fontSize: 15,
                          height: 22 / 15,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        DateFormat('HH:mm').format(record.createdAt.toLocal()),
                        style: TextStyle(
                          fontSize: 12,
                          height: 16 / 12,
                          color: colors.secondaryText,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            if (expanded) _ActivityDetails(record: record),
            Container(height: 1, color: colors.subtleSurface),
          ],
        ),
      ),
    );
  }
}

class _TypeBadge extends StatelessWidget {
  const _TypeBadge({required this.label});
  final String label;
  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppRwaColors>()!;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: colors.subtleSurface,
        border: Border.all(color: colors.border),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 12,
          height: 16 / 12,
          color: colors.secondaryText,
        ),
      ),
    );
  }
}

class _NetworkPath extends StatelessWidget {
  const _NetworkPath({required this.networks});
  final List<String> networks;
  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppRwaColors>()!;
    if (networks.isEmpty) return const SizedBox.shrink();
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        for (var index = 0; index < networks.length; index++) ...[
          if (index > 0)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: Text(
                '→',
                style: TextStyle(
                  fontSize: 12,
                  height: 16 / 12,
                  color: colors.secondaryText,
                ),
              ),
            ),
          _NetworkLabel(network: networks[index]),
        ],
      ],
    );
  }
}

class _NetworkLabel extends StatelessWidget {
  const _NetworkLabel({required this.network});
  final String network;
  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppRwaColors>()!;
    final isBsc = network.toLowerCase() == 'bsc';
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 14,
          height: 14,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isBsc ? const Color(0xFFF0B90B) : const Color(0xFF8247E5),
          ),
          child: Icon(
            isBsc ? Icons.currency_exchange : Icons.link,
            size: 9,
            color: Colors.white,
          ),
        ),
        const SizedBox(width: 4),
        Text(
          network,
          style: TextStyle(
            fontSize: 12,
            height: 16 / 12,
            color: colors.secondaryText,
          ),
        ),
      ],
    );
  }
}

class _ActivityDetails extends StatelessWidget {
  const _ActivityDetails({required this.record});
  final ActivityRecord record;
  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppRwaColors>()!;
    final fields = [...record.fields];
    if (record.txHash != null && !_hasField(fields, 'tx hash')) {
      fields.insert(0, ActivityField(label: 'Tx Hash', value: record.txHash!));
    }
    if (record.amount != null && !_hasField(fields, 'amount')) {
      fields.add(ActivityField(label: 'Amount', value: record.amount!.value));
    }
    if (!_hasField(fields, 'status')) {
      fields.add(
        ActivityField(
          label: 'Status',
          value: _statusLabel(context, record.status),
        ),
      );
    }
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Column(
        children: [
          for (final field in fields)
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: _DetailRow(field: field, colors: colors),
            ),
        ],
      ),
    );
  }
}

class _DetailRow extends StatelessWidget {
  const _DetailRow({required this.field, required this.colors});
  final ActivityField field;
  final AppRwaColors colors;
  @override
  Widget build(BuildContext context) {
    final isAddress = field.value.startsWith('0x') || field.value.length > 24;
    final displayValue = _detailValue(field);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          field.label,
          style: TextStyle(
            fontSize: 12,
            height: 16 / 12,
            fontWeight: FontWeight.w500,
            color: colors.secondaryText,
          ),
        ),
        const SizedBox(width: 12),
        Flexible(
          child: isAddress
              ? _CompactCopyValue(value: field.value, label: field.label)
              : Text(
                  displayValue,
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    fontSize: 12,
                    height: 16 / 12,
                    fontWeight: FontWeight.w600,
                    color: colors.primaryText,
                  ),
                ),
        ),
      ],
    );
  }
}

String _detailValue(ActivityField field) {
  final label = field.label.trim().toLowerCase();
  final isAmount =
      label == 'amount' || label == 'send amount' || label == 'receive amount';
  if (!isAmount) return field.value;
  try {
    return TokenAmountFormatter.formatValue(DecimalValue(field.value));
  } on FormatException {
    return field.value;
  }
}

class _CompactCopyValue extends StatelessWidget {
  const _CompactCopyValue({required this.value, required this.label});
  final String value;
  final String label;

  Future<void> _copy(BuildContext context) async {
    final l10n = AppLocalizations.of(context);
    try {
      await Clipboard.setData(ClipboardData(text: value));
      if (context.mounted) AppToast.showSuccess(context, l10n.copySucceeded);
    } on Object {
      if (context.mounted) AppToast.showFailure(context, l10n.copyFailed);
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppRwaColors>()!;
    return Semantics(
      button: true,
      label: label,
      value: value,
      child: InkWell(
        onTap: () => _copy(context),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Flexible(
              child: Text(
                _shortAddress(value),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 12,
                  height: 16 / 12,
                  fontWeight: FontWeight.w600,
                  color: colors.primaryText,
                ),
              ),
            ),
            const SizedBox(width: 4),
            Icon(Icons.copy_outlined, size: 14, color: colors.primaryText),
          ],
        ),
      ),
    );
  }
}

String _activityTypeLabel(String type) => switch (type) {
  'deposit' => 'Deposit',
  'transfer' => 'Transfer',
  'bridge' => 'Transfer',
  _ => type.isEmpty ? 'Activity' : type[0].toUpperCase() + type.substring(1),
};

List<String> _networks(ActivityRecord record) {
  final matches = RegExp(
    r'(BSC|Polygon|Arbitrum|Base|Ethereum|Solana)',
    caseSensitive: false,
  ).allMatches(record.context ?? '').map((match) => match.group(1)!).toList();
  if (matches.isNotEmpty) return matches;
  return record.chain == null ? const [] : [record.chain!];
}

String _shortAddress(String value) {
  if (value.length <= 13) return value;
  return '${value.substring(0, 6)}...${value.substring(value.length - 4)}';
}

bool _hasField(List<ActivityField> fields, String label) => fields.any(
  (field) => field.label.trim().toLowerCase() == label.toLowerCase(),
);

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

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:go_router/go_router.dart';
import 'package:rwa_interface/app/routing/routes.dart';
import 'package:rwa_interface/domain/auth/authentication.dart';
import 'package:rwa_interface/domain/models/activity_record.dart';
import 'package:rwa_interface/domain/models/decimal_value.dart';
import 'package:rwa_interface/domain/models/market_product.dart';
import 'package:rwa_interface/l10n/generated/app_localizations.dart';
import 'package:rwa_interface/ui/core/feedback/app_toast.dart';
import 'package:rwa_interface/ui/core/feedback/design_state_feedback.dart';
import 'package:rwa_interface/ui/core/formatters/token_amount_formatter.dart';
import 'package:rwa_interface/ui/core/layout/app_bottom_navigation.dart';
import 'package:rwa_interface/ui/core/theme/app_theme.dart';
import 'package:rwa_interface/ui/features/activity/providers/activity_provider.dart';
import 'package:rwa_interface/ui/features/session/providers/authentication_provider.dart';

class ActivityScreen extends ConsumerStatefulWidget {
  const ActivityScreen({super.key, this.initialCategory});

  final ActivityCategory? initialCategory;

  @override
  ConsumerState<ActivityScreen> createState() => _ActivityScreenState();
}

class _ActivityScreenState extends ConsumerState<ActivityScreen> {
  ActivityCategory? _category;
  ActivityState? _status;
  String? _type;
  MarketProductKind? _productKind;

  @override
  void initState() {
    super.initState();
    _category = widget.initialCategory ?? ActivityCategory.orders;
  }

  @override
  void didUpdateWidget(covariant ActivityScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.initialCategory != widget.initialCategory &&
        widget.initialCategory != null) {
      _category = widget.initialCategory;
      _status = null;
      _type = null;
      _productKind = null;
    }
  }

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
                onSelected: (value) => setState(() {
                  _category = value;
                  _status = null;
                  _type = null;
                  _productKind = null;
                }),
              ),
              if (_category != ActivityCategory.funding) ...[
                const SizedBox(height: 8),
                _Filters(
                  category: _category,
                  productKind: _productKind,
                  onProductChanged: (value) =>
                      setState(() => _productKind = value),
                  status: _status,
                  onStatusChanged: (value) => setState(() => _status = value),
                  type: _type,
                  onTypeChanged: (value) => setState(() => _type = value),
                ),
                const SizedBox(height: 8),
              ],
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
                  data: (page) {
                    final records = page.items
                        .where((record) {
                          final productMatches =
                              _productKind == null ||
                              record.kind == _productKind!.name;
                          final typeMatches =
                              _type == null ||
                              _matchesActivityType(record, _type!);
                          return productMatches && typeMatches;
                        })
                        .toList(growable: false);
                    return records.isEmpty
                        ? DesignStateFeedback(
                            state: DesignState.empty,
                            title: AppLocalizations.of(context)
                                .activityEmptyTitle,
                            message: AppLocalizations.of(context)
                                .activityEmptyMessage,
                          )
                        : RefreshIndicator(
                            onRefresh: () =>
                                ref.refresh(activityProvider(filter).future),
                            child: _ActivityList(records: records),
                          );
                  },
                  skipLoadingOnRefresh: true,
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
          selected: selected == ActivityCategory.cash,
          onTap: () => onSelected(ActivityCategory.cash),
        ),
        _Tab(
          label: AppLocalizations.of(context).activityFunding,
          selected: selected == ActivityCategory.funding,
          onTap: () => onSelected(ActivityCategory.funding),
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

final class _ActivityTypeOption {
  const _ActivityTypeOption(this.value, this.label);
  final String value;
  final String label;
}

List<_ActivityTypeOption> _typeOptions(
  BuildContext context,
  ActivityCategory? category,
) {
  final l10n = AppLocalizations.of(context);
  if (category == ActivityCategory.cash) {
    return [
      _ActivityTypeOption('deposit', l10n.deposit),
      _ActivityTypeOption('withdraw', l10n.withdraw),
      _ActivityTypeOption('transfer', l10n.transfer),
      _ActivityTypeOption('bridge', 'Bridge'),
      _ActivityTypeOption('claim', 'Claim'),
    ];
  }
  return [
    _ActivityTypeOption('market', l10n.market),
    _ActivityTypeOption('limit', l10n.limit),
    _ActivityTypeOption('tpsl', 'TP/SL'),
    _ActivityTypeOption('close', 'Close'),
  ];
}

class _ActivityFilterOption<T> {
  const _ActivityFilterOption({required this.value, required this.label});
  final T value;
  final String label;
}

class _ActivityFilterMenu<T> extends StatelessWidget {
  const _ActivityFilterMenu({
    required this.value,
    required this.options,
    required this.label,
    required this.onChanged,
    this.width = 120,
  });

  final T value;
  final List<_ActivityFilterOption<T>> options;
  final String label;
  final ValueChanged<T> onChanged;
  final double width;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppRwaColors>()!;
    return PopupMenuButton<T>(
      tooltip: label,
      color: colors.surface,
      constraints: const BoxConstraints.tightFor(width: 168),
      menuPadding: const EdgeInsets.all(4),
      offset: const Offset(0, 40),
      onSelected: onChanged,
      itemBuilder: (context) => options
          .map(
            (option) => PopupMenuItem<T>(
              value: option.value,
              height: 40,
              padding: EdgeInsets.zero,
              child: Container(
                height: 40,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: option.value == value ? colors.selectedSoft : null,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(option.label),
              ),
            ),
          )
          .toList(growable: false),
      child: _FilterButton(width: width, label: label),
    );
  }
}

class _FilterButton extends StatelessWidget {
  const _FilterButton({required this.label, required this.width});

  final String label;
  final double width;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppRwaColors>()!;
    return SizedBox(
      width: width,
      height: 36,
      child: OutlinedButton(
        onPressed: null,
        style: OutlinedButton.styleFrom(
          minimumSize: Size(width, 36),
          maximumSize: Size(width, 36),
          padding: const EdgeInsets.symmetric(horizontal: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          backgroundColor: colors.surface,
          disabledBackgroundColor: colors.surface,
          disabledForegroundColor: colors.primaryText,
          side: BorderSide(color: colors.border),
          textStyle: const TextStyle(
            fontSize: 13,
            height: 18 / 13,
            fontWeight: FontWeight.w500,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(child: Text(label, overflow: TextOverflow.ellipsis)),
            SvgPicture.asset(
              'assets/figma/home_markets/chevron_down.svg',
              width: 20,
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}

class _Filters extends StatelessWidget {
  const _Filters({
    required this.category,
    required this.productKind,
    required this.onProductChanged,
    required this.status,
    required this.onStatusChanged,
    required this.type,
    required this.onTypeChanged,
  });
  final ActivityCategory? category;
  final MarketProductKind? productKind;
  final ValueChanged<MarketProductKind?> onProductChanged;
  final ActivityState? status;
  final ValueChanged<ActivityState?> onStatusChanged;
  final String? type;
  final ValueChanged<String?> onTypeChanged;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final productOptions = [
      _ActivityFilterOption<MarketProductKind?>(
        value: null,
        label: l10n.allProducts,
      ),
      const _ActivityFilterOption<MarketProductKind?>(
        value: MarketProductKind.bstock,
        label: 'bStocks',
      ),
      _ActivityFilterOption<MarketProductKind?>(
        value: MarketProductKind.perp,
        label: l10n.hip3Perps,
      ),
    ];
    final product = _ActivityFilterMenu<MarketProductKind?>(
      value: productKind,
      options: productOptions,
      label: productOptions
          .firstWhere((option) => option.value == productKind)
          .label,
      onChanged: onProductChanged,
      width: 135,
    );
    final typeOptions = [
      _ActivityFilterOption<String?>(value: null, label: l10n.activityType),
      ..._typeOptions(context, category).map(
        (option) => _ActivityFilterOption<String?>(
          value: option.value,
          label: option.label,
        ),
      ),
    ];
    final typeButton = _ActivityFilterMenu<String?>(
      value: type,
      options: typeOptions,
      label: type == null
          ? l10n.activityType
          : typeOptions.firstWhere((option) => option.value == type).label,
      onChanged: onTypeChanged,
      width: 83,
    );
    final statusOptions = [
      _ActivityFilterOption<ActivityState?>(
        value: null,
        label: l10n.activityStatus,
      ),
      _ActivityFilterOption<ActivityState?>(
        value: ActivityState.pending,
        label: l10n.activityInProgress,
      ),
      _ActivityFilterOption<ActivityState?>(
        value: ActivityState.success,
        label: l10n.activityCompleted,
      ),
      _ActivityFilterOption<ActivityState?>(
        value: ActivityState.failed,
        label: l10n.activityFailed,
      ),
      _ActivityFilterOption<ActivityState?>(
        value: ActivityState.cancelled,
        label: l10n.activityCancelled,
      ),
    ];
    final statusButton = _ActivityFilterMenu<ActivityState?>(
      value: status,
      options: statusOptions,
      label: status == null
          ? l10n.activityStatus
          : _statusLabel(context, status!),
      onChanged: onStatusChanged,
      width: 93,
    );
    if (category == ActivityCategory.funding) {
      return const SizedBox.shrink();
    }
    final filters = category == ActivityCategory.cash
        ? [typeButton, statusButton]
        : [product, typeButton, statusButton];
    final isLargeText = MediaQuery.textScalerOf(context).scale(13) > 18;
    if (isLargeText) {
      return Wrap(spacing: 8, runSpacing: 8, children: filters);
    }
    if (category == ActivityCategory.cash) {
      return Row(
        children: [
          filters[0],
          const SizedBox(width: 8),
          filters[1],
          const Spacer(),
        ],
      );
    }
    return Row(
      children: [
        product,
        const Spacer(),
        for (var index = 1; index < filters.length; index++) ...[
          if (index > 1) const SizedBox(width: 8),
          filters[index],
        ],
      ],
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
      amount == null ? '-' : TokenAmountFormatter.formatUsd(amount);
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
    final isOrder = record.category == ActivityCategory.orders;
    final isFunding = record.category == ActivityCategory.funding;
    final type = isOrder
        ? _orderTypeLabel(record)
        : _activityTypeLabel(record.type);
    final networks = _networks(record);
    final title = isOrder ? _orderTitle(record) : record.title;
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
                                title,
                                style: const TextStyle(
                                  fontSize: 15,
                                  height: 22 / 15,
                                  fontWeight: FontWeight.w600,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            const SizedBox(width: 4),
                            if (isFunding) ...[
                              _TypeBadge(
                                label: _fundingSide(record),
                                order: true,
                              ),
                              const SizedBox(width: 4),
                              _TypeBadge(
                                label: _fundingDirection(record),
                                order: true,
                                positive: true,
                              ),
                            ] else
                              _TypeBadge(label: type, order: isOrder),
                          ],
                        ),
                        const SizedBox(height: 2),
                        Row(
                          children: [
                            if (!isFunding) ...[
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
                            ],
                            isOrder || isFunding
                                ? _VenueLabel(kind: record.kind)
                                : _NetworkPath(networks: networks),
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
  const _TypeBadge({required this.label, this.order = false, this.positive});
  final String label;
  final bool order;
  final bool? positive;
  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppRwaColors>()!;
    final isSell =
        label.toLowerCase().startsWith('sell') ||
        label.toLowerCase().startsWith('short');
    final badgeColor = order
        ? (positive == true
              ? const Color(0xFF04A08B)
              : (isSell ? const Color(0xFFDE596E) : const Color(0xFF04A08B)))
        : colors.secondaryText;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: order ? badgeColor.withValues(alpha: .12) : colors.subtleSurface,
        border: order ? null : Border.all(color: colors.border),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        label,
        style: TextStyle(fontSize: 12, height: 16 / 12, color: badgeColor),
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

class _VenueLabel extends StatelessWidget {
  const _VenueLabel({required this.kind});
  final String? kind;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppRwaColors>()!;
    final isPerp = kind == 'perp';
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        SvgPicture.asset(
          isPerp
              ? 'assets/figma/home_markets/venue_hyperliquid.svg'
              : 'assets/figma/home_markets/venue_bnb.svg',
          width: 14,
          height: 14,
        ),
        const SizedBox(width: 4),
        Text(
          isPerp ? 'HIP-3' : 'bStocks',
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

String _orderTypeLabel(ActivityRecord record) {
  final value = record.type.toLowerCase();
  if (value == 'tpsl' || value == 'take_profit') return 'TP';
  if (value == 'close' || value == 'stop_loss') return 'SL';
  final title = record.title.toLowerCase();
  if (title.contains('sell') || title.contains('short')) return 'Sell / Limit';
  return 'Buy / Limit';
}

String _orderTitle(ActivityRecord record) {
  final symbol = record.symbol?.trim();
  if (symbol == null || symbol.isEmpty) return record.title;
  if (symbol.contains('/')) return symbol;
  final quote = record.asset?.trim();
  return '$symbol/${quote == null || quote.isEmpty ? 'USDT' : quote}';
}

String _fundingSide(ActivityRecord record) {
  final value = '${record.title} ${record.context ?? ''}'.toLowerCase();
  return value.contains('short') || value.contains('sell') ? 'Short' : 'Long';
}

String _fundingDirection(ActivityRecord record) {
  final value = '${record.title} ${record.context ?? ''}'.toLowerCase();
  return value.contains('pay') || value.contains('fee') ? 'Pay' : 'Receive';
}

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

bool _matchesActivityType(ActivityRecord record, String selectedType) {
  final type = record.type.toLowerCase();
  final title = record.title.toLowerCase();
  final context = (record.context ?? '').toLowerCase();
  final value = '$type $title $context';
  return switch (selectedType) {
    'tpsl' =>
      value.contains('tpsl') ||
          value.contains('take_profit') ||
          value.contains('stop_loss') ||
          value.contains('take profit') ||
          value.contains('stop loss'),
    'close' => value.contains('close') || value.contains('liquidat'),
    _ => value.contains(selectedType),
  };
}

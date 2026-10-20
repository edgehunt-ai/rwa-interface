import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:go_router/go_router.dart';
import 'package:nobell/app/routing/routes.dart';
import 'package:nobell/domain/auth/authentication.dart';
import 'package:nobell/domain/models/activity_record.dart';
import 'package:nobell/domain/models/decimal_value.dart';
import 'package:nobell/domain/models/domain_page.dart';
import 'package:nobell/domain/models/market_product.dart';
import 'package:nobell/l10n/generated/app_localizations.dart';
import 'package:nobell/ui/core/feedback/app_toast.dart';
import 'package:nobell/ui/core/feedback/design_state_feedback.dart';
import 'package:nobell/ui/core/formatters/token_amount_formatter.dart';
import 'package:nobell/ui/core/layout/app_bottom_navigation.dart';
import 'package:nobell/ui/core/network/network_icon_assets.dart';
import 'package:nobell/ui/core/theme/app_theme.dart';
import 'package:nobell/ui/core/widgets/app_filter_menu.dart';
import 'package:nobell/ui/features/activity/providers/activity_provider.dart';
import 'package:nobell/ui/features/session/providers/authentication_provider.dart';
import 'package:nobell/ui/features/session/views/privy_login_screen.dart';
import 'package:nobell/app/providers/session_scope.dart';

/// A reloadable destination for a record anywhere in the activity feed.
class ActivityDetailScreen extends ConsumerWidget {
  const ActivityDetailScreen({super.key, required this.recordId});

  final String recordId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final authentication = ref.watch(authenticationProvider);
    final Widget body;
    if (authentication is AuthenticationInitializing) {
      body = DesignStateFeedback(
        state: DesignState.loading,
        title: l10n.activityLoading,
      );
    } else if (authentication is! AuthenticationAuthenticated) {
      body = _LoggedOutActivity(onLogin: () => pushLoginScreen(context));
    } else {
      final detail = ref.watch(activityDetailProvider(recordId));
      body = detail.when(
        loading: () => DesignStateFeedback(
          state: DesignState.loading,
          title: l10n.activityLoading,
        ),
        error: (error, _) => DesignStateFeedback(
          error: error,
          state: DesignState.failure,
          title: l10n.activityUnavailable,
          message: l10n.activityRetry,
          onRetry: () => ref.invalidate(activityDetailProvider(recordId)),
        ),
        data: (record) => record == null
            ? DesignStateFeedback(
                state: DesignState.empty,
                title: l10n.pageNotFoundTitle,
                message: l10n.pageNotFoundMessage,
              )
            : ListView(
                children: [
                  Card(
                    child: _ActivityRow(
                      record,
                      initiallyExpanded: true,
                      showDetailLink: false,
                    ),
                  ),
                ],
              ),
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.details),
        leading: BackButton(
          onPressed: () => context.canPop()
              ? context.pop()
              : context.go(AppRoutes.activityPath),
        ),
      ),
      body: SafeArea(
        child: Padding(padding: const EdgeInsets.all(20), child: body),
      ),
    );
  }
}

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
  final List<String?> _cursors = [null];

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
      _resetPagination();
    }
  }

  void _resetPagination() {
    _cursors
      ..clear()
      ..add(null);
  }

  ActivityFilter _filter(String? cursor) => (
    category: _category,
    status: _status,
    type: _serverType(_type),
    productOrAsset: null,
    cursor: cursor,
  );

  String? _serverType(String? type) => type == 'transfer' ? 'bridge' : type;

  Future<void> _refreshActivity() async {
    setState(_resetPagination);
    final provider = activityProvider(_filter(null));
    ref.invalidate(provider);
    await ref.read(provider.future);
  }

  void _loadMore(String cursor) {
    if (_cursors.contains(cursor)) return;
    setState(() => _cursors.add(cursor));
  }

  @override
  Widget build(BuildContext context) {
    if (ModalRoute.of(context)?.isCurrent ?? true) {
      ref.watch(activityListRefreshProvider);
    }
    ref.listen(sessionGenerationProvider, (_, _) {
      if (!mounted) return;
      setState(_resetPagination);
    });
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
    final pageStates = [
      for (final cursor in _cursors)
        ref.watch(activityProvider(_filter(cursor))),
    ];
    final pages = pageStates
        .map((state) => state.value)
        .whereType<DomainPage<ActivityRecord>>()
        .toList(growable: false);
    final recordsById = <String, ActivityRecord>{};
    for (final page in pages) {
      for (final record in page.items) {
        recordsById[record.id] = record;
      }
    }
    final records = recordsById.values
        .where((record) {
          // Product kind has no corresponding server query parameter. Keep
          // this compatibility filter until the selector uses an exact
          // product ID/symbol accepted by `product_or_asset`.
          return _productKind == null || record.kind == _productKind!.name;
        })
        .toList(growable: false);
    final lastPage = pages.isEmpty ? null : pages.last;
    final nextCursor = lastPage?.nextCursor;
    final hasMore =
        lastPage?.hasMore == true &&
        nextCursor != null &&
        !_cursors.contains(nextCursor);
    final loading = pageStates.any((state) => state.isLoading);
    final loadingMore = _cursors.length > 1 && pageStates.last.isLoading;
    final hasError = pageStates.any((state) => state.hasError);
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
                  _resetPagination();
                }),
              ),
              if (_category != ActivityCategory.funding) ...[
                const SizedBox(height: 8),
                _Filters(
                  category: _category,
                  productKind: _productKind,
                  onProductChanged: (value) => setState(() {
                    _productKind = value;
                    _resetPagination();
                  }),
                  status: _status,
                  onStatusChanged: (value) => setState(() {
                    _status = value;
                    _resetPagination();
                  }),
                  type: _type,
                  onTypeChanged: (value) => setState(() {
                    _type = value;
                    _resetPagination();
                  }),
                ),
                const SizedBox(height: 8),
              ],
              Expanded(
                child: hasError
                    ? DesignStateFeedback(
                        state: DesignState.failure,
                        title: AppLocalizations.of(context).activityUnavailable,
                        message: AppLocalizations.of(context).activityRetry,
                        onRetry: _refreshActivity,
                      )
                    : loading && pages.isEmpty
                    ? DesignStateFeedback(
                        state: DesignState.loading,
                        title: AppLocalizations.of(context).activityLoading,
                      )
                    : records.isEmpty && !hasMore && !loadingMore
                    ? DesignStateFeedback(
                        state: DesignState.empty,
                        title: AppLocalizations.of(context).activityEmptyTitle,
                        message: AppLocalizations.of(context)
                            .activityEmptyMessage,
                      )
                    : RefreshIndicator(
                        onRefresh: _refreshActivity,
                        child: _ActivityList(
                          records: records,
                          hasMore: hasMore,
                          loadingMore: loadingMore,
                          onLoadMore: nextCursor == null
                              ? null
                              : () => _loadMore(nextCursor),
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
                'assets/figma/common/sign_in_illustration.webp',
                width: 120,
                height: 120,
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
      AppFilterOption<MarketProductKind?>(value: null, label: l10n.allProducts),
      const AppFilterOption<MarketProductKind?>(
        value: MarketProductKind.bstock,
        label: 'bStocks',
      ),
      AppFilterOption<MarketProductKind?>(
        value: MarketProductKind.perp,
        label: l10n.hip3Perps,
      ),
    ];
    final product = AppFilterMenu<MarketProductKind?>(
      value: productKind,
      options: productOptions,
      label: productOptions
          .firstWhere((option) => option.value == productKind)
          .label,
      onChanged: onProductChanged,
      width: 135,
    );
    final typeOptions = [
      AppFilterOption<String?>(value: null, label: l10n.activityType),
      ..._typeOptions(context, category).map(
        (option) =>
            AppFilterOption<String?>(value: option.value, label: option.label),
      ),
    ];
    final typeButton = AppFilterMenu<String?>(
      value: type,
      options: typeOptions,
      label: type == null
          ? l10n.activityType
          : typeOptions.firstWhere((option) => option.value == type).label,
      onChanged: onTypeChanged,
      width: 83,
    );
    final statusOptions = [
      AppFilterOption<ActivityState?>(value: null, label: l10n.activityStatus),
      AppFilterOption<ActivityState?>(
        value: ActivityState.pending,
        label: l10n.activityInProgress,
      ),
      AppFilterOption<ActivityState?>(
        value: ActivityState.success,
        label: l10n.activityCompleted,
      ),
      AppFilterOption<ActivityState?>(
        value: ActivityState.failed,
        label: l10n.activityFailed,
      ),
      AppFilterOption<ActivityState?>(
        value: ActivityState.cancelled,
        label: l10n.activityCancelled,
      ),
    ];
    final statusButton = AppFilterMenu<ActivityState?>(
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
  const _ActivityList({
    required this.records,
    required this.hasMore,
    required this.loadingMore,
    required this.onLoadMore,
  });
  final List<ActivityRecord> records;
  final bool hasMore;
  final bool loadingMore;
  final VoidCallback? onLoadMore;

  @override
  Widget build(BuildContext context) {
    final groups = <String, List<ActivityRecord>>{};
    for (final record in records) {
      final key = DateFormat('yyyy/MM/dd').format(record.createdAt.toLocal());
      (groups[key] ??= []).add(record);
    }
    final entries = groups.entries.toList(growable: false);
    return ListView.separated(
      physics: const AlwaysScrollableScrollPhysics(),
      itemCount: entries.length + (hasMore ? 1 : 0),
      separatorBuilder: (_, _) => const SizedBox(height: 16),
      itemBuilder: (_, index) {
        if (index == entries.length) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 4, bottom: 12),
              child: TextButton(
                onPressed: loadingMore ? null : onLoadMore,
                child: loadingMore
                    ? const SizedBox(
                        width: 18,
                        height: 18,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : Text(AppLocalizations.of(context).loadMore),
              ),
            ),
          );
        }
        final entry = entries[index];
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
  const _ActivityRow(
    this.record, {
    this.initiallyExpanded = false,
    this.showDetailLink = true,
  });
  final ActivityRecord record;
  final bool initiallyExpanded;
  final bool showDetailLink;
  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppRwaColors>()!;
    final semantic = Theme.of(context).extension<AppSemanticColors>()!;
    final statusColor = switch (record.status) {
      ActivityState.success || ActivityState.settled || ActivityState.credited =>
        semantic.success,
      ActivityState.failed => semantic.loss,
      ActivityState.pending || ActivityState.refundPending ||
      ActivityState.partiallySettled ||
      ActivityState.partiallyRefunded || ActivityState.reserved ||
      ActivityState.sourceDebited || ActivityState.inTransit ||
      ActivityState.manualReview => semantic.warning,
      _ => colors.secondaryText,
    };
    return _ExpandableActivityRow(
      key: ValueKey(record.id),
      record: record,
      initiallyExpanded: initiallyExpanded,
      showDetailLink: showDetailLink,
      statusColor: statusColor,
      amount: _amount(record),
    );
  }

  String _amount(ActivityRecord record) {
    final amount = record.amount;
    if (amount == null) return '-';
    if (record.category == ActivityCategory.cash) {
      return TokenAmountFormatter.formatDecimal(amount);
    }
    final asset = record.asset ?? amount.asset;
    if (asset == null || asset.trim().isEmpty) {
      return TokenAmountFormatter.formatUsd(amount);
    }
    return '${TokenAmountFormatter.formatDecimal(amount)} ${asset.trim()}';
  }
}

class _ExpandableActivityRow extends StatefulWidget {
  const _ExpandableActivityRow({
    super.key,
    required this.record,
    required this.statusColor,
    required this.amount,
    required this.initiallyExpanded,
    required this.showDetailLink,
  });
  final ActivityRecord record;
  final bool initiallyExpanded;
  final bool showDetailLink;
  final Color statusColor;
  final String amount;

  @override
  State<_ExpandableActivityRow> createState() => _ExpandableActivityRowState();
}

class _ExpandableActivityRowState extends State<_ExpandableActivityRow> {
  late bool expanded = widget.initiallyExpanded;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppRwaColors>()!;
    final record = widget.record;
    final isOrder = record.category == ActivityCategory.orders;
    final isFunding = record.category == ActivityCategory.funding;
    final isCash = record.category == ActivityCategory.cash;
    final isEconomicStatus = switch (record.status) {
      ActivityState.pending ||
      ActivityState.success ||
      ActivityState.failed ||
      ActivityState.cancelled ||
      ActivityState.unknown => false,
      _ => true,
    };
    final type = isOrder
        ? _orderTypeLabel(record, AppLocalizations.of(context))
        : _activityTypeLabel(record.type, AppLocalizations.of(context));
    final networks = _networks(record);
    final title = isOrder
        ? _orderTitle(record)
        : record.category == ActivityCategory.cash
        ? _cashTitle(record)
        : record.title;
    return InkWell(
      onTap: () => setState(() => expanded = !expanded),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            SizedBox(
              height: 72,
              child: LayoutBuilder(
                builder: (context, constraints) => Row(
                  children: [
                    Expanded(
                      flex: 6,
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
                                Flexible(
                                  child: _TypeBadge(
                                    label: _fundingSide(
                                      record,
                                      AppLocalizations.of(context),
                                    ),
                                    order: true,
                                  ),
                                ),
                                const SizedBox(width: 4),
                                Flexible(
                                  child: _TypeBadge(
                                    label: _fundingDirection(
                                      record,
                                      AppLocalizations.of(context),
                                    ),
                                    order: true,
                                    positive: true,
                                  ),
                                ),
                              ] else if (isCash)
                                _TypeBadge(label: type, order: false)
                              else
                                Flexible(
                                  child: _TypeBadge(
                                    label: type,
                                    order: isOrder,
                                  ),
                                ),
                            ],
                          ),
                          const SizedBox(height: 2),
                          Row(
                            children: [
                              if (!isFunding) ...[
                                Flexible(
                                  flex: isCash && !isEconomicStatus ? 0 : 1,
                                  child: Text(
                                    _statusLabel(context, record.status),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontSize: 12,
                                      height: 16 / 12,
                                      color: widget.statusColor,
                                    ),
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
                                  : Flexible(
                                      child: _NetworkPath(networks: networks),
                                    ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 8),
                    Flexible(
                      flex: isCash ? 0 : 4,
                      fit: isCash ? FlexFit.loose : FlexFit.tight,
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                          maxWidth: constraints.maxWidth * 0.4,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              widget.amount,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.right,
                              style: const TextStyle(
                                fontSize: 15,
                                height: 22 / 15,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              DateFormat('HH:mm')
                                  .format(record.createdAt.toLocal()),
                              style: TextStyle(
                                fontSize: 12,
                                height: 16 / 12,
                                color: colors.secondaryText,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            if (expanded) ...[
              _ActivityDetails(record: record),
              if (widget.showDetailLink)
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    key: ValueKey('activity-detail-link-${record.id}'),
                    onPressed: () =>
                        context.go(AppRoutes.activityDetailLocation(record.id)),
                    child: Text(AppLocalizations.of(context).details),
                  ),
                ),
            ],
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
    final l10n = AppLocalizations.of(context);
    final direction = label.split(' / ').first;
    final isSell = direction == l10n.sell || direction == l10n.short;
    final badgeColor = order
        ? (positive == true
              ? const Color(0xFF04A08B)
              : direction == l10n.close
              ? colors.secondaryText
              : (isSell || direction == l10n.stopLoss)
              ? kShortTradeColor
              : const Color(0xFF04A08B))
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
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(fontSize: 12, height: 16 / 12, color: badgeColor),
      ),
    );
  }
}

class _NetworkPath extends StatelessWidget {
  const _NetworkPath({required this.networks});
  final List<({String chain, String label})> networks;
  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppRwaColors>()!;
    if (networks.isEmpty) return const SizedBox.shrink();
    // Share constrained space in proportion to each label's natural width.
    // Equal shares can truncate a long name while its shorter neighbor has room.
    final widths = [
      for (final network in networks)
        _networkLabelWidth(context, network.label),
    ];
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
          Flexible(
            flex: widths[index],
            child: _NetworkLabel(
              network: networks[index].chain,
              label: networks[index].label,
            ),
          ),
        ],
      ],
    );
  }
}

int _networkLabelWidth(BuildContext context, String label) {
  final painter = TextPainter(
    text: TextSpan(
      text: label,
      style: DefaultTextStyle.of(context).style
          .copyWith(fontSize: 12, height: 16 / 12),
    ),
    textDirection: Directionality.of(context),
    textScaler: MediaQuery.textScalerOf(context),
    maxLines: 1,
  )..layout();
  final width = (painter.width + 18).ceil();
  painter.dispose();
  return width;
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
  const _NetworkLabel({required this.network, required this.label});
  final String network;
  final String label;
  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppRwaColors>()!;
    final asset = networkIconAssetPath(network);
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (asset != null)
          SvgPicture.asset(asset, width: 14, height: 14)
        else
          Container(
            width: 14,
            height: 14,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Color(0xFF8247E5),
            ),
            child: const Icon(Icons.link, size: 9, color: Colors.white),
          ),
        const SizedBox(width: 4),
        Flexible(
          child: Tooltip(
            message: label,
            child: Text(
              label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 12,
                height: 16 / 12,
                color: colors.secondaryText,
              ),
            ),
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
    if (record.economicStatus != null) {
      fields.removeWhere((field) => field.label.trim().toLowerCase() == 'status');
    }
    if (record.category == ActivityCategory.orders &&
        _orderTypeConveysDirection(record, AppLocalizations.of(context))) {
      fields.removeWhere((field) => field.label.trim().toLowerCase() == 'side');
    }
    if (record.txHash != null && !_hasField(fields, 'tx hash')) {
      fields.insert(0, ActivityField(label: 'Tx Hash', value: record.txHash!));
    }
    if (record.amount != null && !_hasField(fields, 'amount')) {
      fields.add(
        ActivityField(
          label: 'Amount',
          value: _formatActivityAmount(record.amount!, record.asset),
        ),
      );
    }
    if (!_hasField(fields, 'status')) {
      fields.add(
        ActivityField(
          label: 'Status',
          value: _statusLabel(context, record.status),
        ),
      );
    }
    for (final field in [
      if (record.rawStatus case final status?)
        ActivityField(
          label: AppLocalizations.of(context).fundsTechnicalStatus,
          value: status,
        ),
      if (record.economicStatus case final status?)
        ActivityField(
          label: AppLocalizations.of(context).fundsEconomicStatus,
          value: status,
        ),
      ActivityField(label: 'Activity ID', value: record.id),
      if (record.reference case final reference?)
        ActivityField(label: '${reference.type} ID', value: reference.id),
      if (record.relatedId case final id?)
        ActivityField(label: 'Related ID', value: id),
      if (record.failureReason case final reason?)
        ActivityField(label: 'Reason', value: reason),
      ActivityField(label: 'Created at', value: record.createdAt.toIso8601String()),
      if (record.updatedAt case final timestamp?)
        ActivityField(label: 'Updated at', value: timestamp.toIso8601String()),
    ]) {
      if (!_hasField(fields, field.label)) fields.add(field);
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
          for (final id in record.financialObligationIds)
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: _DetailRow(
                field: ActivityField(
                  label: AppLocalizations.of(context).fundsObligationId,
                  value: id,
                ),
                colors: colors,
              ),
            ),
          if (record.financialObligationIds.isNotEmpty)
            TextButton(
              key: ValueKey('activity-obligations-${record.id}'),
              onPressed: () => context.pushNamed(AppRoutes.fundsObligationsName),
              child: Text(AppLocalizations.of(context).fundsObligationsTitle),
            ),
        ],
      ),
    );
  }
}

String _formatActivityAmount(DecimalValue amount, String? asset) {
  final numeric = amount.value;
  final symbol = asset ?? amount.asset;
  return symbol == null || symbol.trim().isEmpty
      ? numeric
      : '$numeric ${symbol.trim()}';
}

class _DetailRow extends StatelessWidget {
  const _DetailRow({required this.field, required this.colors});
  final ActivityField field;
  final AppRwaColors colors;
  @override
  Widget build(BuildContext context) {
    final normalizedLabel = field.label.trim().toLowerCase();
    final isAddress = field.value.startsWith('0x') ||
        normalizedLabel.endsWith(' id') ||
        normalizedLabel.endsWith(' hash');
    final l10n = AppLocalizations.of(context);
    final displayValue = _detailValue(field, l10n);
    final label = _detailLabel(field.label, l10n);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          label,
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
              ? _CompactCopyValue(value: field.value, label: label)
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

String _detailLabel(String label, AppLocalizations l10n) =>
    switch (label.trim().toLowerCase().replaceAll(RegExp(r'[_\s]+'), ' ')) {
      'tx hash' || 'transaction hash' => l10n.activityTxHash,
      'quantity' => l10n.quantity,
      'limit price' => l10n.limitPrice,
      'filled quantity' => l10n.activityFilledQuantity,
      'average price' => l10n.activityAveragePrice,
      'amount' => l10n.amount,
      'status' => l10n.status,
      'side' => l10n.activitySide,
      'close price' => l10n.activityClosePrice,
      'trigger price' => l10n.activityTriggerPrice,
      'order amount' => l10n.activityOrderAmount,
      'filled' => l10n.filled,
      'fee' => l10n.activityFee,
      'activity id' => l10n.activityId,
      'related id' => l10n.activityRelatedId,
      'reason' => l10n.activityReason,
      'created at' => l10n.activityCreatedAt,
      'updated at' => l10n.activityUpdatedAt,
      _ => label,
    };

String _detailValue(ActivityField field, AppLocalizations l10n) {
  final label = field.label.trim().toLowerCase();
  if (label == 'side') {
    return switch (field.value.trim().toLowerCase()) {
      'long' => l10n.long,
      'short' => l10n.short,
      'buy' => l10n.buy,
      'sell' => l10n.sell,
      _ => field.value,
    };
  }
  return field.value;
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

String _activityTypeLabel(String type, AppLocalizations l10n) => switch (type) {
  'deposit' => l10n.deposit,
  'transfer' || 'bridge' => l10n.transfer,
  _ => type.isEmpty ? l10n.activity : type[0].toUpperCase() + type.substring(1),
};

String _orderTypeLabel(ActivityRecord record, AppLocalizations l10n) {
  switch (record.businessType) {
    case ActivityBusinessType.takeProfit:
      return l10n.takeProfit;
    case ActivityBusinessType.stopLoss:
      return l10n.stopLoss;
    case ActivityBusinessType.closing:
      return l10n.close;
    case ActivityBusinessType.opening:
      break;
    case ActivityBusinessType.unknown || null:
      final value = record.type.toLowerCase();
      if (value == 'stop_loss') return l10n.stopLoss;
      if (value == 'take_profit') return l10n.takeProfit;
      if (value == 'close') return l10n.close;
      if (value == 'liquidation') return l10n.liquidation;
      if (value == 'tpsl') {
        final title = record.title.toLowerCase();
        return title.contains('stop') ? l10n.stopLoss : l10n.takeProfit;
      }
  }
  if (record.type.toLowerCase() == 'liquidation') return l10n.liquidation;
  final execution = record.type.toLowerCase() == 'market'
      ? l10n.market
      : l10n.limitPrice;
  final side = _orderSideLabel(record, l10n);
  if (side != null) return '$side / $execution';
  final title = record.title.toLowerCase();
  if (title.contains('sell') || title.contains('short')) {
    return '${l10n.sell} / $execution';
  }
  return '${l10n.buy} / $execution';
}

bool _orderTypeConveysDirection(ActivityRecord record, AppLocalizations l10n) {
  final label = _orderTypeLabel(record, l10n);
  return [
    l10n.buy,
    l10n.sell,
    l10n.long,
    l10n.short,
  ].any((direction) => label == direction || label.startsWith('$direction /'));
}

String? _orderSideLabel(ActivityRecord record, AppLocalizations l10n) {
  for (final field in record.fields) {
    if (field.label.trim().toLowerCase() != 'side') continue;
    return switch (field.value.trim().toLowerCase()) {
      'buy' => l10n.buy,
      'sell' => l10n.sell,
      'long' => l10n.long,
      'short' => l10n.short,
      _ => null,
    };
  }
  return null;
}

String _orderTitle(ActivityRecord record) {
  final symbol = record.symbol?.trim();
  return symbol == null || symbol.isEmpty ? record.title : symbol;
}

String _cashTitle(ActivityRecord record) {
  final flow = record.cashFlow;
  if (flow != null) return '${flow.source.asset} → ${flow.destination.asset}';
  final title = record.title.trim();
  if (title.isNotEmpty &&
      !const {
        'transfer',
        'bridge',
        'deposit',
        'withdrawal',
        'withdraw',
      }.contains(title.toLowerCase())) {
    return title;
  }
  final asset =
      _tokenSymbol(record.asset) ?? _tokenSymbol(record.amount?.asset);
  if (record.type == 'bridge' || record.type == 'transfer') {
    final from = _cashFieldToken(record, 'send');
    final to = _cashFieldToken(record, 'receive');
    if (from != null && to != null) return '$from→$to';
    // Some activity responses already provide the token pair as symbol.
    final symbol = record.symbol?.trim();
    if (symbol != null && symbol.isNotEmpty) return symbol;
    return from ?? to ?? asset ?? record.title;
  }
  return asset ?? _tokenSymbol(record.symbol) ?? record.title;
}

String? _cashFieldToken(ActivityRecord record, String direction) {
  for (final field in record.fields) {
    final label = field.label.trim().toLowerCase().replaceAll('_', ' ');
    if (label == '$direction token' || label == '$direction token symbol') {
      final symbol = _tokenSymbol(field.value);
      if (symbol != null) return symbol;
    }
    if (label == '$direction amount') {
      final parts = field.value.trim().split(RegExp(r'\s+'));
      if (parts.length == 2) {
        final symbol = _tokenSymbol(parts.last);
        if (symbol != null) return symbol;
      }
    }
  }
  return null;
}

String? _tokenSymbol(String? value) {
  final symbol = value?.trim();
  // Token address fields are not token symbols and must not become titles.
  if (symbol == null ||
      symbol.startsWith('0x') ||
      !RegExp(r'^[A-Za-z][A-Za-z0-9.\-]{0,19}$').hasMatch(symbol)) {
    return null;
  }
  return symbol;
}

String _fundingSide(ActivityRecord record, AppLocalizations l10n) {
  final value = '${record.title} ${record.context ?? ''}'.toLowerCase();
  return value.contains('short') || value.contains('sell')
      ? l10n.short
      : l10n.long;
}

String _fundingDirection(ActivityRecord record, AppLocalizations l10n) {
  final value = '${record.title} ${record.context ?? ''}'.toLowerCase();
  return value.contains('pay') || value.contains('fee')
      ? l10n.pay
      : l10n.receive;
}

List<({String chain, String label})> _networks(ActivityRecord record) {
  final flow = record.cashFlow;
  if (flow != null) {
    return [
      for (final endpoint in [flow.source, flow.destination])
        (chain: endpoint.chain, label: _cashNetworkLabel(endpoint)),
    ];
  }
  // A legacy cash row proves only its evidence chain, not the other endpoint.
  if (record.category == ActivityCategory.cash) {
    return record.chain == null
        ? const []
        : [(chain: record.chain!, label: networkDisplayName(record.chain!))];
  }
  final matches = RegExp(
    r'(BSC|Polygon|Arbitrum|Base|Ethereum|Solana)',
    caseSensitive: false,
  ).allMatches(record.context ?? '').map((match) => match.group(1)!).toList();
  final chains = matches.isNotEmpty
      ? matches
      : record.chain == null
      ? const <String>[]
      : [record.chain!];
  return [
    for (final chain in chains)
      (chain: chain, label: networkDisplayName(chain)),
  ];
}

String _cashNetworkLabel(ActivityCashFlowEndpoint endpoint) =>
    switch ((endpoint.chain, endpoint.chainId)) {
      ('BSC', '97') => 'BSC Testnet',
      ('Arbitrum', '421614') => 'Arbitrum Sepolia',
      ('Ethereum', '11155111') => 'Sepolia',
      ('Base', '84532') => 'Base Sepolia',
      ('Polygon', '80002') => 'Polygon Amoy',
      ('BSC', '56') ||
      ('Arbitrum', '42161') ||
      ('Ethereum', '1') ||
      ('Base', '8453') ||
      ('Polygon', '137') ||
      (_, null) => networkDisplayName(endpoint.chain),
      (_, final id) => '${networkDisplayName(endpoint.chain)} ($id)',
    };

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
    ActivityState.refundPending => l10n.activityRefundPending,
    ActivityState.refunded => l10n.activityRefunded,
    ActivityState.credited => l10n.activityCredited,
    ActivityState.reserved => l10n.fundsReserved,
    ActivityState.sourceDebited => l10n.activitySourceDebited,
    ActivityState.inTransit => l10n.fundsInTransit,
    ActivityState.partiallySettled => l10n.transferPartiallySettled,
    ActivityState.partiallyRefunded => l10n.fundsPartiallyRefunded,
    ActivityState.compensated => l10n.fundsCompensated,
    ActivityState.released => l10n.fundsReleased,
    ActivityState.settled => l10n.activitySettled,
    ActivityState.manualReview => l10n.activityManualReview,
    ActivityState.failed => l10n.activityFailed,
    ActivityState.cancelled => l10n.activityCancelled,
    ActivityState.unknown => l10n.activityUnknown,
  };
}

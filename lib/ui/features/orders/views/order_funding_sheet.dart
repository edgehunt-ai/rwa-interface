import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/routing/routes.dart';
import '../../../../domain/models/api_failure.dart';
import '../../../../domain/models/decimal_value.dart';
import '../../../../domain/models/funding_catalog.dart';
import '../../../../domain/models/funding_transfer.dart';
import '../../../../domain/models/market_product.dart';
import '../../../../l10n/generated/app_localizations.dart';
import '../../../core/feedback/inline_error_notice.dart';
import '../../../core/formatters/token_amount_formatter.dart';
import '../../../core/theme/app_theme.dart';
import '../../funding/providers/funding_transfer_providers.dart';

class OrderFundingSheet extends ConsumerStatefulWidget {
  const OrderFundingSheet({
    super.key,
    required this.plan,
    required this.kind,
    required this.canConfirmTransfer,
    this.slippage,
  });
  final FundingPlan plan;
  final MarketProductKind kind;
  final bool canConfirmTransfer;
  final DecimalValue? slippage;

  @override
  ConsumerState<OrderFundingSheet> createState() => _OrderFundingSheetState();
}

class _OrderFundingSheetState extends ConsumerState<OrderFundingSheet> {
  late FundingPlan _plan = widget.plan;
  bool _busy = false;
  bool _pending = false;
  bool _transferSubmitted = false;
  bool _polling = false;
  Timer? _pollTimer;
  bool _transferStep = false;
  String? _error;

  String get _targetAsset => _displayTargetAsset(
    _plan.targetAsset ??
        (widget.kind == MarketProductKind.bstock ? 'USDT' : 'USDC'),
  );

  String get _targetNetwork =>
      _plan.targetNetwork ??
      (widget.kind == MarketProductKind.bstock ? 'BSC' : 'Hyperliquid');

  @override
  void dispose() {
    _pollTimer?.cancel();
    super.dispose();
  }

  Future<void> _continue({bool refresh = false}) async {
    if (_busy || !widget.canConfirmTransfer) return;
    setState(() {
      _busy = true;
      if (!refresh) _pending = true;
      _error = null;
    });
    try {
      final commands = ref.read(fundingTransferCommandsProvider);
      if (refresh) {
        _plan = await commands.refresh(_plan.planId);
      } else {
        final authorization = await commands.authorize(_plan);
        final transfer = await commands.create(
          plan: _plan,
          authorization: authorization,
        );
        if (!mounted) return;
        setState(() {
          _transferSubmitted = true;
          _error = transfer.failureReason;
        });
        _plan = await commands.refresh(_plan.planId);
      }
      if (!mounted) return;
      if (_plan.status == FundingPlanState.alreadyFunded) {
        Navigator.of(context).pop(true);
        return;
      }
      _pending =
          _plan.isExecuting || _plan.legs.any((leg) => leg.transferId != null);
    } on Object catch (error) {
      if (mounted) {
        _error = error is ApiFailure
            ? apiFailureMessage(
                error,
                fallback: AppLocalizations.of(context).transferStartFailed,
              )
            : error.toString();
        _pending = _transferSubmitted;
      }
    } finally {
      if (mounted) {
        setState(() => _busy = false);
        if (_pending) _startPolling();
      }
    }
  }

  void _startPolling() {
    if (!_pending || _pollTimer != null) return;
    _pollTimer = Timer.periodic(
      const Duration(seconds: 2),
      (_) => unawaited(_pollFundingPlan()),
    );
    unawaited(_pollFundingPlan());
  }

  Future<void> _pollFundingPlan() async {
    if (_polling || !_pending || !mounted) return;
    _polling = true;
    try {
      final plan = await ref
          .read(fundingTransferCommandsProvider)
          .reconcile(_plan);
      if (!mounted) return;
      if (plan.status == FundingPlanState.alreadyFunded) {
        _stopPolling();
        Navigator.of(context).pop(true);
        return;
      }
      final remainsPending =
          plan.isExecuting || plan.legs.any((leg) => leg.transferId != null);
      setState(() {
        _plan = plan;
        _pending = remainsPending;
        if (!remainsPending) {
          _error =
              plan.blocker ?? AppLocalizations.of(context).transferStartFailed;
        }
      });
      if (!remainsPending) _stopPolling();
    } on Object catch (error) {
      if (mounted && error is! ApiFailure) {
        setState(() => _error = error.toString());
      }
    } finally {
      _polling = false;
    }
  }

  void _stopPolling() {
    _pollTimer?.cancel();
    _pollTimer = null;
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppRwaColors>()!;
    final options = ref.watch(transferOptionsProvider);
    final spotBalance = switch (options) {
      AsyncData(:final value) => value.account.availableToFundUsd,
      _ => null,
    };
    final spotBalanceLoading = options is AsyncLoading<TransferOptions>;
    final canUseSpot =
        widget.canConfirmTransfer &&
        switch (options) {
          AsyncLoading() => true,
          AsyncData(:final value) =>
            DecimalValue(value.account.availableToFundUsd.value)
                    .compareMagnitudeTo(DecimalValue(_plan.shortfall.value)) >=
                0,
          _ => false,
        };
    return PopScope(
      canPop: !_busy || _transferSubmitted,
      child: Material(
        color: colors.surface,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        clipBehavior: Clip.antiAlias,
        child: SafeArea(
          top: false,
          child: SingleChildScrollView(
            padding: EdgeInsets.fromLTRB(20, 12, 20, _transferStep ? 24 : 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const _DragHandle(),
                const SizedBox(height: 16),
                _Steps(current: _transferStep ? 2 : 1),
                const SizedBox(height: 16),
                Divider(height: 1, color: colors.subtleSurface),
                const SizedBox(height: 16),
                if (_transferStep && _pending)
                  OrderFundingPendingContent(
                    transferSubmitted: _transferSubmitted,
                    onClose: () => Navigator.of(context).pop(false),
                  )
                else if (_transferStep)
                  switch (options) {
                    AsyncData(:final value) => _TransferContent(
                      plan: _plan,
                      fallbackTargetAsset: _targetAsset,
                      slippage: widget.slippage,
                      busy: _busy,
                      pending: _pending,
                      error: _error,
                      availableByPositionId: {
                        for (final position in value.account.positions)
                          position.positionId: position.availableAmount,
                      },
                      onBack: () => setState(() => _transferStep = false),
                      onConfirm: () => _continue(),
                      onRetry: () => _continue(refresh: true),
                    ),
                    _ => _TransferContent(
                      plan: _plan,
                      fallbackTargetAsset: _targetAsset,
                      slippage: widget.slippage,
                      busy: _busy,
                      pending: _pending,
                      error: _error,
                      onBack: () => setState(() => _transferStep = false),
                      onConfirm: () => _continue(),
                      onRetry: () => _continue(refresh: true),
                    ),
                  }
                else
                  _PrepareContent(
                    plan: _plan,
                    targetAsset: _targetAsset,
                    targetNetwork: _targetNetwork,
                    spotBalance: spotBalance,
                    spotBalanceLoading: spotBalanceLoading,
                    sourcePositions: switch (options) {
                      AsyncData(:final value) =>
                        value.account.positions
                            .where((position) => position.eligible)
                            .toList(growable: false),
                      _ => const [],
                    },
                    showSpot: canUseSpot,
                    onSpot: () => setState(() => _transferStep = true),
                    onDeposit: () {
                      final router = GoRouter.of(context);
                      Navigator.of(context).pop(false);
                      router.pushNamed(AppRoutes.depositSelectName);
                    },
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _DragHandle extends StatelessWidget {
  const _DragHandle();
  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppRwaColors>()!;
    return Center(
      child: Container(
        width: 32,
        height: 4,
        decoration: BoxDecoration(
          color: colors.secondaryText.withValues(alpha: .45),
          borderRadius: BorderRadius.circular(2),
        ),
      ),
    );
  }
}

class _Steps extends StatelessWidget {
  const _Steps({required this.current});
  final int current;
  @override
  Widget build(BuildContext context) => Row(
    children: [
      if (current == 2) ...[
        const _Circle(child: Icon(Icons.check, size: 18)),
        const SizedBox(width: 8),
      ],
      _Circle(active: true, child: Text('$current')),
      const SizedBox(width: 4),
      Flexible(
        child: Text(
          current == 1
              ? AppLocalizations.of(context).prepareFunds
              : AppLocalizations.of(context).transfer,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            fontSize: 20,
            height: 26 / 20,
            fontWeight: FontWeight.w600,
            letterSpacing: 0,
          ),
        ),
      ),
      const SizedBox(width: 8),
      if (current == 1) ...[
        const _Circle(child: Text('2')),
        const SizedBox(width: 8),
      ],
      const _Circle(child: Text('3')),
    ],
  );
}

class _Circle extends StatelessWidget {
  const _Circle({required this.child, this.active = false});
  final Widget child;
  final bool active;
  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppRwaColors>()!;
    return Container(
      width: 28,
      height: 28,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: active ? colors.primaryAction : colors.subtleSurface,
      ),
      child: DefaultTextStyle(
        style: TextStyle(
          fontSize: 13,
          height: 18 / 13,
          fontWeight: FontWeight.w600,
          color: active ? colors.onPrimaryAction : colors.tertiaryText,
        ),
        child: child,
      ),
    );
  }
}

class _PrepareContent extends StatelessWidget {
  const _PrepareContent({
    required this.plan,
    required this.targetAsset,
    required this.targetNetwork,
    required this.spotBalance,
    required this.spotBalanceLoading,
    required this.sourcePositions,
    required this.showSpot,
    required this.onSpot,
    required this.onDeposit,
  });
  final FundingPlan plan;
  final String targetAsset;
  final String targetNetwork;
  final DecimalValue? spotBalance;
  final bool spotBalanceLoading;
  final List<FundingSourcePosition> sourcePositions;
  final bool showSpot;
  final VoidCallback onSpot;
  final VoidCallback onDeposit;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final required = TokenAmountFormatter.formatValue(
      plan.requiredTargetAmount ?? plan.shortfall,
    );
    final available = plan.targetAvailableAmount == null
        ? '0'
        : TokenAmountFormatter.formatValue(plan.targetAvailableAmount!);
    final shortfall = TokenAmountFormatter.formatValue(plan.shortfall);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          l10n.addFundingOnNetworkToContinue(
            shortfall,
            targetAsset,
            targetNetwork,
          ),
          style: const TextStyle(
            fontSize: 17,
            height: 26 / 17,
            fontWeight: FontWeight.w600,
            letterSpacing: 0,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          l10n.fundingReadyDescription(available, targetAsset, targetNetwork),
          style: TextStyle(
            fontSize: 13,
            height: 18 / 13,
            fontWeight: FontWeight.w500,
            color: Theme.of(context).extension<AppRwaColors>()!.secondaryText,
          ),
        ),
        const SizedBox(height: 12),
        _Breakdown(
          required: required,
          available: available,
          shortfall: shortfall,
          asset: targetAsset,
          network: targetNetwork,
          otherAssetsUsd: spotBalance == null
              ? null
              : TokenAmountFormatter.formatValue(spotBalance!),
          otherAssetsLoading: spotBalanceLoading,
          sourcePositions: sourcePositions,
        ),
        const SizedBox(height: 16),
        Text(
          l10n.addFundingAmountFrom(shortfall, targetAsset),
          style: Theme.of(context).textTheme.labelMedium,
        ),
        const SizedBox(height: 8),
        if (showSpot) ...[
          _SourceTile(
            key: const Key('order-funding-spot-option'),
            iconAsset: 'assets/figma/funding/order_funding_trade.svg',
            title: l10n.transferExistingBalances,
            detail: l10n.chooseAssetsToTransfer,
            onTap: onSpot,
          ),
          const SizedBox(height: 12),
        ],
        _SourceTile(
          key: const Key('order-funding-deposit-option'),
          iconAsset: 'assets/figma/funding/order_funding_deposit.svg',
          title: l10n.deposit,
          detail: l10n.fromAnotherWalletOrPlatform,
          onTap: onDeposit,
        ),
      ],
    );
  }
}

class _Breakdown extends StatelessWidget {
  const _Breakdown({
    required this.required,
    required this.available,
    required this.shortfall,
    required this.asset,
    required this.network,
    required this.otherAssetsUsd,
    required this.otherAssetsLoading,
    required this.sourcePositions,
  });
  final String required, available, shortfall, asset, network;
  final String? otherAssetsUsd;
  final bool otherAssetsLoading;
  final List<FundingSourcePosition> sourcePositions;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppRwaColors>()!;
    final l10n = AppLocalizations.of(context);
    return Container(
      key: const Key('order-funding-breakdown'),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        border: Border.all(color: colors.border),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        children: [
          _FundingSummaryRow(
            label: l10n.orderValue,
            amount: required,
            asset: asset,
            network: network,
          ),
          const SizedBox(height: 12),
          _FundingSummaryRow(
            label: l10n.readyOnNetwork(network),
            amount: available,
            asset: asset,
            network: network,
          ),
          const SizedBox(height: 12),
          _OtherAssetsRow(
            value: otherAssetsUsd,
            loading: otherAssetsLoading,
            positions: sourcePositions,
          ),
          const SizedBox(height: 12),
          Container(height: 1, color: colors.border),
          const SizedBox(height: 12),
          _FundingSummaryRow(
            label: l10n.stillNeeded,
            amount: shortfall,
            asset: asset,
            network: network,
            emphasized: true,
          ),
        ],
      ),
    );
  }
}

class _FundingSummaryRow extends StatelessWidget {
  const _FundingSummaryRow({
    required this.label,
    required this.amount,
    required this.asset,
    required this.network,
    this.emphasized = false,
  });
  final String label, amount, asset, network;
  final bool emphasized;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppRwaColors>()!;
    return SizedBox(
      height: 24,
      child: Row(
        children: [
          Expanded(
            child: Text(
              label,
              style: TextStyle(
                fontSize: emphasized ? 13 : 12,
                height: 18 / (emphasized ? 13 : 12),
                fontWeight: emphasized ? FontWeight.w600 : FontWeight.w500,
                color: emphasized ? colors.primaryText : colors.secondaryText,
              ),
            ),
          ),
          const SizedBox(width: 8),
          Text(
            '$amount $asset',
            maxLines: 1,
            style: const TextStyle(
              fontSize: 13,
              height: 18 / 13,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(width: 8),
          _CompactAssetIcon(asset: asset, network: network),
        ],
      ),
    );
  }
}

class _OtherAssetsRow extends StatelessWidget {
  const _OtherAssetsRow({
    required this.value,
    required this.loading,
    required this.positions,
  });

  final String? value;
  final bool loading;
  final List<FundingSourcePosition> positions;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppRwaColors>()!;
    final l10n = AppLocalizations.of(context);
    final networks = positions.map((position) => position.network).toSet();
    return SizedBox(
      key: const Key('order-funding-other-assets-row'),
      height: 32,
      child: Row(
        children: [
          Expanded(
            child: Text(
              l10n.otherAssets,
              style: TextStyle(
                fontSize: 12,
                height: 18 / 12,
                fontWeight: FontWeight.w500,
                color: colors.secondaryText,
              ),
            ),
          ),
          SizedBox(
            height: 32,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                if (loading)
                  const SizedBox(
                    height: 18,
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: SizedBox.square(
                        key: Key('order-funding-spot-balance-loading'),
                        dimension: 14,
                        child: CircularProgressIndicator(strokeWidth: 1.5),
                      ),
                    ),
                  )
                else
                  Text(
                    '\$${value ?? '--'}',
                    maxLines: 1,
                    style: const TextStyle(
                      fontSize: 13,
                      height: 18 / 13,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                SizedBox(
                  height: 14,
                  child: networks.isEmpty
                      ? null
                      : Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            _NetworkStack(networks: networks.take(2).toList()),
                            const SizedBox(width: 4),
                            Text(
                              l10n.otherNetworks(networks.length),
                              maxLines: 1,
                              style: TextStyle(
                                fontSize: 11,
                                height: 14 / 11,
                                color: colors.secondaryText,
                              ),
                            ),
                          ],
                        ),
                ),
              ],
            ),
          ),
          if (positions.isNotEmpty) ...[
            const SizedBox(width: 8),
            _MiniAssetGrid(positions: positions.take(4).toList()),
          ],
        ],
      ),
    );
  }
}

class _SourceTile extends StatelessWidget {
  const _SourceTile({
    super.key,
    required this.iconAsset,
    required this.title,
    required this.detail,
    required this.onTap,
  });
  final String iconAsset;
  final String title;
  final String detail;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppRwaColors>()!;
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(14),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: colors.subtleSurface,
          borderRadius: BorderRadius.circular(14),
        ),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: colors.surface,
                borderRadius: BorderRadius.circular(12),
              ),
              child: SvgPicture.asset(iconAsset, width: 20, height: 20),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: SizedBox(
                height: 40,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 15,
                        height: 22 / 15,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      detail,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
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
            SvgPicture.asset(
              'assets/figma/funding/chevron_right.svg',
              width: 20,
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}

class _CompactAssetIcon extends StatelessWidget {
  const _CompactAssetIcon({required this.asset, required this.network});

  final String asset;
  final String network;

  @override
  Widget build(BuildContext context) => SizedBox.square(
    dimension: 24,
    child: Stack(
      clipBehavior: Clip.none,
      children: [
        _TokenIcon(asset: asset, size: 24),
        Positioned(
          right: 0,
          bottom: 0,
          child: _NetworkIcon(network: network, size: 12),
        ),
      ],
    ),
  );
}

class _NetworkStack extends StatelessWidget {
  const _NetworkStack({required this.networks});

  final List<String> networks;

  @override
  Widget build(BuildContext context) {
    final visible = networks
        .where((network) => _networkAssetPath(network) != null)
        .toList(growable: false);
    return SizedBox(
      width: visible.isEmpty ? 0 : 12 + (visible.length - 1) * 8,
      height: 12,
      child: Stack(
        children: [
          for (var index = 0; index < visible.length; index++)
            Positioned(
              left: index * 8,
              child: _NetworkIcon(network: visible[index], size: 12),
            ),
        ],
      ),
    );
  }
}

class _MiniAssetGrid extends StatelessWidget {
  const _MiniAssetGrid({required this.positions});

  final List<FundingSourcePosition> positions;

  @override
  Widget build(BuildContext context) => SizedBox.square(
    dimension: 24,
    child: Wrap(
      spacing: 1,
      runSpacing: 1,
      children: [
        for (final position in positions)
          SizedBox.square(
            dimension: 11.5,
            child: ClipOval(
              child: _TokenIcon(asset: position.token, size: 11.5),
            ),
          ),
      ],
    ),
  );
}

class _TransferContent extends StatelessWidget {
  const _TransferContent({
    required this.plan,
    required this.fallbackTargetAsset,
    required this.slippage,
    required this.busy,
    required this.pending,
    required this.error,
    required this.onBack,
    required this.onConfirm,
    required this.onRetry,
    this.availableByPositionId = const {},
  });
  final FundingPlan plan;
  final String fallbackTargetAsset;
  final DecimalValue? slippage;
  final bool busy, pending;
  final String? error;
  final VoidCallback onBack, onConfirm, onRetry;
  final Map<String, DecimalValue> availableByPositionId;

  @override
  Widget build(BuildContext context) {
    final leg = plan.nextActionableLeg ?? plan.legs.firstOrNull;
    final l10n = AppLocalizations.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          l10n.transferFromSpot,
          style: Theme.of(context).textTheme.labelMedium,
        ),
        const SizedBox(height: 8),
        _AssetsCard(
          legs: plan.legs,
          availableByPositionId: availableByPositionId,
          targetAsset: _displayTargetAsset(
            plan.targetAsset ?? fallbackTargetAsset,
          ),
          targetNetwork: plan.targetNetwork,
          targetAmount: _outputAmount(plan),
        ),
        const SizedBox(height: 16),
        _RouteRows(leg: leg, slippage: slippage),
        const SizedBox(height: 28),
        if (error != null) ...[
          InlineErrorNotice(
            key: const Key('order-funding-error'),
            message: error!,
          ),
          const SizedBox(height: 8),
        ],
        Row(
          children: [
            SizedBox(
              width: 160,
              height: 48,
              child: OutlinedButton(
                onPressed: busy ? null : onBack,
                child: Text(l10n.back),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: SizedBox(
                height: 48,
                child: FilledButton(
                  onPressed: busy
                      ? null
                      : pending
                      ? onRetry
                      : plan.isActionable
                      ? onConfirm
                      : null,
                  child: busy
                      ? const SizedBox.square(
                          dimension: 20,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : Text(pending ? l10n.retry : l10n.confirm),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  static String _outputAmount(FundingPlan plan) {
    if (plan.legs.isEmpty) return plan.shortfall.value;
    var total = plan.legs.first.outputAmount;
    for (final leg in plan.legs.skip(1)) {
      try {
        total = total.plusMagnitude(leg.outputAmount);
      } on ArgumentError {
        return plan.shortfall.value;
      }
    }
    return total.value;
  }
}

String _displayTargetAsset(String asset) =>
    asset.toUpperCase().replaceFirst(RegExp(r'-PERPS$'), '');

class OrderFundingPendingContent extends StatelessWidget {
  const OrderFundingPendingContent({
    super.key,
    required this.transferSubmitted,
    this.onClose,
  });

  final bool transferSubmitted;
  final VoidCallback? onClose;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppRwaColors>()!;
    final l10n = AppLocalizations.of(context);
    return Column(
      key: const Key('order-funding-transfer-pending'),
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Image.asset(
          'assets/figma/trade/funding_pending.webp',
          width: 120,
          height: 120,
        ),
        Text(
          l10n.preparingTradingFunds,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 17,
            height: 22 / 17,
            fontWeight: FontWeight.w600,
            letterSpacing: -.1,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          l10n.bridgeInProgress,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: colors.secondaryText,
            fontSize: 12,
            height: 16 / 12,
          ),
        ),
        if (transferSubmitted && onClose != null) ...[
          const SizedBox(height: 16),
          SizedBox(
            height: 48,
            child: OutlinedButton(
              key: const Key('order-funding-close-view-later'),
              onPressed: onClose,
              style: OutlinedButton.styleFrom(
                backgroundColor: colors.subtleSurface,
                side: BorderSide(color: colors.border),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
              child: Text(l10n.closeViewLater),
            ),
          ),
        ],
      ],
    );
  }
}

class _AssetsCard extends StatelessWidget {
  const _AssetsCard({
    required this.legs,
    required this.targetAsset,
    required this.targetAmount,
    required this.targetNetwork,
    this.availableByPositionId = const {},
  });
  final List<FundingLeg> legs;
  final String targetAsset, targetAmount;
  final String? targetNetwork;
  final Map<String, DecimalValue> availableByPositionId;
  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppRwaColors>()!;
    return ClipRRect(
      borderRadius: BorderRadius.circular(14),
      child: ColoredBox(
        color: colors.canvas,
        child: Column(
          children: [
            _FundingLegs(
              legs: legs,
              availableByPositionId: availableByPositionId,
            ),
            _TargetAssetRow(
              asset: targetAsset,
              network: targetNetwork,
              amount: targetAmount,
            ),
          ],
        ),
      ),
    );
  }
}

class _FundingLegs extends StatefulWidget {
  const _FundingLegs({
    required this.legs,
    this.availableByPositionId = const {},
  });

  final List<FundingLeg> legs;
  final Map<String, DecimalValue> availableByPositionId;

  @override
  State<_FundingLegs> createState() => _FundingLegsState();
}

class _FundingLegsState extends State<_FundingLegs> {
  static const _rowHeight = 63.0;
  static const _maximumVisibleRows = 4;
  final _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.legs.length <= _maximumVisibleRows) {
      return Column(
        children: [
          for (final leg in widget.legs)
            _AssetRow(
              leg: leg,
              available: widget.availableByPositionId[leg.sourcePositionId],
              showConnector: true,
            ),
        ],
      );
    }

    return SizedBox(
      key: const Key('order-funding-token-scroll'),
      height: _rowHeight * _maximumVisibleRows,
      child: Scrollbar(
        controller: _scrollController,
        thumbVisibility: true,
        child: ListView.builder(
          controller: _scrollController,
          padding: EdgeInsets.zero,
          itemCount: widget.legs.length,
          itemExtent: _rowHeight,
          itemBuilder: (context, index) {
            final leg = widget.legs[index];
            return _AssetRow(
              leg: leg,
              available: widget.availableByPositionId[leg.sourcePositionId],
              showConnector: true,
            );
          },
        ),
      ),
    );
  }
}

class _AssetRow extends StatelessWidget {
  const _AssetRow({
    required this.leg,
    required this.showConnector,
    this.available,
  });
  final FundingLeg leg;
  final bool showConnector;
  final DecimalValue? available;
  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppRwaColors>()!;
    final l10n = AppLocalizations.of(context);
    final network = leg.network;
    final availableAmount = available;
    return Container(
      height: 63,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: colors.surface)),
      ),
      child: Row(
        children: [
          _RouteAssetIcon(
            asset: leg.asset,
            network: network,
            showConnector: showConnector,
          ),
          const SizedBox(width: 4),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                  text: TextSpan(
                    style: TextStyle(
                      fontSize: 13,
                      height: 18 / 13,
                      color: colors.primaryText,
                    ),
                    children: [
                      TextSpan(
                        text: leg.asset,
                        style: const TextStyle(fontWeight: FontWeight.w600),
                      ),
                      TextSpan(
                        text: network == null || network.isEmpty
                            ? ''
                            : ' ($network)',
                        style: TextStyle(
                          fontSize: 11,
                          color: colors.secondaryText,
                        ),
                      ),
                    ],
                  ),
                ),
                Text(
                  l10n.availableAmount(
                    availableAmount == null
                        ? '-'
                        : TokenAmountFormatter.formatValue(availableAmount),
                  ),
                  style: TextStyle(
                    fontSize: 11,
                    height: 14 / 11,
                    color: colors.secondaryText,
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: 88,
            height: 32,
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              color: colors.subtleSurface,
              border: Border.all(color: colors.border),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              TokenAmountFormatter.formatValue(leg.maximumAmount),
              maxLines: 1,
              softWrap: false,
              overflow: TextOverflow.fade,
              style: const TextStyle(
                fontSize: 15,
                height: 22 / 15,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _TargetAssetRow extends StatelessWidget {
  const _TargetAssetRow({
    required this.asset,
    required this.network,
    required this.amount,
  });

  final String asset;
  final String? network;
  final String amount;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppRwaColors>()!;
    return SizedBox(
      height: 63,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: Row(
          children: [
            _RouteAssetIcon(asset: asset, network: network),
            const SizedBox(width: 4),
            Expanded(
              child: Text.rich(
                TextSpan(
                  style: TextStyle(
                    fontSize: 13,
                    height: 18 / 13,
                    color: colors.primaryText,
                  ),
                  children: [
                    TextSpan(
                      text: asset,
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                    if (network != null && network!.isNotEmpty)
                      TextSpan(
                        text: ' ($network)',
                        style: TextStyle(
                          fontSize: 11,
                          color: colors.secondaryText,
                        ),
                      ),
                  ],
                ),
              ),
            ),
            Text(
              amount,
              style: const TextStyle(
                fontSize: 15,
                height: 22 / 15,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _RouteAssetIcon extends StatelessWidget {
  const _RouteAssetIcon({
    required this.asset,
    required this.network,
    this.showConnector = false,
  });

  final String asset;
  final String? network;
  final bool showConnector;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppRwaColors>()!;
    return SizedBox(
      width: 32,
      height: 32,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          if (showConnector)
            Positioned(
              left: 13,
              top: 27,
              child: Container(width: 2, height: 18, color: colors.border),
            ),
          _TokenIcon(asset: asset),
          if (_networkAssetPath(network) != null)
            Positioned(
              right: 0,
              bottom: 0,
              child: _NetworkIcon(network: network!, size: 12),
            ),
        ],
      ),
    );
  }
}

class _TokenIcon extends StatelessWidget {
  const _TokenIcon({required this.asset, this.size = 28});

  final String asset;
  final double size;

  @override
  Widget build(BuildContext context) {
    if (asset.toUpperCase().startsWith('USDC')) {
      return SvgPicture.asset(
        'assets/figma/funding/usdc.svg',
        width: size,
        height: size,
      );
    }
    if (asset.toUpperCase() == 'ETH') {
      return SvgPicture.asset(
        'assets/figma/funding/eth.svg',
        width: size,
        height: size,
      );
    }
    return Image.asset(
      'assets/figma/funding/usdt.png',
      width: size,
      height: size,
    );
  }
}

class _NetworkIcon extends StatelessWidget {
  const _NetworkIcon({required this.network, required this.size});

  final String network;
  final double size;

  @override
  Widget build(BuildContext context) {
    final path = _networkAssetPath(network);
    if (path == null) return const SizedBox.shrink();
    if (network.toLowerCase() != 'arbitrum') {
      return SvgPicture.asset(path, width: size, height: size);
    }

    final colors = Theme.of(context).extension<AppRwaColors>()!;
    return Container(
      width: size,
      height: size,
      padding: EdgeInsets.symmetric(
        horizontal: size * 0.165,
        vertical: size * 0.125,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFF2F3749),
        border: Border.all(color: colors.border, width: size / 16),
        borderRadius: BorderRadius.circular(size / 4),
      ),
      child: SvgPicture.asset(path),
    );
  }
}

String? _networkAssetPath(String? network) => switch (network?.toLowerCase()) {
  'polygon' => 'assets/figma/funding/polygon.svg',
  'bsc' || 'bnb chain' => 'assets/figma/common/network_bsc.svg',
  'arbitrum' => 'assets/figma/portfolio/network_arbitrum_mark.svg',
  'hyperliquid' => 'assets/figma/home_markets/venue_hyperliquid.svg',
  _ => null,
};

class _RouteRows extends StatelessWidget {
  const _RouteRows({required this.leg, required this.slippage});
  final FundingLeg? leg;
  final DecimalValue? slippage;
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Column(
      children: [
        _InfoRow(label: l10n.estimateTime, value: _eta(l10n, leg?.etaSeconds)),
        const SizedBox(height: 8),
        _InfoRow(
          label: l10n.bridgeFee,
          value: _fee(leg?.bridgeFee, leg?.feeAsset),
        ),
        const SizedBox(height: 8),
        _InfoRow(
          label: l10n.networkFee,
          value: _fee(leg?.networkFee, leg?.feeAsset),
        ),
        if (slippage != null) ...[
          const SizedBox(height: 8),
          _InfoRow(
            label: l10n.slippage,
            labelIcon: 'assets/figma/trade/order_slippage_edit.svg',
            value: '${TokenAmountFormatter.formatValue(slippage!)}%',
          ),
        ],
      ],
    );
  }

  static String _eta(AppLocalizations l10n, int? seconds) {
    if (seconds == null) return '--';
    final minutes = (seconds / 60).ceil().clamp(1, 999);
    return minutes == 1 ? l10n.oneMinute : l10n.minutesRange(minutes);
  }

  static String _fee(DecimalValue? fee, String? asset) {
    if (fee == null) return '--';
    return asset == 'USD'
        ? '\$${TokenAmountFormatter.formatValue(fee)}'
        : '${TokenAmountFormatter.formatValue(fee)} ${asset ?? ''}'.trim();
  }
}

class _InfoRow extends StatelessWidget {
  const _InfoRow({required this.label, required this.value, this.labelIcon});
  final String label, value;
  final String? labelIcon;
  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppRwaColors>()!;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: 13,
                height: 18 / 13,
                fontWeight: FontWeight.w500,
                color: colors.secondaryText,
              ),
            ),
            if (labelIcon != null) ...[
              const SizedBox(width: 4),
              SvgPicture.asset(labelIcon!, width: 12, height: 12),
            ],
          ],
        ),
        Text(
          value,
          style: const TextStyle(
            fontSize: 13,
            height: 18 / 13,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}

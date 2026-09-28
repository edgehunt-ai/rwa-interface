import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/routing/routes.dart';
import '../../../../domain/models/api_failure.dart';
import '../../../../domain/models/decimal_value.dart';
import '../../../../domain/models/funding_transfer.dart';
import '../../../../domain/models/market_product.dart';
import '../../../../l10n/generated/app_localizations.dart';
import '../../../core/theme/app_theme.dart';
import '../../funding/providers/funding_transfer_providers.dart';

class OrderFundingSheet extends ConsumerStatefulWidget {
  const OrderFundingSheet({super.key, required this.plan, required this.kind});
  final FundingPlan plan;
  final MarketProductKind kind;

  @override
  ConsumerState<OrderFundingSheet> createState() => _OrderFundingSheetState();
}

class _OrderFundingSheetState extends ConsumerState<OrderFundingSheet> {
  late FundingPlan _plan = widget.plan;
  bool _busy = false;
  bool _pending = false;
  bool _polling = false;
  Timer? _pollTimer;
  bool _transferStep = false;
  String? _error;

  String get _targetAsset =>
      widget.kind == MarketProductKind.bstock ? 'USDT' : 'USDC';

  @override
  void dispose() {
    _pollTimer?.cancel();
    super.dispose();
  }

  Future<void> _continue({bool refresh = false}) async {
    if (_busy) return;
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
        _error = transfer.failureReason;
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
        _pending = false;
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
    final canUseSpot = switch (options) {
      AsyncLoading() => true,
      AsyncData(:final value) =>
        DecimalValue(value.account.availableToFundUsd.value)
                .compareMagnitudeTo(DecimalValue(_plan.shortfall.value)) >=
            0,
      _ => false,
    };
    return PopScope(
      canPop: !_busy,
      child: Material(
        color: colors.surface,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        clipBehavior: Clip.antiAlias,
        child: SafeArea(
          top: false,
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(20, 12, 20, 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const _DragHandle(),
                const SizedBox(height: 16),
                _Steps(current: _transferStep ? 2 : 1),
                const SizedBox(height: 16),
                Divider(color: colors.subtleSurface),
                const SizedBox(height: 16),
                if (_transferStep && _pending)
                  _TransferPendingContent(
                    onClose: () => Navigator.of(context).pop(false),
                  )
                else if (_transferStep)
                  _TransferContent(
                    plan: _plan,
                    busy: _busy,
                    pending: _pending,
                    error: _error,
                    onBack: () => setState(() => _transferStep = false),
                    onConfirm: () => _continue(),
                    onRetry: () => _continue(refresh: true),
                  )
                else
                  _PrepareContent(
                    plan: _plan,
                    targetAsset: _targetAsset,
                    spotBalance: spotBalance,
                    spotBalanceLoading: spotBalanceLoading,
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
      Text(
        current == 1
            ? AppLocalizations.of(context).prepareFunds
            : AppLocalizations.of(context).transfer,
        style: Theme.of(context).textTheme.titleLarge,
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
    required this.spotBalance,
    required this.spotBalanceLoading,
    required this.showSpot,
    required this.onSpot,
    required this.onDeposit,
  });
  final FundingPlan plan;
  final String targetAsset;
  final DecimalValue? spotBalance;
  final bool spotBalanceLoading;
  final bool showSpot;
  final VoidCallback onSpot;
  final VoidCallback onDeposit;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final required = plan.requiredTargetAmount?.value ?? plan.shortfall.value;
    final available = plan.targetAvailableAmount?.value ?? '0';
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          l10n.insufficientAssetInSpotAccount(targetAsset),
          style: Theme.of(context).textTheme.labelMedium,
        ),
        const SizedBox(height: 8),
        _Breakdown(
          required: required,
          available: available,
          shortfall: plan.shortfall.value,
          asset: targetAsset,
        ),
        const SizedBox(height: 16),
        Text(
          l10n.addFundingAmountFrom(plan.shortfall.value, targetAsset),
          style: Theme.of(context).textTheme.labelMedium,
        ),
        const SizedBox(height: 8),
        if (showSpot) ...[
          _SourceTile(
            key: const Key('order-funding-spot-option'),
            icon: Icons.swap_horiz,
            title: l10n.spot,
            detail: spotBalance == null
                ? null
                : '${l10n.balance}: \$${spotBalance!.value}',
            detailLoading: spotBalanceLoading,
            onTap: onSpot,
          ),
          const SizedBox(height: 12),
        ],
        _SourceTile(
          key: const Key('order-funding-deposit-option'),
          icon: Icons.file_download_outlined,
          title: l10n.externalDeposit,
          detail: l10n.depositAssetOnNetwork('USDC', 'Arbitrum'),
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
  });
  final String required, available, shortfall, asset;
  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppRwaColors>()!;
    final l10n = AppLocalizations.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: colors.canvas,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        children: [
          _ValueRow(label: l10n.orderValue, value: '$required $asset'),
          const SizedBox(height: 8),
          _ValueRow(
            label: '- ${l10n.availableBalance}',
            value: '$available $asset',
          ),
          const SizedBox(height: 8),
          Divider(color: colors.border),
          const SizedBox(height: 8),
          _ValueRow(
            label: '= ${l10n.fundsNeeded}',
            value: '$shortfall $asset',
            emphasized: true,
          ),
        ],
      ),
    );
  }
}

class _ValueRow extends StatelessWidget {
  const _ValueRow({
    required this.label,
    required this.value,
    this.emphasized = false,
  });
  final String label, value;
  final bool emphasized;
  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppRwaColors>()!;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 13,
            height: 18 / 13,
            fontWeight: FontWeight.w500,
            color: emphasized ? colors.primaryText : colors.secondaryText,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: emphasized ? 17 : 13,
            height: emphasized ? 22 / 17 : 18 / 13,
            fontWeight: emphasized ? FontWeight.w600 : FontWeight.w500,
          ),
        ),
      ],
    );
  }
}

class _SourceTile extends StatelessWidget {
  const _SourceTile({
    super.key,
    required this.icon,
    required this.title,
    this.detail,
    this.detailLoading = false,
    required this.onTap,
  });
  final IconData icon;
  final String title;
  final String? detail;
  final bool detailLoading;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppRwaColors>()!;
    final l10n = AppLocalizations.of(context);
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(14),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          border: Border.all(color: colors.border),
          borderRadius: BorderRadius.circular(14),
        ),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: colors.subtleSurface,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, size: 20),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 15,
                      height: 22 / 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  if (detailLoading)
                    Row(
                      children: [
                        Text(
                          '${l10n.balance}:',
                          style: TextStyle(
                            fontSize: 12,
                            height: 16 / 12,
                            color: colors.secondaryText,
                          ),
                        ),
                        const SizedBox(width: 6),
                        const SizedBox.square(
                          key: Key('order-funding-spot-balance-loading'),
                          dimension: 12,
                          child: CircularProgressIndicator(strokeWidth: 1.5),
                        ),
                      ],
                    )
                  else if (detail != null)
                    Text(
                      detail!,
                      style: TextStyle(
                        fontSize: 12,
                        height: 16 / 12,
                        color: colors.secondaryText,
                      ),
                    ),
                ],
              ),
            ),
            const Icon(Icons.chevron_right, size: 20),
          ],
        ),
      ),
    );
  }
}

class _TransferContent extends StatelessWidget {
  const _TransferContent({
    required this.plan,
    required this.busy,
    required this.pending,
    required this.error,
    required this.onBack,
    required this.onConfirm,
    required this.onRetry,
  });
  final FundingPlan plan;
  final bool busy, pending;
  final String? error;
  final VoidCallback onBack, onConfirm, onRetry;

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
          needed: plan.shortfall.value,
          transferAmount: leg?.outputAmount.value ?? plan.shortfall.value,
        ),
        const SizedBox(height: 16),
        _RouteRows(leg: leg),
        if (error != null) ...[
          const SizedBox(height: 8),
          Text(
            error!,
            style: TextStyle(
              color: Theme.of(context).extension<AppSemanticColors>()!.loss,
            ),
          ),
        ],
        const SizedBox(height: 28),
        Row(
          children: [
            Expanded(
              child: SizedBox(
                height: 48,
                child: OutlinedButton(
                  onPressed: busy ? null : onBack,
                  child: Text(l10n.back),
                ),
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
}

class _TransferPendingContent extends StatelessWidget {
  const _TransferPendingContent({required this.onClose});

  final VoidCallback onClose;

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
          'assets/figma/trade/funding_pending.png',
          width: 160,
          height: 160,
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
    );
  }
}

class _AssetsCard extends StatelessWidget {
  const _AssetsCard({
    required this.legs,
    required this.needed,
    required this.transferAmount,
  });
  final List<FundingLeg> legs;
  final String needed, transferAmount;
  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppRwaColors>()!;
    final l10n = AppLocalizations.of(context);
    return ClipRRect(
      borderRadius: BorderRadius.circular(14),
      child: ColoredBox(
        color: colors.canvas,
        child: Column(
          children: [
            _FundingLegs(legs: legs),
            Container(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
              decoration: BoxDecoration(
                border: Border(top: BorderSide(color: colors.surface)),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: _Total(label: l10n.amountNeeded, value: '\$$needed'),
                  ),
                  Expanded(
                    child: _Total(
                      label: l10n.transferAmount,
                      value: '~\$$transferAmount',
                      alignEnd: true,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _FundingLegs extends StatefulWidget {
  const _FundingLegs({required this.legs});

  final List<FundingLeg> legs;

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
        children: [for (final leg in widget.legs) _AssetRow(leg: leg)],
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
          itemBuilder: (context, index) => _AssetRow(leg: widget.legs[index]),
        ),
      ),
    );
  }
}

class _AssetRow extends StatelessWidget {
  const _AssetRow({required this.leg});
  final FundingLeg leg;
  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppRwaColors>()!;
    final l10n = AppLocalizations.of(context);
    final usdc = leg.asset.toUpperCase() == 'USDC';
    return Container(
      height: 63,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: colors.surface)),
      ),
      child: Row(
        children: [
          if (usdc)
            SvgPicture.asset(
              'assets/figma/funding/usdc.svg',
              width: 28,
              height: 28,
            )
          else
            Image.asset('assets/figma/funding/usdt.png', width: 28, height: 28),
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
                        text: usdc ? ' (Ethereum)' : ' (Arbitrum)',
                        style: TextStyle(
                          fontSize: 11,
                          color: colors.secondaryText,
                        ),
                      ),
                    ],
                  ),
                ),
                Text(
                  l10n.availableAmount(leg.maximumAmount.value),
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
            height: 34,
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              color: colors.subtleSurface,
              border: Border.all(color: colors.border),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              leg.maximumAmount.value,
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

class _Total extends StatelessWidget {
  const _Total({
    required this.label,
    required this.value,
    this.alignEnd = false,
  });
  final String label, value;
  final bool alignEnd;
  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppRwaColors>()!;
    return Column(
      crossAxisAlignment: alignEnd
          ? CrossAxisAlignment.end
          : CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 11,
            height: 14 / 11,
            color: colors.tertiaryText,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            fontSize: 15,
            height: 22 / 15,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}

class _RouteRows extends StatelessWidget {
  const _RouteRows({required this.leg});
  final FundingLeg? leg;
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
        ? '\$${fee.value}'
        : '${fee.value} ${asset ?? ''}'.trim();
  }
}

class _InfoRow extends StatelessWidget {
  const _InfoRow({required this.label, required this.value});
  final String label, value;
  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppRwaColors>()!;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
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

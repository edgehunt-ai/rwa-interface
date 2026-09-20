import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/routing/routes.dart';
import '../../../../domain/models/funding_transfer.dart';
import '../../../../domain/models/market_product.dart';
import '../../../../l10n/generated/app_localizations.dart';
import '../../funding/providers/funding_transfer_providers.dart';

/// Confirms funding separately from the order; only a funded plan can continue.
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
  late bool _pending =
      _plan.status == FundingPlanState.ready && !_plan.isActionable;
  String? _error;

  Future<void> _continue({bool refresh = false}) async {
    if (_busy) return;
    setState(() {
      _busy = true;
      _error = null;
    });
    try {
      final commands = ref.read(fundingTransferCommandsProvider);
      if (refresh) {
        _plan = await commands.refresh(_plan.planId);
        if (!mounted) return;
      } else {
        // Authorize one server-released leg at a time. Later legs require a
        // fresh confirmation so their current maximum input is visible.
        final authorization = await commands.authorize(_plan);
        final transfer = await commands.create(
          plan: _plan,
          authorization: authorization,
        );
        if (!mounted) return;
        _error = transfer.failureReason;
        _plan = await commands.refresh(_plan.planId);
        if (!mounted) return;
      }
      if (_plan.status == FundingPlanState.alreadyFunded) {
        Navigator.of(context).pop(true);
        return;
      }
      _pending = _plan.status == FundingPlanState.ready && !_plan.isActionable;
    } on Object {
      if (mounted) {
        _error = AppLocalizations.of(context).transferStartFailed;
        // Reconcile before offering another authorization after an uncertain
        // transfer response.
        _pending = true;
      }
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final isBstock = widget.kind == MarketProductKind.bstock;
    final asset = isBstock ? 'USDT' : 'USDC';
    final target = isBstock ? 'BSC USDT' : 'Hyperliquid Perps USDC';
    final leg = _plan.nextActionableLeg;
    return PopScope(
      canPop: !_busy,
      child: Material(
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        child: SafeArea(
          top: false,
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  l10n.preparingTradingFunds,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                Text(target),
                Text('${l10n.amountNeeded}: ${_plan.shortfall.value} $asset'),
                const SizedBox(height: 16),
                Text(l10n.addFundsFrom),
                if (leg != null) ...[
                  Text(l10n.serverSelectedFundingRoute),
                  Text(
                    '${leg.maximumAmount.value} ${leg.asset} → '
                    '${leg.outputAmount.value} $asset',
                  ),
                ],
                if (_pending) Text(l10n.bridgeInProgress),
                if (_error != null) Text(_error!),
                if (_plan.status != FundingPlanState.ready)
                  Text(l10n.fundingNotReady),
                if (_busy)
                  const Center(child: CircularProgressIndicator())
                else ...[
                  FilledButton(
                    onPressed: _plan.isActionable && !_pending
                        ? () => _continue()
                        : null,
                    child: Text(l10n.inAppTransfer),
                  ),
                  OutlinedButton(
                    onPressed: () => _continue(refresh: true),
                    child: Text(l10n.retry),
                  ),
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(false),
                    child: Text(l10n.cancel),
                  ),
                  TextButton(
                    onPressed: () {
                      final router = GoRouter.of(context);
                      Navigator.of(context).pop(false);
                      // Deposit rails are selected from the server catalog;
                      // the funding target is not necessarily a deposit rail.
                      router.pushNamed(AppRoutes.depositSelectName);
                    },
                    child: Text(l10n.externalDeposit),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}

part of 'bstocks_order_panel.dart';

/// Explicit UI-only state for the documented transfer and bridge flow.
class BstocksTransferFlowSheet extends ConsumerStatefulWidget {
  const BstocksTransferFlowSheet({
    super.key,
    required this.amountNeeded,
    this.initialStage = BstocksTransferFlowStage.source,
    this.onClose,
    required this.plan,
    required this.orderPreview,
    required this.symbol,
  });

  final DecimalValue amountNeeded;
  final BstocksTransferFlowStage initialStage;
  final VoidCallback? onClose;
  final FundingPlan plan;
  final OrderPreview orderPreview;
  final String symbol;

  @override
  ConsumerState<BstocksTransferFlowSheet> createState() =>
      _BstocksTransferFlowState();
}

enum BstocksTransferFlowStage {
  source,
  review,
  fundingPending,
  submitting,
  tradeSuccess,
}

class _BstocksTransferFlowState
    extends ConsumerState<BstocksTransferFlowSheet> {
  late BstocksTransferFlowStage _stage;
  String? error;

  @override
  void initState() {
    super.initState();
    _stage = widget.initialStage;
  }

  @override
  Widget build(BuildContext context) => Material(
    borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
    child: SafeArea(
      top: false,
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
        child: switch (_stage) {
          BstocksTransferFlowStage.source => _source(context),
          BstocksTransferFlowStage.review => _review(context),
          BstocksTransferFlowStage.fundingPending => _fundingPending(context),
          BstocksTransferFlowStage.submitting => _submitting(context),
          BstocksTransferFlowStage.tradeSuccess => _tradeSuccess(context),
        },
      ),
    ),
  );

  Widget _source(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _TransferHeader(step: '2', title: l10n.transfer),
        const Divider(),
        Text(l10n.inAppTransferLowercase),
        const SizedBox(height: 8),
        _ServerSelectedSource(plan: widget.plan),
        if (error case final value?)
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Text(value, style: const TextStyle(color: Colors.red)),
          ),
        _AmountOverview(amount: widget.amountNeeded),
        _TransferDetails(plan: widget.plan),
        const SizedBox(height: 16),
        _Actions(
          primary: l10n.confirm,
          onBack: widget.onClose,
          onPrimary: widget.plan.isActionable
              ? () => setState(() => _stage = BstocksTransferFlowStage.review)
              : null,
        ),
      ],
    );
  }

  Widget _review(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _TransferHeader(step: '3', title: l10n.buySymbol(widget.symbol)),
        const Divider(),
        Text(l10n.buySymbolMarket(widget.symbol)),
        const SizedBox(height: 12),
        const _UnifiedFundingAccountSummary(),
        _ConversionOverview(plan: widget.plan, preview: widget.orderPreview),
        const SizedBox(height: 16),
        _ReviewDetails(preview: widget.orderPreview),
        const SizedBox(height: 16),
        _Actions(
          primary: '${l10n.confirm} ${l10n.buy}',
          onBack: () =>
              setState(() => _stage = BstocksTransferFlowStage.source),
          onPrimary: _submitTransfer,
        ),
      ],
    );
  }

  Future<void> _submitTransfer() async {
    var plan = widget.plan;
    setState(() {
      error = null;
      _stage = BstocksTransferFlowStage.submitting;
    });
    try {
      final commands = ref.read(fundingTransferCommandsProvider);
      while (plan.isActionable) {
        final authorization = await commands.authorize(plan);
        final transfer = await commands.create(
          plan: plan,
          authorization: authorization,
        );
        if (!mounted) return;
        if (transfer.status != FundingTransferState.completed) {
          setState(() {
            _stage = switch (transfer.status) {
              FundingTransferState.failed ||
              FundingTransferState.ambiguous ||
              FundingTransferState.manualReview =>
                BstocksTransferFlowStage.review,
              _ => BstocksTransferFlowStage.fundingPending,
            };
            error = transfer.failureReason;
          });
          return;
        }
        plan = await ref
            .read(fundingRepositoryProvider)
            .getFundingPlan(plan.planId);
        if (!mounted) return;
      }
      if (plan.status == FundingPlanState.alreadyFunded) {
        await _submitCompletedOrder();
        return;
      }
      setState(() {
        _stage = BstocksTransferFlowStage.review;
        error = plan.blocker ?? AppLocalizations.of(context).fundingNotReady;
      });
    } on Object {
      if (mounted) {
        setState(() {
          _stage = BstocksTransferFlowStage.review;
          error = AppLocalizations.of(context).transferStartFailed;
        });
      }
    }
  }

  Future<void> _submitCompletedOrder() async {
    final preview = widget.orderPreview;
    try {
      final result = await ref
          .read(orderCommandProvider.notifier)
          .submit(preview.intent, previewId: preview.previewId);
      if (!mounted) return;
      setState(() {
        _stage = result == null
            ? BstocksTransferFlowStage.review
            : BstocksTransferFlowStage.tradeSuccess;
        error = result == null
            ? AppLocalizations.of(context).orderSubmissionFailed
            : null;
      });
    } on Object {
      if (mounted) {
        setState(() {
          _stage = BstocksTransferFlowStage.review;
          error = AppLocalizations.of(context).orderSubmissionFailed;
        });
      }
    }
  }

  Widget _fundingPending(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _TransferHeader(step: '2', title: l10n.transfer),
        const Divider(),
        Image.asset(
          'assets/figma/trade/funding_pending.png',
          width: 160,
          height: 160,
        ),
        Text(
          l10n.preparingTradingFunds,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(height: 8),
        Text(
          l10n.bridgeInProgress,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Theme.of(context).extension<AppRwaColors>()!.secondaryText,
            fontSize: 12,
          ),
        ),
        const SizedBox(height: 16),
        OutlinedButton(
          onPressed: widget.onClose,
          child: Text(l10n.closeViewLater),
        ),
      ],
    );
  }

  Widget _submitting(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _TransferHeader(step: '3', title: l10n.buySymbol(widget.symbol)),
        const Divider(),
        Image.asset(
          'assets/figma/trade/order_submitting.png',
          width: 160,
          height: 160,
        ),
        Text(
          l10n.submittingOrder,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(height: 8),
        Text(
          l10n.submittingOrderDescription,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Theme.of(context).extension<AppRwaColors>()!.secondaryText,
            fontSize: 12,
          ),
        ),
        const SizedBox(height: 16),
        OutlinedButton(
          onPressed: widget.onClose,
          child: Text(l10n.closeViewLater),
        ),
      ],
    );
  }

  Widget _tradeSuccess(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _TransferHeader(step: '3', title: l10n.buySymbol(widget.symbol)),
        const Divider(),
        const Icon(Icons.check_circle_outline, size: 64),
        const SizedBox(height: 12),
        Text(
          l10n.tradeSuccessful,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(height: 16),
        OutlinedButton(
          onPressed: widget.onClose,
          child: Text(l10n.closeViewLater),
        ),
      ],
    );
  }
}

class _TransferHeader extends StatelessWidget {
  const _TransferHeader({required this.step, required this.title});
  final String step;
  final String title;
  @override
  Widget build(BuildContext context) => Row(
    children: [
      const Icon(Icons.check_circle, size: 28),
      const SizedBox(width: 8),
      CircleAvatar(radius: 14, child: Text(step)),
      const SizedBox(width: 8),
      Text(title, style: Theme.of(context).textTheme.titleLarge),
    ],
  );
}

class _ServerSelectedSource extends StatelessWidget {
  const _ServerSelectedSource({required this.plan});

  final FundingPlan plan;

  @override
  Widget build(BuildContext context) {
    final sources = plan.legs.where((leg) => leg.isActionable).toList();
    return Column(
      children: [
        for (final leg in sources)
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: const Icon(Icons.account_balance_wallet_outlined),
            title: Text(AppLocalizations.of(context).serverSelected(leg.asset)),
            subtitle: Text(AppLocalizations.of(context).availableBalance),
            trailing: Text(
              TokenAmountFormatter.format(leg.maximumAmount, symbol: leg.asset),
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
          ),
      ],
    );
  }
}

class _AmountOverview extends StatelessWidget {
  const _AmountOverview({required this.amount});
  final DecimalValue amount;
  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Theme.of(context).extension<AppRwaColors>()!.canvas,
      borderRadius: BorderRadius.circular(14),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _AmountValue(
          label: AppLocalizations.of(context).amountNeeded,
          value: TokenAmountFormatter.format(amount, symbol: 'USDT'),
        ),
        _AmountValue(
          label: AppLocalizations.of(context).transferAmount,
          value: '~${TokenAmountFormatter.format(amount, symbol: 'USDT')}',
        ),
      ],
    ),
  );
}

class _UnifiedFundingAccountSummary extends ConsumerWidget {
  const _UnifiedFundingAccountSummary();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final account = ref.watch(unifiedFundingAccountProvider);
    return account.when(
      loading: () => const SizedBox(height: 20),
      error: (_, _) => const SizedBox.shrink(),
      data: (value) => Padding(
        padding: const EdgeInsets.only(bottom: 12),
        child: _SummaryRow(
          label: AppLocalizations.of(context).availableToFund,
          value: TokenAmountFormatter.formatUsd(value.availableToFundUsd),
        ),
      ),
    );
  }
}

/// Matches the two 160pt conversion cards in the trade confirmation design.
/// Values remain DecimalValue-backed so the display does not use floating point.
class _ConversionOverview extends StatelessWidget {
  const _ConversionOverview({required this.plan, required this.preview});

  final FundingPlan plan;
  final OrderPreview preview;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppRwaColors>()!;
    return Stack(
      alignment: Alignment.center,
      children: [
        Row(
          children: [
            Expanded(
              child: _ConversionCard(
                value: TokenAmountFormatter.format(
                  plan.shortfall,
                  symbol: plan.shortfall.asset ?? plan.sourceAsset ?? '—',
                ),
                symbol: plan.sourceAsset ?? '—',
                alignEnd: false,
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: _ConversionCard(
                value: preview.estimatedQuantity == null
                    ? '—'
                    : TokenAmountFormatter.format(
                        preview.estimatedQuantity!,
                        symbol: preview.intent.symbol,
                      ),
                symbol: preview.intent.symbol,
                alignEnd: true,
              ),
            ),
          ],
        ),
        Container(
          width: 28,
          height: 28,
          decoration: BoxDecoration(
            color: colors.canvas,
            border: Border.all(color: colors.surface, width: 4),
            shape: BoxShape.circle,
          ),
          child: const Icon(Icons.arrow_forward, size: 16),
        ),
      ],
    );
  }
}

class _ConversionCard extends StatelessWidget {
  const _ConversionCard({
    required this.value,
    required this.symbol,
    required this.alignEnd,
  });

  final String value;
  final String symbol;
  final bool alignEnd;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppRwaColors>()!;
    final pieces = value.split(' ');
    return Container(
      height: 82,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colors.canvas,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        crossAxisAlignment: alignEnd
            ? CrossAxisAlignment.end
            : CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: alignEnd
                ? MainAxisAlignment.end
                : MainAxisAlignment.start,
            children: [
              if (!alignEnd) _AssetMark(symbol: symbol),
              if (!alignEnd) const SizedBox(width: 4),
              Flexible(
                child: Text(
                  pieces.first,
                  style: Theme.of(context).textTheme.titleMedium,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              if (alignEnd) const SizedBox(width: 4),
              if (alignEnd) _AssetMark(symbol: symbol),
            ],
          ),
          Text(
            pieces.length > 1 ? pieces.last : '',
            style: TextStyle(
              color: colors.secondaryText,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

class _AssetMark extends StatelessWidget {
  const _AssetMark({required this.symbol});

  final String symbol;

  @override
  Widget build(BuildContext context) => Container(
    width: 20,
    height: 20,
    decoration: BoxDecoration(
      color: Theme.of(context).extension<AppRwaColors>()!.surface,
      border: Border.all(
        color: Theme.of(context).extension<AppRwaColors>()!.border,
      ),
      shape: BoxShape.circle,
    ),
    child: Text(symbol, style: const TextStyle(fontSize: 8)),
  );
}

class _AmountValue extends StatelessWidget {
  const _AmountValue({required this.label, required this.value});
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(label, style: const TextStyle(fontSize: 11)),
      Text(value, style: const TextStyle(fontWeight: FontWeight.w600)),
    ],
  );
}

class _TransferDetails extends StatelessWidget {
  const _TransferDetails({required this.plan});
  final FundingPlan plan;
  @override
  Widget build(BuildContext context) => Column(
    children: [
      _SummaryRow(
        label: AppLocalizations.of(context).shortfall,
        value: TokenAmountFormatter.format(
          plan.shortfall,
          symbol: plan.shortfall.asset ?? plan.sourceAsset ?? '—',
        ),
      ),
      _SummaryRow(
        label: AppLocalizations.of(context).availableBalance,
        value: plan.sourceMaximum == null
            ? AppLocalizations.of(context).availableBalanceUnavailable
            : TokenAmountFormatter.format(
                plan.sourceMaximum!,
                symbol: plan.sourceMaximum!.asset ?? plan.sourceAsset ?? '—',
              ),
      ),
    ],
  );
}

class _ReviewDetails extends StatelessWidget {
  const _ReviewDetails({required this.preview});
  final OrderPreview preview;

  @override
  Widget build(BuildContext context) => Column(
    children: [
      _SummaryRow(
        label: AppLocalizations.of(context).orderType,
        value: preview.intent.type == TradingOrderType.market
            ? AppLocalizations.of(context).market
            : AppLocalizations.of(context).limit,
      ),
      if (preview.marketPrice case final price?)
        _SummaryRow(
          label: AppLocalizations.of(context).marketPrice,
          value: TokenAmountFormatter.formatUsd(price),
        ),
      if (preview.fee case final fee?)
        _SummaryRow(
          label: AppLocalizations.of(context).estimatedFee,
          value: TokenAmountFormatter.format(
            fee,
            symbol: fee.asset ?? preview.intent.symbol,
          ),
        ),
    ],
  );
}

class _Actions extends StatelessWidget {
  const _Actions({
    required this.primary,
    required this.onBack,
    required this.onPrimary,
  });
  final String primary;
  final VoidCallback? onBack;
  final VoidCallback? onPrimary;
  @override
  Widget build(BuildContext context) => Row(
    children: [
      Expanded(
        child: OutlinedButton(
          onPressed: onBack,
          child: Text(AppLocalizations.of(context).back),
        ),
      ),
      const SizedBox(width: 12),
      Expanded(
        child: FilledButton(onPressed: onPrimary, child: Text(primary)),
      ),
    ],
  );
}

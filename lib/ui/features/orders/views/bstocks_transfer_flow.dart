part of 'bstocks_order_panel.dart';

/// Explicit UI-only state for the documented transfer and bridge flow.
class BstocksTransferFlowSheet extends ConsumerStatefulWidget {
  const BstocksTransferFlowSheet({
    super.key,
    required this.amountNeeded,
    this.initialStage = BstocksTransferFlowStage.source,
    this.onClose,
    this.plan,
    this.orderPreview,
    this.symbol = 'NVDAB',
  });

  final DecimalValue amountNeeded;
  final BstocksTransferFlowStage initialStage;
  final VoidCallback? onClose;
  final FundingPlan? plan;
  final OrderPreview? orderPreview;
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

  Widget _source(BuildContext context) => Column(
    mainAxisSize: MainAxisSize.min,
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      const _TransferHeader(step: '2', title: 'Transfer'),
      const Divider(),
      const Text('In-App transfer'),
      const SizedBox(height: 8),
      if (widget.plan case final plan?)
        _ServerSelectedSource(plan: plan)
      else
        for (final source in const [
          ('USDT', 'Arbitrum', '50'),
          ('USDC', 'Arbitrum', '51.4'),
          ('ETH', 'Polygon', '0.0'),
        ])
          ListTile(
            title: Text('${source.$1} (${source.$2})'),
            subtitle: const Text(
              'Available balance',
              style: TextStyle(fontSize: 11),
            ),
            trailing: Text(
              source.$3,
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
          ),
      if (error case final value?)
        Padding(
          padding: const EdgeInsets.only(top: 8),
          child: Text(value, style: const TextStyle(color: Colors.red)),
        ),
      _AmountOverview(amount: widget.amountNeeded),
      _TransferDetails(symbol: widget.symbol),
      const SizedBox(height: 16),
      _Actions(
        primary: 'Confirm',
        onBack: widget.onClose,
        onPrimary: widget.plan == null || widget.plan!.isActionable
            ? () => setState(() => _stage = BstocksTransferFlowStage.review)
            : null,
      ),
    ],
  );

  Widget _review(BuildContext context) => Column(
    mainAxisSize: MainAxisSize.min,
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      _TransferHeader(step: '3', title: 'Buy ${widget.symbol}'),
      const Divider(),
      Text('Buy ${widget.symbol} · Market'),
      const SizedBox(height: 12),
      _ConversionOverview(amount: widget.amountNeeded, symbol: widget.symbol),
      const SizedBox(height: 16),
      _ReviewDetails(symbol: widget.symbol),
      const SizedBox(height: 16),
      _Actions(
        primary: 'Confirm Buy',
        onBack: () => setState(() => _stage = BstocksTransferFlowStage.source),
        onPrimary: _submitTransfer,
      ),
    ],
  );

  Future<void> _submitTransfer() async {
    final plan = widget.plan;
    if (plan == null) {
      setState(() => _stage = BstocksTransferFlowStage.submitting);
      return;
    }
    setState(() {
      error = null;
      _stage = BstocksTransferFlowStage.submitting;
    });
    try {
      final commands = ref.read(fundingTransferCommandsProvider);
      final authorization = await commands.authorize(plan);
      final transfer = await commands.create(
        plan: plan,
        authorization: authorization,
      );
      if (!mounted) return;
      if (transfer.status == FundingTransferState.completed) {
        await _submitCompletedOrder();
        return;
      }
      setState(() {
        _stage = switch (transfer.status) {
          FundingTransferState.failed ||
          FundingTransferState.ambiguous ||
          FundingTransferState.manualReview => BstocksTransferFlowStage.review,
          _ => BstocksTransferFlowStage.fundingPending,
        };
        error = transfer.failureReason;
      });
    } on Object {
      if (mounted) {
        setState(() {
          _stage = BstocksTransferFlowStage.review;
          error = 'Unable to authorize or start this transfer. Try again.';
        });
      }
    }
  }

  Future<void> _submitCompletedOrder() async {
    final preview = widget.orderPreview;
    if (preview == null) {
      if (mounted) {
        setState(() {
          _stage = BstocksTransferFlowStage.review;
          error =
              'Funding completed. Return to the order sheet to review again.';
        });
      }
      return;
    }
    try {
      final result = await ref
          .read(orderCommandProvider.notifier)
          .submit(preview.intent, previewId: preview.previewId);
      if (!mounted) return;
      setState(() {
        _stage = result == null
            ? BstocksTransferFlowStage.review
            : BstocksTransferFlowStage.tradeSuccess;
        error = result == null ? 'Order was not submitted. Try again.' : null;
      });
    } on Object {
      if (mounted) {
        setState(() {
          _stage = BstocksTransferFlowStage.review;
          error = 'Order was not submitted. Try again.';
        });
      }
    }
  }

  Widget _fundingPending(BuildContext context) => Column(
    mainAxisSize: MainAxisSize.min,
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      const _TransferHeader(step: '2', title: 'Transfer'),
      const Divider(),
      Image.asset(
        'assets/figma/trade/funding_pending.png',
        width: 160,
        height: 160,
      ),
      Text(
        'Preparing Trading Funds...',
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.titleMedium,
      ),
      const SizedBox(height: 8),
      Text(
        'Bridge in progress. Estimated time: 1–3 min\nYou can track the progress on the Details page.',
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Theme.of(context).extension<AppRwaColors>()!.secondaryText,
          fontSize: 12,
        ),
      ),
      const SizedBox(height: 16),
      OutlinedButton(
        onPressed: widget.onClose,
        child: const Text('Close & View Later'),
      ),
    ],
  );

  Widget _submitting(BuildContext context) => Column(
    mainAxisSize: MainAxisSize.min,
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      _TransferHeader(step: '3', title: 'Buy ${widget.symbol}'),
      const Divider(),
      Image.asset(
        'assets/figma/trade/order_submitting.png',
        width: 160,
        height: 160,
      ),
      Text(
        'Submitting Order...',
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.titleMedium,
      ),
      const SizedBox(height: 8),
      Text(
        'This may take a few moments.\nYou can track the progress on the Details page.',
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Theme.of(context).extension<AppRwaColors>()!.secondaryText,
          fontSize: 12,
        ),
      ),
      const SizedBox(height: 16),
      OutlinedButton(
        onPressed: widget.onClose,
        child: const Text('Close & View Later'),
      ),
    ],
  );

  Widget _tradeSuccess(BuildContext context) => Column(
    mainAxisSize: MainAxisSize.min,
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      _TransferHeader(step: '3', title: 'Buy ${widget.symbol}'),
      const Divider(),
      const Icon(Icons.check_circle_outline, size: 64),
      const SizedBox(height: 12),
      Text(
        'Trade Successful',
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.titleMedium,
      ),
      const SizedBox(height: 16),
      OutlinedButton(
        onPressed: widget.onClose,
        child: const Text('Close & View Later'),
      ),
    ],
  );
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
  Widget build(BuildContext context) => ListTile(
    contentPadding: EdgeInsets.zero,
    leading: const Icon(Icons.account_balance_wallet_outlined),
    title: Text('${plan.sourceAsset ?? 'Asset'} (server selected)'),
    subtitle: const Text('Available balance'),
    trailing: Text(
      plan.sourceMaximum == null
          ? 'Unavailable'
          : TokenAmountFormatter.format(
              plan.sourceMaximum!,
              symbol: plan.sourceAsset ?? 'USDC',
            ),
      style: const TextStyle(fontWeight: FontWeight.w600),
    ),
  );
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
          label: 'Amount Needed',
          value: TokenAmountFormatter.format(amount, symbol: 'USDT'),
        ),
        _AmountValue(
          label: 'Transfer amount',
          value: '~${TokenAmountFormatter.format(amount, symbol: 'USDT')}',
        ),
      ],
    ),
  );
}

/// Matches the two 160pt conversion cards in the trade confirmation design.
/// Values remain DecimalValue-backed so the display does not use floating point.
class _ConversionOverview extends StatelessWidget {
  const _ConversionOverview({required this.amount, required this.symbol});

  final DecimalValue amount;
  final String symbol;

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
                value: TokenAmountFormatter.format(amount, symbol: 'USDT'),
                asset: 'assets/figma/trade/usdt_mark.png',
                alignEnd: false,
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: _ConversionCard(
                value: TokenAmountFormatter.format(
                  DecimalValue('0.88', asset: symbol, unit: 'token'),
                  symbol: symbol,
                ),
                asset: 'assets/figma/trade/nvidia.svg',
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
    required this.asset,
    required this.alignEnd,
  });

  final String value;
  final String asset;
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
              if (!alignEnd) _AssetMark(asset: asset),
              if (!alignEnd) const SizedBox(width: 4),
              Flexible(
                child: Text(
                  pieces.first,
                  style: Theme.of(context).textTheme.titleMedium,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              if (alignEnd) const SizedBox(width: 4),
              if (alignEnd) _AssetMark(asset: asset),
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
  const _AssetMark({required this.asset});

  final String asset;

  @override
  Widget build(BuildContext context) => Container(
    width: 20,
    height: 20,
    padding: asset.endsWith('.svg') ? const EdgeInsets.all(4) : EdgeInsets.zero,
    decoration: BoxDecoration(
      color: Theme.of(context).extension<AppRwaColors>()!.surface,
      border: Border.all(
        color: Theme.of(context).extension<AppRwaColors>()!.border,
      ),
      shape: BoxShape.circle,
    ),
    child: asset.endsWith('.svg')
        ? SvgPicture.asset(asset, width: 20, height: 20)
        : Image.asset(asset, width: 20, height: 20),
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
  const _TransferDetails({required this.symbol});
  final String symbol;
  @override
  Widget build(BuildContext context) => Column(
    children: [
      const _SummaryRow(label: 'Estimate time', value: '1–3 mins'),
      const _SummaryRow(label: 'Bridge Fee', value: r'$0.1'),
      const _SummaryRow(label: 'Network Fee', value: r'$0.1'),
      const _SummaryRow(label: 'Slippage', value: '0.12%'),
      _SummaryRow(label: 'Estimated Fee', value: '0.5 $symbol'),
    ],
  );
}

class _ReviewDetails extends StatelessWidget {
  const _ReviewDetails({required this.symbol});
  final String symbol;

  @override
  Widget build(BuildContext context) => Column(
    children: [
      _SummaryRow(label: 'Order Type', value: 'Market'),
      _SummaryRow(label: 'Market price', value: r'$182.40 → $188.10'),
      _SummaryRow(label: 'Slippage', value: '0.12%'),
      _SummaryRow(label: 'Estimated Fee', value: '0.5 $symbol'),
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
        child: OutlinedButton(onPressed: onBack, child: const Text('Back')),
      ),
      const SizedBox(width: 12),
      Expanded(
        child: FilledButton(onPressed: onPrimary, child: Text(primary)),
      ),
    ],
  );
}

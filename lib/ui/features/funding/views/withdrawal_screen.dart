import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:rwa_interface/app/routing/routes.dart';
import 'package:rwa_interface/domain/models/decimal_value.dart';
import 'package:rwa_interface/domain/models/withdrawal.dart';
import 'package:rwa_interface/ui/core/feedback/empty_state.dart';
import 'package:rwa_interface/ui/core/feedback/failure_state.dart';
import 'package:rwa_interface/ui/core/feedback/loading_skeleton.dart';
import 'package:rwa_interface/ui/core/formatters/token_amount_formatter.dart';
import 'package:rwa_interface/ui/core/theme/app_theme.dart';
import 'package:rwa_interface/ui/features/funding/providers/withdrawal_providers.dart';

class WithdrawalScreen extends ConsumerStatefulWidget {
  const WithdrawalScreen({
    super.key,
    this.showSelector = false,
    this.token = 'USDC',
    this.chain = 'Arbitrum',
  });

  final bool showSelector;
  final String token;
  final String chain;

  @override
  ConsumerState<WithdrawalScreen> createState() => _WithdrawalScreenState();
}

class _WithdrawalScreenState extends ConsumerState<WithdrawalScreen> {
  final address = TextEditingController();
  final amount = TextEditingController();
  WithdrawalQuote? quote;
  String? error;
  bool quoting = false;

  @override
  void dispose() {
    address.dispose();
    amount.dispose();
    super.dispose();
  }

  Future<void> _review() async {
    final raw = amount.text.trim();
    if (address.text.trim().isEmpty || raw.isEmpty) {
      setState(() => error = 'Enter a recipient address and amount.');
      return;
    }
    DecimalValue value;
    try {
      value = DecimalValue(raw, asset: widget.token, unit: 'token');
    } on FormatException {
      setState(() => error = 'Enter a valid ${widget.token} amount.');
      return;
    }
    setState(() {
      quoting = true;
      error = null;
    });
    try {
      final next = await ref
          .read(withdrawalCommandsProvider)
          .quote(
            WithdrawalIntent(
              chain: widget.chain,
              amount: value,
              address: address.text.trim(),
            ),
          );
      if (mounted) setState(() => quote = next);
    } on Object {
      if (mounted) {
        setState(() => error = 'Unable to prepare this withdrawal. Try again.');
      }
    } finally {
      if (mounted) setState(() => quoting = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.showSelector) return const _AssetSelector();
    final selectedAsset = ref
        .watch(withdrawalAssetsProvider)
        .value
        ?.where(
          (asset) =>
              asset.symbol == widget.token && asset.chain == widget.chain,
        )
        .firstOrNull;
    return Scaffold(
      body: SafeArea(
        child: quote == null
            ? _WithdrawalForm(
                address: address,
                amount: amount,
                error: error,
                submitting: quoting,
                asset: selectedAsset,
                token: widget.token,
                chain: widget.chain,
                onReview: _review,
              )
            : _WithdrawalReview(
                quote: quote!,
                onBack: () => setState(() => quote = null),
              ),
      ),
    );
  }
}

class _WithdrawalForm extends StatefulWidget {
  const _WithdrawalForm({
    required this.address,
    required this.amount,
    required this.error,
    required this.submitting,
    required this.asset,
    required this.token,
    required this.chain,
    required this.onReview,
  });

  final TextEditingController address;
  final TextEditingController amount;
  final String? error;
  final bool submitting;
  final WithdrawableAsset? asset;
  final String token;
  final String chain;
  final VoidCallback onReview;

  @override
  State<_WithdrawalForm> createState() => _WithdrawalFormState();
}

class _WithdrawalFormState extends State<_WithdrawalForm> {
  @override
  void initState() {
    super.initState();
    widget.amount.addListener(_refresh);
    widget.address.addListener(_refresh);
  }

  @override
  void didUpdateWidget(covariant _WithdrawalForm oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.amount != widget.amount) {
      oldWidget.amount.removeListener(_refresh);
      widget.amount.addListener(_refresh);
    }
    if (oldWidget.address != widget.address) {
      oldWidget.address.removeListener(_refresh);
      widget.address.addListener(_refresh);
    }
  }

  @override
  void dispose() {
    widget.amount.removeListener(_refresh);
    widget.address.removeListener(_refresh);
    super.dispose();
  }

  void _refresh() => setState(() {});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppRwaColors>()!;
    final rawAmount = widget.amount.text.trim();
    final displayAmount = rawAmount.isEmpty ? '0.00' : rawAmount;
    final parsedAmount = _parseAmount(rawAmount);
    final canSubmit =
        !widget.submitting &&
        widget.asset?.isWithdrawalSupported == true &&
        widget.address.text.trim().isNotEmpty &&
        parsedAmount != null &&
        parsedAmount.compareTo(DecimalValue('0')) > 0 &&
        parsedAmount.compareTo(widget.asset!.balance) <= 0;
    return ListView(
      padding: const EdgeInsets.fromLTRB(20, 18, 20, 20),
      children: [
        _PageHeader(title: 'Withdraw ${widget.token}'),
        const SizedBox(height: 40),
        _RouteCard(token: widget.token, chain: widget.chain),
        const SizedBox(height: 36),
        _InputCard(
          height: 88,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const _FieldLabel('Recipient address'),
              const SizedBox(height: 4),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: widget.address,
                      decoration: const InputDecoration.collapsed(
                        hintText: 'Enter wallet address',
                      ),
                      style: _strongText,
                    ),
                  ),
                  TextButton(
                    onPressed: () async {
                      final data = await Clipboard.getData('text/plain');
                      if (data?.text case final text? when text.isNotEmpty) {
                        widget.address.text = text;
                      }
                    },
                    style: TextButton.styleFrom(
                      foregroundColor: colors.primaryText,
                      padding: EdgeInsets.zero,
                      minimumSize: const Size(42, 24),
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    child: const Text('Paste', style: _strongText),
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 36),
        _InputCard(
          height: 104,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _FieldLabel('Amount'),
                  _FieldLabel(
                    widget.asset == null
                        ? 'Available — ${widget.token}'
                        : 'Available ${TokenAmountFormatter.formatValue(widget.asset!.balance, decimals: widget.asset!.decimals)} ${widget.token}',
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: widget.amount,
                      keyboardType: const TextInputType.numberWithOptions(
                        decimal: true,
                      ),
                      decoration: const InputDecoration.collapsed(
                        hintText: '0.00',
                      ),
                      style: _strongText,
                    ),
                  ),
                  Text(widget.token, style: _strongText),
                ],
              ),
              const SizedBox(height: 4),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '≈ \$$displayAmount',
                    style: Theme.of(context).textTheme.bodySmall
                        ?.copyWith(color: colors.secondaryText),
                  ),
                  TextButton(
                    onPressed: widget.asset == null
                        ? null
                        : () =>
                              widget.amount.text = widget.asset!.balance.value,
                    style: TextButton.styleFrom(
                      foregroundColor: colors.primaryText,
                      padding: EdgeInsets.zero,
                      minimumSize: const Size(36, 16),
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    child: const Text('Max', style: _strongText),
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 36),
        Container(
          height: 88,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: colors.subtleSurface,
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _CompactDetail(label: 'Network fee', value: '≈ 0.10 USDC'),
              _CompactDetail(label: 'Recipient receives', value: '— USDC'),
            ],
          ),
        ),
        const SizedBox(height: 40),
        Text(
          'Network fees may change before confirmation.',
          style: Theme.of(context).textTheme.bodySmall
              ?.copyWith(color: colors.secondaryText),
        ),
        if (widget.error != null) ...[
          const SizedBox(height: 12),
          Text(
            widget.error!,
            style: TextStyle(
              color: Theme.of(context).extension<AppSemanticColors>()!.loss,
            ),
          ),
        ],
        const SizedBox(height: 60),
        FilledButton(
          onPressed: canSubmit ? widget.onReview : null,
          child: Text(
            widget.submitting ? 'Preparing withdrawal…' : 'Review withdrawal',
          ),
        ),
      ],
    );
  }

  DecimalValue? _parseAmount(String value) {
    if (value.isEmpty) return null;
    try {
      return DecimalValue(value, asset: widget.token, unit: 'token');
    } on FormatException {
      return null;
    }
  }
}

class _RouteCard extends StatelessWidget {
  const _RouteCard({required this.token, required this.chain});

  final String token;
  final String chain;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppRwaColors>()!;
    return Container(
      height: 104,
      decoration: BoxDecoration(
        color: colors.surface,
        border: Border.all(color: colors.border),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Expanded(
            child: _RouteRow(
              label: 'Token',
              value: token,
              asset: _tokenIcon(token),
              raster: token == 'USDT',
            ),
          ),
          Divider(),
          Expanded(
            child: _RouteRow(
              label: 'Network',
              value: chain,
              asset: _networkIcon(chain),
            ),
          ),
        ],
      ),
    );
  }
}

class _RouteRow extends StatelessWidget {
  const _RouteRow({
    required this.label,
    required this.value,
    required this.asset,
    this.raster = false,
  });

  final String label;
  final String value;
  final String asset;
  final bool raster;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16),
    child: Row(
      children: [
        Expanded(child: Text(label)),
        SizedBox(
          width: 24,
          height: 24,
          child: raster
              ? Image.asset(asset, width: 24, height: 24)
              : SvgPicture.asset(asset, width: 24, height: 24),
        ),
        const SizedBox(width: 8),
        Text(value, style: _strongText),
      ],
    ),
  );
}

class _WithdrawalReview extends StatelessWidget {
  const _WithdrawalReview({required this.quote, required this.onBack});

  final WithdrawalQuote quote;
  final VoidCallback onBack;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppRwaColors>()!;
    final amount = TokenAmountFormatter.format(
      quote.intent.amount,
      symbol: 'USDC',
    );
    return ListView(
      padding: const EdgeInsets.fromLTRB(20, 18, 20, 20),
      children: [
        _PageHeader(title: 'Review withdrawal', onBack: onBack),
        const SizedBox(height: 24),
        Text(
          'YOU ARE SENDING',
          style: Theme.of(context).textTheme.bodySmall
              ?.copyWith(color: colors.secondaryText),
        ),
        const SizedBox(height: 4),
        Text(
          amount,
          style: const TextStyle(
            fontSize: 32,
            height: 38 / 32,
            fontWeight: FontWeight.w700,
            letterSpacing: -0.5,
          ),
        ),
        Text(
          '≈ \$${TokenAmountFormatter.formatValue(quote.intent.amount)}',
          style: Theme.of(context).textTheme.bodyLarge
              ?.copyWith(color: colors.secondaryText),
        ),
        const SizedBox(height: 20),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: colors.subtleSurface,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Withdrawal details',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 8),
              _ReviewDetail(
                label: 'To',
                value: _shortAddress(quote.intent.address),
              ),
              const SizedBox(height: 8),
              const _ReviewDetail(label: 'Network', value: 'Arbitrum'),
              const SizedBox(height: 8),
              _ReviewDetail(
                label: 'Network fee',
                value:
                    '≈ ${TokenAmountFormatter.format(quote.totalFee, symbol: 'USDC')}',
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        _BreakdownRow(
          label: 'Recipient receives',
          value: TokenAmountFormatter.format(
            quote.estimatedReceive,
            symbol: 'USDC',
          ),
          mutedLabel: true,
        ),
        const Divider(height: 17),
        _BreakdownRow(label: 'Total deducted', value: amount),
        const SizedBox(height: 12),
        Text(
          'The final network fee may vary slightly.',
          style: Theme.of(context).textTheme.bodySmall
              ?.copyWith(color: colors.secondaryText),
        ),
        const SizedBox(height: 40),
        FilledButton(onPressed: null, child: const Text('Withdraw USDC')),
      ],
    );
  }

  static String _shortAddress(String value) {
    if (value.length <= 18) return value;
    return '${value.substring(0, 10)}...${value.substring(value.length - 4)}';
  }
}

class _AssetSelector extends ConsumerStatefulWidget {
  const _AssetSelector();

  @override
  ConsumerState<_AssetSelector> createState() => _AssetSelectorState();
}

class _AssetSelectorState extends ConsumerState<_AssetSelector> {
  String query = '';

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppRwaColors>()!;
    final assets = ref.watch(withdrawalAssetsProvider);
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(20, 18, 20, 20),
          children: [
            const _PageHeader(title: 'Select asset'),
            const SizedBox(height: 24),
            SizedBox(
              height: 44,
              child: TextField(
                onChanged: (value) => setState(() => query = value),
                decoration: InputDecoration(
                  prefixIcon: Padding(
                    padding: const EdgeInsets.all(12),
                    child: SvgPicture.asset(
                      'assets/figma/home_markets/search.svg',
                      width: 20,
                      height: 20,
                      colorFilter: ColorFilter.mode(
                        colors.primaryText,
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
                  hintText: 'Search assets',
                  fillColor: colors.subtleSurface,
                ),
              ),
            ),
            const SizedBox(height: 16),
            assets.when(
              loading: () => const SizedBox(
                height: 360,
                child: LoadingSkeleton(
                  rows: 4,
                  padding: EdgeInsets.only(top: 16),
                ),
              ),
              error: (_, _) => FailureState(
                height: 420,
                title: 'Unable to load assets',
                description: 'Check your connection and try again.',
                onRetry: () => ref.refresh(withdrawalAssetsProvider.future),
              ),
              data: (items) {
                final filtered = items
                    .where(
                      (asset) => '${asset.symbol} ${asset.chain}'
                          .toLowerCase()
                          .contains(query.toLowerCase()),
                    )
                    .toList(growable: false);
                if (filtered.isEmpty) {
                  return SizedBox(
                    height: 400,
                    child: EmptyState(
                      title: query.isEmpty
                          ? 'No assets available'
                          : 'No matching assets',
                      description: query.isEmpty
                          ? 'Assets with an available balance will appear here.'
                          : 'Try a different asset name or network.',
                    ),
                  );
                }
                return Column(
                  children: [
                    for (final asset in filtered) _AssetRow(asset: asset),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _AssetRow extends StatelessWidget {
  const _AssetRow({required this.asset});

  final WithdrawableAsset asset;

  @override
  Widget build(BuildContext context) => InkWell(
    onTap: () => context.go(
      AppRoutes.withdrawalLocation(token: asset.symbol, chain: asset.chain),
    ),
    child: SizedBox(
      height: 72,
      child: Row(
        children: [
          SizedBox(
            width: 40,
            height: 40,
            child: asset.symbol == 'USDT'
                ? Image.asset(_tokenIcon(asset.symbol), width: 40, height: 40)
                : SvgPicture.asset(
                    _tokenIcon(asset.symbol),
                    width: 40,
                    height: 40,
                  ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(children: [Text(asset.symbol, style: _strongText)]),
                Text(
                  '${_assetName(asset.symbol)} · ${asset.chain}',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Theme.of(context)
                        .extension<AppRwaColors>()!
                        .secondaryText,
                  ),
                ),
              ],
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                TokenAmountFormatter.formatValue(
                  asset.balance,
                  decimals: asset.decimals,
                ),
                style: _strongText,
              ),
              Text(
                asset.valueUsd == null
                    ? '—'
                    : TokenAmountFormatter.formatUsd(asset.valueUsd!),
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Theme.of(context)
                      .extension<AppRwaColors>()!
                      .secondaryText,
                ),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}

class _PageHeader extends StatelessWidget {
  const _PageHeader({required this.title, this.onBack});

  final String title;
  final VoidCallback? onBack;

  @override
  Widget build(BuildContext context) => SizedBox(
    height: 34,
    child: Row(
      children: [
        IconButton(
          onPressed: onBack ?? () => context.pop(),
          padding: EdgeInsets.zero,
          constraints: const BoxConstraints.tightFor(width: 20, height: 34),
          icon: Transform.flip(
            flipX: true,
            child: SvgPicture.asset(
              'assets/figma/funding/back.svg',
              width: 20,
              height: 20,
            ),
          ),
        ),
        const SizedBox(width: 8),
        Text(title, style: Theme.of(context).textTheme.titleLarge),
      ],
    ),
  );
}

class _InputCard extends StatelessWidget {
  const _InputCard({required this.height, required this.child});

  final double height;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppRwaColors>()!;
    return Container(
      height: height,
      padding: const EdgeInsets.fromLTRB(12, 12, 16, 12),
      decoration: BoxDecoration(
        color: colors.surface,
        border: Border.all(color: colors.border),
        borderRadius: BorderRadius.circular(8),
      ),
      child: child,
    );
  }
}

class _FieldLabel extends StatelessWidget {
  const _FieldLabel(this.text);

  final String text;

  @override
  Widget build(BuildContext context) => Text(
    text,
    style: Theme.of(context).textTheme.bodySmall?.copyWith(
      color: Theme.of(context).extension<AppRwaColors>()!.secondaryText,
    ),
  );
}

class _CompactDetail extends StatelessWidget {
  const _CompactDetail({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) => Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      _FieldLabel(label),
      Text(value, style: _strongText),
    ],
  );
}

class _ReviewDetail extends StatelessWidget {
  const _ReviewDetail({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) => Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      _FieldLabel(label),
      Flexible(child: Text(value, textAlign: TextAlign.right)),
    ],
  );
}

class _BreakdownRow extends StatelessWidget {
  const _BreakdownRow({
    required this.label,
    required this.value,
    this.mutedLabel = false,
  });

  final String label;
  final String value;
  final bool mutedLabel;

  @override
  Widget build(BuildContext context) => Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(
        label,
        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
          color: mutedLabel
              ? Theme.of(context).extension<AppRwaColors>()!.secondaryText
              : null,
        ),
      ),
      Text(value, style: _strongText),
    ],
  );
}

const _strongText = TextStyle(
  fontSize: 15,
  height: 22 / 15,
  fontWeight: FontWeight.w600,
);

String _tokenIcon(String symbol) => switch (symbol.toUpperCase()) {
  'USDT' => 'assets/figma/funding/usdt.png',
  'NVDAB' => 'assets/figma/home_markets/nvidia.svg',
  'TSLAB' => 'assets/figma/home_markets/tesla.svg',
  _ => 'assets/figma/funding/usdc.svg',
};

String _networkIcon(String chain) => switch (chain.toLowerCase()) {
  'bsc' || 'bnb chain' => 'assets/figma/funding/bnb_chain.svg',
  _ => 'assets/figma/funding/arbitrum.svg',
};

String _assetName(String symbol) => switch (symbol.toUpperCase()) {
  'USDC' => 'USD Coin',
  'USDT' => 'Tether USD',
  'NVDAB' => 'NVIDIA',
  'TSLAB' => 'Tesla',
  _ => symbol,
};

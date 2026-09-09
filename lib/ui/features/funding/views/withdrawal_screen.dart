import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:rwa_interface/app/routing/routes.dart';
import 'package:rwa_interface/domain/models/decimal_value.dart';
import 'package:rwa_interface/domain/models/withdrawal.dart';
import 'package:rwa_interface/ui/core/formatters/token_amount_formatter.dart';
import 'package:rwa_interface/ui/core/theme/app_theme.dart';
import 'package:rwa_interface/ui/features/funding/providers/withdrawal_providers.dart';

class WithdrawalScreen extends ConsumerStatefulWidget {
  const WithdrawalScreen({super.key, this.showSelector = false});
  final bool showSelector;
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
      value = DecimalValue(raw, asset: 'USDC', unit: 'token');
    } on FormatException {
      setState(() => error = 'Enter a valid USDC amount.');
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
              chain: 'Arbitrum',
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
  Widget build(BuildContext context) => widget.showSelector
      ? const _AssetSelector()
      : Scaffold(
          body: SafeArea(
            child: quote == null
                ? _Form(
                    address: address,
                    amount: amount,
                    error: error,
                    submitting: quoting,
                    onReview: _review,
                  )
                : _Review(
                    quote: quote!,
                    onBack: () => setState(() => quote = null),
                  ),
          ),
        );
}

class _Form extends StatelessWidget {
  const _Form({
    required this.address,
    required this.amount,
    required this.error,
    required this.submitting,
    required this.onReview,
  });
  final TextEditingController address;
  final TextEditingController amount;
  final String? error;
  final bool submitting;
  final VoidCallback onReview;
  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppRwaColors>()!;
    return ListView(
      padding: const EdgeInsets.fromLTRB(20, 18, 20, 20),
      children: [
        Row(
          children: [
            IconButton(
              onPressed: () => context.pop(),
              icon: const Icon(Icons.arrow_back_ios_new, size: 20),
            ),
            Text(
              'Withdraw USDC',
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ],
        ),
        const SizedBox(height: 40),
        _RouteCard(),
        const SizedBox(height: 16),
        TextField(
          controller: address,
          decoration: const InputDecoration(
            labelText: 'Recipient address',
            hintText: 'Enter wallet address',
            suffixText: 'Paste',
          ),
        ),
        const SizedBox(height: 16),
        TextField(
          controller: amount,
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          decoration: const InputDecoration(
            labelText: 'Amount',
            hintText: '0.00',
            suffixText: 'USDC',
            helperText: 'Available balance is shown after quote',
          ),
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: colors.subtleSurface,
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Column(
            children: [
              _Detail(label: 'Network fee', value: 'Calculated on review'),
              _Detail(label: 'Recipient receives', value: '— USDC'),
            ],
          ),
        ),
        const SizedBox(height: 12),
        const Text(
          'Network fees may change before confirmation.',
          style: TextStyle(fontSize: 12),
        ),
        if (error != null) ...[
          const SizedBox(height: 12),
          Text(
            error!,
            style: TextStyle(
              color: Theme.of(context).extension<AppSemanticColors>()!.loss,
            ),
          ),
        ],
        const SizedBox(height: 28),
        FilledButton(
          onPressed: submitting ? null : onReview,
          child: Text(
            submitting ? 'Preparing withdrawal…' : 'Review withdrawal',
          ),
        ),
      ],
    );
  }
}

class _RouteCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppRwaColors>()!;
    return Container(
      decoration: BoxDecoration(
        color: colors.surface,
        border: Border.all(color: colors.border),
        borderRadius: BorderRadius.circular(12),
      ),
      child: const Column(
        children: [
          _Detail(label: 'Token', value: 'USDC'),
          Divider(height: 1),
          _Detail(label: 'Network', value: 'Arbitrum'),
        ],
      ),
    );
  }
}

class _Detail extends StatelessWidget {
  const _Detail({required this.label, required this.value});
  final String label;
  final String value;
  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
    child: Row(
      children: [
        Expanded(child: Text(label)),
        Text(value, style: const TextStyle(fontWeight: FontWeight.w600)),
      ],
    ),
  );
}

class _Review extends StatelessWidget {
  const _Review({required this.quote, required this.onBack});
  final WithdrawalQuote quote;
  final VoidCallback onBack;
  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppRwaColors>()!;
    return ListView(
      padding: const EdgeInsets.fromLTRB(20, 18, 20, 20),
      children: [
        Row(
          children: [
            IconButton(
              onPressed: onBack,
              icon: const Icon(Icons.arrow_back_ios_new, size: 20),
            ),
            Text(
              'Review withdrawal',
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ],
        ),
        const SizedBox(height: 40),
        const Text('YOU ARE SENDING', style: TextStyle(fontSize: 12)),
        Text(
          TokenAmountFormatter.format(quote.intent.amount, symbol: 'USDC'),
          style: Theme.of(context).textTheme.headlineLarge
              ?.copyWith(fontWeight: FontWeight.w700),
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
              const Text(
                'Withdrawal details',
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 17),
              ),
              _Detail(label: 'To', value: quote.intent.address),
              const _Detail(label: 'Network', value: 'Arbitrum'),
              _Detail(
                label: 'Network fee',
                value: TokenAmountFormatter.format(
                  quote.totalFee,
                  symbol: 'USDC',
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        _Detail(
          label: 'Recipient receives',
          value: TokenAmountFormatter.format(
            quote.estimatedReceive,
            symbol: 'USDC',
          ),
        ),
        const Divider(),
        _Detail(
          label: 'Total deducted',
          value: TokenAmountFormatter.format(
            quote.intent.amount,
            symbol: 'USDC',
          ),
        ),
        const SizedBox(height: 12),
        const Text(
          'Final authorization is required before funds are sent.',
          style: TextStyle(fontSize: 12),
        ),
        const SizedBox(height: 32),
        FilledButton(
          onPressed: null,
          child: const Text('Authorization required'),
        ),
      ],
    );
  }
}

class _AssetSelector extends StatelessWidget {
  const _AssetSelector();
  @override
  Widget build(BuildContext context) => Scaffold(
    body: SafeArea(
      child: ListView(
        padding: const EdgeInsets.fromLTRB(20, 18, 20, 20),
        children: [
          Row(
            children: [
              IconButton(
                onPressed: () => context.pop(),
                icon: const Icon(Icons.arrow_back_ios_new, size: 20),
              ),
              Text(
                'Select asset',
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ],
          ),
          const SizedBox(height: 24),
          const TextField(
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.search),
              hintText: 'Search assets',
            ),
          ),
          const SizedBox(height: 16),
          const Text('Available to withdraw', style: TextStyle(fontSize: 12)),
          const _AssetRow(
            symbol: 'USDC',
            detail: 'USD Coin · Arbitrum',
            amount: '1,240.20',
          ),
          const _AssetRow(
            symbol: 'USDT',
            detail: 'Tether USD · BNB Chain',
            amount: '580.00',
          ),
        ],
      ),
    ),
  );
}

class _AssetRow extends StatelessWidget {
  const _AssetRow({
    required this.symbol,
    required this.detail,
    required this.amount,
  });
  final String symbol;
  final String detail;
  final String amount;
  @override
  Widget build(BuildContext context) => InkWell(
    onTap: () => context.goNamed(AppRoutes.withdrawalName),
    child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        children: [
          CircleAvatar(child: Text(symbol.substring(0, 1))),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  symbol,
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
                Text(detail, style: const TextStyle(fontSize: 12)),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(amount, style: const TextStyle(fontWeight: FontWeight.w600)),
              Text('\$$amount', style: const TextStyle(fontSize: 12)),
            ],
          ),
        ],
      ),
    ),
  );
}

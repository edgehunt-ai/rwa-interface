import 'package:flutter/material.dart';
import 'package:rwa_interface/ui/core/navigation/app_page_header.dart';
import 'package:rwa_interface/ui/core/theme/app_theme.dart';

/// Presents the internal Spot/Perps transfer flow.
///
/// The execution endpoint is intentionally not called here yet; this screen
/// keeps the design flow usable while the transfer contract is introduced.
class TransferScreen extends StatefulWidget {
  const TransferScreen({super.key});

  @override
  State<TransferScreen> createState() => _TransferScreenState();
}

class _TransferScreenState extends State<TransferScreen> {
  final amount = TextEditingController(text: '51.4');
  bool perpsToSpot = false;

  @override
  void dispose() {
    amount.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppRwaColors>()!;
    final send = perpsToSpot ? 'Perps' : 'Spot';
    final receive = perpsToSpot ? 'Spot' : 'Perps';
    return Scaffold(
      backgroundColor: colors.canvas,
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(20, 18, 20, 20),
          children: [
            const AppPageHeader(title: 'Transfer'),
            const SizedBox(height: 16),
            _AccountSelector(
              send: send,
              receive: receive,
              onSwap: () => setState(() => perpsToSpot = !perpsToSpot),
            ),
            const SizedBox(height: 16),
            _SectionLabel('Send amount'),
            _AmountCard(
              amount: amount,
              available: perpsToSpot ? '51.4' : '100',
              onMax: () => amount.text = perpsToSpot ? '51.4' : '100',
            ),
            const SizedBox(height: 16),
            _SectionLabel('Receive amount'),
            _ReadOnlyCard(value: perpsToSpot ? '50.22' : '160'),
            const SizedBox(height: 16),
            _FeeSummary(colors: colors),
            const SizedBox(height: 8),
            _RiskNotice(colors: colors, increasing: perpsToSpot),
            const SizedBox(height: 8),
            Text(
              'Signature Details ⌄',
              style: TextStyle(fontSize: 12, color: colors.secondaryText),
            ),
            const SizedBox(height: 58),
            SizedBox(
              height: 48,
              width: double.infinity,
              child: FilledButton(
                onPressed: amount.text.trim().isEmpty ? null : () {},
                child: const Text('Sign & Transfer'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SectionLabel extends StatelessWidget {
  const _SectionLabel(this.label);
  final String label;
  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.only(bottom: 8),
    child: Text(label, style: Theme.of(context).textTheme.bodyMedium),
  );
}

class _AccountSelector extends StatelessWidget {
  const _AccountSelector({
    required this.send,
    required this.receive,
    required this.onSwap,
  });
  final String send;
  final String receive;
  final VoidCallback onSwap;
  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppRwaColors>()!;
    Widget account(String label, String value) => Expanded(
      child: Container(
        height: 78,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: colors.surface,
          border: Border.all(color: colors.border),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: TextStyle(fontSize: 12, color: colors.secondaryText),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(Icons.account_balance_wallet_outlined, size: 20),
                const SizedBox(width: 4),
                Text(value, style: Theme.of(context).textTheme.titleMedium),
              ],
            ),
          ],
        ),
      ),
    );
    return Stack(
      alignment: Alignment.center,
      children: [
        Row(
          children: [
            account('Send account', send),
            const SizedBox(width: 4),
            account('Receive account', receive),
          ],
        ),
        IconButton(
          onPressed: onSwap,
          icon: const Icon(Icons.arrow_forward, size: 18),
          style: IconButton.styleFrom(
            backgroundColor: colors.surface,
            side: BorderSide(color: colors.border),
          ),
        ),
      ],
    );
  }
}

class _AmountCard extends StatelessWidget {
  const _AmountCard({
    required this.amount,
    required this.available,
    required this.onMax,
  });
  final TextEditingController amount;
  final String available;
  final VoidCallback onMax;
  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppRwaColors>()!;
    return _Card(
      child: Row(
        children: [
          const CircleAvatar(
            radius: 14,
            backgroundColor: Color(0xff2775ca),
            child: Text('\$', style: TextStyle(color: Colors.white)),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'USDC (Arbitrum)',
                  style: Theme.of(context).textTheme.labelMedium,
                ),
                Text(
                  'Available: $available',
                  style: TextStyle(fontSize: 11, color: colors.secondaryText),
                ),
              ],
            ),
          ),
          SizedBox(
            width: 88,
            child: TextField(
              controller: amount,
              textAlign: TextAlign.right,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                isDense: true,
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 8,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ReadOnlyCard extends StatelessWidget {
  const _ReadOnlyCard({required this.value});
  final String value;
  @override
  Widget build(BuildContext context) => _Card(
    child: Row(
      children: [
        const CircleAvatar(
          radius: 14,
          backgroundColor: Color(0xff2775ca),
          child: Text('\$', style: TextStyle(color: Colors.white)),
        ),
        const SizedBox(width: 8),
        const Expanded(child: Text('USDC (Arbitrum)')),
        Text(value, style: Theme.of(context).textTheme.labelLarge),
      ],
    ),
  );
}

class _Card extends StatelessWidget {
  const _Card({required this.child});
  final Widget child;
  @override
  Widget build(BuildContext context) {
    final c = Theme.of(context).extension<AppRwaColors>()!;
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: c.surface,
        border: Border.all(color: c.border),
        borderRadius: BorderRadius.circular(12),
      ),
      child: child,
    );
  }
}

class _FeeSummary extends StatelessWidget {
  const _FeeSummary({required this.colors});
  final AppRwaColors colors;
  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: colors.subtleSurface,
      borderRadius: BorderRadius.circular(12),
    ),
    child: const Column(
      children: [
        _FeeRow('Estimated Time', '~1-3mins'),
        _FeeRow('Bridge Fee', '\$0.1'),
        _FeeRow('Network Fee', '\$0.1'),
      ],
    ),
  );
}

class _FeeRow extends StatelessWidget {
  const _FeeRow(this.label, this.value);
  final String label, value;
  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 3),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label),
        Text(value, style: const TextStyle(fontWeight: FontWeight.w600)),
      ],
    ),
  );
}

class _RiskNotice extends StatelessWidget {
  const _RiskNotice({required this.colors, required this.increasing});
  final AppRwaColors colors;
  final bool increasing;
  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: increasing ? const Color(0xfffff7ed) : const Color(0xffe9f8f4),
      border: Border.all(color: colors.border),
      borderRadius: BorderRadius.circular(8),
    ),
    child: Column(
      children: [
        Row(
          children: [
            Icon(
              increasing ? Icons.warning_amber : Icons.check_circle_outline,
              size: 14,
              color: increasing
                  ? const Color(0xffb45309)
                  : const Color(0xff04a08b),
            ),
            const SizedBox(width: 4),
            Expanded(
              child: Text(
                increasing
                    ? 'Your cross position risk will increase'
                    : 'Your cross position risk will decrease',
                style: TextStyle(
                  fontSize: 13,
                  color: increasing
                      ? const Color(0xffb45309)
                      : const Color(0xff04a08b),
                ),
              ),
            ),
            const Icon(Icons.keyboard_arrow_up, size: 16),
          ],
        ),
        const SizedBox(height: 12),
        const _FeeRow('Long  TSLA Liq. Price', '\$182.4 → \$180.11'),
        const _FeeRow('Short NVDA Liq. Price', '\$128.40 → \$131.20'),
      ],
    ),
  );
}

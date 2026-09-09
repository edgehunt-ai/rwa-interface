part of 'bstocks_order_panel.dart';

/// Recoverable insufficient-balance state for the order flow.
class BstocksFundingRequiredSheet extends StatelessWidget {
  const BstocksFundingRequiredSheet({
    super.key,
    required this.amountNeeded,
    required this.onInAppTransfer,
    required this.onExternalDeposit,
  });

  final DecimalValue amountNeeded;
  final VoidCallback onInAppTransfer;
  final VoidCallback onExternalDeposit;

  @override
  Widget build(BuildContext context) => Material(
    borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
    child: SafeArea(
      top: false,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 32,
                height: 4,
                decoration: BoxDecoration(
                  color: Theme.of(context)
                      .extension<AppRwaColors>()!
                      .secondaryText,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const SizedBox(height: 16),
            const Row(
              children: [
                _Step(number: '1', label: 'Prepare Funds', active: true),
                _Step(number: '2', label: '', active: false),
                _Step(number: '3', label: '', active: false),
              ],
            ),
            const Divider(),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Theme.of(context)
                    .extension<AppRwaColors>()!
                    .subtleSurface,
                borderRadius: BorderRadius.circular(14),
              ),
              child: _SummaryRow(
                label: 'Amount Needed',
                value: TokenAmountFormatter.format(
                  amountNeeded,
                  symbol: 'USDT',
                ),
              ),
            ),
            const SizedBox(height: 16),
            const Text('Add funds from:'),
            const SizedBox(height: 8),
            _FundingRoute(
              title: 'In-App Transfer',
              detail: r'Balance: $300',
              onTap: onInAppTransfer,
            ),
            const SizedBox(height: 12),
            _FundingRoute(
              title: 'External Deposit',
              detail: 'Deposit USDT on BSC from another platform or wallet',
              onTap: onExternalDeposit,
            ),
          ],
        ),
      ),
    ),
  );
}

class _Step extends StatelessWidget {
  const _Step({
    required this.number,
    required this.label,
    required this.active,
  });
  final String number;
  final String label;
  final bool active;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppRwaColors>()!;
    return Row(
      children: [
        CircleAvatar(
          radius: 14,
          backgroundColor: active ? colors.primaryAction : colors.subtleSurface,
          child: Text(
            number,
            style: TextStyle(color: active ? colors.onPrimaryAction : null),
          ),
        ),
        if (label.isNotEmpty) ...[const SizedBox(width: 8), Text(label)],
        const SizedBox(width: 8),
      ],
    );
  }
}

class _FundingRoute extends StatelessWidget {
  const _FundingRoute({
    required this.title,
    required this.detail,
    required this.onTap,
  });
  final String title;
  final String detail;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) => InkWell(
    onTap: onTap,
    child: Container(
      constraints: const BoxConstraints(minHeight: 72),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(
          color: Theme.of(context).extension<AppRwaColors>()!.border,
        ),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: Theme.of(context).extension<AppRwaColors>()!.subtleSurface,
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
                Text(detail, style: const TextStyle(fontSize: 12)),
              ],
            ),
          ),
          const Icon(Icons.chevron_right, size: 20),
        ],
      ),
    ),
  );
}

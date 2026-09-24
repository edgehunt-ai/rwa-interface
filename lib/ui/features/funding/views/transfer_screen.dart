import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
  final _usdtAmount = TextEditingController(text: '50');
  final _usdcAmount = TextEditingController(text: '51.4');
  final _ethAmount = TextEditingController(text: '0.0');
  bool _perpsToSpot = false;
  bool _riskExpanded = true;

  @override
  void dispose() {
    _usdtAmount.dispose();
    _usdcAmount.dispose();
    _ethAmount.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppRwaColors>()!;
    final send = _perpsToSpot ? 'Perps' : 'Spot';
    final receive = _perpsToSpot ? 'Spot' : 'Perps';

    return Scaffold(
      backgroundColor: colors.canvas,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) => SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(20, 18, 20, 20),
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: constraints.maxHeight - 38,
              ),
              child: IntrinsicHeight(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const AppPageHeader(title: 'Transfer'),
                    const SizedBox(height: 16),
                    _AccountSelector(
                      send: send,
                      receive: receive,
                      onSwap: () =>
                          setState(() => _perpsToSpot = !_perpsToSpot),
                    ),
                    const SizedBox(height: 16),
                    const _SectionLabel('Send amount'),
                    _SendAmountCard(
                      usdtAmount: _usdtAmount,
                      usdcAmount: _usdcAmount,
                      ethAmount: _ethAmount,
                    ),
                    const SizedBox(height: 16),
                    const _SectionLabel('Receive amount'),
                    const _ReceiveAmountCard(value: '160'),
                    const SizedBox(height: 16),
                    const _FeeSummary(),
                    const SizedBox(height: 8),
                    _RiskNotice(
                      increasing: _perpsToSpot,
                      expanded: _riskExpanded,
                      onToggle: () =>
                          setState(() => _riskExpanded = !_riskExpanded),
                    ),
                    const SizedBox(height: 8),
                    const _SignatureDetails(),
                    const Spacer(),
                    const SizedBox(height: 28),
                    SizedBox(
                      height: 48,
                      child: FilledButton(
                        onPressed: () {},
                        child: const Text('Sign & Transfer'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
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
    child: Text(
      label,
      style: Theme.of(context).textTheme.bodyMedium
          ?.copyWith(fontWeight: FontWeight.w500),
    ),
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

    Widget account(
      String label,
      String value, {
      required bool receiveSide,
    }) => Expanded(
      child: Container(
        height: 78,
        padding: EdgeInsets.fromLTRB(receiveSide ? 28 : 12, 12, 12, 12),
        decoration: BoxDecoration(
          color: colors.surface,
          border: Border.all(color: colors.border),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 16,
              child: Text(
                label,
                style: Theme.of(context).textTheme.bodySmall
                    ?.copyWith(color: colors.secondaryText),
              ),
            ),
            const SizedBox(height: 8),
            SizedBox(
              height: 24,
              child: Row(
                children: [
                  SizedBox.square(
                    dimension: 24,
                    child: SvgPicture.asset(
                      value == 'Spot'
                          ? 'assets/figma/home_markets/venue_bnb.svg'
                          : 'assets/figma/home_markets/venue_hyperliquid.svg',
                      fit: BoxFit.contain,
                    ),
                  ),
                  const SizedBox(width: 4),
                  Text(value, style: Theme.of(context).textTheme.titleMedium),
                ],
              ),
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
            account('Send account', send, receiveSide: false),
            const SizedBox(width: 4),
            account('Receive account', receive, receiveSide: true),
          ],
        ),
        Material(
          color: colors.surface,
          shape: CircleBorder(side: BorderSide(color: colors.border)),
          child: InkWell(
            onTap: onSwap,
            customBorder: const CircleBorder(),
            child: const SizedBox(
              width: 28,
              height: 28,
              child: Icon(Icons.arrow_forward, size: 16),
            ),
          ),
        ),
      ],
    );
  }
}

class _SendAmountCard extends StatelessWidget {
  const _SendAmountCard({
    required this.usdtAmount,
    required this.usdcAmount,
    required this.ethAmount,
  });

  final TextEditingController usdtAmount;
  final TextEditingController usdcAmount;
  final TextEditingController ethAmount;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppRwaColors>()!;
    return DecoratedBox(
      decoration: BoxDecoration(
        color: colors.surface,
        border: Border.all(color: colors.border),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          _AssetAmountRow(
            asset: 'USDT',
            network: 'Arbitrum',
            available: '50',
            assetPath: 'assets/figma/funding/usdt.png',
            controller: usdtAmount,
            topPadding: 16,
          ),
          _AssetAmountRow(
            asset: 'USDC',
            network: 'Arbitrum',
            available: '100',
            assetPath: 'assets/figma/funding/usdc.svg',
            controller: usdcAmount,
          ),
          _AssetAmountRow(
            asset: 'ETH',
            network: 'Polygon',
            available: '50',
            assetPath: 'assets/figma/funding/eth.svg',
            controller: ethAmount,
            mutedAmount: true,
          ),
          InkWell(
            onTap: () {},
            borderRadius: const BorderRadius.vertical(
              bottom: Radius.circular(12),
            ),
            child: const SizedBox(
              height: 50,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    _AddTokenIcon(),
                    SizedBox(width: 8),
                    Text(
                      'Add token',
                      style: TextStyle(
                        fontSize: 13,
                        height: 18 / 13,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _AssetAmountRow extends StatelessWidget {
  const _AssetAmountRow({
    required this.asset,
    required this.network,
    required this.available,
    required this.assetPath,
    required this.controller,
    this.topPadding = 12,
    this.mutedAmount = false,
  });

  final String asset;
  final String network;
  final String available;
  final String assetPath;
  final TextEditingController controller;
  final double topPadding;
  final bool mutedAmount;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppRwaColors>()!;
    return SizedBox(
      height: topPadding == 16 ? 72 : 69,
      child: Padding(
        padding: EdgeInsets.fromLTRB(
          16,
          topPadding,
          16,
          topPadding == 16 ? 20 : 21,
        ),
        child: Row(
          children: [
            const _CheckedBox(),
            const SizedBox(width: 8),
            assetPath.endsWith('.svg')
                ? SvgPicture.asset(assetPath, width: 28, height: 28)
                : Image.asset(assetPath, width: 28, height: 28),
            const SizedBox(width: 4),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        asset,
                        style: const TextStyle(
                          fontSize: 13,
                          height: 18 / 13,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(width: 4),
                      Flexible(
                        child: Text(
                          '($network)',
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 11,
                            height: 14 / 11,
                            color: colors.secondaryText,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Available: $available',
                    style: TextStyle(
                      fontSize: 11,
                      height: 14 / 11,
                      color: colors.secondaryText,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            SizedBox(
              width: 88,
              height: 32,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: colors.subtleSurface,
                  border: Border.all(color: colors.border),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: TextField(
                  controller: controller,
                  textAlign: TextAlign.right,
                  textAlignVertical: TextAlignVertical.center,
                  keyboardType: const TextInputType.numberWithOptions(
                    decimal: true,
                  ),
                  style: TextStyle(
                    fontSize: 15,
                    height: 22 / 15,
                    fontWeight: FontWeight.w600,
                    color: mutedAmount
                        ? colors.tertiaryText
                        : colors.primaryText,
                  ),
                  decoration: const InputDecoration(
                    isDense: true,
                    filled: false,
                    border: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    contentPadding: EdgeInsets.only(
                      left: 12,
                      right: 16,
                      top: 5,
                      bottom: 5,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CheckedBox extends StatelessWidget {
  const _CheckedBox();

  @override
  Widget build(BuildContext context) => Container(
    width: 18,
    height: 18,
    decoration: BoxDecoration(
      color: Theme.of(context).extension<AppRwaColors>()!.primaryAction,
      borderRadius: BorderRadius.circular(2),
    ),
    child: const Icon(Icons.check, size: 14, color: Colors.white),
  );
}

class _AddTokenIcon extends StatelessWidget {
  const _AddTokenIcon();

  @override
  Widget build(BuildContext context) => Container(
    width: 24,
    height: 24,
    decoration: BoxDecoration(
      color: Theme.of(context).extension<AppRwaColors>()!.subtleSurface,
      shape: BoxShape.circle,
    ),
    child: const Icon(Icons.add, size: 19),
  );
}

class _ReceiveAmountCard extends StatelessWidget {
  const _ReceiveAmountCard({required this.value});

  final String value;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppRwaColors>()!;
    return Container(
      height: 59,
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 12),
      decoration: BoxDecoration(
        color: colors.surface,
        border: Border.all(color: colors.border),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          SvgPicture.asset(
            'assets/figma/funding/usdc.svg',
            width: 28,
            height: 28,
          ),
          const SizedBox(width: 4),
          const Text(
            'USDC',
            style: TextStyle(
              fontSize: 13,
              height: 18 / 13,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(width: 4),
          Expanded(
            child: Text(
              '(Arbitrum)',
              style: TextStyle(
                fontSize: 11,
                height: 14 / 11,
                color: colors.secondaryText,
              ),
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontSize: 15,
              height: 22 / 15,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

class _FeeSummary extends StatelessWidget {
  const _FeeSummary();

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppRwaColors>()!;
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: colors.subtleSurface,
        borderRadius: BorderRadius.circular(12),
      ),
      child: const Column(
        children: [
          _FeeRow('Estimated Time', '~1-3mins'),
          SizedBox(height: 8),
          _FeeRow('Bridge Fee', '\$0.1'),
          SizedBox(height: 8),
          _FeeRow('Network Fee', '\$0.1'),
          SizedBox(height: 8),
          _FeeRow('Slippage', '0.12%', editable: true),
        ],
      ),
    );
  }
}

class _FeeRow extends StatelessWidget {
  const _FeeRow(this.label, this.value, {this.editable = false});

  final String label;
  final String value;
  final bool editable;

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
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (editable) ...[
              SvgPicture.asset(
                'assets/figma/trade/order_slippage_edit.svg',
                width: 12,
                height: 12,
                colorFilter: ColorFilter.mode(
                  colors.primaryText,
                  BlendMode.srcIn,
                ),
              ),
              const SizedBox(width: 4),
            ],
            Text(
              value,
              style: const TextStyle(
                fontSize: 13,
                height: 18 / 13,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _RiskNotice extends StatelessWidget {
  const _RiskNotice({
    required this.increasing,
    required this.expanded,
    required this.onToggle,
  });

  final bool increasing;
  final bool expanded;
  final VoidCallback onToggle;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppRwaColors>()!;
    final accent = increasing
        ? const Color(0xFFB45309)
        : const Color(0xFF04A08B);
    final background = increasing
        ? const Color(0xFFFFF7ED)
        : const Color(0xFFE9F8F4);

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: background,
        border: Border.all(color: colors.border),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          InkWell(
            onTap: onToggle,
            child: Row(
              children: [
                Icon(
                  increasing ? Icons.warning_amber : Icons.check_circle_outline,
                  size: 14,
                  color: accent,
                ),
                const SizedBox(width: 4),
                Expanded(
                  child: Text(
                    increasing
                        ? 'Your cross position risk will increase'
                        : 'Your cross position risk will decrease',
                    style: TextStyle(
                      fontSize: 13,
                      height: 18 / 13,
                      fontWeight: FontWeight.w500,
                      color: accent,
                    ),
                  ),
                ),
                Icon(
                  expanded
                      ? Icons.keyboard_arrow_up
                      : Icons.keyboard_arrow_down,
                  size: 16,
                  color: accent,
                ),
              ],
            ),
          ),
          if (expanded) ...[
            const SizedBox(height: 16),
            const _RiskRow(
              side: 'Long',
              product: 'TSLA Liq. Price',
              from: '\$182.4',
              to: '\$180.11',
            ),
            const SizedBox(height: 4),
            const _RiskRow(
              side: 'Short',
              product: 'NVDA Liq. Price',
              from: '\$128.40',
              to: '\$131.20',
            ),
          ],
        ],
      ),
    );
  }
}

class _RiskRow extends StatelessWidget {
  const _RiskRow({
    required this.side,
    required this.product,
    required this.from,
    required this.to,
  });

  final String side;
  final String product;
  final String from;
  final String to;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppRwaColors>()!;
    const style = TextStyle(fontSize: 12, height: 16 / 12);
    return Row(
      children: [
        Text(
          side,
          style: style.copyWith(
            fontWeight: FontWeight.w500,
            color: colors.tertiaryText,
          ),
        ),
        const SizedBox(width: 4),
        Expanded(
          child: Text(
            product,
            style: style.copyWith(color: colors.secondaryText),
          ),
        ),
        Text(
          '$from → ',
          style: style.copyWith(
            fontWeight: FontWeight.w600,
            color: colors.tertiaryText,
          ),
        ),
        Text(to, style: style.copyWith(fontWeight: FontWeight.w600)),
      ],
    );
  }
}

class _SignatureDetails extends StatelessWidget {
  const _SignatureDetails();

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppRwaColors>()!;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          'Signature Details',
          style: TextStyle(
            fontSize: 12,
            height: 16 / 12,
            color: colors.secondaryText,
          ),
        ),
        const SizedBox(width: 4),
        Icon(Icons.keyboard_arrow_down, size: 14, color: colors.secondaryText),
      ],
    );
  }
}

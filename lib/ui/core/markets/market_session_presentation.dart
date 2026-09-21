import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rwa_interface/domain/models/market_snapshot.dart';
import 'package:rwa_interface/l10n/generated/app_localizations.dart';
import 'package:rwa_interface/ui/core/theme/app_theme.dart';

String marketSessionLabel(AppLocalizations l10n, MarketSessionKind kind) =>
    switch (kind) {
      MarketSessionKind.premarket => l10n.tradePreMarket,
      MarketSessionKind.regular => l10n.tradeRegularMarket,
      MarketSessionKind.afterHours => l10n.tradeAfterHours,
      MarketSessionKind.overnight => l10n.tradeOvernight,
      MarketSessionKind.weekend => l10n.tradeWeekend,
      MarketSessionKind.holiday => l10n.tradeHoliday,
    };

String marketSessionAsset(MarketSessionKind kind) => switch (kind) {
  MarketSessionKind.regular => 'assets/figma/trade/session_regular.svg',
  MarketSessionKind.overnight =>
    'assets/figma/trade/session_overnight_moon.svg',
  MarketSessionKind.weekend ||
  MarketSessionKind.holiday => 'assets/figma/trade/session_closed.svg',
  _ => 'assets/figma/trade/session_pre_after.svg',
};

Color marketSessionColor(MarketSessionKind kind) => switch (kind) {
  MarketSessionKind.regular => const Color(0xFFB9F34A),
  MarketSessionKind.premarket ||
  MarketSessionKind.afterHours => const Color(0xFFFF9654),
  MarketSessionKind.overnight => const Color(0xFF2690E6),
  MarketSessionKind.weekend ||
  MarketSessionKind.holiday => const Color(0xFF9292A0),
};

MarketSessionSegment? currentMarketSegment(MarketHours hours) {
  final now = DateTime.now().toUtc();
  return hours.segments
          .where((segment) => segment.kind == hours.current)
          .where(
            (segment) =>
                !now.isBefore(segment.start) && now.isBefore(segment.end),
          )
          .firstOrNull ??
      hours.segments
          .where((segment) => segment.kind == hours.current)
          .firstOrNull;
}

/// Rebuilds [builder] once a second with the time left until [until],
/// formatted as `HH:MM` (or `HH:MM:SS` when [showSeconds]).
///
/// The tick writes into a [ValueNotifier] instead of calling `setState`, so
/// only the widget [builder] returns is rebuilt and never the tree around it.
/// The notifier is not written when the formatted string is unchanged, and the
/// ticker stops as soon as [until] has passed.
class MarketCountdownBuilder extends StatefulWidget {
  const MarketCountdownBuilder({
    super.key,
    required this.until,
    required this.builder,
    this.showSeconds = false,
  });

  final DateTime until;
  final bool showSeconds;
  final Widget Function(BuildContext context, String countdown) builder;

  @override
  State<MarketCountdownBuilder> createState() => _MarketCountdownBuilderState();
}

class _MarketCountdownBuilderState extends State<MarketCountdownBuilder> {
  final _countdown = ValueNotifier<String>('');
  Timer? _ticker;

  @override
  void initState() {
    super.initState();
    _tick();
    _ticker = Timer.periodic(const Duration(seconds: 1), (_) => _tick());
  }

  @override
  void didUpdateWidget(MarketCountdownBuilder oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.until != oldWidget.until ||
        widget.showSeconds != oldWidget.showSeconds) {
      _ticker ??= Timer.periodic(const Duration(seconds: 1), (_) => _tick());
      _tick();
    }
  }

  void _tick() {
    final left = widget.until.difference(DateTime.now());
    if (left.isNegative) {
      _ticker?.cancel();
      _ticker = null;
    }
    final clamped = left.isNegative ? Duration.zero : left;
    String pad(int value) => value.toString().padLeft(2, '0');
    final seconds = widget.showSeconds ? ':${pad(clamped.inSeconds % 60)}' : '';
    _countdown.value =
        '${pad(clamped.inHours)}:${pad(clamped.inMinutes % 60)}$seconds';
  }

  @override
  void dispose() {
    _ticker?.cancel();
    _countdown.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => ValueListenableBuilder<String>(
    valueListenable: _countdown,
    builder: (context, countdown, _) => widget.builder(context, countdown),
  );
}

/// Pill showing the session the US market is currently in and its local start
/// time.
class MarketSessionBadge extends StatelessWidget {
  const MarketSessionBadge({
    required this.hours,
    this.compact = false,
    super.key,
  });

  final MarketHours? hours;

  /// The tighter pill the trade screen's navigation bar uses.
  final bool compact;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppRwaColors>()!;
    final l10n = AppLocalizations.of(context);
    final value = hours;
    final segment = value == null ? null : currentMarketSegment(value);
    final label = value == null
        ? l10n.usMarket
        : marketSessionLabel(l10n, segment?.kind ?? value.current);
    final style = TextStyle(
      fontSize: 11,
      height: 16 / 11,
      color: colors.primaryText,
    );
    return Container(
      constraints: BoxConstraints(minHeight: compact ? 0 : 32),
      padding: EdgeInsets.symmetric(horizontal: compact ? 4 : 10, vertical: 2),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: value == null
            ? colors.subtleSurface
            : marketSessionColor(value.current).withValues(alpha: .1),
        borderRadius: BorderRadius.circular(compact ? 8 : 999),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (value != null) ...[
            SvgPicture.asset(
              marketSessionAsset(value.current),
              key: ValueKey('market-status-icon-${value.current.name}'),
              width: 14,
              height: 14,
            ),
            const SizedBox(width: 4),
          ],
          Text(
            segment == null
                ? label
                : '$label ${_formatLocalTime(segment.start)}',
            style: style,
          ),
        ],
      ),
    );
  }
}

String _formatLocalTime(DateTime value) {
  final local = value.toLocal();
  return '${local.hour.toString().padLeft(2, '0')}:${local.minute.toString().padLeft(2, '0')}';
}

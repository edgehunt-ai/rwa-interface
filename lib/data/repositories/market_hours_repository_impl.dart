import 'package:rwa_api_client/rwa_api_client.dart' as api;

import '../../domain/models/market_snapshot.dart';
import '../../domain/repositories/market_hours_repository.dart';
import '../services/charts_service.dart';

final class MarketHoursRepositoryImpl implements MarketHoursRepository {
  MarketHoursRepositoryImpl(this._service);

  final ChartsService _service;

  @override
  Future<MarketHours> getMarketHours() async {
    final value = await _service.getMarketSessions();
    return MarketHours(
      timezone: value.timezone,
      current: _sessionKind(value.current),
      currentLabel: value.currentLabel,
      currentDescription: value.currentDescription,
      nextSession: value.nextSession == null
          ? null
          : _sessionKind(value.nextSession!),
      nextTransitionAt: value.nextTransitionAt?.toUtc(),
      secondsUntilTransition: value.secondsUntilTransition,
      isHoliday: value.isHoliday ?? false,
      holidayName: value.holidayName,
      segments: (value.segments?.toList() ?? const <api.SessionSegment>[])
          .map(
            (segment) => MarketSessionSegment(
              kind: _sessionKind(segment.session),
              start: segment.start.toUtc(),
              end: segment.end.toUtc(),
              label: segment.label,
            ),
          )
          .toList(growable: false),
    );
  }

  MarketSessionKind _sessionKind(api.SessionKind value) => switch (value) {
    api.SessionKind.premarket => MarketSessionKind.premarket,
    api.SessionKind.regular => MarketSessionKind.regular,
    api.SessionKind.after => MarketSessionKind.afterHours,
    api.SessionKind.overnight => MarketSessionKind.overnight,
    api.SessionKind.weekend => MarketSessionKind.weekend,
    api.SessionKind.holiday => MarketSessionKind.holiday,
    _ => MarketSessionKind.holiday,
  };
}

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Whether bStocks spot trading entry points are offered on this platform.
///
/// App Store review (guideline 3.1.5) rejects spot trading because bStocks
/// orders may route through third-party exchange venues. iOS therefore lists
/// only perps and blocks spot trade routes; existing spot holdings, deposits,
/// transfers, withdrawals, and history remain available.
final spotTradingAvailableProvider = Provider<bool>(
  (_) => kIsWeb || defaultTargetPlatform != TargetPlatform.iOS,
);

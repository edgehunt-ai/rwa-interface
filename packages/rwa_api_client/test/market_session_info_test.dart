import 'package:test/test.dart';
import 'package:rwa_api_client/rwa_api_client.dart';

// tests for MarketSessionInfo
void main() {
  final instance = MarketSessionInfoBuilder();
  // TODO add properties to the builder and call build()

  group(MarketSessionInfo, () {
    // String timezone
    test('to test the property `timezone`', () async {
      // TODO
    });

    // SessionKind current
    test('to test the property `current`', () async {
      // TODO
    });

    // String currentLabel
    test('to test the property `currentLabel`', () async {
      // TODO
    });

    // String currentDescription
    test('to test the property `currentDescription`', () async {
      // TODO
    });

    // SessionKind nextSession
    test('to test the property `nextSession`', () async {
      // TODO
    });

    // DateTime nextTransitionAt
    test('to test the property `nextTransitionAt`', () async {
      // TODO
    });

    // 距下一次时段切换的秒数，用于「距开盘 02:14:33」倒计时
    // int secondsUntilTransition
    test('to test the property `secondsUntilTransition`', () async {
      // TODO
    });

    // bool isHoliday
    test('to test the property `isHoliday`', () async {
      // TODO
    });

    // String holidayName
    test('to test the property `holidayName`', () async {
      // TODO
    });

    // BuiltList<SessionSegment> segments
    test('to test the property `segments`', () async {
      // TODO
    });

  });
}

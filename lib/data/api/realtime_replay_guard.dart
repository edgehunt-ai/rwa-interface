import '../../domain/models/api_failure.dart';
import '../../domain/models/realtime_envelope.dart';

final class Hip3EventCursor {
  Hip3EventCursor._(this.stream, this.sequence);
  final String stream;
  final BigInt sequence;
  static final _pattern = RegExp(r'^h3\.([0-9a-f]{32})\.(0|[1-9][0-9]{0,18})$');
  static final _maximum = BigInt.parse('9223372036854775807');

  static Hip3EventCursor parse(String value) {
    final match = value.length <= 55 ? _pattern.firstMatch(value) : null;
    if (match == null || match.end != value.length) {
      throw const CompatibilityFailure();
    }
    final sequence = BigInt.parse(match.group(2)!);
    if (sequence > _maximum) throw const CompatibilityFailure();
    return Hip3EventCursor._(match.group(1)!, sequence);
  }
}

/// One subscription's replay state. HIP3 needs only its latest sequence;
/// generic reserved channels retain a bounded recent-ID window, not every ID.
final class RealtimeReplayGuard {
  RealtimeReplayGuard({this.capacity = 256}) : assert(capacity > 0);
  final int capacity;
  final _recent = <String>{};
  Hip3EventCursor? _last;

  int get retainedIdCount => _recent.length + (_last == null ? 0 : 1);

  bool accept(RealtimeEnvelope event) {
    // A recovery instruction is not a duplicate business update.
    if (event.eventName == 'resync_required') return true;
    if (event.eventName.startsWith('hip3_')) {
      final cursor = Hip3EventCursor.parse(event.eventId);
      final last = _last;
      if (last != null) {
        if (cursor.stream != last.stream) throw const CompatibilityFailure();
        if (cursor.sequence <= last.sequence) return false;
      }
      _last = cursor;
      return true;
    }
    if (!_recent.add(event.eventId)) return false;
    if (_recent.length > capacity) _recent.remove(_recent.first);
    return true;
  }
}

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/models/realtime_envelope.dart';
import 'api_providers.dart';

final realtimeEventsProvider = StreamProvider.autoDispose
    .family<RealtimeEnvelope, String>((ref, channelsKey) {
      final channels = channelsKey
          .split(',')
          .where((value) => value.isNotEmpty)
          .toSet();
      return ref.watch(realtimeServiceProvider).subscribe(channels: channels);
    });

typedef RealtimeEntityKey = ({String channelsKey, String entityId});

final realtimeEntityProvider = StreamProvider.autoDispose
    .family<RealtimeEnvelope, RealtimeEntityKey>((ref, key) {
      final channels = key.channelsKey
          .split(',')
          .where((value) => value.isNotEmpty)
          .toSet();
      return ref
          .watch(realtimeServiceProvider)
          .subscribe(channels: channels)
          .where((event) => _eventEntityId(event) == key.entityId);
    });

String? _eventEntityId(RealtimeEnvelope event) =>
    event.data['entity_id']?.toString() ??
    event.data['order_id']?.toString() ??
    event.data['position_id']?.toString();

String canonicalChannels(Iterable<String> channels) {
  final sorted = channels.toSet().toList()..sort();
  return sorted.join(',');
}

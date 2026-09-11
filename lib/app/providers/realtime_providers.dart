import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/models/realtime_envelope.dart';
import '../../domain/repositories/realtime_repository.dart';
import 'api_providers.dart';
import 'session_scope.dart';

final realtimeEventsProvider = StreamProvider.autoDispose
    .family<RealtimeEnvelope, String>((ref, channelsKey) {
      ref.watch(sessionGenerationProvider);
      final channels = channelsKey
          .split(',')
          .where((value) => value.isNotEmpty)
          .toSet();
      return ref.watch(realtimeServiceProvider).subscribe(channels: channels);
    });

typedef TypedRealtimeKey = ({String channelsKey, int generation});

final typedRealtimeEventsProvider = StreamProvider.autoDispose
    .family<TypedRealtimeEvent, TypedRealtimeKey>((ref, key) {
      if (ref.watch(sessionGenerationProvider).value != key.generation) {
        return const Stream.empty();
      }
      final channels = key.channelsKey
          .split(',')
          .where((value) => value.isNotEmpty)
          .toSet();
      return ref
          .watch(realtimeRepositoryProvider)
          .subscribe(channels: channels);
    });

typedef RealtimeEntityKey = ({String channelsKey, String entityId});

final realtimeEntityProvider = StreamProvider.autoDispose
    .family<RealtimeEnvelope, RealtimeEntityKey>((ref, key) {
      ref.watch(sessionGenerationProvider);
      final channels = key.channelsKey
          .split(',')
          .where((value) => value.isNotEmpty)
          .toSet();
      return ref
          .watch(realtimeServiceProvider)
          .subscribe(channels: channels)
          .where((event) => event.entityId == key.entityId);
    });

String canonicalChannels(Iterable<String> channels) {
  final sorted = channels.toSet().toList()..sort();
  return sorted.join(',');
}

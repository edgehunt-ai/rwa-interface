import 'dart:convert';

import 'package:rwa_api_client/rwa_api_client.dart' as api;

import '../../domain/models/api_failure.dart';
import '../../domain/models/realtime_envelope.dart';
import 'realtime_replay_guard.dart';

/// Data-boundary state only. Repositories must map these public projections to
/// domain resources before exposing them to widgets or presentation providers.
final class Hip3RealtimeScope {
  Hip3RealtimeScope({
    required String signer,
    required this.environment,
    required Set<String> channels,
  }) : signer = signer.toLowerCase(),
       channels = Set.unmodifiable(channels) {
    if (signer.length != 42 ||
        !RegExp(r'^0x[0-9a-fA-F]{40}$').hasMatch(signer) ||
        !_environments.contains(environment) ||
        channels.isEmpty ||
        channels.length > 32 ||
        channels.any((channel) => !_validChannel(channel)) ||
        channels.join(',').length > 4096) {
      throw ArgumentError('Invalid HIP3 realtime scope');
    }
    final markets = channels
        .where(
          (c) => c.startsWith('hip3:price:') || c.startsWith('hip3:candle:'),
        )
        .map((c) {
          final parts = c.split(':');
          return '${parts[2]}:${parts.skip(parts[1] == 'price' ? 3 : 4).join(':')}';
        })
        .toSet();
    if (markets.length > 8) throw ArgumentError('Too many HIP3 markets');
  }

  static const _environments = {'mainnet', 'testnet'};
  static bool _validChannel(String value) {
    if (const {
      'hip3:orders',
      'hip3:positions',
      'hip3:balance',
    }.contains(value)) {
      return true;
    }
    final parts = value.split(':');
    if (parts.length < 5 ||
        parts[0] != 'hip3' ||
        !_environments.contains(parts[2])) {
      return false;
    }
    if (parts[1] == 'price' && parts.length == 5) {
      return _validProduct(parts.skip(3).join(':'));
    }
    return parts[1] == 'candle' &&
        parts.length == 6 &&
        const {'1m', '5m', '15m', '1h', '4h', '1d'}.contains(parts[3]) &&
        _validProduct(parts.skip(4).join(':'));
  }

  final String signer;
  final String environment;
  final Set<String> channels;
}

typedef Hip3RealtimeKey = ({String channel, String entity});

final class Hip3RealtimeResource {
  Hip3RealtimeResource._(this.kind, this.data, this.bytes);
  final String kind;
  final Map<String, Object?> data;
  final int bytes;
}

final class Hip3RealtimeState {
  Hip3RealtimeState._({
    required this.cursor,
    required this.completedAt,
    required this.emittedAt,
    required Map<Hip3RealtimeKey, Hip3RealtimeResource> resources,
  }) : resources = Map.unmodifiable(resources);

  final String cursor;

  /// Completion of the base snapshot, not an exchange-wide atomic timestamp.
  final DateTime completedAt;
  final DateTime emittedAt;
  final Map<Hip3RealtimeKey, Hip3RealtimeResource> resources;
}

/// Replaces whole scoped snapshots and atomically applies validated increments.
/// Rejected batches never advance the cursor or mutate the preceding snapshot.
final class Hip3RealtimeAccumulator {
  Hip3RealtimeAccumulator(this.scope);
  final Hip3RealtimeScope scope;
  Hip3RealtimeState? _state;
  Hip3RealtimeState? get state => _state;

  bool apply(RealtimeEnvelope event) {
    try {
      if (event.data['event'] != event.eventName ||
          event.data['event_id'] != event.eventId ||
          api.standardSerializers.deserializeWith(
                api.RealtimeEvent.serializer,
                event.data,
              ) ==
              null) {
        throw const CompatibilityFailure();
      }
      if (event.eventName == 'resync_required') {
        _state = null;
        return true;
      }
      final cursor = Hip3EventCursor.parse(event.eventId);
      final previous = _state;
      if (previous != null) {
        final before = Hip3EventCursor.parse(previous.cursor);
        if (cursor.stream != before.stream) throw const CompatibilityFailure();
        if (cursor.sequence <= before.sequence) return false;
      } else if (event.eventName != 'hip3_snapshot') {
        throw const CompatibilityFailure();
      }
      final body = _map(event.data['data']);
      final snapshot = event.eventName == 'hip3_snapshot';
      DateTime completedAt;
      final resources = <Hip3RealtimeKey, Hip3RealtimeResource>{};
      if (snapshot) {
        final channels = body['channels'];
        if (channels is! List ||
            channels.length != scope.channels.length ||
            channels.toSet().length != channels.length ||
            !channels.every(scope.channels.contains) ||
            body['environment'] != scope.environment ||
            (body['signer'] as String).toLowerCase() != scope.signer) {
          throw const CompatibilityFailure();
        }
        completedAt = DateTime.parse(body['completed_at'] as String).toUtc();
        final items = body['items'] as List;
        if (items.length > 1000) throw const CompatibilityFailure();
        for (final item in items) {
          final member = _map(item);
          _put(
            resources,
            member['event'] as String,
            _map(member['data']),
            unique: true,
          );
        }
      } else {
        completedAt = previous!.completedAt;
        resources.addAll(previous.resources);
        _put(resources, event.eventName, body, unique: false);
      }
      // Only recent candle windows belong to this live state. REST owns history.
      // Do not evict account resources silently when hitting the safety bound.
      for (final channel in scope.channels.where(
        (c) => c.startsWith('hip3:candle:'),
      )) {
        final keys = resources.keys.where((k) => k.channel == channel).toList()
          ..sort(
            (a, b) =>
                DateTime.parse(a.entity).compareTo(DateTime.parse(b.entity)),
          );
        if (snapshot && keys.length > 3) throw const CompatibilityFailure();
        for (final key in keys.take(keys.length > 3 ? keys.length - 3 : 0)) {
          resources.remove(key);
        }
      }
      if (resources.length > 1000 ||
          resources.values.fold<int>(0, (sum, item) => sum + item.bytes) >
              8 * 1024 * 1024) {
        throw const CompatibilityFailure();
      }
      _state = Hip3RealtimeState._(
        cursor: event.eventId,
        completedAt: completedAt,
        emittedAt: DateTime.parse(event.data['emitted_at'] as String).toUtc(),
        resources: resources,
      );
      return true;
    } on CompatibilityFailure {
      rethrow;
    } catch (_) {
      throw const CompatibilityFailure();
    }
  }

  void _put(
    Map<Hip3RealtimeKey, Hip3RealtimeResource> resources,
    String kind,
    Map<String, Object?> data, {
    required bool unique,
  }) {
    final String channel;
    final String entity;
    switch (kind) {
      case 'hip3_order':
      case 'hip3_position':
        if (data['kind'] != 'perp' || !_product(data['product_id'])) {
          throw const CompatibilityFailure();
        }
        channel = kind == 'hip3_order' ? 'hip3:orders' : 'hip3:positions';
        entity =
            data[kind == 'hip3_order' ? 'order_id' : 'position_id'] as String;
      case 'hip3_balance':
        if (data['scope'] != 'hyperliquid_wallet' ||
            data['environment'] != scope.environment ||
            (data['signer'] as String).toLowerCase() != scope.signer ||
            (data['assets'] as List).length > 1000) {
          throw const CompatibilityFailure();
        }
        channel = 'hip3:balance';
        entity = 'hyperliquid_wallet';
      case 'hip3_price':
      case 'hip3_candle':
        final product = data['product_id'];
        if (data['kind'] != 'perp' ||
            !_product(product) ||
            data['venue'] != (product as String).split(':').first) {
          throw const CompatibilityFailure();
        }
        final prefix = '${data['environment']}:$product';
        if (kind == 'hip3_price') {
          channel = 'hip3:price:$prefix';
          entity = product;
        } else {
          channel =
              'hip3:candle:${data['environment']}:${data['interval']}:$product';
          entity = DateTime.parse(_map(data['point'])['t'] as String)
              .toUtc()
              .toIso8601String();
        }
      default:
        throw const CompatibilityFailure();
    }
    final key = (channel: channel, entity: entity);
    if (entity.isEmpty ||
        !scope.channels.contains(channel) ||
        (unique && resources.containsKey(key))) {
      throw const CompatibilityFailure();
    }
    final previous = _state?.resources[key];
    if (previous != null &&
        (kind == 'hip3_price' || kind == 'hip3_candle') &&
        DateTime.parse(data['updated_at'] as String)
            .isBefore(DateTime.parse(previous.data['updated_at'] as String))) {
      throw const CompatibilityFailure();
    }
    if (previous != null &&
        (previous.data['product_id'] != data['product_id'] ||
            previous.data['environment'] != data['environment'])) {
      throw const CompatibilityFailure();
    }
    final bytes = utf8.encode(jsonEncode(data)).length + 1024;
    if (bytes > 524288 + 1024) throw const CompatibilityFailure();
    resources[key] = Hip3RealtimeResource._(
      kind,
      _freeze(data) as Map<String, Object?>,
      bytes,
    );
  }

  static bool _product(Object? value) =>
      value is String && _validProduct(value);
  static Map<String, Object?> _map(Object? value) =>
      Map<String, Object?>.from(value as Map);
  static Object? _freeze(Object? value) => switch (value) {
    Map() => Map<String, Object?>.unmodifiable(
      value.map((key, member) => MapEntry(key as String, _freeze(member))),
    ),
    List() => List<Object?>.unmodifiable(value.map(_freeze)),
    _ => value,
  };
}

bool _validProduct(String value) {
  final parts = value.split(':');
  return value.length <= 128 &&
      parts.length == 2 &&
      parts.every((part) => part.isNotEmpty) &&
      value.codeUnits.every((unit) => unit >= 33 && unit <= 126 && unit != 44);
}

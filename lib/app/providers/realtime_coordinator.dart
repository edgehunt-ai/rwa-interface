import '../../domain/repositories/realtime_repository.dart';

final class RealtimeCoordinator {
  RealtimeCoordinator({this.maxBufferedEvents = 256});
  final int maxBufferedEvents;
  final Set<String> _seen = {};
  final Map<String, int> _sequenceByEntity = {};
  final List<TypedRealtimeEvent> _buffer = [];
  bool _refreshing = false;
  bool _requiresResync = false;
  int? _generation;

  bool get requiresResync => _requiresResync;
  int? get generation => _generation;

  void setGeneration(int generation) {
    if (_generation == generation) return;
    clear();
    _generation = generation;
  }

  void beginRefresh({int? generation}) {
    if (generation != null) setGeneration(generation);
    _buffer.clear();
    _requiresResync = false;
    _refreshing = true;
  }

  List<TypedRealtimeEvent> finishRefresh({
    Map<String, int> snapshotSequences = const {},
  }) {
    if (_requiresResync) return const [];
    _refreshing = false;
    for (final entry in snapshotSequences.entries) {
      final previous = _sequenceByEntity[entry.key];
      if (previous == null || entry.value > previous) {
        _sequenceByEntity[entry.key] = entry.value;
      }
    }
    final result = List<TypedRealtimeEvent>.of(_buffer)
      ..sort((a, b) => (a.sequence ?? 0).compareTo(b.sequence ?? 0));
    _buffer.clear();
    return result.where(accept).toList();
  }

  void requestResync() {
    _requiresResync = true;
    _buffer.clear();
  }

  bool accept(TypedRealtimeEvent event, {int? generation}) {
    if (generation != null && generation != _generation) return false;
    if (event.kind == 'resync_required' || event.kind == 'resyncRequired') {
      requestResync();
      return false;
    }
    if (_requiresResync) return false;
    if (_refreshing) {
      if (_seen.contains(event.id) ||
          _buffer.any((item) => item.id == event.id)) {
        return false;
      }
      if (_buffer.length == maxBufferedEvents) {
        requestResync();
        return false;
      }
      _buffer.add(event);
      return false;
    }
    if (!_seen.add(event.id)) return false;
    final entity = event.entityId;
    final sequence = event.sequence;
    if (entity != null && sequence != null) {
      final previous = _sequenceByEntity[entity];
      if (previous != null && sequence <= previous) return false;
      _sequenceByEntity[entity] = sequence;
    }
    return true;
  }

  void clear() {
    _seen.clear();
    _sequenceByEntity.clear();
    _buffer.clear();
    _refreshing = false;
    _requiresResync = false;
  }
}

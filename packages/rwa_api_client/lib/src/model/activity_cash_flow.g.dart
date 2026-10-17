// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'activity_cash_flow.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ActivityCashFlow extends ActivityCashFlow {
  @override
  final ActivityCashFlowEndpoint source_;
  @override
  final ActivityCashFlowEndpoint destination;

  factory _$ActivityCashFlow(
          [void Function(ActivityCashFlowBuilder)? updates]) =>
      (ActivityCashFlowBuilder()..update(updates))._build();

  _$ActivityCashFlow._({required this.source_, required this.destination})
      : super._();
  @override
  ActivityCashFlow rebuild(void Function(ActivityCashFlowBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ActivityCashFlowBuilder toBuilder() =>
      ActivityCashFlowBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ActivityCashFlow &&
        source_ == other.source_ &&
        destination == other.destination;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, source_.hashCode);
    _$hash = $jc(_$hash, destination.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'ActivityCashFlow')
          ..add('source_', source_)
          ..add('destination', destination))
        .toString();
  }
}

class ActivityCashFlowBuilder
    implements Builder<ActivityCashFlow, ActivityCashFlowBuilder> {
  _$ActivityCashFlow? _$v;

  ActivityCashFlowEndpointBuilder? _source_;
  ActivityCashFlowEndpointBuilder get source_ =>
      _$this._source_ ??= ActivityCashFlowEndpointBuilder();
  set source_(ActivityCashFlowEndpointBuilder? source_) =>
      _$this._source_ = source_;

  ActivityCashFlowEndpointBuilder? _destination;
  ActivityCashFlowEndpointBuilder get destination =>
      _$this._destination ??= ActivityCashFlowEndpointBuilder();
  set destination(ActivityCashFlowEndpointBuilder? destination) =>
      _$this._destination = destination;

  ActivityCashFlowBuilder() {
    ActivityCashFlow._defaults(this);
  }

  ActivityCashFlowBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _source_ = $v.source_.toBuilder();
      _destination = $v.destination.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ActivityCashFlow other) {
    _$v = other as _$ActivityCashFlow;
  }

  @override
  void update(void Function(ActivityCashFlowBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ActivityCashFlow build() => _build();

  _$ActivityCashFlow _build() {
    _$ActivityCashFlow _$result;
    try {
      _$result = _$v ??
          _$ActivityCashFlow._(
            source_: source_.build(),
            destination: destination.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'source_';
        source_.build();
        _$failedField = 'destination';
        destination.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'ActivityCashFlow', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint

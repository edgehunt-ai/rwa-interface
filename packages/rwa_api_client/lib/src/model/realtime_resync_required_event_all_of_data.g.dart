// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'realtime_resync_required_event_all_of_data.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const RealtimeResyncRequiredEventAllOfDataReasonEnum
    _$realtimeResyncRequiredEventAllOfDataReasonEnum_eventRetentionExpired =
    const RealtimeResyncRequiredEventAllOfDataReasonEnum._(
        'eventRetentionExpired');
const RealtimeResyncRequiredEventAllOfDataReasonEnum
    _$realtimeResyncRequiredEventAllOfDataReasonEnum_unknownDefaultOpenApi =
    const RealtimeResyncRequiredEventAllOfDataReasonEnum._(
        'unknownDefaultOpenApi');

RealtimeResyncRequiredEventAllOfDataReasonEnum
    _$realtimeResyncRequiredEventAllOfDataReasonEnumValueOf(String name) {
  switch (name) {
    case 'eventRetentionExpired':
      return _$realtimeResyncRequiredEventAllOfDataReasonEnum_eventRetentionExpired;
    case 'unknownDefaultOpenApi':
      return _$realtimeResyncRequiredEventAllOfDataReasonEnum_unknownDefaultOpenApi;
    default:
      return _$realtimeResyncRequiredEventAllOfDataReasonEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<RealtimeResyncRequiredEventAllOfDataReasonEnum>
    _$realtimeResyncRequiredEventAllOfDataReasonEnumValues = BuiltSet<
        RealtimeResyncRequiredEventAllOfDataReasonEnum>(const <RealtimeResyncRequiredEventAllOfDataReasonEnum>[
  _$realtimeResyncRequiredEventAllOfDataReasonEnum_eventRetentionExpired,
  _$realtimeResyncRequiredEventAllOfDataReasonEnum_unknownDefaultOpenApi,
]);

Serializer<RealtimeResyncRequiredEventAllOfDataReasonEnum>
    _$realtimeResyncRequiredEventAllOfDataReasonEnumSerializer =
    _$RealtimeResyncRequiredEventAllOfDataReasonEnumSerializer();

class _$RealtimeResyncRequiredEventAllOfDataReasonEnumSerializer
    implements
        PrimitiveSerializer<RealtimeResyncRequiredEventAllOfDataReasonEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'eventRetentionExpired': 'event_retention_expired',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'event_retention_expired': 'eventRetentionExpired',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[
    RealtimeResyncRequiredEventAllOfDataReasonEnum
  ];
  @override
  final String wireName = 'RealtimeResyncRequiredEventAllOfDataReasonEnum';

  @override
  Object serialize(Serializers serializers,
          RealtimeResyncRequiredEventAllOfDataReasonEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  RealtimeResyncRequiredEventAllOfDataReasonEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      RealtimeResyncRequiredEventAllOfDataReasonEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$RealtimeResyncRequiredEventAllOfData
    extends RealtimeResyncRequiredEventAllOfData {
  @override
  final RealtimeResyncRequiredEventAllOfDataReasonEnum reason;

  factory _$RealtimeResyncRequiredEventAllOfData(
          [void Function(RealtimeResyncRequiredEventAllOfDataBuilder)?
              updates]) =>
      (RealtimeResyncRequiredEventAllOfDataBuilder()..update(updates))._build();

  _$RealtimeResyncRequiredEventAllOfData._({required this.reason}) : super._();
  @override
  RealtimeResyncRequiredEventAllOfData rebuild(
          void Function(RealtimeResyncRequiredEventAllOfDataBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  RealtimeResyncRequiredEventAllOfDataBuilder toBuilder() =>
      RealtimeResyncRequiredEventAllOfDataBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is RealtimeResyncRequiredEventAllOfData &&
        reason == other.reason;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, reason.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'RealtimeResyncRequiredEventAllOfData')
          ..add('reason', reason))
        .toString();
  }
}

class RealtimeResyncRequiredEventAllOfDataBuilder
    implements
        Builder<RealtimeResyncRequiredEventAllOfData,
            RealtimeResyncRequiredEventAllOfDataBuilder> {
  _$RealtimeResyncRequiredEventAllOfData? _$v;

  RealtimeResyncRequiredEventAllOfDataReasonEnum? _reason;
  RealtimeResyncRequiredEventAllOfDataReasonEnum? get reason => _$this._reason;
  set reason(RealtimeResyncRequiredEventAllOfDataReasonEnum? reason) =>
      _$this._reason = reason;

  RealtimeResyncRequiredEventAllOfDataBuilder() {
    RealtimeResyncRequiredEventAllOfData._defaults(this);
  }

  RealtimeResyncRequiredEventAllOfDataBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _reason = $v.reason;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(RealtimeResyncRequiredEventAllOfData other) {
    _$v = other as _$RealtimeResyncRequiredEventAllOfData;
  }

  @override
  void update(
      void Function(RealtimeResyncRequiredEventAllOfDataBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  RealtimeResyncRequiredEventAllOfData build() => _build();

  _$RealtimeResyncRequiredEventAllOfData _build() {
    final _$result = _$v ??
        _$RealtimeResyncRequiredEventAllOfData._(
          reason: BuiltValueNullFieldError.checkNotNull(
              reason, r'RealtimeResyncRequiredEventAllOfData', 'reason'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint

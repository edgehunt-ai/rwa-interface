// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'completed_funding_provider_observation.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const CompletedFundingProviderObservationStatusEnum
    _$completedFundingProviderObservationStatusEnum_succeeded =
    const CompletedFundingProviderObservationStatusEnum._('succeeded');
const CompletedFundingProviderObservationStatusEnum
    _$completedFundingProviderObservationStatusEnum_unknownDefaultOpenApi =
    const CompletedFundingProviderObservationStatusEnum._(
        'unknownDefaultOpenApi');

CompletedFundingProviderObservationStatusEnum
    _$completedFundingProviderObservationStatusEnumValueOf(String name) {
  switch (name) {
    case 'succeeded':
      return _$completedFundingProviderObservationStatusEnum_succeeded;
    case 'unknownDefaultOpenApi':
      return _$completedFundingProviderObservationStatusEnum_unknownDefaultOpenApi;
    default:
      return _$completedFundingProviderObservationStatusEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<CompletedFundingProviderObservationStatusEnum>
    _$completedFundingProviderObservationStatusEnumValues = BuiltSet<
        CompletedFundingProviderObservationStatusEnum>(const <CompletedFundingProviderObservationStatusEnum>[
  _$completedFundingProviderObservationStatusEnum_succeeded,
  _$completedFundingProviderObservationStatusEnum_unknownDefaultOpenApi,
]);

Serializer<CompletedFundingProviderObservationStatusEnum>
    _$completedFundingProviderObservationStatusEnumSerializer =
    _$CompletedFundingProviderObservationStatusEnumSerializer();

class _$CompletedFundingProviderObservationStatusEnumSerializer
    implements
        PrimitiveSerializer<CompletedFundingProviderObservationStatusEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'succeeded': 'succeeded',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'succeeded': 'succeeded',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[
    CompletedFundingProviderObservationStatusEnum
  ];
  @override
  final String wireName = 'CompletedFundingProviderObservationStatusEnum';

  @override
  Object serialize(Serializers serializers,
          CompletedFundingProviderObservationStatusEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  CompletedFundingProviderObservationStatusEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      CompletedFundingProviderObservationStatusEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$CompletedFundingProviderObservation
    extends CompletedFundingProviderObservation {
  @override
  final FundingProvider provider;
  @override
  final CompletedFundingProviderObservationStatusEnum status;
  @override
  final DateTime observedAt;

  factory _$CompletedFundingProviderObservation(
          [void Function(CompletedFundingProviderObservationBuilder)?
              updates]) =>
      (CompletedFundingProviderObservationBuilder()..update(updates))._build();

  _$CompletedFundingProviderObservation._(
      {required this.provider, required this.status, required this.observedAt})
      : super._();
  @override
  CompletedFundingProviderObservation rebuild(
          void Function(CompletedFundingProviderObservationBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  CompletedFundingProviderObservationBuilder toBuilder() =>
      CompletedFundingProviderObservationBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is CompletedFundingProviderObservation &&
        provider == other.provider &&
        status == other.status &&
        observedAt == other.observedAt;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, provider.hashCode);
    _$hash = $jc(_$hash, status.hashCode);
    _$hash = $jc(_$hash, observedAt.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'CompletedFundingProviderObservation')
          ..add('provider', provider)
          ..add('status', status)
          ..add('observedAt', observedAt))
        .toString();
  }
}

class CompletedFundingProviderObservationBuilder
    implements
        Builder<CompletedFundingProviderObservation,
            CompletedFundingProviderObservationBuilder> {
  _$CompletedFundingProviderObservation? _$v;

  FundingProvider? _provider;
  FundingProvider? get provider => _$this._provider;
  set provider(FundingProvider? provider) => _$this._provider = provider;

  CompletedFundingProviderObservationStatusEnum? _status;
  CompletedFundingProviderObservationStatusEnum? get status => _$this._status;
  set status(CompletedFundingProviderObservationStatusEnum? status) =>
      _$this._status = status;

  DateTime? _observedAt;
  DateTime? get observedAt => _$this._observedAt;
  set observedAt(DateTime? observedAt) => _$this._observedAt = observedAt;

  CompletedFundingProviderObservationBuilder() {
    CompletedFundingProviderObservation._defaults(this);
  }

  CompletedFundingProviderObservationBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _provider = $v.provider;
      _status = $v.status;
      _observedAt = $v.observedAt;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(CompletedFundingProviderObservation other) {
    _$v = other as _$CompletedFundingProviderObservation;
  }

  @override
  void update(
      void Function(CompletedFundingProviderObservationBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  CompletedFundingProviderObservation build() => _build();

  _$CompletedFundingProviderObservation _build() {
    final _$result = _$v ??
        _$CompletedFundingProviderObservation._(
          provider: BuiltValueNullFieldError.checkNotNull(
              provider, r'CompletedFundingProviderObservation', 'provider'),
          status: BuiltValueNullFieldError.checkNotNull(
              status, r'CompletedFundingProviderObservation', 'status'),
          observedAt: BuiltValueNullFieldError.checkNotNull(
              observedAt, r'CompletedFundingProviderObservation', 'observedAt'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint

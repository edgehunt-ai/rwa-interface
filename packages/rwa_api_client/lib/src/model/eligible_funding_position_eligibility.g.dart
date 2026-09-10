// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'eligible_funding_position_eligibility.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const EligibleFundingPositionEligibilityStatusEnum
    _$eligibleFundingPositionEligibilityStatusEnum_eligible =
    const EligibleFundingPositionEligibilityStatusEnum._('eligible');
const EligibleFundingPositionEligibilityStatusEnum
    _$eligibleFundingPositionEligibilityStatusEnum_unknownDefaultOpenApi =
    const EligibleFundingPositionEligibilityStatusEnum._(
        'unknownDefaultOpenApi');

EligibleFundingPositionEligibilityStatusEnum
    _$eligibleFundingPositionEligibilityStatusEnumValueOf(String name) {
  switch (name) {
    case 'eligible':
      return _$eligibleFundingPositionEligibilityStatusEnum_eligible;
    case 'unknownDefaultOpenApi':
      return _$eligibleFundingPositionEligibilityStatusEnum_unknownDefaultOpenApi;
    default:
      return _$eligibleFundingPositionEligibilityStatusEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<EligibleFundingPositionEligibilityStatusEnum>
    _$eligibleFundingPositionEligibilityStatusEnumValues = BuiltSet<
        EligibleFundingPositionEligibilityStatusEnum>(const <EligibleFundingPositionEligibilityStatusEnum>[
  _$eligibleFundingPositionEligibilityStatusEnum_eligible,
  _$eligibleFundingPositionEligibilityStatusEnum_unknownDefaultOpenApi,
]);

Serializer<EligibleFundingPositionEligibilityStatusEnum>
    _$eligibleFundingPositionEligibilityStatusEnumSerializer =
    _$EligibleFundingPositionEligibilityStatusEnumSerializer();

class _$EligibleFundingPositionEligibilityStatusEnumSerializer
    implements
        PrimitiveSerializer<EligibleFundingPositionEligibilityStatusEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'eligible': 'eligible',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'eligible': 'eligible',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[
    EligibleFundingPositionEligibilityStatusEnum
  ];
  @override
  final String wireName = 'EligibleFundingPositionEligibilityStatusEnum';

  @override
  Object serialize(Serializers serializers,
          EligibleFundingPositionEligibilityStatusEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  EligibleFundingPositionEligibilityStatusEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      EligibleFundingPositionEligibilityStatusEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$EligibleFundingPositionEligibility
    extends EligibleFundingPositionEligibility {
  @override
  final EligibleFundingPositionEligibilityStatusEnum status;
  @override
  final BuiltList<FundingPositionBlocker> blockers;

  factory _$EligibleFundingPositionEligibility(
          [void Function(EligibleFundingPositionEligibilityBuilder)?
              updates]) =>
      (EligibleFundingPositionEligibilityBuilder()..update(updates))._build();

  _$EligibleFundingPositionEligibility._(
      {required this.status, required this.blockers})
      : super._();
  @override
  EligibleFundingPositionEligibility rebuild(
          void Function(EligibleFundingPositionEligibilityBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  EligibleFundingPositionEligibilityBuilder toBuilder() =>
      EligibleFundingPositionEligibilityBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is EligibleFundingPositionEligibility &&
        status == other.status &&
        blockers == other.blockers;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, status.hashCode);
    _$hash = $jc(_$hash, blockers.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'EligibleFundingPositionEligibility')
          ..add('status', status)
          ..add('blockers', blockers))
        .toString();
  }
}

class EligibleFundingPositionEligibilityBuilder
    implements
        Builder<EligibleFundingPositionEligibility,
            EligibleFundingPositionEligibilityBuilder> {
  _$EligibleFundingPositionEligibility? _$v;

  EligibleFundingPositionEligibilityStatusEnum? _status;
  EligibleFundingPositionEligibilityStatusEnum? get status => _$this._status;
  set status(EligibleFundingPositionEligibilityStatusEnum? status) =>
      _$this._status = status;

  ListBuilder<FundingPositionBlocker>? _blockers;
  ListBuilder<FundingPositionBlocker> get blockers =>
      _$this._blockers ??= ListBuilder<FundingPositionBlocker>();
  set blockers(ListBuilder<FundingPositionBlocker>? blockers) =>
      _$this._blockers = blockers;

  EligibleFundingPositionEligibilityBuilder() {
    EligibleFundingPositionEligibility._defaults(this);
  }

  EligibleFundingPositionEligibilityBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _status = $v.status;
      _blockers = $v.blockers.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(EligibleFundingPositionEligibility other) {
    _$v = other as _$EligibleFundingPositionEligibility;
  }

  @override
  void update(
      void Function(EligibleFundingPositionEligibilityBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  EligibleFundingPositionEligibility build() => _build();

  _$EligibleFundingPositionEligibility _build() {
    _$EligibleFundingPositionEligibility _$result;
    try {
      _$result = _$v ??
          _$EligibleFundingPositionEligibility._(
            status: BuiltValueNullFieldError.checkNotNull(
                status, r'EligibleFundingPositionEligibility', 'status'),
            blockers: blockers.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'blockers';
        blockers.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'EligibleFundingPositionEligibility', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint

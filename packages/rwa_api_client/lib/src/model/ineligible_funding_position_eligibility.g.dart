// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ineligible_funding_position_eligibility.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const IneligibleFundingPositionEligibilityStatusEnum
    _$ineligibleFundingPositionEligibilityStatusEnum_ineligible =
    const IneligibleFundingPositionEligibilityStatusEnum._('ineligible');
const IneligibleFundingPositionEligibilityStatusEnum
    _$ineligibleFundingPositionEligibilityStatusEnum_unknownDefaultOpenApi =
    const IneligibleFundingPositionEligibilityStatusEnum._(
        'unknownDefaultOpenApi');

IneligibleFundingPositionEligibilityStatusEnum
    _$ineligibleFundingPositionEligibilityStatusEnumValueOf(String name) {
  switch (name) {
    case 'ineligible':
      return _$ineligibleFundingPositionEligibilityStatusEnum_ineligible;
    case 'unknownDefaultOpenApi':
      return _$ineligibleFundingPositionEligibilityStatusEnum_unknownDefaultOpenApi;
    default:
      return _$ineligibleFundingPositionEligibilityStatusEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<IneligibleFundingPositionEligibilityStatusEnum>
    _$ineligibleFundingPositionEligibilityStatusEnumValues = BuiltSet<
        IneligibleFundingPositionEligibilityStatusEnum>(const <IneligibleFundingPositionEligibilityStatusEnum>[
  _$ineligibleFundingPositionEligibilityStatusEnum_ineligible,
  _$ineligibleFundingPositionEligibilityStatusEnum_unknownDefaultOpenApi,
]);

Serializer<IneligibleFundingPositionEligibilityStatusEnum>
    _$ineligibleFundingPositionEligibilityStatusEnumSerializer =
    _$IneligibleFundingPositionEligibilityStatusEnumSerializer();

class _$IneligibleFundingPositionEligibilityStatusEnumSerializer
    implements
        PrimitiveSerializer<IneligibleFundingPositionEligibilityStatusEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'ineligible': 'ineligible',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'ineligible': 'ineligible',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[
    IneligibleFundingPositionEligibilityStatusEnum
  ];
  @override
  final String wireName = 'IneligibleFundingPositionEligibilityStatusEnum';

  @override
  Object serialize(Serializers serializers,
          IneligibleFundingPositionEligibilityStatusEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  IneligibleFundingPositionEligibilityStatusEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      IneligibleFundingPositionEligibilityStatusEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$IneligibleFundingPositionEligibility
    extends IneligibleFundingPositionEligibility {
  @override
  final IneligibleFundingPositionEligibilityStatusEnum status;
  @override
  final BuiltSet<FundingPositionBlocker> blockers;

  factory _$IneligibleFundingPositionEligibility(
          [void Function(IneligibleFundingPositionEligibilityBuilder)?
              updates]) =>
      (IneligibleFundingPositionEligibilityBuilder()..update(updates))._build();

  _$IneligibleFundingPositionEligibility._(
      {required this.status, required this.blockers})
      : super._();
  @override
  IneligibleFundingPositionEligibility rebuild(
          void Function(IneligibleFundingPositionEligibilityBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  IneligibleFundingPositionEligibilityBuilder toBuilder() =>
      IneligibleFundingPositionEligibilityBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is IneligibleFundingPositionEligibility &&
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
    return (newBuiltValueToStringHelper(r'IneligibleFundingPositionEligibility')
          ..add('status', status)
          ..add('blockers', blockers))
        .toString();
  }
}

class IneligibleFundingPositionEligibilityBuilder
    implements
        Builder<IneligibleFundingPositionEligibility,
            IneligibleFundingPositionEligibilityBuilder> {
  _$IneligibleFundingPositionEligibility? _$v;

  IneligibleFundingPositionEligibilityStatusEnum? _status;
  IneligibleFundingPositionEligibilityStatusEnum? get status => _$this._status;
  set status(IneligibleFundingPositionEligibilityStatusEnum? status) =>
      _$this._status = status;

  SetBuilder<FundingPositionBlocker>? _blockers;
  SetBuilder<FundingPositionBlocker> get blockers =>
      _$this._blockers ??= SetBuilder<FundingPositionBlocker>();
  set blockers(SetBuilder<FundingPositionBlocker>? blockers) =>
      _$this._blockers = blockers;

  IneligibleFundingPositionEligibilityBuilder() {
    IneligibleFundingPositionEligibility._defaults(this);
  }

  IneligibleFundingPositionEligibilityBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _status = $v.status;
      _blockers = $v.blockers.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(IneligibleFundingPositionEligibility other) {
    _$v = other as _$IneligibleFundingPositionEligibility;
  }

  @override
  void update(
      void Function(IneligibleFundingPositionEligibilityBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  IneligibleFundingPositionEligibility build() => _build();

  _$IneligibleFundingPositionEligibility _build() {
    _$IneligibleFundingPositionEligibility _$result;
    try {
      _$result = _$v ??
          _$IneligibleFundingPositionEligibility._(
            status: BuiltValueNullFieldError.checkNotNull(
                status, r'IneligibleFundingPositionEligibility', 'status'),
            blockers: blockers.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'blockers';
        blockers.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'IneligibleFundingPositionEligibility',
            _$failedField,
            e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint

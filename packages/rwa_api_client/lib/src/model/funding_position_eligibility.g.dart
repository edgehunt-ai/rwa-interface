// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'funding_position_eligibility.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const FundingPositionEligibilityStatusEnum
    _$fundingPositionEligibilityStatusEnum_eligible =
    const FundingPositionEligibilityStatusEnum._('eligible');
const FundingPositionEligibilityStatusEnum
    _$fundingPositionEligibilityStatusEnum_ineligible =
    const FundingPositionEligibilityStatusEnum._('ineligible');

FundingPositionEligibilityStatusEnum
    _$fundingPositionEligibilityStatusEnumValueOf(String name) {
  switch (name) {
    case 'eligible':
      return _$fundingPositionEligibilityStatusEnum_eligible;
    case 'ineligible':
      return _$fundingPositionEligibilityStatusEnum_ineligible;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<FundingPositionEligibilityStatusEnum>
    _$fundingPositionEligibilityStatusEnumValues = BuiltSet<
        FundingPositionEligibilityStatusEnum>(const <FundingPositionEligibilityStatusEnum>[
  _$fundingPositionEligibilityStatusEnum_eligible,
  _$fundingPositionEligibilityStatusEnum_ineligible,
]);

Serializer<FundingPositionEligibilityStatusEnum>
    _$fundingPositionEligibilityStatusEnumSerializer =
    _$FundingPositionEligibilityStatusEnumSerializer();

class _$FundingPositionEligibilityStatusEnumSerializer
    implements PrimitiveSerializer<FundingPositionEligibilityStatusEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'eligible': 'eligible',
    'ineligible': 'ineligible',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'eligible': 'eligible',
    'ineligible': 'ineligible',
  };

  @override
  final Iterable<Type> types = const <Type>[
    FundingPositionEligibilityStatusEnum
  ];
  @override
  final String wireName = 'FundingPositionEligibilityStatusEnum';

  @override
  Object serialize(
          Serializers serializers, FundingPositionEligibilityStatusEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  FundingPositionEligibilityStatusEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      FundingPositionEligibilityStatusEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$FundingPositionEligibility extends FundingPositionEligibility {
  @override
  final FundingPositionEligibilityStatusEnum status;
  @override
  final BuiltSet<FundingPositionBlocker> blockers;

  factory _$FundingPositionEligibility(
          [void Function(FundingPositionEligibilityBuilder)? updates]) =>
      (FundingPositionEligibilityBuilder()..update(updates))._build();

  _$FundingPositionEligibility._({required this.status, required this.blockers})
      : super._();
  @override
  FundingPositionEligibility rebuild(
          void Function(FundingPositionEligibilityBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  FundingPositionEligibilityBuilder toBuilder() =>
      FundingPositionEligibilityBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is FundingPositionEligibility &&
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
    return (newBuiltValueToStringHelper(r'FundingPositionEligibility')
          ..add('status', status)
          ..add('blockers', blockers))
        .toString();
  }
}

class FundingPositionEligibilityBuilder
    implements
        Builder<FundingPositionEligibility, FundingPositionEligibilityBuilder> {
  _$FundingPositionEligibility? _$v;

  FundingPositionEligibilityStatusEnum? _status;
  FundingPositionEligibilityStatusEnum? get status => _$this._status;
  set status(FundingPositionEligibilityStatusEnum? status) =>
      _$this._status = status;

  SetBuilder<FundingPositionBlocker>? _blockers;
  SetBuilder<FundingPositionBlocker> get blockers =>
      _$this._blockers ??= SetBuilder<FundingPositionBlocker>();
  set blockers(SetBuilder<FundingPositionBlocker>? blockers) =>
      _$this._blockers = blockers;

  FundingPositionEligibilityBuilder() {
    FundingPositionEligibility._defaults(this);
  }

  FundingPositionEligibilityBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _status = $v.status;
      _blockers = $v.blockers.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(FundingPositionEligibility other) {
    _$v = other as _$FundingPositionEligibility;
  }

  @override
  void update(void Function(FundingPositionEligibilityBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  FundingPositionEligibility build() => _build();

  _$FundingPositionEligibility _build() {
    _$FundingPositionEligibility _$result;
    try {
      _$result = _$v ??
          _$FundingPositionEligibility._(
            status: BuiltValueNullFieldError.checkNotNull(
                status, r'FundingPositionEligibility', 'status'),
            blockers: blockers.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'blockers';
        blockers.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'FundingPositionEligibility', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint

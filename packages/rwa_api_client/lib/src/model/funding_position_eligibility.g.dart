// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'funding_position_eligibility.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const FundingPositionEligibilityStatusEnum
    _$fundingPositionEligibilityStatusEnum_ineligible =
    const FundingPositionEligibilityStatusEnum._('ineligible');
const FundingPositionEligibilityStatusEnum
    _$fundingPositionEligibilityStatusEnum_unknownDefaultOpenApi =
    const FundingPositionEligibilityStatusEnum._('unknownDefaultOpenApi');

FundingPositionEligibilityStatusEnum
    _$fundingPositionEligibilityStatusEnumValueOf(String name) {
  switch (name) {
    case 'ineligible':
      return _$fundingPositionEligibilityStatusEnum_ineligible;
    case 'unknownDefaultOpenApi':
      return _$fundingPositionEligibilityStatusEnum_unknownDefaultOpenApi;
    default:
      return _$fundingPositionEligibilityStatusEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<FundingPositionEligibilityStatusEnum>
    _$fundingPositionEligibilityStatusEnumValues = BuiltSet<
        FundingPositionEligibilityStatusEnum>(const <FundingPositionEligibilityStatusEnum>[
  _$fundingPositionEligibilityStatusEnum_ineligible,
  _$fundingPositionEligibilityStatusEnum_unknownDefaultOpenApi,
]);

Serializer<FundingPositionEligibilityStatusEnum>
    _$fundingPositionEligibilityStatusEnumSerializer =
    _$FundingPositionEligibilityStatusEnumSerializer();

class _$FundingPositionEligibilityStatusEnumSerializer
    implements PrimitiveSerializer<FundingPositionEligibilityStatusEnum> {
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
  final OneOf oneOf;

  factory _$FundingPositionEligibility(
          [void Function(FundingPositionEligibilityBuilder)? updates]) =>
      (FundingPositionEligibilityBuilder()..update(updates))._build();

  _$FundingPositionEligibility._({required this.oneOf}) : super._();
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
    return other is FundingPositionEligibility && oneOf == other.oneOf;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, oneOf.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'FundingPositionEligibility')
          ..add('oneOf', oneOf))
        .toString();
  }
}

class FundingPositionEligibilityBuilder
    implements
        Builder<FundingPositionEligibility, FundingPositionEligibilityBuilder> {
  _$FundingPositionEligibility? _$v;

  OneOf? _oneOf;
  OneOf? get oneOf => _$this._oneOf;
  set oneOf(OneOf? oneOf) => _$this._oneOf = oneOf;

  FundingPositionEligibilityBuilder() {
    FundingPositionEligibility._defaults(this);
  }

  FundingPositionEligibilityBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _oneOf = $v.oneOf;
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
    final _$result = _$v ??
        _$FundingPositionEligibility._(
          oneOf: BuiltValueNullFieldError.checkNotNull(
              oneOf, r'FundingPositionEligibility', 'oneOf'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint

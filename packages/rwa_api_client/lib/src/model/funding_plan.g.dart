// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'funding_plan.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const FundingPlanModeEnum _$fundingPlanModeEnum_userSelectedMultiSource =
    const FundingPlanModeEnum._('userSelectedMultiSource');

FundingPlanModeEnum _$fundingPlanModeEnumValueOf(String name) {
  switch (name) {
    case 'userSelectedMultiSource':
      return _$fundingPlanModeEnum_userSelectedMultiSource;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<FundingPlanModeEnum> _$fundingPlanModeEnumValues =
    BuiltSet<FundingPlanModeEnum>(const <FundingPlanModeEnum>[
  _$fundingPlanModeEnum_userSelectedMultiSource,
]);

const FundingPlanRailEnum _$fundingPlanRailEnum_bstock =
    const FundingPlanRailEnum._('bstock');

FundingPlanRailEnum _$fundingPlanRailEnumValueOf(String name) {
  switch (name) {
    case 'bstock':
      return _$fundingPlanRailEnum_bstock;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<FundingPlanRailEnum> _$fundingPlanRailEnumValues =
    BuiltSet<FundingPlanRailEnum>(const <FundingPlanRailEnum>[
  _$fundingPlanRailEnum_bstock,
]);

const FundingPlanNetworkEnum _$fundingPlanNetworkEnum_BSC =
    const FundingPlanNetworkEnum._('BSC');

FundingPlanNetworkEnum _$fundingPlanNetworkEnumValueOf(String name) {
  switch (name) {
    case 'BSC':
      return _$fundingPlanNetworkEnum_BSC;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<FundingPlanNetworkEnum> _$fundingPlanNetworkEnumValues =
    BuiltSet<FundingPlanNetworkEnum>(const <FundingPlanNetworkEnum>[
  _$fundingPlanNetworkEnum_BSC,
]);

const FundingPlanAssetEnum _$fundingPlanAssetEnum_TUSDT =
    const FundingPlanAssetEnum._('TUSDT');

FundingPlanAssetEnum _$fundingPlanAssetEnumValueOf(String name) {
  switch (name) {
    case 'TUSDT':
      return _$fundingPlanAssetEnum_TUSDT;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<FundingPlanAssetEnum> _$fundingPlanAssetEnumValues =
    BuiltSet<FundingPlanAssetEnum>(const <FundingPlanAssetEnum>[
  _$fundingPlanAssetEnum_TUSDT,
]);

Serializer<FundingPlanModeEnum> _$fundingPlanModeEnumSerializer =
    _$FundingPlanModeEnumSerializer();
Serializer<FundingPlanRailEnum> _$fundingPlanRailEnumSerializer =
    _$FundingPlanRailEnumSerializer();
Serializer<FundingPlanNetworkEnum> _$fundingPlanNetworkEnumSerializer =
    _$FundingPlanNetworkEnumSerializer();
Serializer<FundingPlanAssetEnum> _$fundingPlanAssetEnumSerializer =
    _$FundingPlanAssetEnumSerializer();

class _$FundingPlanModeEnumSerializer
    implements PrimitiveSerializer<FundingPlanModeEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'userSelectedMultiSource': 'user_selected_multi_source',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'user_selected_multi_source': 'userSelectedMultiSource',
  };

  @override
  final Iterable<Type> types = const <Type>[FundingPlanModeEnum];
  @override
  final String wireName = 'FundingPlanModeEnum';

  @override
  Object serialize(Serializers serializers, FundingPlanModeEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  FundingPlanModeEnum deserialize(Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      FundingPlanModeEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$FundingPlanRailEnumSerializer
    implements PrimitiveSerializer<FundingPlanRailEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'bstock': 'bstock',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'bstock': 'bstock',
  };

  @override
  final Iterable<Type> types = const <Type>[FundingPlanRailEnum];
  @override
  final String wireName = 'FundingPlanRailEnum';

  @override
  Object serialize(Serializers serializers, FundingPlanRailEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  FundingPlanRailEnum deserialize(Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      FundingPlanRailEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$FundingPlanNetworkEnumSerializer
    implements PrimitiveSerializer<FundingPlanNetworkEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'BSC': 'BSC',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'BSC': 'BSC',
  };

  @override
  final Iterable<Type> types = const <Type>[FundingPlanNetworkEnum];
  @override
  final String wireName = 'FundingPlanNetworkEnum';

  @override
  Object serialize(Serializers serializers, FundingPlanNetworkEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  FundingPlanNetworkEnum deserialize(Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      FundingPlanNetworkEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$FundingPlanAssetEnumSerializer
    implements PrimitiveSerializer<FundingPlanAssetEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'TUSDT': 'TUSDT',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'TUSDT': 'TUSDT',
  };

  @override
  final Iterable<Type> types = const <Type>[FundingPlanAssetEnum];
  @override
  final String wireName = 'FundingPlanAssetEnum';

  @override
  Object serialize(Serializers serializers, FundingPlanAssetEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  FundingPlanAssetEnum deserialize(Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      FundingPlanAssetEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$FundingPlan extends FundingPlan {
  @override
  final OneOf oneOf;

  factory _$FundingPlan([void Function(FundingPlanBuilder)? updates]) =>
      (FundingPlanBuilder()..update(updates))._build();

  _$FundingPlan._({required this.oneOf}) : super._();
  @override
  FundingPlan rebuild(void Function(FundingPlanBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  FundingPlanBuilder toBuilder() => FundingPlanBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is FundingPlan && oneOf == other.oneOf;
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
    return (newBuiltValueToStringHelper(r'FundingPlan')..add('oneOf', oneOf))
        .toString();
  }
}

class FundingPlanBuilder implements Builder<FundingPlan, FundingPlanBuilder> {
  _$FundingPlan? _$v;

  OneOf? _oneOf;
  OneOf? get oneOf => _$this._oneOf;
  set oneOf(OneOf? oneOf) => _$this._oneOf = oneOf;

  FundingPlanBuilder() {
    FundingPlan._defaults(this);
  }

  FundingPlanBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _oneOf = $v.oneOf;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(FundingPlan other) {
    _$v = other as _$FundingPlan;
  }

  @override
  void update(void Function(FundingPlanBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  FundingPlan build() => _build();

  _$FundingPlan _build() {
    final _$result = _$v ??
        _$FundingPlan._(
          oneOf: BuiltValueNullFieldError.checkNotNull(
              oneOf, r'FundingPlan', 'oneOf'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint

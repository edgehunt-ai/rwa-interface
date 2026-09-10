// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'multi_source_funding_plan_details.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const MultiSourceFundingPlanDetailsMaxLegsEnum
    _$multiSourceFundingPlanDetailsMaxLegsEnum_number3 =
    const MultiSourceFundingPlanDetailsMaxLegsEnum._('number3');
const MultiSourceFundingPlanDetailsMaxLegsEnum
    _$multiSourceFundingPlanDetailsMaxLegsEnum_unknownDefaultOpenApi =
    const MultiSourceFundingPlanDetailsMaxLegsEnum._('unknownDefaultOpenApi');

MultiSourceFundingPlanDetailsMaxLegsEnum
    _$multiSourceFundingPlanDetailsMaxLegsEnumValueOf(String name) {
  switch (name) {
    case 'number3':
      return _$multiSourceFundingPlanDetailsMaxLegsEnum_number3;
    case 'unknownDefaultOpenApi':
      return _$multiSourceFundingPlanDetailsMaxLegsEnum_unknownDefaultOpenApi;
    default:
      return _$multiSourceFundingPlanDetailsMaxLegsEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<MultiSourceFundingPlanDetailsMaxLegsEnum>
    _$multiSourceFundingPlanDetailsMaxLegsEnumValues = BuiltSet<
        MultiSourceFundingPlanDetailsMaxLegsEnum>(const <MultiSourceFundingPlanDetailsMaxLegsEnum>[
  _$multiSourceFundingPlanDetailsMaxLegsEnum_number3,
  _$multiSourceFundingPlanDetailsMaxLegsEnum_unknownDefaultOpenApi,
]);

Serializer<MultiSourceFundingPlanDetailsMaxLegsEnum>
    _$multiSourceFundingPlanDetailsMaxLegsEnumSerializer =
    _$MultiSourceFundingPlanDetailsMaxLegsEnumSerializer();

class _$MultiSourceFundingPlanDetailsMaxLegsEnumSerializer
    implements PrimitiveSerializer<MultiSourceFundingPlanDetailsMaxLegsEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'number3': 3,
    'unknownDefaultOpenApi': 11184809,
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    3: 'number3',
    11184809: 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[
    MultiSourceFundingPlanDetailsMaxLegsEnum
  ];
  @override
  final String wireName = 'MultiSourceFundingPlanDetailsMaxLegsEnum';

  @override
  Object serialize(Serializers serializers,
          MultiSourceFundingPlanDetailsMaxLegsEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  MultiSourceFundingPlanDetailsMaxLegsEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      MultiSourceFundingPlanDetailsMaxLegsEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$MultiSourceFundingPlanDetails extends MultiSourceFundingPlanDetails {
  @override
  final String allocationPolicyVersion;
  @override
  final MultiSourceFundingPlanDetailsMaxLegsEnum maxLegs;
  @override
  final BuiltSet<String> excludedSourcePositionIds;
  @override
  final String allocatedOutputAmount;
  @override
  final BuiltList<MultiSourceFundingLeg> legs;

  factory _$MultiSourceFundingPlanDetails(
          [void Function(MultiSourceFundingPlanDetailsBuilder)? updates]) =>
      (MultiSourceFundingPlanDetailsBuilder()..update(updates))._build();

  _$MultiSourceFundingPlanDetails._(
      {required this.allocationPolicyVersion,
      required this.maxLegs,
      required this.excludedSourcePositionIds,
      required this.allocatedOutputAmount,
      required this.legs})
      : super._();
  @override
  MultiSourceFundingPlanDetails rebuild(
          void Function(MultiSourceFundingPlanDetailsBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  MultiSourceFundingPlanDetailsBuilder toBuilder() =>
      MultiSourceFundingPlanDetailsBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is MultiSourceFundingPlanDetails &&
        allocationPolicyVersion == other.allocationPolicyVersion &&
        maxLegs == other.maxLegs &&
        excludedSourcePositionIds == other.excludedSourcePositionIds &&
        allocatedOutputAmount == other.allocatedOutputAmount &&
        legs == other.legs;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, allocationPolicyVersion.hashCode);
    _$hash = $jc(_$hash, maxLegs.hashCode);
    _$hash = $jc(_$hash, excludedSourcePositionIds.hashCode);
    _$hash = $jc(_$hash, allocatedOutputAmount.hashCode);
    _$hash = $jc(_$hash, legs.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'MultiSourceFundingPlanDetails')
          ..add('allocationPolicyVersion', allocationPolicyVersion)
          ..add('maxLegs', maxLegs)
          ..add('excludedSourcePositionIds', excludedSourcePositionIds)
          ..add('allocatedOutputAmount', allocatedOutputAmount)
          ..add('legs', legs))
        .toString();
  }
}

class MultiSourceFundingPlanDetailsBuilder
    implements
        Builder<MultiSourceFundingPlanDetails,
            MultiSourceFundingPlanDetailsBuilder> {
  _$MultiSourceFundingPlanDetails? _$v;

  String? _allocationPolicyVersion;
  String? get allocationPolicyVersion => _$this._allocationPolicyVersion;
  set allocationPolicyVersion(String? allocationPolicyVersion) =>
      _$this._allocationPolicyVersion = allocationPolicyVersion;

  MultiSourceFundingPlanDetailsMaxLegsEnum? _maxLegs;
  MultiSourceFundingPlanDetailsMaxLegsEnum? get maxLegs => _$this._maxLegs;
  set maxLegs(MultiSourceFundingPlanDetailsMaxLegsEnum? maxLegs) =>
      _$this._maxLegs = maxLegs;

  SetBuilder<String>? _excludedSourcePositionIds;
  SetBuilder<String> get excludedSourcePositionIds =>
      _$this._excludedSourcePositionIds ??= SetBuilder<String>();
  set excludedSourcePositionIds(
          SetBuilder<String>? excludedSourcePositionIds) =>
      _$this._excludedSourcePositionIds = excludedSourcePositionIds;

  String? _allocatedOutputAmount;
  String? get allocatedOutputAmount => _$this._allocatedOutputAmount;
  set allocatedOutputAmount(String? allocatedOutputAmount) =>
      _$this._allocatedOutputAmount = allocatedOutputAmount;

  ListBuilder<MultiSourceFundingLeg>? _legs;
  ListBuilder<MultiSourceFundingLeg> get legs =>
      _$this._legs ??= ListBuilder<MultiSourceFundingLeg>();
  set legs(ListBuilder<MultiSourceFundingLeg>? legs) => _$this._legs = legs;

  MultiSourceFundingPlanDetailsBuilder() {
    MultiSourceFundingPlanDetails._defaults(this);
  }

  MultiSourceFundingPlanDetailsBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _allocationPolicyVersion = $v.allocationPolicyVersion;
      _maxLegs = $v.maxLegs;
      _excludedSourcePositionIds = $v.excludedSourcePositionIds.toBuilder();
      _allocatedOutputAmount = $v.allocatedOutputAmount;
      _legs = $v.legs.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(MultiSourceFundingPlanDetails other) {
    _$v = other as _$MultiSourceFundingPlanDetails;
  }

  @override
  void update(void Function(MultiSourceFundingPlanDetailsBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  MultiSourceFundingPlanDetails build() => _build();

  _$MultiSourceFundingPlanDetails _build() {
    _$MultiSourceFundingPlanDetails _$result;
    try {
      _$result = _$v ??
          _$MultiSourceFundingPlanDetails._(
            allocationPolicyVersion: BuiltValueNullFieldError.checkNotNull(
                allocationPolicyVersion,
                r'MultiSourceFundingPlanDetails',
                'allocationPolicyVersion'),
            maxLegs: BuiltValueNullFieldError.checkNotNull(
                maxLegs, r'MultiSourceFundingPlanDetails', 'maxLegs'),
            excludedSourcePositionIds: excludedSourcePositionIds.build(),
            allocatedOutputAmount: BuiltValueNullFieldError.checkNotNull(
                allocatedOutputAmount,
                r'MultiSourceFundingPlanDetails',
                'allocatedOutputAmount'),
            legs: legs.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'excludedSourcePositionIds';
        excludedSourcePositionIds.build();

        _$failedField = 'legs';
        legs.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'MultiSourceFundingPlanDetails', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bstock_funding_transfer_target.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const BstockFundingTransferTargetRailEnum
    _$bstockFundingTransferTargetRailEnum_bstock =
    const BstockFundingTransferTargetRailEnum._('bstock');
const BstockFundingTransferTargetRailEnum
    _$bstockFundingTransferTargetRailEnum_unknownDefaultOpenApi =
    const BstockFundingTransferTargetRailEnum._('unknownDefaultOpenApi');

BstockFundingTransferTargetRailEnum
    _$bstockFundingTransferTargetRailEnumValueOf(String name) {
  switch (name) {
    case 'bstock':
      return _$bstockFundingTransferTargetRailEnum_bstock;
    case 'unknownDefaultOpenApi':
      return _$bstockFundingTransferTargetRailEnum_unknownDefaultOpenApi;
    default:
      return _$bstockFundingTransferTargetRailEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<BstockFundingTransferTargetRailEnum>
    _$bstockFundingTransferTargetRailEnumValues = BuiltSet<
        BstockFundingTransferTargetRailEnum>(const <BstockFundingTransferTargetRailEnum>[
  _$bstockFundingTransferTargetRailEnum_bstock,
  _$bstockFundingTransferTargetRailEnum_unknownDefaultOpenApi,
]);

Serializer<BstockFundingTransferTargetRailEnum>
    _$bstockFundingTransferTargetRailEnumSerializer =
    _$BstockFundingTransferTargetRailEnumSerializer();

class _$BstockFundingTransferTargetRailEnumSerializer
    implements PrimitiveSerializer<BstockFundingTransferTargetRailEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'bstock': 'bstock',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'bstock': 'bstock',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[
    BstockFundingTransferTargetRailEnum
  ];
  @override
  final String wireName = 'BstockFundingTransferTargetRailEnum';

  @override
  Object serialize(
          Serializers serializers, BstockFundingTransferTargetRailEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  BstockFundingTransferTargetRailEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      BstockFundingTransferTargetRailEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$BstockFundingTransferTarget extends BstockFundingTransferTarget {
  @override
  final BstockFundingTransferTargetRailEnum rail;
  @override
  final BstockFundingTargetBalanceSnapshot target;
  @override
  final BstockFundingTargetCreditObservation? targetCredit;

  factory _$BstockFundingTransferTarget(
          [void Function(BstockFundingTransferTargetBuilder)? updates]) =>
      (BstockFundingTransferTargetBuilder()..update(updates))._build();

  _$BstockFundingTransferTarget._(
      {required this.rail, required this.target, this.targetCredit})
      : super._();
  @override
  BstockFundingTransferTarget rebuild(
          void Function(BstockFundingTransferTargetBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  BstockFundingTransferTargetBuilder toBuilder() =>
      BstockFundingTransferTargetBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is BstockFundingTransferTarget &&
        rail == other.rail &&
        target == other.target &&
        targetCredit == other.targetCredit;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, rail.hashCode);
    _$hash = $jc(_$hash, target.hashCode);
    _$hash = $jc(_$hash, targetCredit.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'BstockFundingTransferTarget')
          ..add('rail', rail)
          ..add('target', target)
          ..add('targetCredit', targetCredit))
        .toString();
  }
}

class BstockFundingTransferTargetBuilder
    implements
        Builder<BstockFundingTransferTarget,
            BstockFundingTransferTargetBuilder> {
  _$BstockFundingTransferTarget? _$v;

  BstockFundingTransferTargetRailEnum? _rail;
  BstockFundingTransferTargetRailEnum? get rail => _$this._rail;
  set rail(BstockFundingTransferTargetRailEnum? rail) => _$this._rail = rail;

  BstockFundingTargetBalanceSnapshotBuilder? _target;
  BstockFundingTargetBalanceSnapshotBuilder get target =>
      _$this._target ??= BstockFundingTargetBalanceSnapshotBuilder();
  set target(BstockFundingTargetBalanceSnapshotBuilder? target) =>
      _$this._target = target;

  BstockFundingTargetCreditObservationBuilder? _targetCredit;
  BstockFundingTargetCreditObservationBuilder get targetCredit =>
      _$this._targetCredit ??= BstockFundingTargetCreditObservationBuilder();
  set targetCredit(BstockFundingTargetCreditObservationBuilder? targetCredit) =>
      _$this._targetCredit = targetCredit;

  BstockFundingTransferTargetBuilder() {
    BstockFundingTransferTarget._defaults(this);
  }

  BstockFundingTransferTargetBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _rail = $v.rail;
      _target = $v.target.toBuilder();
      _targetCredit = $v.targetCredit?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(BstockFundingTransferTarget other) {
    _$v = other as _$BstockFundingTransferTarget;
  }

  @override
  void update(void Function(BstockFundingTransferTargetBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  BstockFundingTransferTarget build() => _build();

  _$BstockFundingTransferTarget _build() {
    _$BstockFundingTransferTarget _$result;
    try {
      _$result = _$v ??
          _$BstockFundingTransferTarget._(
            rail: BuiltValueNullFieldError.checkNotNull(
                rail, r'BstockFundingTransferTarget', 'rail'),
            target: target.build(),
            targetCredit: _targetCredit?.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'target';
        target.build();
        _$failedField = 'targetCredit';
        _targetCredit?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'BstockFundingTransferTarget', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint

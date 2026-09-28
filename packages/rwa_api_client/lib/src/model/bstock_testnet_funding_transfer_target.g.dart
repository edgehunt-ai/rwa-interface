// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bstock_testnet_funding_transfer_target.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const BstockTestnetFundingTransferTargetRailEnum
    _$bstockTestnetFundingTransferTargetRailEnum_bstock =
    const BstockTestnetFundingTransferTargetRailEnum._('bstock');

BstockTestnetFundingTransferTargetRailEnum
    _$bstockTestnetFundingTransferTargetRailEnumValueOf(String name) {
  switch (name) {
    case 'bstock':
      return _$bstockTestnetFundingTransferTargetRailEnum_bstock;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<BstockTestnetFundingTransferTargetRailEnum>
    _$bstockTestnetFundingTransferTargetRailEnumValues = BuiltSet<
        BstockTestnetFundingTransferTargetRailEnum>(const <BstockTestnetFundingTransferTargetRailEnum>[
  _$bstockTestnetFundingTransferTargetRailEnum_bstock,
]);

Serializer<BstockTestnetFundingTransferTargetRailEnum>
    _$bstockTestnetFundingTransferTargetRailEnumSerializer =
    _$BstockTestnetFundingTransferTargetRailEnumSerializer();

class _$BstockTestnetFundingTransferTargetRailEnumSerializer
    implements PrimitiveSerializer<BstockTestnetFundingTransferTargetRailEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'bstock': 'bstock',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'bstock': 'bstock',
  };

  @override
  final Iterable<Type> types = const <Type>[
    BstockTestnetFundingTransferTargetRailEnum
  ];
  @override
  final String wireName = 'BstockTestnetFundingTransferTargetRailEnum';

  @override
  Object serialize(Serializers serializers,
          BstockTestnetFundingTransferTargetRailEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  BstockTestnetFundingTransferTargetRailEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      BstockTestnetFundingTransferTargetRailEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$BstockTestnetFundingTransferTarget
    extends BstockTestnetFundingTransferTarget {
  @override
  final BstockTestnetFundingTransferTargetRailEnum rail;
  @override
  final BstockTestnetFundingTargetBalanceSnapshot target;
  @override
  final BstockTestnetFundingTargetCreditObservation? targetCredit;

  factory _$BstockTestnetFundingTransferTarget(
          [void Function(BstockTestnetFundingTransferTargetBuilder)?
              updates]) =>
      (BstockTestnetFundingTransferTargetBuilder()..update(updates))._build();

  _$BstockTestnetFundingTransferTarget._(
      {required this.rail, required this.target, this.targetCredit})
      : super._();
  @override
  BstockTestnetFundingTransferTarget rebuild(
          void Function(BstockTestnetFundingTransferTargetBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  BstockTestnetFundingTransferTargetBuilder toBuilder() =>
      BstockTestnetFundingTransferTargetBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is BstockTestnetFundingTransferTarget &&
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
    return (newBuiltValueToStringHelper(r'BstockTestnetFundingTransferTarget')
          ..add('rail', rail)
          ..add('target', target)
          ..add('targetCredit', targetCredit))
        .toString();
  }
}

class BstockTestnetFundingTransferTargetBuilder
    implements
        Builder<BstockTestnetFundingTransferTarget,
            BstockTestnetFundingTransferTargetBuilder> {
  _$BstockTestnetFundingTransferTarget? _$v;

  BstockTestnetFundingTransferTargetRailEnum? _rail;
  BstockTestnetFundingTransferTargetRailEnum? get rail => _$this._rail;
  set rail(BstockTestnetFundingTransferTargetRailEnum? rail) =>
      _$this._rail = rail;

  BstockTestnetFundingTargetBalanceSnapshotBuilder? _target;
  BstockTestnetFundingTargetBalanceSnapshotBuilder get target =>
      _$this._target ??= BstockTestnetFundingTargetBalanceSnapshotBuilder();
  set target(BstockTestnetFundingTargetBalanceSnapshotBuilder? target) =>
      _$this._target = target;

  BstockTestnetFundingTargetCreditObservationBuilder? _targetCredit;
  BstockTestnetFundingTargetCreditObservationBuilder get targetCredit =>
      _$this._targetCredit ??=
          BstockTestnetFundingTargetCreditObservationBuilder();
  set targetCredit(
          BstockTestnetFundingTargetCreditObservationBuilder? targetCredit) =>
      _$this._targetCredit = targetCredit;

  BstockTestnetFundingTransferTargetBuilder() {
    BstockTestnetFundingTransferTarget._defaults(this);
  }

  BstockTestnetFundingTransferTargetBuilder get _$this {
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
  void replace(BstockTestnetFundingTransferTarget other) {
    _$v = other as _$BstockTestnetFundingTransferTarget;
  }

  @override
  void update(
      void Function(BstockTestnetFundingTransferTargetBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  BstockTestnetFundingTransferTarget build() => _build();

  _$BstockTestnetFundingTransferTarget _build() {
    _$BstockTestnetFundingTransferTarget _$result;
    try {
      _$result = _$v ??
          _$BstockTestnetFundingTransferTarget._(
            rail: BuiltValueNullFieldError.checkNotNull(
                rail, r'BstockTestnetFundingTransferTarget', 'rail'),
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
            r'BstockTestnetFundingTransferTarget', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint

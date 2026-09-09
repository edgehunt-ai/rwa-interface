// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'perp_funding_transfer_target.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const PerpFundingTransferTargetRailEnum
    _$perpFundingTransferTargetRailEnum_perp =
    const PerpFundingTransferTargetRailEnum._('perp');
const PerpFundingTransferTargetRailEnum
    _$perpFundingTransferTargetRailEnum_unknownDefaultOpenApi =
    const PerpFundingTransferTargetRailEnum._('unknownDefaultOpenApi');

PerpFundingTransferTargetRailEnum _$perpFundingTransferTargetRailEnumValueOf(
    String name) {
  switch (name) {
    case 'perp':
      return _$perpFundingTransferTargetRailEnum_perp;
    case 'unknownDefaultOpenApi':
      return _$perpFundingTransferTargetRailEnum_unknownDefaultOpenApi;
    default:
      return _$perpFundingTransferTargetRailEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<PerpFundingTransferTargetRailEnum>
    _$perpFundingTransferTargetRailEnumValues = BuiltSet<
        PerpFundingTransferTargetRailEnum>(const <PerpFundingTransferTargetRailEnum>[
  _$perpFundingTransferTargetRailEnum_perp,
  _$perpFundingTransferTargetRailEnum_unknownDefaultOpenApi,
]);

Serializer<PerpFundingTransferTargetRailEnum>
    _$perpFundingTransferTargetRailEnumSerializer =
    _$PerpFundingTransferTargetRailEnumSerializer();

class _$PerpFundingTransferTargetRailEnumSerializer
    implements PrimitiveSerializer<PerpFundingTransferTargetRailEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'perp': 'perp',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'perp': 'perp',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[PerpFundingTransferTargetRailEnum];
  @override
  final String wireName = 'PerpFundingTransferTargetRailEnum';

  @override
  Object serialize(
          Serializers serializers, PerpFundingTransferTargetRailEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  PerpFundingTransferTargetRailEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      PerpFundingTransferTargetRailEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$PerpFundingTransferTarget extends PerpFundingTransferTarget {
  @override
  final PerpFundingTransferTargetRailEnum rail;
  @override
  final PerpFundingTargetBalanceSnapshot target;
  @override
  final PerpFundingTargetCreditObservation? targetCredit;

  factory _$PerpFundingTransferTarget(
          [void Function(PerpFundingTransferTargetBuilder)? updates]) =>
      (PerpFundingTransferTargetBuilder()..update(updates))._build();

  _$PerpFundingTransferTarget._(
      {required this.rail, required this.target, this.targetCredit})
      : super._();
  @override
  PerpFundingTransferTarget rebuild(
          void Function(PerpFundingTransferTargetBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  PerpFundingTransferTargetBuilder toBuilder() =>
      PerpFundingTransferTargetBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is PerpFundingTransferTarget &&
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
    return (newBuiltValueToStringHelper(r'PerpFundingTransferTarget')
          ..add('rail', rail)
          ..add('target', target)
          ..add('targetCredit', targetCredit))
        .toString();
  }
}

class PerpFundingTransferTargetBuilder
    implements
        Builder<PerpFundingTransferTarget, PerpFundingTransferTargetBuilder> {
  _$PerpFundingTransferTarget? _$v;

  PerpFundingTransferTargetRailEnum? _rail;
  PerpFundingTransferTargetRailEnum? get rail => _$this._rail;
  set rail(PerpFundingTransferTargetRailEnum? rail) => _$this._rail = rail;

  PerpFundingTargetBalanceSnapshotBuilder? _target;
  PerpFundingTargetBalanceSnapshotBuilder get target =>
      _$this._target ??= PerpFundingTargetBalanceSnapshotBuilder();
  set target(PerpFundingTargetBalanceSnapshotBuilder? target) =>
      _$this._target = target;

  PerpFundingTargetCreditObservationBuilder? _targetCredit;
  PerpFundingTargetCreditObservationBuilder get targetCredit =>
      _$this._targetCredit ??= PerpFundingTargetCreditObservationBuilder();
  set targetCredit(PerpFundingTargetCreditObservationBuilder? targetCredit) =>
      _$this._targetCredit = targetCredit;

  PerpFundingTransferTargetBuilder() {
    PerpFundingTransferTarget._defaults(this);
  }

  PerpFundingTransferTargetBuilder get _$this {
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
  void replace(PerpFundingTransferTarget other) {
    _$v = other as _$PerpFundingTransferTarget;
  }

  @override
  void update(void Function(PerpFundingTransferTargetBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  PerpFundingTransferTarget build() => _build();

  _$PerpFundingTransferTarget _build() {
    _$PerpFundingTransferTarget _$result;
    try {
      _$result = _$v ??
          _$PerpFundingTransferTarget._(
            rail: BuiltValueNullFieldError.checkNotNull(
                rail, r'PerpFundingTransferTarget', 'rail'),
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
            r'PerpFundingTransferTarget', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint

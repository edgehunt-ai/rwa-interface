// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hip3_liquidation.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const Hip3LiquidationAccountValueScopeEnum
    _$hip3LiquidationAccountValueScopeEnum_crossAccount =
    const Hip3LiquidationAccountValueScopeEnum._('crossAccount');
const Hip3LiquidationAccountValueScopeEnum
    _$hip3LiquidationAccountValueScopeEnum_isolatedAccount =
    const Hip3LiquidationAccountValueScopeEnum._('isolatedAccount');
const Hip3LiquidationAccountValueScopeEnum
    _$hip3LiquidationAccountValueScopeEnum_unknownDefaultOpenApi =
    const Hip3LiquidationAccountValueScopeEnum._('unknownDefaultOpenApi');

Hip3LiquidationAccountValueScopeEnum
    _$hip3LiquidationAccountValueScopeEnumValueOf(String name) {
  switch (name) {
    case 'crossAccount':
      return _$hip3LiquidationAccountValueScopeEnum_crossAccount;
    case 'isolatedAccount':
      return _$hip3LiquidationAccountValueScopeEnum_isolatedAccount;
    case 'unknownDefaultOpenApi':
      return _$hip3LiquidationAccountValueScopeEnum_unknownDefaultOpenApi;
    default:
      return _$hip3LiquidationAccountValueScopeEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<Hip3LiquidationAccountValueScopeEnum>
    _$hip3LiquidationAccountValueScopeEnumValues = BuiltSet<
        Hip3LiquidationAccountValueScopeEnum>(const <Hip3LiquidationAccountValueScopeEnum>[
  _$hip3LiquidationAccountValueScopeEnum_crossAccount,
  _$hip3LiquidationAccountValueScopeEnum_isolatedAccount,
  _$hip3LiquidationAccountValueScopeEnum_unknownDefaultOpenApi,
]);

const Hip3LiquidationMarginModeEnum _$hip3LiquidationMarginModeEnum_cross =
    const Hip3LiquidationMarginModeEnum._('cross');
const Hip3LiquidationMarginModeEnum _$hip3LiquidationMarginModeEnum_isolated =
    const Hip3LiquidationMarginModeEnum._('isolated');
const Hip3LiquidationMarginModeEnum
    _$hip3LiquidationMarginModeEnum_unknownDefaultOpenApi =
    const Hip3LiquidationMarginModeEnum._('unknownDefaultOpenApi');

Hip3LiquidationMarginModeEnum _$hip3LiquidationMarginModeEnumValueOf(
    String name) {
  switch (name) {
    case 'cross':
      return _$hip3LiquidationMarginModeEnum_cross;
    case 'isolated':
      return _$hip3LiquidationMarginModeEnum_isolated;
    case 'unknownDefaultOpenApi':
      return _$hip3LiquidationMarginModeEnum_unknownDefaultOpenApi;
    default:
      return _$hip3LiquidationMarginModeEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<Hip3LiquidationMarginModeEnum>
    _$hip3LiquidationMarginModeEnumValues = BuiltSet<
        Hip3LiquidationMarginModeEnum>(const <Hip3LiquidationMarginModeEnum>[
  _$hip3LiquidationMarginModeEnum_cross,
  _$hip3LiquidationMarginModeEnum_isolated,
  _$hip3LiquidationMarginModeEnum_unknownDefaultOpenApi,
]);

Serializer<Hip3LiquidationAccountValueScopeEnum>
    _$hip3LiquidationAccountValueScopeEnumSerializer =
    _$Hip3LiquidationAccountValueScopeEnumSerializer();
Serializer<Hip3LiquidationMarginModeEnum>
    _$hip3LiquidationMarginModeEnumSerializer =
    _$Hip3LiquidationMarginModeEnumSerializer();

class _$Hip3LiquidationAccountValueScopeEnumSerializer
    implements PrimitiveSerializer<Hip3LiquidationAccountValueScopeEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'crossAccount': 'cross_account',
    'isolatedAccount': 'isolated_account',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'cross_account': 'crossAccount',
    'isolated_account': 'isolatedAccount',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[
    Hip3LiquidationAccountValueScopeEnum
  ];
  @override
  final String wireName = 'Hip3LiquidationAccountValueScopeEnum';

  @override
  Object serialize(
          Serializers serializers, Hip3LiquidationAccountValueScopeEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  Hip3LiquidationAccountValueScopeEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      Hip3LiquidationAccountValueScopeEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$Hip3LiquidationMarginModeEnumSerializer
    implements PrimitiveSerializer<Hip3LiquidationMarginModeEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'cross': 'cross',
    'isolated': 'isolated',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'cross': 'cross',
    'isolated': 'isolated',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[Hip3LiquidationMarginModeEnum];
  @override
  final String wireName = 'Hip3LiquidationMarginModeEnum';

  @override
  Object serialize(
          Serializers serializers, Hip3LiquidationMarginModeEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  Hip3LiquidationMarginModeEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      Hip3LiquidationMarginModeEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$Hip3Liquidation extends Hip3Liquidation {
  @override
  final String id;
  @override
  final String providerAccountValue;
  @override
  final Hip3LiquidationAccountValueScopeEnum accountValueScope;
  @override
  final Hip3LiquidationMarginModeEnum marginMode;
  @override
  final BuiltList<Hip3LiquidationPosition> positions;
  @override
  final int excludedNativePositionCount;
  @override
  final String transactionHash;
  @override
  final DateTime occurredAt;

  factory _$Hip3Liquidation([void Function(Hip3LiquidationBuilder)? updates]) =>
      (Hip3LiquidationBuilder()..update(updates))._build();

  _$Hip3Liquidation._(
      {required this.id,
      required this.providerAccountValue,
      required this.accountValueScope,
      required this.marginMode,
      required this.positions,
      required this.excludedNativePositionCount,
      required this.transactionHash,
      required this.occurredAt})
      : super._();
  @override
  Hip3Liquidation rebuild(void Function(Hip3LiquidationBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  Hip3LiquidationBuilder toBuilder() => Hip3LiquidationBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Hip3Liquidation &&
        id == other.id &&
        providerAccountValue == other.providerAccountValue &&
        accountValueScope == other.accountValueScope &&
        marginMode == other.marginMode &&
        positions == other.positions &&
        excludedNativePositionCount == other.excludedNativePositionCount &&
        transactionHash == other.transactionHash &&
        occurredAt == other.occurredAt;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, providerAccountValue.hashCode);
    _$hash = $jc(_$hash, accountValueScope.hashCode);
    _$hash = $jc(_$hash, marginMode.hashCode);
    _$hash = $jc(_$hash, positions.hashCode);
    _$hash = $jc(_$hash, excludedNativePositionCount.hashCode);
    _$hash = $jc(_$hash, transactionHash.hashCode);
    _$hash = $jc(_$hash, occurredAt.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'Hip3Liquidation')
          ..add('id', id)
          ..add('providerAccountValue', providerAccountValue)
          ..add('accountValueScope', accountValueScope)
          ..add('marginMode', marginMode)
          ..add('positions', positions)
          ..add('excludedNativePositionCount', excludedNativePositionCount)
          ..add('transactionHash', transactionHash)
          ..add('occurredAt', occurredAt))
        .toString();
  }
}

class Hip3LiquidationBuilder
    implements Builder<Hip3Liquidation, Hip3LiquidationBuilder> {
  _$Hip3Liquidation? _$v;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  String? _providerAccountValue;
  String? get providerAccountValue => _$this._providerAccountValue;
  set providerAccountValue(String? providerAccountValue) =>
      _$this._providerAccountValue = providerAccountValue;

  Hip3LiquidationAccountValueScopeEnum? _accountValueScope;
  Hip3LiquidationAccountValueScopeEnum? get accountValueScope =>
      _$this._accountValueScope;
  set accountValueScope(
          Hip3LiquidationAccountValueScopeEnum? accountValueScope) =>
      _$this._accountValueScope = accountValueScope;

  Hip3LiquidationMarginModeEnum? _marginMode;
  Hip3LiquidationMarginModeEnum? get marginMode => _$this._marginMode;
  set marginMode(Hip3LiquidationMarginModeEnum? marginMode) =>
      _$this._marginMode = marginMode;

  ListBuilder<Hip3LiquidationPosition>? _positions;
  ListBuilder<Hip3LiquidationPosition> get positions =>
      _$this._positions ??= ListBuilder<Hip3LiquidationPosition>();
  set positions(ListBuilder<Hip3LiquidationPosition>? positions) =>
      _$this._positions = positions;

  int? _excludedNativePositionCount;
  int? get excludedNativePositionCount => _$this._excludedNativePositionCount;
  set excludedNativePositionCount(int? excludedNativePositionCount) =>
      _$this._excludedNativePositionCount = excludedNativePositionCount;

  String? _transactionHash;
  String? get transactionHash => _$this._transactionHash;
  set transactionHash(String? transactionHash) =>
      _$this._transactionHash = transactionHash;

  DateTime? _occurredAt;
  DateTime? get occurredAt => _$this._occurredAt;
  set occurredAt(DateTime? occurredAt) => _$this._occurredAt = occurredAt;

  Hip3LiquidationBuilder() {
    Hip3Liquidation._defaults(this);
  }

  Hip3LiquidationBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _providerAccountValue = $v.providerAccountValue;
      _accountValueScope = $v.accountValueScope;
      _marginMode = $v.marginMode;
      _positions = $v.positions.toBuilder();
      _excludedNativePositionCount = $v.excludedNativePositionCount;
      _transactionHash = $v.transactionHash;
      _occurredAt = $v.occurredAt;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Hip3Liquidation other) {
    _$v = other as _$Hip3Liquidation;
  }

  @override
  void update(void Function(Hip3LiquidationBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  Hip3Liquidation build() => _build();

  _$Hip3Liquidation _build() {
    _$Hip3Liquidation _$result;
    try {
      _$result = _$v ??
          _$Hip3Liquidation._(
            id: BuiltValueNullFieldError.checkNotNull(
                id, r'Hip3Liquidation', 'id'),
            providerAccountValue: BuiltValueNullFieldError.checkNotNull(
                providerAccountValue,
                r'Hip3Liquidation',
                'providerAccountValue'),
            accountValueScope: BuiltValueNullFieldError.checkNotNull(
                accountValueScope, r'Hip3Liquidation', 'accountValueScope'),
            marginMode: BuiltValueNullFieldError.checkNotNull(
                marginMode, r'Hip3Liquidation', 'marginMode'),
            positions: positions.build(),
            excludedNativePositionCount: BuiltValueNullFieldError.checkNotNull(
                excludedNativePositionCount,
                r'Hip3Liquidation',
                'excludedNativePositionCount'),
            transactionHash: BuiltValueNullFieldError.checkNotNull(
                transactionHash, r'Hip3Liquidation', 'transactionHash'),
            occurredAt: BuiltValueNullFieldError.checkNotNull(
                occurredAt, r'Hip3Liquidation', 'occurredAt'),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'positions';
        positions.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'Hip3Liquidation', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint

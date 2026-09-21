// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bstocks_cancellation_policy.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const BstocksCancellationPolicyInsufficientBalanceEnum
    _$bstocksCancellationPolicyInsufficientBalanceEnum_permanent =
    const BstocksCancellationPolicyInsufficientBalanceEnum._('permanent');
const BstocksCancellationPolicyInsufficientBalanceEnum
    _$bstocksCancellationPolicyInsufficientBalanceEnum_unknownDefaultOpenApi =
    const BstocksCancellationPolicyInsufficientBalanceEnum._(
        'unknownDefaultOpenApi');

BstocksCancellationPolicyInsufficientBalanceEnum
    _$bstocksCancellationPolicyInsufficientBalanceEnumValueOf(String name) {
  switch (name) {
    case 'permanent':
      return _$bstocksCancellationPolicyInsufficientBalanceEnum_permanent;
    case 'unknownDefaultOpenApi':
      return _$bstocksCancellationPolicyInsufficientBalanceEnum_unknownDefaultOpenApi;
    default:
      return _$bstocksCancellationPolicyInsufficientBalanceEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<BstocksCancellationPolicyInsufficientBalanceEnum>
    _$bstocksCancellationPolicyInsufficientBalanceEnumValues = BuiltSet<
        BstocksCancellationPolicyInsufficientBalanceEnum>(const <BstocksCancellationPolicyInsufficientBalanceEnum>[
  _$bstocksCancellationPolicyInsufficientBalanceEnum_permanent,
  _$bstocksCancellationPolicyInsufficientBalanceEnum_unknownDefaultOpenApi,
]);

const BstocksCancellationPolicyInsufficientAllowanceEnum
    _$bstocksCancellationPolicyInsufficientAllowanceEnum_permanent =
    const BstocksCancellationPolicyInsufficientAllowanceEnum._('permanent');
const BstocksCancellationPolicyInsufficientAllowanceEnum
    _$bstocksCancellationPolicyInsufficientAllowanceEnum_unknownDefaultOpenApi =
    const BstocksCancellationPolicyInsufficientAllowanceEnum._(
        'unknownDefaultOpenApi');

BstocksCancellationPolicyInsufficientAllowanceEnum
    _$bstocksCancellationPolicyInsufficientAllowanceEnumValueOf(String name) {
  switch (name) {
    case 'permanent':
      return _$bstocksCancellationPolicyInsufficientAllowanceEnum_permanent;
    case 'unknownDefaultOpenApi':
      return _$bstocksCancellationPolicyInsufficientAllowanceEnum_unknownDefaultOpenApi;
    default:
      return _$bstocksCancellationPolicyInsufficientAllowanceEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<BstocksCancellationPolicyInsufficientAllowanceEnum>
    _$bstocksCancellationPolicyInsufficientAllowanceEnumValues = BuiltSet<
        BstocksCancellationPolicyInsufficientAllowanceEnum>(const <BstocksCancellationPolicyInsufficientAllowanceEnum>[
  _$bstocksCancellationPolicyInsufficientAllowanceEnum_permanent,
  _$bstocksCancellationPolicyInsufficientAllowanceEnum_unknownDefaultOpenApi,
]);

Serializer<BstocksCancellationPolicyInsufficientBalanceEnum>
    _$bstocksCancellationPolicyInsufficientBalanceEnumSerializer =
    _$BstocksCancellationPolicyInsufficientBalanceEnumSerializer();
Serializer<BstocksCancellationPolicyInsufficientAllowanceEnum>
    _$bstocksCancellationPolicyInsufficientAllowanceEnumSerializer =
    _$BstocksCancellationPolicyInsufficientAllowanceEnumSerializer();

class _$BstocksCancellationPolicyInsufficientBalanceEnumSerializer
    implements
        PrimitiveSerializer<BstocksCancellationPolicyInsufficientBalanceEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'permanent': 'permanent',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'permanent': 'permanent',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[
    BstocksCancellationPolicyInsufficientBalanceEnum
  ];
  @override
  final String wireName = 'BstocksCancellationPolicyInsufficientBalanceEnum';

  @override
  Object serialize(Serializers serializers,
          BstocksCancellationPolicyInsufficientBalanceEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  BstocksCancellationPolicyInsufficientBalanceEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      BstocksCancellationPolicyInsufficientBalanceEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$BstocksCancellationPolicyInsufficientAllowanceEnumSerializer
    implements
        PrimitiveSerializer<
            BstocksCancellationPolicyInsufficientAllowanceEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'permanent': 'permanent',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'permanent': 'permanent',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[
    BstocksCancellationPolicyInsufficientAllowanceEnum
  ];
  @override
  final String wireName = 'BstocksCancellationPolicyInsufficientAllowanceEnum';

  @override
  Object serialize(Serializers serializers,
          BstocksCancellationPolicyInsufficientAllowanceEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  BstocksCancellationPolicyInsufficientAllowanceEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      BstocksCancellationPolicyInsufficientAllowanceEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$BstocksCancellationPolicy extends BstocksCancellationPolicy {
  @override
  final BstocksCancellationPolicyInsufficientBalanceEnum insufficientBalance;
  @override
  final BstocksCancellationPolicyInsufficientAllowanceEnum
      insufficientAllowance;

  factory _$BstocksCancellationPolicy(
          [void Function(BstocksCancellationPolicyBuilder)? updates]) =>
      (BstocksCancellationPolicyBuilder()..update(updates))._build();

  _$BstocksCancellationPolicy._(
      {required this.insufficientBalance, required this.insufficientAllowance})
      : super._();
  @override
  BstocksCancellationPolicy rebuild(
          void Function(BstocksCancellationPolicyBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  BstocksCancellationPolicyBuilder toBuilder() =>
      BstocksCancellationPolicyBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is BstocksCancellationPolicy &&
        insufficientBalance == other.insufficientBalance &&
        insufficientAllowance == other.insufficientAllowance;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, insufficientBalance.hashCode);
    _$hash = $jc(_$hash, insufficientAllowance.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'BstocksCancellationPolicy')
          ..add('insufficientBalance', insufficientBalance)
          ..add('insufficientAllowance', insufficientAllowance))
        .toString();
  }
}

class BstocksCancellationPolicyBuilder
    implements
        Builder<BstocksCancellationPolicy, BstocksCancellationPolicyBuilder> {
  _$BstocksCancellationPolicy? _$v;

  BstocksCancellationPolicyInsufficientBalanceEnum? _insufficientBalance;
  BstocksCancellationPolicyInsufficientBalanceEnum? get insufficientBalance =>
      _$this._insufficientBalance;
  set insufficientBalance(
          BstocksCancellationPolicyInsufficientBalanceEnum?
              insufficientBalance) =>
      _$this._insufficientBalance = insufficientBalance;

  BstocksCancellationPolicyInsufficientAllowanceEnum? _insufficientAllowance;
  BstocksCancellationPolicyInsufficientAllowanceEnum?
      get insufficientAllowance => _$this._insufficientAllowance;
  set insufficientAllowance(
          BstocksCancellationPolicyInsufficientAllowanceEnum?
              insufficientAllowance) =>
      _$this._insufficientAllowance = insufficientAllowance;

  BstocksCancellationPolicyBuilder() {
    BstocksCancellationPolicy._defaults(this);
  }

  BstocksCancellationPolicyBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _insufficientBalance = $v.insufficientBalance;
      _insufficientAllowance = $v.insufficientAllowance;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(BstocksCancellationPolicy other) {
    _$v = other as _$BstocksCancellationPolicy;
  }

  @override
  void update(void Function(BstocksCancellationPolicyBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  BstocksCancellationPolicy build() => _build();

  _$BstocksCancellationPolicy _build() {
    final _$result = _$v ??
        _$BstocksCancellationPolicy._(
          insufficientBalance: BuiltValueNullFieldError.checkNotNull(
              insufficientBalance,
              r'BstocksCancellationPolicy',
              'insufficientBalance'),
          insufficientAllowance: BuiltValueNullFieldError.checkNotNull(
              insufficientAllowance,
              r'BstocksCancellationPolicy',
              'insufficientAllowance'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint

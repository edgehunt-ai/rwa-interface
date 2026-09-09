// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'frozen_evm_transaction.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const FrozenEvmTransactionValueEnum _$frozenEvmTransactionValueEnum_n0x0 =
    const FrozenEvmTransactionValueEnum._('n0x0');
const FrozenEvmTransactionValueEnum
    _$frozenEvmTransactionValueEnum_unknownDefaultOpenApi =
    const FrozenEvmTransactionValueEnum._('unknownDefaultOpenApi');

FrozenEvmTransactionValueEnum _$frozenEvmTransactionValueEnumValueOf(
    String name) {
  switch (name) {
    case 'n0x0':
      return _$frozenEvmTransactionValueEnum_n0x0;
    case 'unknownDefaultOpenApi':
      return _$frozenEvmTransactionValueEnum_unknownDefaultOpenApi;
    default:
      return _$frozenEvmTransactionValueEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<FrozenEvmTransactionValueEnum>
    _$frozenEvmTransactionValueEnumValues = BuiltSet<
        FrozenEvmTransactionValueEnum>(const <FrozenEvmTransactionValueEnum>[
  _$frozenEvmTransactionValueEnum_n0x0,
  _$frozenEvmTransactionValueEnum_unknownDefaultOpenApi,
]);

Serializer<FrozenEvmTransactionValueEnum>
    _$frozenEvmTransactionValueEnumSerializer =
    _$FrozenEvmTransactionValueEnumSerializer();

class _$FrozenEvmTransactionValueEnumSerializer
    implements PrimitiveSerializer<FrozenEvmTransactionValueEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'n0x0': '0x0',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    '0x0': 'n0x0',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[FrozenEvmTransactionValueEnum];
  @override
  final String wireName = 'FrozenEvmTransactionValueEnum';

  @override
  Object serialize(
          Serializers serializers, FrozenEvmTransactionValueEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  FrozenEvmTransactionValueEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      FrozenEvmTransactionValueEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$FrozenEvmTransaction extends FrozenEvmTransaction {
  @override
  final String to;
  @override
  final String data;
  @override
  final FrozenEvmTransactionValueEnum value;

  factory _$FrozenEvmTransaction(
          [void Function(FrozenEvmTransactionBuilder)? updates]) =>
      (FrozenEvmTransactionBuilder()..update(updates))._build();

  _$FrozenEvmTransaction._(
      {required this.to, required this.data, required this.value})
      : super._();
  @override
  FrozenEvmTransaction rebuild(
          void Function(FrozenEvmTransactionBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  FrozenEvmTransactionBuilder toBuilder() =>
      FrozenEvmTransactionBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is FrozenEvmTransaction &&
        to == other.to &&
        data == other.data &&
        value == other.value;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, to.hashCode);
    _$hash = $jc(_$hash, data.hashCode);
    _$hash = $jc(_$hash, value.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'FrozenEvmTransaction')
          ..add('to', to)
          ..add('data', data)
          ..add('value', value))
        .toString();
  }
}

class FrozenEvmTransactionBuilder
    implements Builder<FrozenEvmTransaction, FrozenEvmTransactionBuilder> {
  _$FrozenEvmTransaction? _$v;

  String? _to;
  String? get to => _$this._to;
  set to(String? to) => _$this._to = to;

  String? _data;
  String? get data => _$this._data;
  set data(String? data) => _$this._data = data;

  FrozenEvmTransactionValueEnum? _value;
  FrozenEvmTransactionValueEnum? get value => _$this._value;
  set value(FrozenEvmTransactionValueEnum? value) => _$this._value = value;

  FrozenEvmTransactionBuilder() {
    FrozenEvmTransaction._defaults(this);
  }

  FrozenEvmTransactionBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _to = $v.to;
      _data = $v.data;
      _value = $v.value;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(FrozenEvmTransaction other) {
    _$v = other as _$FrozenEvmTransaction;
  }

  @override
  void update(void Function(FrozenEvmTransactionBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  FrozenEvmTransaction build() => _build();

  _$FrozenEvmTransaction _build() {
    final _$result = _$v ??
        _$FrozenEvmTransaction._(
          to: BuiltValueNullFieldError.checkNotNull(
              to, r'FrozenEvmTransaction', 'to'),
          data: BuiltValueNullFieldError.checkNotNull(
              data, r'FrozenEvmTransaction', 'data'),
          value: BuiltValueNullFieldError.checkNotNull(
              value, r'FrozenEvmTransaction', 'value'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint

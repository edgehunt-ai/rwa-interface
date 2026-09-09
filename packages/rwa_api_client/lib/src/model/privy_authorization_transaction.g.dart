// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'privy_authorization_transaction.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const PrivyAuthorizationTransactionValueEnum
    _$privyAuthorizationTransactionValueEnum_n0x0 =
    const PrivyAuthorizationTransactionValueEnum._('n0x0');
const PrivyAuthorizationTransactionValueEnum
    _$privyAuthorizationTransactionValueEnum_unknownDefaultOpenApi =
    const PrivyAuthorizationTransactionValueEnum._('unknownDefaultOpenApi');

PrivyAuthorizationTransactionValueEnum
    _$privyAuthorizationTransactionValueEnumValueOf(String name) {
  switch (name) {
    case 'n0x0':
      return _$privyAuthorizationTransactionValueEnum_n0x0;
    case 'unknownDefaultOpenApi':
      return _$privyAuthorizationTransactionValueEnum_unknownDefaultOpenApi;
    default:
      return _$privyAuthorizationTransactionValueEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<PrivyAuthorizationTransactionValueEnum>
    _$privyAuthorizationTransactionValueEnumValues = BuiltSet<
        PrivyAuthorizationTransactionValueEnum>(const <PrivyAuthorizationTransactionValueEnum>[
  _$privyAuthorizationTransactionValueEnum_n0x0,
  _$privyAuthorizationTransactionValueEnum_unknownDefaultOpenApi,
]);

Serializer<PrivyAuthorizationTransactionValueEnum>
    _$privyAuthorizationTransactionValueEnumSerializer =
    _$PrivyAuthorizationTransactionValueEnumSerializer();

class _$PrivyAuthorizationTransactionValueEnumSerializer
    implements PrimitiveSerializer<PrivyAuthorizationTransactionValueEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'n0x0': '0x0',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    '0x0': 'n0x0',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[
    PrivyAuthorizationTransactionValueEnum
  ];
  @override
  final String wireName = 'PrivyAuthorizationTransactionValueEnum';

  @override
  Object serialize(Serializers serializers,
          PrivyAuthorizationTransactionValueEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  PrivyAuthorizationTransactionValueEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      PrivyAuthorizationTransactionValueEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$PrivyAuthorizationTransaction extends PrivyAuthorizationTransaction {
  @override
  final String from;
  @override
  final String to;
  @override
  final String data;
  @override
  final PrivyAuthorizationTransactionValueEnum value;

  factory _$PrivyAuthorizationTransaction(
          [void Function(PrivyAuthorizationTransactionBuilder)? updates]) =>
      (PrivyAuthorizationTransactionBuilder()..update(updates))._build();

  _$PrivyAuthorizationTransaction._(
      {required this.from,
      required this.to,
      required this.data,
      required this.value})
      : super._();
  @override
  PrivyAuthorizationTransaction rebuild(
          void Function(PrivyAuthorizationTransactionBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  PrivyAuthorizationTransactionBuilder toBuilder() =>
      PrivyAuthorizationTransactionBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is PrivyAuthorizationTransaction &&
        from == other.from &&
        to == other.to &&
        data == other.data &&
        value == other.value;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, from.hashCode);
    _$hash = $jc(_$hash, to.hashCode);
    _$hash = $jc(_$hash, data.hashCode);
    _$hash = $jc(_$hash, value.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'PrivyAuthorizationTransaction')
          ..add('from', from)
          ..add('to', to)
          ..add('data', data)
          ..add('value', value))
        .toString();
  }
}

class PrivyAuthorizationTransactionBuilder
    implements
        Builder<PrivyAuthorizationTransaction,
            PrivyAuthorizationTransactionBuilder> {
  _$PrivyAuthorizationTransaction? _$v;

  String? _from;
  String? get from => _$this._from;
  set from(String? from) => _$this._from = from;

  String? _to;
  String? get to => _$this._to;
  set to(String? to) => _$this._to = to;

  String? _data;
  String? get data => _$this._data;
  set data(String? data) => _$this._data = data;

  PrivyAuthorizationTransactionValueEnum? _value;
  PrivyAuthorizationTransactionValueEnum? get value => _$this._value;
  set value(PrivyAuthorizationTransactionValueEnum? value) =>
      _$this._value = value;

  PrivyAuthorizationTransactionBuilder() {
    PrivyAuthorizationTransaction._defaults(this);
  }

  PrivyAuthorizationTransactionBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _from = $v.from;
      _to = $v.to;
      _data = $v.data;
      _value = $v.value;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(PrivyAuthorizationTransaction other) {
    _$v = other as _$PrivyAuthorizationTransaction;
  }

  @override
  void update(void Function(PrivyAuthorizationTransactionBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  PrivyAuthorizationTransaction build() => _build();

  _$PrivyAuthorizationTransaction _build() {
    final _$result = _$v ??
        _$PrivyAuthorizationTransaction._(
          from: BuiltValueNullFieldError.checkNotNull(
              from, r'PrivyAuthorizationTransaction', 'from'),
          to: BuiltValueNullFieldError.checkNotNull(
              to, r'PrivyAuthorizationTransaction', 'to'),
          data: BuiltValueNullFieldError.checkNotNull(
              data, r'PrivyAuthorizationTransaction', 'data'),
          value: BuiltValueNullFieldError.checkNotNull(
              value, r'PrivyAuthorizationTransaction', 'value'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint

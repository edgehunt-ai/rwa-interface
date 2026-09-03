// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'account_kind.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const AccountKind _$app = const AccountKind._('app');
const AccountKind _$bstocks = const AccountKind._('bstocks');
const AccountKind _$hip3 = const AccountKind._('hip3');
const AccountKind _$unknownDefaultOpenApi =
    const AccountKind._('unknownDefaultOpenApi');

AccountKind _$valueOf(String name) {
  switch (name) {
    case 'app':
      return _$app;
    case 'bstocks':
      return _$bstocks;
    case 'hip3':
      return _$hip3;
    case 'unknownDefaultOpenApi':
      return _$unknownDefaultOpenApi;
    default:
      return _$unknownDefaultOpenApi;
  }
}

final BuiltSet<AccountKind> _$values =
    BuiltSet<AccountKind>(const <AccountKind>[
  _$app,
  _$bstocks,
  _$hip3,
  _$unknownDefaultOpenApi,
]);

class _$AccountKindMeta {
  const _$AccountKindMeta();
  AccountKind get app => _$app;
  AccountKind get bstocks => _$bstocks;
  AccountKind get hip3 => _$hip3;
  AccountKind get unknownDefaultOpenApi => _$unknownDefaultOpenApi;
  AccountKind valueOf(String name) => _$valueOf(name);
  BuiltSet<AccountKind> get values => _$values;
}

abstract class _$AccountKindMixin {
  // ignore: non_constant_identifier_names
  _$AccountKindMeta get AccountKind => const _$AccountKindMeta();
}

Serializer<AccountKind> _$accountKindSerializer = _$AccountKindSerializer();

class _$AccountKindSerializer implements PrimitiveSerializer<AccountKind> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'app': 'app',
    'bstocks': 'bstocks',
    'hip3': 'hip3',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'app': 'app',
    'bstocks': 'bstocks',
    'hip3': 'hip3',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[AccountKind];
  @override
  final String wireName = 'AccountKind';

  @override
  Object serialize(Serializers serializers, AccountKind object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  AccountKind deserialize(Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      AccountKind.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint

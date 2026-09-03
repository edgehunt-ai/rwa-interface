// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_kind.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const ProductKind _$bstock = const ProductKind._('bstock');
const ProductKind _$perp = const ProductKind._('perp');
const ProductKind _$unknownDefaultOpenApi =
    const ProductKind._('unknownDefaultOpenApi');

ProductKind _$valueOf(String name) {
  switch (name) {
    case 'bstock':
      return _$bstock;
    case 'perp':
      return _$perp;
    case 'unknownDefaultOpenApi':
      return _$unknownDefaultOpenApi;
    default:
      return _$unknownDefaultOpenApi;
  }
}

final BuiltSet<ProductKind> _$values =
    BuiltSet<ProductKind>(const <ProductKind>[
  _$bstock,
  _$perp,
  _$unknownDefaultOpenApi,
]);

class _$ProductKindMeta {
  const _$ProductKindMeta();
  ProductKind get bstock => _$bstock;
  ProductKind get perp => _$perp;
  ProductKind get unknownDefaultOpenApi => _$unknownDefaultOpenApi;
  ProductKind valueOf(String name) => _$valueOf(name);
  BuiltSet<ProductKind> get values => _$values;
}

abstract class _$ProductKindMixin {
  // ignore: non_constant_identifier_names
  _$ProductKindMeta get ProductKind => const _$ProductKindMeta();
}

Serializer<ProductKind> _$productKindSerializer = _$ProductKindSerializer();

class _$ProductKindSerializer implements PrimitiveSerializer<ProductKind> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'bstock': 'bstock',
    'perp': 'perp',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'bstock': 'bstock',
    'perp': 'perp',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[ProductKind];
  @override
  final String wireName = 'ProductKind';

  @override
  Object serialize(Serializers serializers, ProductKind object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  ProductKind deserialize(Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      ProductKind.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint

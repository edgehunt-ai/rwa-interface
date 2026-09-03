// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_type.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const ProductType _$all = const ProductType._('all');
const ProductType _$spot = const ProductType._('spot');
const ProductType _$contract = const ProductType._('contract');
const ProductType _$unknownDefaultOpenApi =
    const ProductType._('unknownDefaultOpenApi');

ProductType _$valueOf(String name) {
  switch (name) {
    case 'all':
      return _$all;
    case 'spot':
      return _$spot;
    case 'contract':
      return _$contract;
    case 'unknownDefaultOpenApi':
      return _$unknownDefaultOpenApi;
    default:
      return _$unknownDefaultOpenApi;
  }
}

final BuiltSet<ProductType> _$values =
    BuiltSet<ProductType>(const <ProductType>[
  _$all,
  _$spot,
  _$contract,
  _$unknownDefaultOpenApi,
]);

class _$ProductTypeMeta {
  const _$ProductTypeMeta();
  ProductType get all => _$all;
  ProductType get spot => _$spot;
  ProductType get contract => _$contract;
  ProductType get unknownDefaultOpenApi => _$unknownDefaultOpenApi;
  ProductType valueOf(String name) => _$valueOf(name);
  BuiltSet<ProductType> get values => _$values;
}

abstract class _$ProductTypeMixin {
  // ignore: non_constant_identifier_names
  _$ProductTypeMeta get ProductType => const _$ProductTypeMeta();
}

Serializer<ProductType> _$productTypeSerializer = _$ProductTypeSerializer();

class _$ProductTypeSerializer implements PrimitiveSerializer<ProductType> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'all': 'all',
    'spot': 'spot',
    'contract': 'contract',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'all': 'all',
    'spot': 'spot',
    'contract': 'contract',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[ProductType];
  @override
  final String wireName = 'ProductType';

  @override
  Object serialize(Serializers serializers, ProductType object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  ProductType deserialize(Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      ProductType.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hip3_mainnet_product.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const Hip3MainnetProduct _$xyzColonSP500 =
    const Hip3MainnetProduct._('xyzColonSP500');
const Hip3MainnetProduct _$xyzColonXYZ100 =
    const Hip3MainnetProduct._('xyzColonXYZ100');
const Hip3MainnetProduct _$xyzColonGOLD =
    const Hip3MainnetProduct._('xyzColonGOLD');
const Hip3MainnetProduct _$xyzColonNVDA =
    const Hip3MainnetProduct._('xyzColonNVDA');
const Hip3MainnetProduct _$xyzColonTSLA =
    const Hip3MainnetProduct._('xyzColonTSLA');
const Hip3MainnetProduct _$unknownDefaultOpenApi =
    const Hip3MainnetProduct._('unknownDefaultOpenApi');

Hip3MainnetProduct _$valueOf(String name) {
  switch (name) {
    case 'xyzColonSP500':
      return _$xyzColonSP500;
    case 'xyzColonXYZ100':
      return _$xyzColonXYZ100;
    case 'xyzColonGOLD':
      return _$xyzColonGOLD;
    case 'xyzColonNVDA':
      return _$xyzColonNVDA;
    case 'xyzColonTSLA':
      return _$xyzColonTSLA;
    case 'unknownDefaultOpenApi':
      return _$unknownDefaultOpenApi;
    default:
      return _$unknownDefaultOpenApi;
  }
}

final BuiltSet<Hip3MainnetProduct> _$values =
    BuiltSet<Hip3MainnetProduct>(const <Hip3MainnetProduct>[
  _$xyzColonSP500,
  _$xyzColonXYZ100,
  _$xyzColonGOLD,
  _$xyzColonNVDA,
  _$xyzColonTSLA,
  _$unknownDefaultOpenApi,
]);

class _$Hip3MainnetProductMeta {
  const _$Hip3MainnetProductMeta();
  Hip3MainnetProduct get xyzColonSP500 => _$xyzColonSP500;
  Hip3MainnetProduct get xyzColonXYZ100 => _$xyzColonXYZ100;
  Hip3MainnetProduct get xyzColonGOLD => _$xyzColonGOLD;
  Hip3MainnetProduct get xyzColonNVDA => _$xyzColonNVDA;
  Hip3MainnetProduct get xyzColonTSLA => _$xyzColonTSLA;
  Hip3MainnetProduct get unknownDefaultOpenApi => _$unknownDefaultOpenApi;
  Hip3MainnetProduct valueOf(String name) => _$valueOf(name);
  BuiltSet<Hip3MainnetProduct> get values => _$values;
}

abstract class _$Hip3MainnetProductMixin {
  // ignore: non_constant_identifier_names
  _$Hip3MainnetProductMeta get Hip3MainnetProduct =>
      const _$Hip3MainnetProductMeta();
}

Serializer<Hip3MainnetProduct> _$hip3MainnetProductSerializer =
    _$Hip3MainnetProductSerializer();

class _$Hip3MainnetProductSerializer
    implements PrimitiveSerializer<Hip3MainnetProduct> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'xyzColonSP500': 'xyz:SP500',
    'xyzColonXYZ100': 'xyz:XYZ100',
    'xyzColonGOLD': 'xyz:GOLD',
    'xyzColonNVDA': 'xyz:NVDA',
    'xyzColonTSLA': 'xyz:TSLA',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'xyz:SP500': 'xyzColonSP500',
    'xyz:XYZ100': 'xyzColonXYZ100',
    'xyz:GOLD': 'xyzColonGOLD',
    'xyz:NVDA': 'xyzColonNVDA',
    'xyz:TSLA': 'xyzColonTSLA',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[Hip3MainnetProduct];
  @override
  final String wireName = 'Hip3MainnetProduct';

  @override
  Object serialize(Serializers serializers, Hip3MainnetProduct object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  Hip3MainnetProduct deserialize(Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      Hip3MainnetProduct.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint

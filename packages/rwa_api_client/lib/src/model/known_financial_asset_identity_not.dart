//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'known_financial_asset_identity_not.g.dart';

/// KnownFinancialAssetIdentityNot
///
/// Properties:
/// * [namespace] 
@BuiltValue()
abstract class KnownFinancialAssetIdentityNot implements Built<KnownFinancialAssetIdentityNot, KnownFinancialAssetIdentityNotBuilder> {
  @BuiltValueField(wireName: r'namespace')
  KnownFinancialAssetIdentityNotNamespaceEnum get namespace;
  // enum namespaceEnum {  hyperliquid,  };

  KnownFinancialAssetIdentityNot._();

  factory KnownFinancialAssetIdentityNot([void updates(KnownFinancialAssetIdentityNotBuilder b)]) = _$KnownFinancialAssetIdentityNot;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(KnownFinancialAssetIdentityNotBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<KnownFinancialAssetIdentityNot> get serializer => _$KnownFinancialAssetIdentityNotSerializer();
}

class _$KnownFinancialAssetIdentityNotSerializer implements PrimitiveSerializer<KnownFinancialAssetIdentityNot> {
  @override
  final Iterable<Type> types = const [KnownFinancialAssetIdentityNot, _$KnownFinancialAssetIdentityNot];

  @override
  final String wireName = r'KnownFinancialAssetIdentityNot';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    KnownFinancialAssetIdentityNot object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'namespace';
    yield serializers.serialize(
      object.namespace,
      specifiedType: const FullType(KnownFinancialAssetIdentityNotNamespaceEnum),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    KnownFinancialAssetIdentityNot object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required KnownFinancialAssetIdentityNotBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'namespace':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(KnownFinancialAssetIdentityNotNamespaceEnum),
          ) as KnownFinancialAssetIdentityNotNamespaceEnum;
          result.namespace = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  KnownFinancialAssetIdentityNot deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = KnownFinancialAssetIdentityNotBuilder();
    final serializedList = (serialized as Iterable<Object?>).toList();
    final unhandled = <Object?>[];
    _deserializeProperties(
      serializers,
      serialized,
      specifiedType: specifiedType,
      serializedList: serializedList,
      unhandled: unhandled,
      result: result,
    );
    return result.build();
  }
}

class KnownFinancialAssetIdentityNotNamespaceEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'hyperliquid')
  static const KnownFinancialAssetIdentityNotNamespaceEnum hyperliquid = _$knownFinancialAssetIdentityNotNamespaceEnum_hyperliquid;

  static Serializer<KnownFinancialAssetIdentityNotNamespaceEnum> get serializer => _$knownFinancialAssetIdentityNotNamespaceEnumSerializer;

  const KnownFinancialAssetIdentityNotNamespaceEnum._(String name): super(name);

  static BuiltSet<KnownFinancialAssetIdentityNotNamespaceEnum> get values => _$knownFinancialAssetIdentityNotNamespaceEnumValues;
  static KnownFinancialAssetIdentityNotNamespaceEnum valueOf(String name) => _$knownFinancialAssetIdentityNotNamespaceEnumValueOf(name);
}


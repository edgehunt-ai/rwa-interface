//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'known_financial_asset_identity_not_not.g.dart';

/// KnownFinancialAssetIdentityNotNot
///
/// Properties:
/// * [environment] 
@BuiltValue()
abstract class KnownFinancialAssetIdentityNotNot implements Built<KnownFinancialAssetIdentityNotNot, KnownFinancialAssetIdentityNotNotBuilder> {
  @BuiltValueField(wireName: r'environment')
  KnownFinancialAssetIdentityNotNotEnvironmentEnum get environment;
  // enum environmentEnum {  mainnet,  testnet,  };

  KnownFinancialAssetIdentityNotNot._();

  factory KnownFinancialAssetIdentityNotNot([void updates(KnownFinancialAssetIdentityNotNotBuilder b)]) = _$KnownFinancialAssetIdentityNotNot;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(KnownFinancialAssetIdentityNotNotBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<KnownFinancialAssetIdentityNotNot> get serializer => _$KnownFinancialAssetIdentityNotNotSerializer();
}

class _$KnownFinancialAssetIdentityNotNotSerializer implements PrimitiveSerializer<KnownFinancialAssetIdentityNotNot> {
  @override
  final Iterable<Type> types = const [KnownFinancialAssetIdentityNotNot, _$KnownFinancialAssetIdentityNotNot];

  @override
  final String wireName = r'KnownFinancialAssetIdentityNotNot';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    KnownFinancialAssetIdentityNotNot object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'environment';
    yield serializers.serialize(
      object.environment,
      specifiedType: const FullType(KnownFinancialAssetIdentityNotNotEnvironmentEnum),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    KnownFinancialAssetIdentityNotNot object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required KnownFinancialAssetIdentityNotNotBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'environment':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(KnownFinancialAssetIdentityNotNotEnvironmentEnum),
          ) as KnownFinancialAssetIdentityNotNotEnvironmentEnum;
          result.environment = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  KnownFinancialAssetIdentityNotNot deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = KnownFinancialAssetIdentityNotNotBuilder();
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

class KnownFinancialAssetIdentityNotNotEnvironmentEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'mainnet')
  static const KnownFinancialAssetIdentityNotNotEnvironmentEnum mainnet = _$knownFinancialAssetIdentityNotNotEnvironmentEnum_mainnet;
  @BuiltValueEnumConst(wireName: r'testnet')
  static const KnownFinancialAssetIdentityNotNotEnvironmentEnum testnet = _$knownFinancialAssetIdentityNotNotEnvironmentEnum_testnet;

  static Serializer<KnownFinancialAssetIdentityNotNotEnvironmentEnum> get serializer => _$knownFinancialAssetIdentityNotNotEnvironmentEnumSerializer;

  const KnownFinancialAssetIdentityNotNotEnvironmentEnum._(String name): super(name);

  static BuiltSet<KnownFinancialAssetIdentityNotNotEnvironmentEnum> get values => _$knownFinancialAssetIdentityNotNotEnvironmentEnumValues;
  static KnownFinancialAssetIdentityNotNotEnvironmentEnum valueOf(String name) => _$knownFinancialAssetIdentityNotNotEnvironmentEnumValueOf(name);
}


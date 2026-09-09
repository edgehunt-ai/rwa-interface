//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'hip3_eip712_domain.g.dart';

/// Hip3Eip712Domain
///
/// Properties:
/// * [name] 
/// * [version] 
/// * [chainId] 
/// * [verifyingContract] 
@BuiltValue()
abstract class Hip3Eip712Domain implements Built<Hip3Eip712Domain, Hip3Eip712DomainBuilder> {
  @BuiltValueField(wireName: r'name')
  Hip3Eip712DomainNameEnum get name;
  // enum nameEnum {  Exchange,  };

  @BuiltValueField(wireName: r'version')
  Hip3Eip712DomainVersionEnum get version;
  // enum versionEnum {  1,  };

  @BuiltValueField(wireName: r'chainId')
  Hip3Eip712DomainChainIdEnum get chainId;
  // enum chainIdEnum {  1337,  };

  @BuiltValueField(wireName: r'verifyingContract')
  Hip3Eip712DomainVerifyingContractEnum get verifyingContract;
  // enum verifyingContractEnum {  0x0000000000000000000000000000000000000000,  };

  Hip3Eip712Domain._();

  factory Hip3Eip712Domain([void updates(Hip3Eip712DomainBuilder b)]) = _$Hip3Eip712Domain;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(Hip3Eip712DomainBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<Hip3Eip712Domain> get serializer => _$Hip3Eip712DomainSerializer();
}

class _$Hip3Eip712DomainSerializer implements PrimitiveSerializer<Hip3Eip712Domain> {
  @override
  final Iterable<Type> types = const [Hip3Eip712Domain, _$Hip3Eip712Domain];

  @override
  final String wireName = r'Hip3Eip712Domain';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    Hip3Eip712Domain object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'name';
    yield serializers.serialize(
      object.name,
      specifiedType: const FullType(Hip3Eip712DomainNameEnum),
    );
    yield r'version';
    yield serializers.serialize(
      object.version,
      specifiedType: const FullType(Hip3Eip712DomainVersionEnum),
    );
    yield r'chainId';
    yield serializers.serialize(
      object.chainId,
      specifiedType: const FullType(Hip3Eip712DomainChainIdEnum),
    );
    yield r'verifyingContract';
    yield serializers.serialize(
      object.verifyingContract,
      specifiedType: const FullType(Hip3Eip712DomainVerifyingContractEnum),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    Hip3Eip712Domain object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required Hip3Eip712DomainBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'name':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(Hip3Eip712DomainNameEnum),
          ) as Hip3Eip712DomainNameEnum;
          result.name = valueDes;
          break;
        case r'version':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(Hip3Eip712DomainVersionEnum),
          ) as Hip3Eip712DomainVersionEnum;
          result.version = valueDes;
          break;
        case r'chainId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(Hip3Eip712DomainChainIdEnum),
          ) as Hip3Eip712DomainChainIdEnum;
          result.chainId = valueDes;
          break;
        case r'verifyingContract':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(Hip3Eip712DomainVerifyingContractEnum),
          ) as Hip3Eip712DomainVerifyingContractEnum;
          result.verifyingContract = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  Hip3Eip712Domain deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = Hip3Eip712DomainBuilder();
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

class Hip3Eip712DomainNameEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'Exchange')
  static const Hip3Eip712DomainNameEnum exchange = _$hip3Eip712DomainNameEnum_exchange;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const Hip3Eip712DomainNameEnum unknownDefaultOpenApi = _$hip3Eip712DomainNameEnum_unknownDefaultOpenApi;

  static Serializer<Hip3Eip712DomainNameEnum> get serializer => _$hip3Eip712DomainNameEnumSerializer;

  const Hip3Eip712DomainNameEnum._(String name): super(name);

  static BuiltSet<Hip3Eip712DomainNameEnum> get values => _$hip3Eip712DomainNameEnumValues;
  static Hip3Eip712DomainNameEnum valueOf(String name) => _$hip3Eip712DomainNameEnumValueOf(name);
}

class Hip3Eip712DomainVersionEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'1')
  static const Hip3Eip712DomainVersionEnum n1 = _$hip3Eip712DomainVersionEnum_n1;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const Hip3Eip712DomainVersionEnum unknownDefaultOpenApi = _$hip3Eip712DomainVersionEnum_unknownDefaultOpenApi;

  static Serializer<Hip3Eip712DomainVersionEnum> get serializer => _$hip3Eip712DomainVersionEnumSerializer;

  const Hip3Eip712DomainVersionEnum._(String name): super(name);

  static BuiltSet<Hip3Eip712DomainVersionEnum> get values => _$hip3Eip712DomainVersionEnumValues;
  static Hip3Eip712DomainVersionEnum valueOf(String name) => _$hip3Eip712DomainVersionEnumValueOf(name);
}

class Hip3Eip712DomainChainIdEnum extends EnumClass {

  @BuiltValueEnumConst(wireNumber: 1337)
  static const Hip3Eip712DomainChainIdEnum number1337 = _$hip3Eip712DomainChainIdEnum_number1337;
  @BuiltValueEnumConst(wireNumber: 11184809, fallback: true)
  static const Hip3Eip712DomainChainIdEnum unknownDefaultOpenApi = _$hip3Eip712DomainChainIdEnum_unknownDefaultOpenApi;

  static Serializer<Hip3Eip712DomainChainIdEnum> get serializer => _$hip3Eip712DomainChainIdEnumSerializer;

  const Hip3Eip712DomainChainIdEnum._(String name): super(name);

  static BuiltSet<Hip3Eip712DomainChainIdEnum> get values => _$hip3Eip712DomainChainIdEnumValues;
  static Hip3Eip712DomainChainIdEnum valueOf(String name) => _$hip3Eip712DomainChainIdEnumValueOf(name);
}

class Hip3Eip712DomainVerifyingContractEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'0x0000000000000000000000000000000000000000')
  static const Hip3Eip712DomainVerifyingContractEnum n0x0000000000000000000000000000000000000000 = _$hip3Eip712DomainVerifyingContractEnum_n0x0000000000000000000000000000000000000000;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const Hip3Eip712DomainVerifyingContractEnum unknownDefaultOpenApi = _$hip3Eip712DomainVerifyingContractEnum_unknownDefaultOpenApi;

  static Serializer<Hip3Eip712DomainVerifyingContractEnum> get serializer => _$hip3Eip712DomainVerifyingContractEnumSerializer;

  const Hip3Eip712DomainVerifyingContractEnum._(String name): super(name);

  static BuiltSet<Hip3Eip712DomainVerifyingContractEnum> get values => _$hip3Eip712DomainVerifyingContractEnumValues;
  static Hip3Eip712DomainVerifyingContractEnum valueOf(String name) => _$hip3Eip712DomainVerifyingContractEnumValueOf(name);
}


//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:rwa_api_client/src/model/deposit_rail_availability.dart';
import 'package:built_collection/built_collection.dart';
import 'package:rwa_api_client/src/model/arbitrum_deposit_rail.dart';
import 'package:rwa_api_client/src/model/bsc_deposit_rail.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:one_of/one_of.dart';

part 'deposit_rail.g.dart';

/// 用户钱包直入的只读观察 rail；网络、chain ID、Token 合约、decimals 和确认数必须成组匹配。
///
/// Properties:
/// * [chain] 
/// * [chainId] 
/// * [token] 
/// * [tokenContract] 
/// * [tokenDecimals] 
/// * [minimumAmount] - 必须大于零；服务端按精确十进制语义校验。
/// * [confirmationsRequired] 
/// * [availability] 
@BuiltValue()
abstract class DepositRail implements Built<DepositRail, DepositRailBuilder> {
  /// One Of [ArbitrumDepositRail], [BscDepositRail]
  OneOf get oneOf;

  static const String discriminatorFieldName = r'chain';

  static const Map<String, Type> discriminatorMapping = {
    r'Arbitrum': ArbitrumDepositRail,
    r'BSC': BscDepositRail,
  };

  DepositRail._();

  factory DepositRail([void updates(DepositRailBuilder b)]) = _$DepositRail;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(DepositRailBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<DepositRail> get serializer => _$DepositRailSerializer();
}

extension DepositRailDiscriminatorExt on DepositRail {
    String? get discriminatorValue {
        if (this is ArbitrumDepositRail) {
            return r'Arbitrum';
        }
        if (this is BscDepositRail) {
            return r'BSC';
        }
        return null;
    }
}
extension DepositRailBuilderDiscriminatorExt on DepositRailBuilder {
    String? get discriminatorValue {
        if (this is ArbitrumDepositRailBuilder) {
            return r'Arbitrum';
        }
        if (this is BscDepositRailBuilder) {
            return r'BSC';
        }
        return null;
    }
}

class _$DepositRailSerializer implements PrimitiveSerializer<DepositRail> {
  @override
  final Iterable<Type> types = const [DepositRail, _$DepositRail];

  @override
  final String wireName = r'DepositRail';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    DepositRail object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
  }

  @override
  Object serialize(
    Serializers serializers,
    DepositRail object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final oneOf = object.oneOf;
    return serializers.serialize(oneOf.value, specifiedType: FullType(oneOf.valueType))!;
  }

  @override
  DepositRail deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = DepositRailBuilder();
    Object? oneOfDataSrc;
    final serializedList = (serialized as Iterable<Object?>).toList();
    final discIndex = serializedList.indexOf(DepositRail.discriminatorFieldName) + 1;
    final discValue = serializers.deserialize(serializedList[discIndex], specifiedType: FullType(String)) as String;
    oneOfDataSrc = serialized;
    final oneOfTypes = [ArbitrumDepositRail, BscDepositRail, ];
    Object oneOfResult;
    Type oneOfType;
    switch (discValue) {
      case r'Arbitrum':
        oneOfResult = serializers.deserialize(
          oneOfDataSrc,
          specifiedType: FullType(ArbitrumDepositRail),
        ) as ArbitrumDepositRail;
        oneOfType = ArbitrumDepositRail;
        break;
      case r'BSC':
        oneOfResult = serializers.deserialize(
          oneOfDataSrc,
          specifiedType: FullType(BscDepositRail),
        ) as BscDepositRail;
        oneOfType = BscDepositRail;
        break;
      default:
        throw UnsupportedError("Couldn't deserialize oneOf for the discriminator value: ${discValue}");
    }
    result.oneOf = OneOfDynamic(typeIndex: oneOfTypes.indexOf(oneOfType), types: oneOfTypes, value: oneOfResult);
    return result.build();
  }
}

class DepositRailChainEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'Arbitrum')
  static const DepositRailChainEnum arbitrum = _$depositRailChainEnum_arbitrum;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const DepositRailChainEnum unknownDefaultOpenApi = _$depositRailChainEnum_unknownDefaultOpenApi;

  static Serializer<DepositRailChainEnum> get serializer => _$depositRailChainEnumSerializer;

  const DepositRailChainEnum._(String name): super(name);

  static BuiltSet<DepositRailChainEnum> get values => _$depositRailChainEnumValues;
  static DepositRailChainEnum valueOf(String name) => _$depositRailChainEnumValueOf(name);
}

class DepositRailChainIdEnum extends EnumClass {

  @BuiltValueEnumConst(wireNumber: 42161)
  static const DepositRailChainIdEnum number42161 = _$depositRailChainIdEnum_number42161;
  @BuiltValueEnumConst(wireNumber: 11184809, fallback: true)
  static const DepositRailChainIdEnum unknownDefaultOpenApi = _$depositRailChainIdEnum_unknownDefaultOpenApi;

  static Serializer<DepositRailChainIdEnum> get serializer => _$depositRailChainIdEnumSerializer;

  const DepositRailChainIdEnum._(String name): super(name);

  static BuiltSet<DepositRailChainIdEnum> get values => _$depositRailChainIdEnumValues;
  static DepositRailChainIdEnum valueOf(String name) => _$depositRailChainIdEnumValueOf(name);
}

class DepositRailTokenEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'USDC')
  static const DepositRailTokenEnum USDC = _$depositRailTokenEnum_USDC;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const DepositRailTokenEnum unknownDefaultOpenApi = _$depositRailTokenEnum_unknownDefaultOpenApi;

  static Serializer<DepositRailTokenEnum> get serializer => _$depositRailTokenEnumSerializer;

  const DepositRailTokenEnum._(String name): super(name);

  static BuiltSet<DepositRailTokenEnum> get values => _$depositRailTokenEnumValues;
  static DepositRailTokenEnum valueOf(String name) => _$depositRailTokenEnumValueOf(name);
}

class DepositRailTokenContractEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'0xaf88d065e77c8cc2239327c5edb3a432268e5831')
  static const DepositRailTokenContractEnum n0xaf88d065e77c8cc2239327c5edb3a432268e5831 = _$depositRailTokenContractEnum_n0xaf88d065e77c8cc2239327c5edb3a432268e5831;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const DepositRailTokenContractEnum unknownDefaultOpenApi = _$depositRailTokenContractEnum_unknownDefaultOpenApi;

  static Serializer<DepositRailTokenContractEnum> get serializer => _$depositRailTokenContractEnumSerializer;

  const DepositRailTokenContractEnum._(String name): super(name);

  static BuiltSet<DepositRailTokenContractEnum> get values => _$depositRailTokenContractEnumValues;
  static DepositRailTokenContractEnum valueOf(String name) => _$depositRailTokenContractEnumValueOf(name);
}

class DepositRailTokenDecimalsEnum extends EnumClass {

  @BuiltValueEnumConst(wireNumber: 6)
  static const DepositRailTokenDecimalsEnum number6 = _$depositRailTokenDecimalsEnum_number6;
  @BuiltValueEnumConst(wireNumber: 11184809, fallback: true)
  static const DepositRailTokenDecimalsEnum unknownDefaultOpenApi = _$depositRailTokenDecimalsEnum_unknownDefaultOpenApi;

  static Serializer<DepositRailTokenDecimalsEnum> get serializer => _$depositRailTokenDecimalsEnumSerializer;

  const DepositRailTokenDecimalsEnum._(String name): super(name);

  static BuiltSet<DepositRailTokenDecimalsEnum> get values => _$depositRailTokenDecimalsEnumValues;
  static DepositRailTokenDecimalsEnum valueOf(String name) => _$depositRailTokenDecimalsEnumValueOf(name);
}

class DepositRailConfirmationsRequiredEnum extends EnumClass {

  @BuiltValueEnumConst(wireNumber: 20)
  static const DepositRailConfirmationsRequiredEnum number20 = _$depositRailConfirmationsRequiredEnum_number20;
  @BuiltValueEnumConst(wireNumber: 11184809, fallback: true)
  static const DepositRailConfirmationsRequiredEnum unknownDefaultOpenApi = _$depositRailConfirmationsRequiredEnum_unknownDefaultOpenApi;

  static Serializer<DepositRailConfirmationsRequiredEnum> get serializer => _$depositRailConfirmationsRequiredEnumSerializer;

  const DepositRailConfirmationsRequiredEnum._(String name): super(name);

  static BuiltSet<DepositRailConfirmationsRequiredEnum> get values => _$depositRailConfirmationsRequiredEnumValues;
  static DepositRailConfirmationsRequiredEnum valueOf(String name) => _$depositRailConfirmationsRequiredEnumValueOf(name);
}


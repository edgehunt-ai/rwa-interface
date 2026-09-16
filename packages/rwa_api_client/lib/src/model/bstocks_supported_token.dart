//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'bstocks_supported_token.g.dart';

/// BstocksSupportedToken
///
/// Properties:
/// * [symbol] 
/// * [underlyingSymbol] 
/// * [contractAddress] 
/// * [feedSymbol] 
/// * [asset] 
/// * [decimals] 
/// * [multiplier] 
/// * [lastUpdateTime] 
/// * [assetType] 
/// * [displayEnabled] 
/// * [executionStatus] 
/// * [executionEnabled] 
@BuiltValue()
abstract class BstocksSupportedToken implements Built<BstocksSupportedToken, BstocksSupportedTokenBuilder> {
  @BuiltValueField(wireName: r'symbol')
  String get symbol;

  @BuiltValueField(wireName: r'underlying_symbol')
  String? get underlyingSymbol;

  @BuiltValueField(wireName: r'contract_address')
  String get contractAddress;

  @BuiltValueField(wireName: r'feed_symbol')
  String? get feedSymbol;

  @BuiltValueField(wireName: r'asset')
  String? get asset;

  @BuiltValueField(wireName: r'decimals')
  int get decimals;

  @BuiltValueField(wireName: r'multiplier')
  String? get multiplier;

  @BuiltValueField(wireName: r'last_update_time')
  int? get lastUpdateTime;

  @BuiltValueField(wireName: r'asset_type')
  int? get assetType;

  @BuiltValueField(wireName: r'display_enabled')
  bool get displayEnabled;

  @BuiltValueField(wireName: r'execution_status')
  BstocksSupportedTokenExecutionStatusEnum get executionStatus;
  // enum executionStatusEnum {  discovery_only,  admitted,  };

  @BuiltValueField(wireName: r'execution_enabled')
  bool get executionEnabled;

  BstocksSupportedToken._();

  factory BstocksSupportedToken([void updates(BstocksSupportedTokenBuilder b)]) = _$BstocksSupportedToken;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(BstocksSupportedTokenBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<BstocksSupportedToken> get serializer => _$BstocksSupportedTokenSerializer();
}

class _$BstocksSupportedTokenSerializer implements PrimitiveSerializer<BstocksSupportedToken> {
  @override
  final Iterable<Type> types = const [BstocksSupportedToken, _$BstocksSupportedToken];

  @override
  final String wireName = r'BstocksSupportedToken';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    BstocksSupportedToken object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'symbol';
    yield serializers.serialize(
      object.symbol,
      specifiedType: const FullType(String),
    );
    if (object.underlyingSymbol != null) {
      yield r'underlying_symbol';
      yield serializers.serialize(
        object.underlyingSymbol,
        specifiedType: const FullType.nullable(String),
      );
    }
    yield r'contract_address';
    yield serializers.serialize(
      object.contractAddress,
      specifiedType: const FullType(String),
    );
    if (object.feedSymbol != null) {
      yield r'feed_symbol';
      yield serializers.serialize(
        object.feedSymbol,
        specifiedType: const FullType.nullable(String),
      );
    }
    if (object.asset != null) {
      yield r'asset';
      yield serializers.serialize(
        object.asset,
        specifiedType: const FullType.nullable(String),
      );
    }
    yield r'decimals';
    yield serializers.serialize(
      object.decimals,
      specifiedType: const FullType(int),
    );
    if (object.multiplier != null) {
      yield r'multiplier';
      yield serializers.serialize(
        object.multiplier,
        specifiedType: const FullType.nullable(String),
      );
    }
    if (object.lastUpdateTime != null) {
      yield r'last_update_time';
      yield serializers.serialize(
        object.lastUpdateTime,
        specifiedType: const FullType.nullable(int),
      );
    }
    if (object.assetType != null) {
      yield r'asset_type';
      yield serializers.serialize(
        object.assetType,
        specifiedType: const FullType.nullable(int),
      );
    }
    yield r'display_enabled';
    yield serializers.serialize(
      object.displayEnabled,
      specifiedType: const FullType(bool),
    );
    yield r'execution_status';
    yield serializers.serialize(
      object.executionStatus,
      specifiedType: const FullType(BstocksSupportedTokenExecutionStatusEnum),
    );
    yield r'execution_enabled';
    yield serializers.serialize(
      object.executionEnabled,
      specifiedType: const FullType(bool),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    BstocksSupportedToken object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required BstocksSupportedTokenBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'symbol':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.symbol = valueDes;
          break;
        case r'underlying_symbol':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.underlyingSymbol = valueDes;
          break;
        case r'contract_address':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.contractAddress = valueDes;
          break;
        case r'feed_symbol':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.feedSymbol = valueDes;
          break;
        case r'asset':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.asset = valueDes;
          break;
        case r'decimals':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.decimals = valueDes;
          break;
        case r'multiplier':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.multiplier = valueDes;
          break;
        case r'last_update_time':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(int),
          ) as int?;
          if (valueDes == null) continue;
          result.lastUpdateTime = valueDes;
          break;
        case r'asset_type':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(int),
          ) as int?;
          if (valueDes == null) continue;
          result.assetType = valueDes;
          break;
        case r'display_enabled':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.displayEnabled = valueDes;
          break;
        case r'execution_status':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BstocksSupportedTokenExecutionStatusEnum),
          ) as BstocksSupportedTokenExecutionStatusEnum;
          result.executionStatus = valueDes;
          break;
        case r'execution_enabled':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.executionEnabled = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  BstocksSupportedToken deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = BstocksSupportedTokenBuilder();
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

class BstocksSupportedTokenExecutionStatusEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'discovery_only')
  static const BstocksSupportedTokenExecutionStatusEnum discoveryOnly = _$bstocksSupportedTokenExecutionStatusEnum_discoveryOnly;
  @BuiltValueEnumConst(wireName: r'admitted')
  static const BstocksSupportedTokenExecutionStatusEnum admitted = _$bstocksSupportedTokenExecutionStatusEnum_admitted;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const BstocksSupportedTokenExecutionStatusEnum unknownDefaultOpenApi = _$bstocksSupportedTokenExecutionStatusEnum_unknownDefaultOpenApi;

  static Serializer<BstocksSupportedTokenExecutionStatusEnum> get serializer => _$bstocksSupportedTokenExecutionStatusEnumSerializer;

  const BstocksSupportedTokenExecutionStatusEnum._(String name): super(name);

  static BuiltSet<BstocksSupportedTokenExecutionStatusEnum> get values => _$bstocksSupportedTokenExecutionStatusEnumValues;
  static BstocksSupportedTokenExecutionStatusEnum valueOf(String name) => _$bstocksSupportedTokenExecutionStatusEnumValueOf(name);
}


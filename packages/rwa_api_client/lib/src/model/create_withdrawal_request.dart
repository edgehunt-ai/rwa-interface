//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:rwa_api_client/src/model/chain.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'create_withdrawal_request.g.dart';

/// CreateWithdrawalRequest
///
/// Properties:
/// * [asset] 
/// * [chain] 
/// * [amount] - 十进制字符串，避免浮点误差
/// * [address] 
/// * [authorizationId] - 已授权且尚未消费的钱包操作授权 ID
/// * [memo] 
/// * [quoteId] 
/// * [saveAddress] 
/// * [addressLabel] 
@BuiltValue()
abstract class CreateWithdrawalRequest implements Built<CreateWithdrawalRequest, CreateWithdrawalRequestBuilder> {
  @BuiltValueField(wireName: r'asset')
  CreateWithdrawalRequestAssetEnum get asset;
  // enum assetEnum {  USDC,  };

  @BuiltValueField(wireName: r'chain')
  Chain get chain;
  // enum chainEnum {  BSC,  Arbitrum,  Base,  Ethereum,  Hyperliquid,  Polygon,  Solana,  };

  /// 十进制字符串，避免浮点误差
  @BuiltValueField(wireName: r'amount')
  String get amount;

  @BuiltValueField(wireName: r'address')
  String get address;

  /// 已授权且尚未消费的钱包操作授权 ID
  @BuiltValueField(wireName: r'authorization_id')
  String get authorizationId;

  @BuiltValueField(wireName: r'memo')
  String? get memo;

  @BuiltValueField(wireName: r'quote_id')
  String? get quoteId;

  @BuiltValueField(wireName: r'save_address')
  bool? get saveAddress;

  @BuiltValueField(wireName: r'address_label')
  String? get addressLabel;

  CreateWithdrawalRequest._();

  factory CreateWithdrawalRequest([void updates(CreateWithdrawalRequestBuilder b)]) = _$CreateWithdrawalRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(CreateWithdrawalRequestBuilder b) => b
      ..saveAddress = false;

  @BuiltValueSerializer(custom: true)
  static Serializer<CreateWithdrawalRequest> get serializer => _$CreateWithdrawalRequestSerializer();
}

class _$CreateWithdrawalRequestSerializer implements PrimitiveSerializer<CreateWithdrawalRequest> {
  @override
  final Iterable<Type> types = const [CreateWithdrawalRequest, _$CreateWithdrawalRequest];

  @override
  final String wireName = r'CreateWithdrawalRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    CreateWithdrawalRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'asset';
    yield serializers.serialize(
      object.asset,
      specifiedType: const FullType(CreateWithdrawalRequestAssetEnum),
    );
    yield r'chain';
    yield serializers.serialize(
      object.chain,
      specifiedType: const FullType(Chain),
    );
    yield r'amount';
    yield serializers.serialize(
      object.amount,
      specifiedType: const FullType(String),
    );
    yield r'address';
    yield serializers.serialize(
      object.address,
      specifiedType: const FullType(String),
    );
    yield r'authorization_id';
    yield serializers.serialize(
      object.authorizationId,
      specifiedType: const FullType(String),
    );
    if (object.memo != null) {
      yield r'memo';
      yield serializers.serialize(
        object.memo,
        specifiedType: const FullType.nullable(String),
      );
    }
    if (object.quoteId != null) {
      yield r'quote_id';
      yield serializers.serialize(
        object.quoteId,
        specifiedType: const FullType.nullable(String),
      );
    }
    if (object.saveAddress != null) {
      yield r'save_address';
      yield serializers.serialize(
        object.saveAddress,
        specifiedType: const FullType(bool),
      );
    }
    if (object.addressLabel != null) {
      yield r'address_label';
      yield serializers.serialize(
        object.addressLabel,
        specifiedType: const FullType.nullable(String),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    CreateWithdrawalRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required CreateWithdrawalRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'asset':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(CreateWithdrawalRequestAssetEnum),
          ) as CreateWithdrawalRequestAssetEnum;
          result.asset = valueDes;
          break;
        case r'chain':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(Chain),
          ) as Chain;
          result.chain = valueDes;
          break;
        case r'amount':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.amount = valueDes;
          break;
        case r'address':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.address = valueDes;
          break;
        case r'authorization_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.authorizationId = valueDes;
          break;
        case r'memo':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.memo = valueDes;
          break;
        case r'quote_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.quoteId = valueDes;
          break;
        case r'save_address':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(bool),
          ) as bool?;
          if (valueDes == null) continue;
          result.saveAddress = valueDes;
          break;
        case r'address_label':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.addressLabel = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  CreateWithdrawalRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = CreateWithdrawalRequestBuilder();
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

class CreateWithdrawalRequestAssetEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'USDC')
  static const CreateWithdrawalRequestAssetEnum USDC = _$createWithdrawalRequestAssetEnum_USDC;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const CreateWithdrawalRequestAssetEnum unknownDefaultOpenApi = _$createWithdrawalRequestAssetEnum_unknownDefaultOpenApi;

  static Serializer<CreateWithdrawalRequestAssetEnum> get serializer => _$createWithdrawalRequestAssetEnumSerializer;

  const CreateWithdrawalRequestAssetEnum._(String name): super(name);

  static BuiltSet<CreateWithdrawalRequestAssetEnum> get values => _$createWithdrawalRequestAssetEnumValues;
  static CreateWithdrawalRequestAssetEnum valueOf(String name) => _$createWithdrawalRequestAssetEnumValueOf(name);
}


//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'wallet_authorization_request.g.dart';

/// WalletAuthorizationRequest
///
/// Properties:
/// * [purpose]
/// * [asset]
/// * [amount] - For transfer authorization this is the frozen source maximum input, not the target shortfall.
/// * [resourceId] - 绑定的服务端资源 ID；order=preview/order，transfer=funding plan，withdrawal=quote，claim=transfer。 Transfer 授权只能消费同账户、未过期且 source/amount 完全匹配的 frozen plan。
@BuiltValue()
abstract class WalletAuthorizationRequest
    implements
        Built<WalletAuthorizationRequest, WalletAuthorizationRequestBuilder> {
  @BuiltValueField(wireName: r'purpose')
  WalletAuthorizationRequestPurposeEnum get purpose;
  // enum purposeEnum {  order,  transfer,  withdrawal,  claim,  };

  @BuiltValueField(wireName: r'asset')
  String get asset;

  /// For transfer authorization this is the frozen source maximum input, not the target shortfall.
  @BuiltValueField(wireName: r'amount')
  String get amount;

  /// 绑定的服务端资源 ID；order=preview/order，transfer=funding plan，withdrawal=quote，claim=transfer。 Transfer 授权只能消费同账户、未过期且 source/amount 完全匹配的 frozen plan。
  @BuiltValueField(wireName: r'resource_id')
  String get resourceId;

  WalletAuthorizationRequest._();

  factory WalletAuthorizationRequest(
          [void updates(WalletAuthorizationRequestBuilder b)]) =
      _$WalletAuthorizationRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(WalletAuthorizationRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<WalletAuthorizationRequest> get serializer =>
      _$WalletAuthorizationRequestSerializer();
}

class _$WalletAuthorizationRequestSerializer
    implements PrimitiveSerializer<WalletAuthorizationRequest> {
  @override
  final Iterable<Type> types = const [
    WalletAuthorizationRequest,
    _$WalletAuthorizationRequest
  ];

  @override
  final String wireName = r'WalletAuthorizationRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    WalletAuthorizationRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'purpose';
    yield serializers.serialize(
      object.purpose,
      specifiedType: const FullType(WalletAuthorizationRequestPurposeEnum),
    );
    yield r'asset';
    yield serializers.serialize(
      object.asset,
      specifiedType: const FullType(String),
    );
    yield r'amount';
    yield serializers.serialize(
      object.amount,
      specifiedType: const FullType(String),
    );
    yield r'resource_id';
    yield serializers.serialize(
      object.resourceId,
      specifiedType: const FullType(String),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    WalletAuthorizationRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object,
            specifiedType: specifiedType)
        .toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required WalletAuthorizationRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'purpose':
          final valueDes = serializers.deserialize(
            value,
            specifiedType:
                const FullType(WalletAuthorizationRequestPurposeEnum),
          ) as WalletAuthorizationRequestPurposeEnum;
          result.purpose = valueDes;
          break;
        case r'asset':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.asset = valueDes;
          break;
        case r'amount':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.amount = valueDes;
          break;
        case r'resource_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.resourceId = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  WalletAuthorizationRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = WalletAuthorizationRequestBuilder();
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

class WalletAuthorizationRequestPurposeEnum extends EnumClass {
  @BuiltValueEnumConst(wireName: r'order')
  static const WalletAuthorizationRequestPurposeEnum order =
      _$walletAuthorizationRequestPurposeEnum_order;
  @BuiltValueEnumConst(wireName: r'transfer')
  static const WalletAuthorizationRequestPurposeEnum transfer =
      _$walletAuthorizationRequestPurposeEnum_transfer;
  @BuiltValueEnumConst(wireName: r'withdrawal')
  static const WalletAuthorizationRequestPurposeEnum withdrawal =
      _$walletAuthorizationRequestPurposeEnum_withdrawal;
  @BuiltValueEnumConst(wireName: r'claim')
  static const WalletAuthorizationRequestPurposeEnum claim =
      _$walletAuthorizationRequestPurposeEnum_claim;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const WalletAuthorizationRequestPurposeEnum unknownDefaultOpenApi =
      _$walletAuthorizationRequestPurposeEnum_unknownDefaultOpenApi;

  static Serializer<WalletAuthorizationRequestPurposeEnum> get serializer =>
      _$walletAuthorizationRequestPurposeEnumSerializer;

  const WalletAuthorizationRequestPurposeEnum._(String name) : super(name);

  static BuiltSet<WalletAuthorizationRequestPurposeEnum> get values =>
      _$walletAuthorizationRequestPurposeEnumValues;
  static WalletAuthorizationRequestPurposeEnum valueOf(String name) =>
      _$walletAuthorizationRequestPurposeEnumValueOf(name);
}

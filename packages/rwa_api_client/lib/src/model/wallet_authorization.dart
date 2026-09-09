//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'wallet_authorization.g.dart';

/// WalletAuthorization
///
/// Properties:
/// * [authorizationId]
/// * [walletId]
/// * [purpose]
/// * [status]
/// * [createdAt]
/// * [expiresAt]
@BuiltValue()
abstract class WalletAuthorization
    implements Built<WalletAuthorization, WalletAuthorizationBuilder> {
  @BuiltValueField(wireName: r'authorization_id')
  String get authorizationId;

  @BuiltValueField(wireName: r'wallet_id')
  String get walletId;

  @BuiltValueField(wireName: r'purpose')
  WalletAuthorizationPurposeEnum get purpose;
  // enum purposeEnum {  order,  transfer,  withdrawal,  claim,  };

  @BuiltValueField(wireName: r'status')
  WalletAuthorizationStatusEnum get status;
  // enum statusEnum {  pending,  authorized,  consumed,  expired,  failed,  };

  @BuiltValueField(wireName: r'created_at')
  DateTime get createdAt;

  @BuiltValueField(wireName: r'expires_at')
  DateTime get expiresAt;

  WalletAuthorization._();

  factory WalletAuthorization([void updates(WalletAuthorizationBuilder b)]) =
      _$WalletAuthorization;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(WalletAuthorizationBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<WalletAuthorization> get serializer =>
      _$WalletAuthorizationSerializer();
}

class _$WalletAuthorizationSerializer
    implements PrimitiveSerializer<WalletAuthorization> {
  @override
  final Iterable<Type> types = const [
    WalletAuthorization,
    _$WalletAuthorization
  ];

  @override
  final String wireName = r'WalletAuthorization';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    WalletAuthorization object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'authorization_id';
    yield serializers.serialize(
      object.authorizationId,
      specifiedType: const FullType(String),
    );
    yield r'wallet_id';
    yield serializers.serialize(
      object.walletId,
      specifiedType: const FullType(String),
    );
    yield r'purpose';
    yield serializers.serialize(
      object.purpose,
      specifiedType: const FullType(WalletAuthorizationPurposeEnum),
    );
    yield r'status';
    yield serializers.serialize(
      object.status,
      specifiedType: const FullType(WalletAuthorizationStatusEnum),
    );
    yield r'created_at';
    yield serializers.serialize(
      object.createdAt,
      specifiedType: const FullType(DateTime),
    );
    yield r'expires_at';
    yield serializers.serialize(
      object.expiresAt,
      specifiedType: const FullType(DateTime),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    WalletAuthorization object, {
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
    required WalletAuthorizationBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'authorization_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.authorizationId = valueDes;
          break;
        case r'wallet_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.walletId = valueDes;
          break;
        case r'purpose':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(WalletAuthorizationPurposeEnum),
          ) as WalletAuthorizationPurposeEnum;
          result.purpose = valueDes;
          break;
        case r'status':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(WalletAuthorizationStatusEnum),
          ) as WalletAuthorizationStatusEnum;
          result.status = valueDes;
          break;
        case r'created_at':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DateTime),
          ) as DateTime;
          result.createdAt = valueDes;
          break;
        case r'expires_at':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DateTime),
          ) as DateTime;
          result.expiresAt = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  WalletAuthorization deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = WalletAuthorizationBuilder();
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

class WalletAuthorizationPurposeEnum extends EnumClass {
  @BuiltValueEnumConst(wireName: r'order')
  static const WalletAuthorizationPurposeEnum order =
      _$walletAuthorizationPurposeEnum_order;
  @BuiltValueEnumConst(wireName: r'transfer')
  static const WalletAuthorizationPurposeEnum transfer =
      _$walletAuthorizationPurposeEnum_transfer;
  @BuiltValueEnumConst(wireName: r'withdrawal')
  static const WalletAuthorizationPurposeEnum withdrawal =
      _$walletAuthorizationPurposeEnum_withdrawal;
  @BuiltValueEnumConst(wireName: r'claim')
  static const WalletAuthorizationPurposeEnum claim =
      _$walletAuthorizationPurposeEnum_claim;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const WalletAuthorizationPurposeEnum unknownDefaultOpenApi =
      _$walletAuthorizationPurposeEnum_unknownDefaultOpenApi;

  static Serializer<WalletAuthorizationPurposeEnum> get serializer =>
      _$walletAuthorizationPurposeEnumSerializer;

  const WalletAuthorizationPurposeEnum._(String name) : super(name);

  static BuiltSet<WalletAuthorizationPurposeEnum> get values =>
      _$walletAuthorizationPurposeEnumValues;
  static WalletAuthorizationPurposeEnum valueOf(String name) =>
      _$walletAuthorizationPurposeEnumValueOf(name);
}

class WalletAuthorizationStatusEnum extends EnumClass {
  @BuiltValueEnumConst(wireName: r'pending')
  static const WalletAuthorizationStatusEnum pending =
      _$walletAuthorizationStatusEnum_pending;
  @BuiltValueEnumConst(wireName: r'authorized')
  static const WalletAuthorizationStatusEnum authorized =
      _$walletAuthorizationStatusEnum_authorized;
  @BuiltValueEnumConst(wireName: r'consumed')
  static const WalletAuthorizationStatusEnum consumed =
      _$walletAuthorizationStatusEnum_consumed;
  @BuiltValueEnumConst(wireName: r'expired')
  static const WalletAuthorizationStatusEnum expired =
      _$walletAuthorizationStatusEnum_expired;
  @BuiltValueEnumConst(wireName: r'failed')
  static const WalletAuthorizationStatusEnum failed =
      _$walletAuthorizationStatusEnum_failed;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const WalletAuthorizationStatusEnum unknownDefaultOpenApi =
      _$walletAuthorizationStatusEnum_unknownDefaultOpenApi;

  static Serializer<WalletAuthorizationStatusEnum> get serializer =>
      _$walletAuthorizationStatusEnumSerializer;

  const WalletAuthorizationStatusEnum._(String name) : super(name);

  static BuiltSet<WalletAuthorizationStatusEnum> get values =>
      _$walletAuthorizationStatusEnumValues;
  static WalletAuthorizationStatusEnum valueOf(String name) =>
      _$walletAuthorizationStatusEnumValueOf(name);
}

//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:rwa_api_client/src/model/account_kind.dart';
import 'package:rwa_api_client/src/model/chain.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'deposit_address.g.dart';

/// DepositAddress
///
/// Properties:
/// * [chain] 
/// * [token] 
/// * [address] 
/// * [memo] 
/// * [qrPayload] 
/// * [minDeposit] - 十进制字符串，避免浮点误差
/// * [confirmationsRequired] 
/// * [creditedTo] 
/// * [warning] 
@Deprecated('DepositAddress has been deprecated')
@BuiltValue()
abstract class DepositAddress implements Built<DepositAddress, DepositAddressBuilder> {
  @BuiltValueField(wireName: r'chain')
  Chain get chain;
  // enum chainEnum {  BSC,  Arbitrum,  Base,  Ethereum,  Hyperliquid,  Polygon,  Solana,  };

  @BuiltValueField(wireName: r'token')
  DepositAddressTokenEnum get token;
  // enum tokenEnum {  USDC,  };

  @BuiltValueField(wireName: r'address')
  String get address;

  @BuiltValueField(wireName: r'memo')
  String? get memo;

  @BuiltValueField(wireName: r'qr_payload')
  String? get qrPayload;

  /// 十进制字符串，避免浮点误差
  @BuiltValueField(wireName: r'min_deposit')
  String? get minDeposit;

  @BuiltValueField(wireName: r'confirmations_required')
  int? get confirmationsRequired;

  @BuiltValueField(wireName: r'credited_to')
  AccountKind? get creditedTo;
  // enum creditedToEnum {  app,  bstocks,  hip3,  };

  @BuiltValueField(wireName: r'warning')
  String? get warning;

  DepositAddress._();

  factory DepositAddress([void updates(DepositAddressBuilder b)]) = _$DepositAddress;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(DepositAddressBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<DepositAddress> get serializer => _$DepositAddressSerializer();
}

class _$DepositAddressSerializer implements PrimitiveSerializer<DepositAddress> {
  @override
  final Iterable<Type> types = const [DepositAddress, _$DepositAddress];

  @override
  final String wireName = r'DepositAddress';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    DepositAddress object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'chain';
    yield serializers.serialize(
      object.chain,
      specifiedType: const FullType(Chain),
    );
    yield r'token';
    yield serializers.serialize(
      object.token,
      specifiedType: const FullType(DepositAddressTokenEnum),
    );
    yield r'address';
    yield serializers.serialize(
      object.address,
      specifiedType: const FullType(String),
    );
    if (object.memo != null) {
      yield r'memo';
      yield serializers.serialize(
        object.memo,
        specifiedType: const FullType.nullable(String),
      );
    }
    if (object.qrPayload != null) {
      yield r'qr_payload';
      yield serializers.serialize(
        object.qrPayload,
        specifiedType: const FullType(String),
      );
    }
    if (object.minDeposit != null) {
      yield r'min_deposit';
      yield serializers.serialize(
        object.minDeposit,
        specifiedType: const FullType(String),
      );
    }
    if (object.confirmationsRequired != null) {
      yield r'confirmations_required';
      yield serializers.serialize(
        object.confirmationsRequired,
        specifiedType: const FullType(int),
      );
    }
    if (object.creditedTo != null) {
      yield r'credited_to';
      yield serializers.serialize(
        object.creditedTo,
        specifiedType: const FullType(AccountKind),
      );
    }
    if (object.warning != null) {
      yield r'warning';
      yield serializers.serialize(
        object.warning,
        specifiedType: const FullType(String),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    DepositAddress object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required DepositAddressBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'chain':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(Chain),
          ) as Chain;
          result.chain = valueDes;
          break;
        case r'token':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DepositAddressTokenEnum),
          ) as DepositAddressTokenEnum;
          result.token = valueDes;
          break;
        case r'address':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.address = valueDes;
          break;
        case r'memo':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.memo = valueDes;
          break;
        case r'qr_payload':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.qrPayload = valueDes;
          break;
        case r'min_deposit':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.minDeposit = valueDes;
          break;
        case r'confirmations_required':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(int),
          ) as int?;
          if (valueDes == null) continue;
          result.confirmationsRequired = valueDes;
          break;
        case r'credited_to':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(AccountKind),
          ) as AccountKind?;
          if (valueDes == null) continue;
          result.creditedTo = valueDes;
          break;
        case r'warning':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.warning = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  DepositAddress deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = DepositAddressBuilder();
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

@Deprecated('DepositAddressTokenEnum has been deprecated')
class DepositAddressTokenEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'USDC')
  static const DepositAddressTokenEnum USDC = _$depositAddressTokenEnum_USDC;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const DepositAddressTokenEnum unknownDefaultOpenApi = _$depositAddressTokenEnum_unknownDefaultOpenApi;

  static Serializer<DepositAddressTokenEnum> get serializer => _$depositAddressTokenEnumSerializer;

  const DepositAddressTokenEnum._(String name): super(name);

  static BuiltSet<DepositAddressTokenEnum> get values => _$depositAddressTokenEnumValues;
  static DepositAddressTokenEnum valueOf(String name) => _$depositAddressTokenEnumValueOf(name);
}


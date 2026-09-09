//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:rwa_api_client/src/model/hip3_eip712_typed_data.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'hip3_order_action.g.dart';

/// 后端完成风控、资金预留、operation binding 并持久化完整 Hyperliquid action 后， 交给前端签名的 HIP-3 数据。前端只签署 typed data 并回传签名，不广播交易，也不 回传 action、nonce 或 Provider response。
///
/// Properties:
/// * [actionId]
/// * [operation]
/// * [environment]
/// * [expectedSigner]
/// * [nonce] - 服务端冻结的 Hyperliquid action nonce；客户端不得回传或覆盖。
/// * [expiresAfter] - Hyperliquid expiresAfter 毫秒值；客户端不得回传或覆盖。
/// * [signingMethod] - 必须使用 EIP-712 typed-data 签名；禁止将 `signing_digest` 交给 `personal_sign` 或 `eth_sign`，否则会引入不同的消息前缀。
/// * [signatureFormat] - 钱包若返回 65-byte compact signature，客户端必须拆分为 32-byte `r`、32-byte `s` 和归一化为 27/28 的 `v` 后再提交。
/// * [signingTypedData]
/// * [signingDigest] - 服务端预先计算的 EIP-712 digest，仅用于签名结果校验与故障诊断； 客户端不得对该 digest 另行执行 personal-sign。
/// * [validUntil]
@BuiltValue()
abstract class Hip3OrderAction
    implements Built<Hip3OrderAction, Hip3OrderActionBuilder> {
  @BuiltValueField(wireName: r'action_id')
  String get actionId;

  @BuiltValueField(wireName: r'operation')
  Hip3OrderActionOperationEnum get operation;
  // enum operationEnum {  place_order,  cancel_order,  close_position,  };

  @BuiltValueField(wireName: r'environment')
  Hip3OrderActionEnvironmentEnum get environment;
  // enum environmentEnum {  mainnet,  testnet,  };

  @BuiltValueField(wireName: r'expected_signer')
  String get expectedSigner;

  /// 服务端冻结的 Hyperliquid action nonce；客户端不得回传或覆盖。
  @BuiltValueField(wireName: r'nonce')
  int get nonce;

  /// Hyperliquid expiresAfter 毫秒值；客户端不得回传或覆盖。
  @BuiltValueField(wireName: r'expires_after')
  int? get expiresAfter;

  /// 必须使用 EIP-712 typed-data 签名；禁止将 `signing_digest` 交给 `personal_sign` 或 `eth_sign`，否则会引入不同的消息前缀。
  @BuiltValueField(wireName: r'signing_method')
  Hip3OrderActionSigningMethodEnum get signingMethod;
  // enum signingMethodEnum {  eth_signTypedData_v4,  };

  /// 钱包若返回 65-byte compact signature，客户端必须拆分为 32-byte `r`、32-byte `s` 和归一化为 27/28 的 `v` 后再提交。
  @BuiltValueField(wireName: r'signature_format')
  Hip3OrderActionSignatureFormatEnum get signatureFormat;
  // enum signatureFormatEnum {  r_s_v,  };

  @BuiltValueField(wireName: r'signing_typed_data')
  Hip3Eip712TypedData get signingTypedData;

  /// 服务端预先计算的 EIP-712 digest，仅用于签名结果校验与故障诊断； 客户端不得对该 digest 另行执行 personal-sign。
  @BuiltValueField(wireName: r'signing_digest')
  String get signingDigest;

  @BuiltValueField(wireName: r'valid_until')
  DateTime get validUntil;

  Hip3OrderAction._();

  factory Hip3OrderAction([void updates(Hip3OrderActionBuilder b)]) =
      _$Hip3OrderAction;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(Hip3OrderActionBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<Hip3OrderAction> get serializer =>
      _$Hip3OrderActionSerializer();
}

class _$Hip3OrderActionSerializer
    implements PrimitiveSerializer<Hip3OrderAction> {
  @override
  final Iterable<Type> types = const [Hip3OrderAction, _$Hip3OrderAction];

  @override
  final String wireName = r'Hip3OrderAction';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    Hip3OrderAction object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'action_id';
    yield serializers.serialize(
      object.actionId,
      specifiedType: const FullType(String),
    );
    yield r'operation';
    yield serializers.serialize(
      object.operation,
      specifiedType: const FullType(Hip3OrderActionOperationEnum),
    );
    yield r'environment';
    yield serializers.serialize(
      object.environment,
      specifiedType: const FullType(Hip3OrderActionEnvironmentEnum),
    );
    yield r'expected_signer';
    yield serializers.serialize(
      object.expectedSigner,
      specifiedType: const FullType(String),
    );
    yield r'nonce';
    yield serializers.serialize(
      object.nonce,
      specifiedType: const FullType(int),
    );
    yield r'expires_after';
    yield object.expiresAfter == null
        ? null
        : serializers.serialize(
            object.expiresAfter,
            specifiedType: const FullType.nullable(int),
          );
    yield r'signing_method';
    yield serializers.serialize(
      object.signingMethod,
      specifiedType: const FullType(Hip3OrderActionSigningMethodEnum),
    );
    yield r'signature_format';
    yield serializers.serialize(
      object.signatureFormat,
      specifiedType: const FullType(Hip3OrderActionSignatureFormatEnum),
    );
    yield r'signing_typed_data';
    yield serializers.serialize(
      object.signingTypedData,
      specifiedType: const FullType(Hip3Eip712TypedData),
    );
    yield r'signing_digest';
    yield serializers.serialize(
      object.signingDigest,
      specifiedType: const FullType(String),
    );
    yield r'valid_until';
    yield serializers.serialize(
      object.validUntil,
      specifiedType: const FullType(DateTime),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    Hip3OrderAction object, {
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
    required Hip3OrderActionBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'action_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.actionId = valueDes;
          break;
        case r'operation':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(Hip3OrderActionOperationEnum),
          ) as Hip3OrderActionOperationEnum;
          result.operation = valueDes;
          break;
        case r'environment':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(Hip3OrderActionEnvironmentEnum),
          ) as Hip3OrderActionEnvironmentEnum;
          result.environment = valueDes;
          break;
        case r'expected_signer':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.expectedSigner = valueDes;
          break;
        case r'nonce':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.nonce = valueDes;
          break;
        case r'expires_after':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(int),
          ) as int?;
          if (valueDes == null) continue;
          result.expiresAfter = valueDes;
          break;
        case r'signing_method':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(Hip3OrderActionSigningMethodEnum),
          ) as Hip3OrderActionSigningMethodEnum;
          result.signingMethod = valueDes;
          break;
        case r'signature_format':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(Hip3OrderActionSignatureFormatEnum),
          ) as Hip3OrderActionSignatureFormatEnum;
          result.signatureFormat = valueDes;
          break;
        case r'signing_typed_data':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(Hip3Eip712TypedData),
          ) as Hip3Eip712TypedData;
          result.signingTypedData.replace(valueDes);
          break;
        case r'signing_digest':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.signingDigest = valueDes;
          break;
        case r'valid_until':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DateTime),
          ) as DateTime;
          result.validUntil = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  Hip3OrderAction deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = Hip3OrderActionBuilder();
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

class Hip3OrderActionOperationEnum extends EnumClass {
  @BuiltValueEnumConst(wireName: r'place_order')
  static const Hip3OrderActionOperationEnum placeOrder =
      _$hip3OrderActionOperationEnum_placeOrder;
  @BuiltValueEnumConst(wireName: r'cancel_order')
  static const Hip3OrderActionOperationEnum cancelOrder =
      _$hip3OrderActionOperationEnum_cancelOrder;
  @BuiltValueEnumConst(wireName: r'close_position')
  static const Hip3OrderActionOperationEnum closePosition =
      _$hip3OrderActionOperationEnum_closePosition;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const Hip3OrderActionOperationEnum unknownDefaultOpenApi =
      _$hip3OrderActionOperationEnum_unknownDefaultOpenApi;

  static Serializer<Hip3OrderActionOperationEnum> get serializer =>
      _$hip3OrderActionOperationEnumSerializer;

  const Hip3OrderActionOperationEnum._(String name) : super(name);

  static BuiltSet<Hip3OrderActionOperationEnum> get values =>
      _$hip3OrderActionOperationEnumValues;
  static Hip3OrderActionOperationEnum valueOf(String name) =>
      _$hip3OrderActionOperationEnumValueOf(name);
}

class Hip3OrderActionEnvironmentEnum extends EnumClass {
  @BuiltValueEnumConst(wireName: r'mainnet')
  static const Hip3OrderActionEnvironmentEnum mainnet =
      _$hip3OrderActionEnvironmentEnum_mainnet;
  @BuiltValueEnumConst(wireName: r'testnet')
  static const Hip3OrderActionEnvironmentEnum testnet =
      _$hip3OrderActionEnvironmentEnum_testnet;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const Hip3OrderActionEnvironmentEnum unknownDefaultOpenApi =
      _$hip3OrderActionEnvironmentEnum_unknownDefaultOpenApi;

  static Serializer<Hip3OrderActionEnvironmentEnum> get serializer =>
      _$hip3OrderActionEnvironmentEnumSerializer;

  const Hip3OrderActionEnvironmentEnum._(String name) : super(name);

  static BuiltSet<Hip3OrderActionEnvironmentEnum> get values =>
      _$hip3OrderActionEnvironmentEnumValues;
  static Hip3OrderActionEnvironmentEnum valueOf(String name) =>
      _$hip3OrderActionEnvironmentEnumValueOf(name);
}

class Hip3OrderActionSigningMethodEnum extends EnumClass {
  /// 必须使用 EIP-712 typed-data 签名；禁止将 `signing_digest` 交给 `personal_sign` 或 `eth_sign`，否则会引入不同的消息前缀。
  @BuiltValueEnumConst(wireName: r'eth_signTypedData_v4')
  static const Hip3OrderActionSigningMethodEnum ethSignTypedDataV4 =
      _$hip3OrderActionSigningMethodEnum_ethSignTypedDataV4;

  /// 必须使用 EIP-712 typed-data 签名；禁止将 `signing_digest` 交给 `personal_sign` 或 `eth_sign`，否则会引入不同的消息前缀。
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const Hip3OrderActionSigningMethodEnum unknownDefaultOpenApi =
      _$hip3OrderActionSigningMethodEnum_unknownDefaultOpenApi;

  static Serializer<Hip3OrderActionSigningMethodEnum> get serializer =>
      _$hip3OrderActionSigningMethodEnumSerializer;

  const Hip3OrderActionSigningMethodEnum._(String name) : super(name);

  static BuiltSet<Hip3OrderActionSigningMethodEnum> get values =>
      _$hip3OrderActionSigningMethodEnumValues;
  static Hip3OrderActionSigningMethodEnum valueOf(String name) =>
      _$hip3OrderActionSigningMethodEnumValueOf(name);
}

class Hip3OrderActionSignatureFormatEnum extends EnumClass {
  /// 钱包若返回 65-byte compact signature，客户端必须拆分为 32-byte `r`、32-byte `s` 和归一化为 27/28 的 `v` 后再提交。
  @BuiltValueEnumConst(wireName: r'r_s_v')
  static const Hip3OrderActionSignatureFormatEnum rSV =
      _$hip3OrderActionSignatureFormatEnum_rSV;

  /// 钱包若返回 65-byte compact signature，客户端必须拆分为 32-byte `r`、32-byte `s` 和归一化为 27/28 的 `v` 后再提交。
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const Hip3OrderActionSignatureFormatEnum unknownDefaultOpenApi =
      _$hip3OrderActionSignatureFormatEnum_unknownDefaultOpenApi;

  static Serializer<Hip3OrderActionSignatureFormatEnum> get serializer =>
      _$hip3OrderActionSignatureFormatEnumSerializer;

  const Hip3OrderActionSignatureFormatEnum._(String name) : super(name);

  static BuiltSet<Hip3OrderActionSignatureFormatEnum> get values =>
      _$hip3OrderActionSignatureFormatEnumValues;
  static Hip3OrderActionSignatureFormatEnum valueOf(String name) =>
      _$hip3OrderActionSignatureFormatEnumValueOf(name);
}

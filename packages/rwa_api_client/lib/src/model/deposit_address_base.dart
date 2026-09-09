//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:rwa_api_client/src/model/deposit_credit_target.dart';
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'deposit_address_base.g.dart';

/// DepositAddressBase
///
/// Properties:
/// * [chain] 
/// * [chainId] 
/// * [token] 
/// * [tokenContract] - 所选网络上经过后端 allowlist 和启动预检的 USDC 合约地址。
/// * [tokenDecimals] 
/// * [address] - 当前账号唯一、active 且已验证的 Privy EVM 钱包地址。
/// * [memo] - 部分链需要的备注 / tag
/// * [qrPayload] - 二维码内容，使用 `ethereum:<token_contract>@<chain_id>/transfer?address=<recipient>` 形式。recipient 必须与同一响应中的结构化 `address` 大小写不敏感地相等； 后端生成/解析测试与客户端展示前校验共同执行该不变量，不一致时 fail-closed。 
/// * [minDeposit] - 必须大于零；服务端按精确十进制语义校验。
/// * [confirmationsRequired] 
/// * [estimatedArrivalSeconds] - 达到当前 rail 确认门槛的保守预计时间；不是结算保证。
/// * [creditedTo] 
/// * [warning] 
@BuiltValue(instantiable: false)
abstract class DepositAddressBase  {
  @BuiltValueField(wireName: r'chain')
  String get chain;

  @BuiltValueField(wireName: r'chain_id')
  DepositAddressBaseChainIdEnum get chainId;
  // enum chainIdEnum {  1,  56,  8453,  42161,  };

  @BuiltValueField(wireName: r'token')
  String get token;

  /// 所选网络上经过后端 allowlist 和启动预检的 USDC 合约地址。
  @BuiltValueField(wireName: r'token_contract')
  String get tokenContract;

  @BuiltValueField(wireName: r'token_decimals')
  int get tokenDecimals;

  /// 当前账号唯一、active 且已验证的 Privy EVM 钱包地址。
  @BuiltValueField(wireName: r'address')
  String get address;

  /// 部分链需要的备注 / tag
  @BuiltValueField(wireName: r'memo')
  String? get memo;

  /// 二维码内容，使用 `ethereum:<token_contract>@<chain_id>/transfer?address=<recipient>` 形式。recipient 必须与同一响应中的结构化 `address` 大小写不敏感地相等； 后端生成/解析测试与客户端展示前校验共同执行该不变量，不一致时 fail-closed。 
  @BuiltValueField(wireName: r'qr_payload')
  String get qrPayload;

  /// 必须大于零；服务端按精确十进制语义校验。
  @BuiltValueField(wireName: r'min_deposit')
  String get minDeposit;

  @BuiltValueField(wireName: r'confirmations_required')
  int get confirmationsRequired;

  /// 达到当前 rail 确认门槛的保守预计时间；不是结算保证。
  @BuiltValueField(wireName: r'estimated_arrival_seconds')
  int get estimatedArrivalSeconds;

  @BuiltValueField(wireName: r'credited_to')
  DepositCreditTarget get creditedTo;
  // enum creditedToEnum {  wallet,  };

  @BuiltValueField(wireName: r'warning')
  String get warning;

  @BuiltValueSerializer(custom: true)
  static Serializer<DepositAddressBase> get serializer => _$DepositAddressBaseSerializer();
}

class _$DepositAddressBaseSerializer implements PrimitiveSerializer<DepositAddressBase> {
  @override
  final Iterable<Type> types = const [DepositAddressBase];

  @override
  final String wireName = r'DepositAddressBase';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    DepositAddressBase object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'chain';
    yield serializers.serialize(
      object.chain,
      specifiedType: const FullType(String),
    );
    yield r'chain_id';
    yield serializers.serialize(
      object.chainId,
      specifiedType: const FullType(DepositAddressBaseChainIdEnum),
    );
    yield r'token';
    yield serializers.serialize(
      object.token,
      specifiedType: const FullType(String),
    );
    yield r'token_contract';
    yield serializers.serialize(
      object.tokenContract,
      specifiedType: const FullType(String),
    );
    yield r'token_decimals';
    yield serializers.serialize(
      object.tokenDecimals,
      specifiedType: const FullType(int),
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
    yield r'qr_payload';
    yield serializers.serialize(
      object.qrPayload,
      specifiedType: const FullType(String),
    );
    yield r'min_deposit';
    yield serializers.serialize(
      object.minDeposit,
      specifiedType: const FullType(String),
    );
    yield r'confirmations_required';
    yield serializers.serialize(
      object.confirmationsRequired,
      specifiedType: const FullType(int),
    );
    yield r'estimated_arrival_seconds';
    yield serializers.serialize(
      object.estimatedArrivalSeconds,
      specifiedType: const FullType(int),
    );
    yield r'credited_to';
    yield serializers.serialize(
      object.creditedTo,
      specifiedType: const FullType(DepositCreditTarget),
    );
    yield r'warning';
    yield serializers.serialize(
      object.warning,
      specifiedType: const FullType(String),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    DepositAddressBase object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  @override
  DepositAddressBase deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return serializers.deserialize(serialized, specifiedType: FullType($DepositAddressBase)) as $DepositAddressBase;
  }
}

/// a concrete implementation of [DepositAddressBase], since [DepositAddressBase] is not instantiable
@BuiltValue(instantiable: true)
abstract class $DepositAddressBase implements DepositAddressBase, Built<$DepositAddressBase, $DepositAddressBaseBuilder> {
  $DepositAddressBase._();

  factory $DepositAddressBase([void Function($DepositAddressBaseBuilder)? updates]) = _$$DepositAddressBase;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults($DepositAddressBaseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<$DepositAddressBase> get serializer => _$$DepositAddressBaseSerializer();
}

class _$$DepositAddressBaseSerializer implements PrimitiveSerializer<$DepositAddressBase> {
  @override
  final Iterable<Type> types = const [$DepositAddressBase, _$$DepositAddressBase];

  @override
  final String wireName = r'$DepositAddressBase';

  @override
  Object serialize(
    Serializers serializers,
    $DepositAddressBase object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return serializers.serialize(object, specifiedType: FullType(DepositAddressBase))!;
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required DepositAddressBaseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'chain':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.chain = valueDes;
          break;
        case r'chain_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DepositAddressBaseChainIdEnum),
          ) as DepositAddressBaseChainIdEnum;
          result.chainId = valueDes;
          break;
        case r'token':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.token = valueDes;
          break;
        case r'token_contract':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.tokenContract = valueDes;
          break;
        case r'token_decimals':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.tokenDecimals = valueDes;
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
            specifiedType: const FullType(String),
          ) as String;
          result.qrPayload = valueDes;
          break;
        case r'min_deposit':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.minDeposit = valueDes;
          break;
        case r'confirmations_required':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.confirmationsRequired = valueDes;
          break;
        case r'estimated_arrival_seconds':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.estimatedArrivalSeconds = valueDes;
          break;
        case r'credited_to':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DepositCreditTarget),
          ) as DepositCreditTarget;
          result.creditedTo = valueDes;
          break;
        case r'warning':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
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
  $DepositAddressBase deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = $DepositAddressBaseBuilder();
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

class DepositAddressBaseChainIdEnum extends EnumClass {

  @BuiltValueEnumConst(wireNumber: 1)
  static const DepositAddressBaseChainIdEnum number1 = _$depositAddressBaseChainIdEnum_number1;
  @BuiltValueEnumConst(wireNumber: 56)
  static const DepositAddressBaseChainIdEnum number56 = _$depositAddressBaseChainIdEnum_number56;
  @BuiltValueEnumConst(wireNumber: 8453)
  static const DepositAddressBaseChainIdEnum number8453 = _$depositAddressBaseChainIdEnum_number8453;
  @BuiltValueEnumConst(wireNumber: 42161)
  static const DepositAddressBaseChainIdEnum number42161 = _$depositAddressBaseChainIdEnum_number42161;
  @BuiltValueEnumConst(wireNumber: 11184809, fallback: true)
  static const DepositAddressBaseChainIdEnum unknownDefaultOpenApi = _$depositAddressBaseChainIdEnum_unknownDefaultOpenApi;

  static Serializer<DepositAddressBaseChainIdEnum> get serializer => _$depositAddressBaseChainIdEnumSerializer;

  const DepositAddressBaseChainIdEnum._(String name): super(name);

  static BuiltSet<DepositAddressBaseChainIdEnum> get values => _$depositAddressBaseChainIdEnumValues;
  static DepositAddressBaseChainIdEnum valueOf(String name) => _$depositAddressBaseChainIdEnumValueOf(name);
}


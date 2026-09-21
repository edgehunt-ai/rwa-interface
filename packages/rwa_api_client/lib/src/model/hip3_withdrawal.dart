//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:rwa_api_client/src/model/hip3_withdrawal_status.dart';
import 'package:rwa_api_client/src/model/hip3_withdrawal_rail.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'hip3_withdrawal.g.dart';

/// HIP-3 统一账户提现资源。`typed_data_json`/`payload_hash` 仅在创建响应中返回，供客户端 原样签名；`destination_address` 始终等于 `owner_address`。 
///
/// Properties:
/// * [withdrawalId] 
/// * [ownerAddress] 
/// * [destinationAddress] 
/// * [amount] - 十进制字符串，避免浮点误差
/// * [fee] - 十进制字符串，避免浮点误差
/// * [minimumReceived] - 十进制字符串，避免浮点误差
/// * [status] 
/// * [rail] 
/// * [nonce] - HL action nonce（创建时间毫秒），同时是 typed-data `time`。
/// * [hyperliquidChain] - 仅在创建响应中返回。
/// * [chainId] - EIP-712 签名链（421614 testnet / 42161 mainnet），仅创建响应返回。
/// * [amountText] - 冻结进 action 的规范化金额文本，仅创建响应返回。
/// * [typedDataJson] - 精确 EIP-712 typed data JSON，仅创建响应返回；客户端必须原样签名。
/// * [payloadHash] - 冻结 action 的 EIP-712 digest，仅创建响应返回。
/// * [failureReason] 
/// * [observedLedgerTime] 
/// * [payoutTxHash] - float rail 的平台 Arbitrum 垫付交易哈希（`payout`/`completed` 时返回）。
/// * [expiresAt] 
/// * [createdAt] 
/// * [updatedAt] 
/// * [submittedAt] 
/// * [confirmedAt] 
@BuiltValue()
abstract class Hip3Withdrawal implements Built<Hip3Withdrawal, Hip3WithdrawalBuilder> {
  @BuiltValueField(wireName: r'withdrawal_id')
  String get withdrawalId;

  @BuiltValueField(wireName: r'owner_address')
  String get ownerAddress;

  @BuiltValueField(wireName: r'destination_address')
  String get destinationAddress;

  /// 十进制字符串，避免浮点误差
  @BuiltValueField(wireName: r'amount')
  String get amount;

  /// 十进制字符串，避免浮点误差
  @BuiltValueField(wireName: r'fee')
  String get fee;

  /// 十进制字符串，避免浮点误差
  @BuiltValueField(wireName: r'minimum_received')
  String get minimumReceived;

  @BuiltValueField(wireName: r'status')
  Hip3WithdrawalStatus get status;
  // enum statusEnum {  awaiting_signature,  submitted,  payout,  completed,  failed,  expired,  };

  @BuiltValueField(wireName: r'rail')
  Hip3WithdrawalRail get rail;
  // enum railEnum {  bridge2,  float,  };

  /// HL action nonce（创建时间毫秒），同时是 typed-data `time`。
  @BuiltValueField(wireName: r'nonce')
  int get nonce;

  /// 仅在创建响应中返回。
  @BuiltValueField(wireName: r'hyperliquid_chain')
  Hip3WithdrawalHyperliquidChainEnum? get hyperliquidChain;
  // enum hyperliquidChainEnum {  Testnet,  Mainnet,  };

  /// EIP-712 签名链（421614 testnet / 42161 mainnet），仅创建响应返回。
  @BuiltValueField(wireName: r'chain_id')
  String? get chainId;

  /// 冻结进 action 的规范化金额文本，仅创建响应返回。
  @BuiltValueField(wireName: r'amount_text')
  String? get amountText;

  /// 精确 EIP-712 typed data JSON，仅创建响应返回；客户端必须原样签名。
  @BuiltValueField(wireName: r'typed_data_json')
  String? get typedDataJson;

  /// 冻结 action 的 EIP-712 digest，仅创建响应返回。
  @BuiltValueField(wireName: r'payload_hash')
  String? get payloadHash;

  @BuiltValueField(wireName: r'failure_reason')
  String? get failureReason;

  @BuiltValueField(wireName: r'observed_ledger_time')
  int? get observedLedgerTime;

  /// float rail 的平台 Arbitrum 垫付交易哈希（`payout`/`completed` 时返回）。
  @BuiltValueField(wireName: r'payout_tx_hash')
  String? get payoutTxHash;

  @BuiltValueField(wireName: r'expires_at')
  DateTime get expiresAt;

  @BuiltValueField(wireName: r'created_at')
  DateTime get createdAt;

  @BuiltValueField(wireName: r'updated_at')
  DateTime get updatedAt;

  @BuiltValueField(wireName: r'submitted_at')
  DateTime? get submittedAt;

  @BuiltValueField(wireName: r'confirmed_at')
  DateTime? get confirmedAt;

  Hip3Withdrawal._();

  factory Hip3Withdrawal([void updates(Hip3WithdrawalBuilder b)]) = _$Hip3Withdrawal;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(Hip3WithdrawalBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<Hip3Withdrawal> get serializer => _$Hip3WithdrawalSerializer();
}

class _$Hip3WithdrawalSerializer implements PrimitiveSerializer<Hip3Withdrawal> {
  @override
  final Iterable<Type> types = const [Hip3Withdrawal, _$Hip3Withdrawal];

  @override
  final String wireName = r'Hip3Withdrawal';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    Hip3Withdrawal object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'withdrawal_id';
    yield serializers.serialize(
      object.withdrawalId,
      specifiedType: const FullType(String),
    );
    yield r'owner_address';
    yield serializers.serialize(
      object.ownerAddress,
      specifiedType: const FullType(String),
    );
    yield r'destination_address';
    yield serializers.serialize(
      object.destinationAddress,
      specifiedType: const FullType(String),
    );
    yield r'amount';
    yield serializers.serialize(
      object.amount,
      specifiedType: const FullType(String),
    );
    yield r'fee';
    yield serializers.serialize(
      object.fee,
      specifiedType: const FullType(String),
    );
    yield r'minimum_received';
    yield serializers.serialize(
      object.minimumReceived,
      specifiedType: const FullType(String),
    );
    yield r'status';
    yield serializers.serialize(
      object.status,
      specifiedType: const FullType(Hip3WithdrawalStatus),
    );
    yield r'rail';
    yield serializers.serialize(
      object.rail,
      specifiedType: const FullType(Hip3WithdrawalRail),
    );
    yield r'nonce';
    yield serializers.serialize(
      object.nonce,
      specifiedType: const FullType(int),
    );
    if (object.hyperliquidChain != null) {
      yield r'hyperliquid_chain';
      yield serializers.serialize(
        object.hyperliquidChain,
        specifiedType: const FullType(Hip3WithdrawalHyperliquidChainEnum),
      );
    }
    if (object.chainId != null) {
      yield r'chain_id';
      yield serializers.serialize(
        object.chainId,
        specifiedType: const FullType(String),
      );
    }
    if (object.amountText != null) {
      yield r'amount_text';
      yield serializers.serialize(
        object.amountText,
        specifiedType: const FullType(String),
      );
    }
    if (object.typedDataJson != null) {
      yield r'typed_data_json';
      yield serializers.serialize(
        object.typedDataJson,
        specifiedType: const FullType(String),
      );
    }
    if (object.payloadHash != null) {
      yield r'payload_hash';
      yield serializers.serialize(
        object.payloadHash,
        specifiedType: const FullType(String),
      );
    }
    yield r'failure_reason';
    yield object.failureReason == null ? null : serializers.serialize(
      object.failureReason,
      specifiedType: const FullType.nullable(String),
    );
    yield r'observed_ledger_time';
    yield object.observedLedgerTime == null ? null : serializers.serialize(
      object.observedLedgerTime,
      specifiedType: const FullType.nullable(int),
    );
    yield r'payout_tx_hash';
    yield object.payoutTxHash == null ? null : serializers.serialize(
      object.payoutTxHash,
      specifiedType: const FullType.nullable(String),
    );
    yield r'expires_at';
    yield serializers.serialize(
      object.expiresAt,
      specifiedType: const FullType(DateTime),
    );
    yield r'created_at';
    yield serializers.serialize(
      object.createdAt,
      specifiedType: const FullType(DateTime),
    );
    yield r'updated_at';
    yield serializers.serialize(
      object.updatedAt,
      specifiedType: const FullType(DateTime),
    );
    yield r'submitted_at';
    yield object.submittedAt == null ? null : serializers.serialize(
      object.submittedAt,
      specifiedType: const FullType.nullable(DateTime),
    );
    yield r'confirmed_at';
    yield object.confirmedAt == null ? null : serializers.serialize(
      object.confirmedAt,
      specifiedType: const FullType.nullable(DateTime),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    Hip3Withdrawal object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required Hip3WithdrawalBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'withdrawal_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.withdrawalId = valueDes;
          break;
        case r'owner_address':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.ownerAddress = valueDes;
          break;
        case r'destination_address':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.destinationAddress = valueDes;
          break;
        case r'amount':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.amount = valueDes;
          break;
        case r'fee':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.fee = valueDes;
          break;
        case r'minimum_received':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.minimumReceived = valueDes;
          break;
        case r'status':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(Hip3WithdrawalStatus),
          ) as Hip3WithdrawalStatus;
          result.status = valueDes;
          break;
        case r'rail':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(Hip3WithdrawalRail),
          ) as Hip3WithdrawalRail;
          result.rail = valueDes;
          break;
        case r'nonce':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.nonce = valueDes;
          break;
        case r'hyperliquid_chain':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(Hip3WithdrawalHyperliquidChainEnum),
          ) as Hip3WithdrawalHyperliquidChainEnum?;
          if (valueDes == null) continue;
          result.hyperliquidChain = valueDes;
          break;
        case r'chain_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.chainId = valueDes;
          break;
        case r'amount_text':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.amountText = valueDes;
          break;
        case r'typed_data_json':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.typedDataJson = valueDes;
          break;
        case r'payload_hash':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.payloadHash = valueDes;
          break;
        case r'failure_reason':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.failureReason = valueDes;
          break;
        case r'observed_ledger_time':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(int),
          ) as int?;
          if (valueDes == null) continue;
          result.observedLedgerTime = valueDes;
          break;
        case r'payout_tx_hash':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.payoutTxHash = valueDes;
          break;
        case r'expires_at':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DateTime),
          ) as DateTime;
          result.expiresAt = valueDes;
          break;
        case r'created_at':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DateTime),
          ) as DateTime;
          result.createdAt = valueDes;
          break;
        case r'updated_at':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DateTime),
          ) as DateTime;
          result.updatedAt = valueDes;
          break;
        case r'submitted_at':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(DateTime),
          ) as DateTime?;
          if (valueDes == null) continue;
          result.submittedAt = valueDes;
          break;
        case r'confirmed_at':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(DateTime),
          ) as DateTime?;
          if (valueDes == null) continue;
          result.confirmedAt = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  Hip3Withdrawal deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = Hip3WithdrawalBuilder();
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

class Hip3WithdrawalHyperliquidChainEnum extends EnumClass {

  /// 仅在创建响应中返回。
  @BuiltValueEnumConst(wireName: r'Testnet')
  static const Hip3WithdrawalHyperliquidChainEnum testnet = _$hip3WithdrawalHyperliquidChainEnum_testnet;
  /// 仅在创建响应中返回。
  @BuiltValueEnumConst(wireName: r'Mainnet')
  static const Hip3WithdrawalHyperliquidChainEnum mainnet = _$hip3WithdrawalHyperliquidChainEnum_mainnet;
  /// 仅在创建响应中返回。
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const Hip3WithdrawalHyperliquidChainEnum unknownDefaultOpenApi = _$hip3WithdrawalHyperliquidChainEnum_unknownDefaultOpenApi;

  static Serializer<Hip3WithdrawalHyperliquidChainEnum> get serializer => _$hip3WithdrawalHyperliquidChainEnumSerializer;

  const Hip3WithdrawalHyperliquidChainEnum._(String name): super(name);

  static BuiltSet<Hip3WithdrawalHyperliquidChainEnum> get values => _$hip3WithdrawalHyperliquidChainEnumValues;
  static Hip3WithdrawalHyperliquidChainEnum valueOf(String name) => _$hip3WithdrawalHyperliquidChainEnumValueOf(name);
}


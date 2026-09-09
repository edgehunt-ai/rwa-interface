//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:rwa_api_client/src/model/deposit_status.dart';
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'deposit_base.g.dart';

/// DepositBase
///
/// Properties:
/// * [depositId]
/// * [chain]
/// * [chainId]
/// * [token]
/// * [tokenContract]
/// * [tokenDecimals]
/// * [amount] - 十进制字符串，避免浮点误差
/// * [amountRaw] - ERC-20 Transfer log 中的精确原始整数金额。
/// * [status]
/// * [confirmations]
/// * [confirmationsRequired]
/// * [txHash]
/// * [logIndex]
/// * [blockNumber]
/// * [blockHash]
/// * [sender]
/// * [recipient]
/// * [detectedAt]
/// * [confirmedAt]
/// * [updatedAt]
@BuiltValue(instantiable: false)
abstract class DepositBase {
  @BuiltValueField(wireName: r'deposit_id')
  String get depositId;

  @BuiltValueField(wireName: r'chain')
  String get chain;

  @BuiltValueField(wireName: r'chain_id')
  int get chainId;

  @BuiltValueField(wireName: r'token')
  DepositBaseTokenEnum get token;
  // enum tokenEnum {  USDC,  };

  @BuiltValueField(wireName: r'token_contract')
  String get tokenContract;

  @BuiltValueField(wireName: r'token_decimals')
  int get tokenDecimals;

  /// 十进制字符串，避免浮点误差
  @BuiltValueField(wireName: r'amount')
  String get amount;

  /// ERC-20 Transfer log 中的精确原始整数金额。
  @BuiltValueField(wireName: r'amount_raw')
  String get amountRaw;

  @BuiltValueField(wireName: r'status')
  DepositStatus get status;
  // enum statusEnum {  confirmed,  };

  @BuiltValueField(wireName: r'confirmations')
  int get confirmations;

  @BuiltValueField(wireName: r'confirmations_required')
  int get confirmationsRequired;

  @BuiltValueField(wireName: r'tx_hash')
  String get txHash;

  @BuiltValueField(wireName: r'log_index')
  int get logIndex;

  @BuiltValueField(wireName: r'block_number')
  int get blockNumber;

  @BuiltValueField(wireName: r'block_hash')
  String get blockHash;

  @BuiltValueField(wireName: r'sender')
  String get sender;

  @BuiltValueField(wireName: r'recipient')
  String get recipient;

  @BuiltValueField(wireName: r'detected_at')
  DateTime get detectedAt;

  @BuiltValueField(wireName: r'confirmed_at')
  DateTime get confirmedAt;

  @BuiltValueField(wireName: r'updated_at')
  DateTime get updatedAt;

  @BuiltValueSerializer(custom: true)
  static Serializer<DepositBase> get serializer => _$DepositBaseSerializer();
}

class _$DepositBaseSerializer implements PrimitiveSerializer<DepositBase> {
  @override
  final Iterable<Type> types = const [DepositBase];

  @override
  final String wireName = r'DepositBase';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    DepositBase object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'deposit_id';
    yield serializers.serialize(
      object.depositId,
      specifiedType: const FullType(String),
    );
    yield r'chain';
    yield serializers.serialize(
      object.chain,
      specifiedType: const FullType(String),
    );
    yield r'chain_id';
    yield serializers.serialize(
      object.chainId,
      specifiedType: const FullType(int),
    );
    yield r'token';
    yield serializers.serialize(
      object.token,
      specifiedType: const FullType(DepositBaseTokenEnum),
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
    yield r'amount';
    yield serializers.serialize(
      object.amount,
      specifiedType: const FullType(String),
    );
    yield r'amount_raw';
    yield serializers.serialize(
      object.amountRaw,
      specifiedType: const FullType(String),
    );
    yield r'status';
    yield serializers.serialize(
      object.status,
      specifiedType: const FullType(DepositStatus),
    );
    yield r'confirmations';
    yield serializers.serialize(
      object.confirmations,
      specifiedType: const FullType(int),
    );
    yield r'confirmations_required';
    yield serializers.serialize(
      object.confirmationsRequired,
      specifiedType: const FullType(int),
    );
    yield r'tx_hash';
    yield serializers.serialize(
      object.txHash,
      specifiedType: const FullType(String),
    );
    yield r'log_index';
    yield serializers.serialize(
      object.logIndex,
      specifiedType: const FullType(int),
    );
    yield r'block_number';
    yield serializers.serialize(
      object.blockNumber,
      specifiedType: const FullType(int),
    );
    yield r'block_hash';
    yield serializers.serialize(
      object.blockHash,
      specifiedType: const FullType(String),
    );
    yield r'sender';
    yield serializers.serialize(
      object.sender,
      specifiedType: const FullType(String),
    );
    yield r'recipient';
    yield serializers.serialize(
      object.recipient,
      specifiedType: const FullType(String),
    );
    yield r'detected_at';
    yield serializers.serialize(
      object.detectedAt,
      specifiedType: const FullType(DateTime),
    );
    yield r'confirmed_at';
    yield serializers.serialize(
      object.confirmedAt,
      specifiedType: const FullType(DateTime),
    );
    yield r'updated_at';
    yield serializers.serialize(
      object.updatedAt,
      specifiedType: const FullType(DateTime),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    DepositBase object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object,
            specifiedType: specifiedType)
        .toList();
  }

  @override
  DepositBase deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return serializers.deserialize(serialized,
        specifiedType: FullType($DepositBase)) as $DepositBase;
  }
}

/// a concrete implementation of [DepositBase], since [DepositBase] is not instantiable
@BuiltValue(instantiable: true)
abstract class $DepositBase
    implements DepositBase, Built<$DepositBase, $DepositBaseBuilder> {
  $DepositBase._();

  factory $DepositBase([void Function($DepositBaseBuilder)? updates]) =
      _$$DepositBase;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults($DepositBaseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<$DepositBase> get serializer => _$$DepositBaseSerializer();
}

class _$$DepositBaseSerializer implements PrimitiveSerializer<$DepositBase> {
  @override
  final Iterable<Type> types = const [$DepositBase, _$$DepositBase];

  @override
  final String wireName = r'$DepositBase';

  @override
  Object serialize(
    Serializers serializers,
    $DepositBase object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return serializers.serialize(object, specifiedType: FullType(DepositBase))!;
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required DepositBaseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'deposit_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.depositId = valueDes;
          break;
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
            specifiedType: const FullType(int),
          ) as int;
          result.chainId = valueDes;
          break;
        case r'token':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DepositBaseTokenEnum),
          ) as DepositBaseTokenEnum;
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
        case r'amount':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.amount = valueDes;
          break;
        case r'amount_raw':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.amountRaw = valueDes;
          break;
        case r'status':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DepositStatus),
          ) as DepositStatus;
          result.status = valueDes;
          break;
        case r'confirmations':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.confirmations = valueDes;
          break;
        case r'confirmations_required':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.confirmationsRequired = valueDes;
          break;
        case r'tx_hash':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.txHash = valueDes;
          break;
        case r'log_index':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.logIndex = valueDes;
          break;
        case r'block_number':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.blockNumber = valueDes;
          break;
        case r'block_hash':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.blockHash = valueDes;
          break;
        case r'sender':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.sender = valueDes;
          break;
        case r'recipient':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.recipient = valueDes;
          break;
        case r'detected_at':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DateTime),
          ) as DateTime;
          result.detectedAt = valueDes;
          break;
        case r'confirmed_at':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DateTime),
          ) as DateTime;
          result.confirmedAt = valueDes;
          break;
        case r'updated_at':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DateTime),
          ) as DateTime;
          result.updatedAt = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  $DepositBase deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = $DepositBaseBuilder();
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

class DepositBaseTokenEnum extends EnumClass {
  @BuiltValueEnumConst(wireName: r'USDC')
  static const DepositBaseTokenEnum USDC = _$depositBaseTokenEnum_USDC;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const DepositBaseTokenEnum unknownDefaultOpenApi =
      _$depositBaseTokenEnum_unknownDefaultOpenApi;

  static Serializer<DepositBaseTokenEnum> get serializer =>
      _$depositBaseTokenEnumSerializer;

  const DepositBaseTokenEnum._(String name) : super(name);

  static BuiltSet<DepositBaseTokenEnum> get values =>
      _$depositBaseTokenEnumValues;
  static DepositBaseTokenEnum valueOf(String name) =>
      _$depositBaseTokenEnumValueOf(name);
}

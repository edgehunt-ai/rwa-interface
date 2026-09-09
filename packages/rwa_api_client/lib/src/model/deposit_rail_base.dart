//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:rwa_api_client/src/model/deposit_rail_availability.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'deposit_rail_base.g.dart';

/// `unavailable` rail 只用于解释阻塞原因；API 必须拒绝返回该 rail 的入金指引。 
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
@BuiltValue(instantiable: false)
abstract class DepositRailBase  {
  @BuiltValueField(wireName: r'chain')
  String get chain;

  @BuiltValueField(wireName: r'chain_id')
  int get chainId;

  @BuiltValueField(wireName: r'token')
  String get token;

  @BuiltValueField(wireName: r'token_contract')
  String get tokenContract;

  @BuiltValueField(wireName: r'token_decimals')
  int get tokenDecimals;

  /// 必须大于零；服务端按精确十进制语义校验。
  @BuiltValueField(wireName: r'minimum_amount')
  String get minimumAmount;

  @BuiltValueField(wireName: r'confirmations_required')
  int get confirmationsRequired;

  @BuiltValueField(wireName: r'availability')
  DepositRailAvailability get availability;

  @BuiltValueSerializer(custom: true)
  static Serializer<DepositRailBase> get serializer => _$DepositRailBaseSerializer();
}

class _$DepositRailBaseSerializer implements PrimitiveSerializer<DepositRailBase> {
  @override
  final Iterable<Type> types = const [DepositRailBase];

  @override
  final String wireName = r'DepositRailBase';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    DepositRailBase object, {
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
      specifiedType: const FullType(int),
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
    yield r'minimum_amount';
    yield serializers.serialize(
      object.minimumAmount,
      specifiedType: const FullType(String),
    );
    yield r'confirmations_required';
    yield serializers.serialize(
      object.confirmationsRequired,
      specifiedType: const FullType(int),
    );
    yield r'availability';
    yield serializers.serialize(
      object.availability,
      specifiedType: const FullType(DepositRailAvailability),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    DepositRailBase object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  @override
  DepositRailBase deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return serializers.deserialize(serialized, specifiedType: FullType($DepositRailBase)) as $DepositRailBase;
  }
}

/// a concrete implementation of [DepositRailBase], since [DepositRailBase] is not instantiable
@BuiltValue(instantiable: true)
abstract class $DepositRailBase implements DepositRailBase, Built<$DepositRailBase, $DepositRailBaseBuilder> {
  $DepositRailBase._();

  factory $DepositRailBase([void Function($DepositRailBaseBuilder)? updates]) = _$$DepositRailBase;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults($DepositRailBaseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<$DepositRailBase> get serializer => _$$DepositRailBaseSerializer();
}

class _$$DepositRailBaseSerializer implements PrimitiveSerializer<$DepositRailBase> {
  @override
  final Iterable<Type> types = const [$DepositRailBase, _$$DepositRailBase];

  @override
  final String wireName = r'$DepositRailBase';

  @override
  Object serialize(
    Serializers serializers,
    $DepositRailBase object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return serializers.serialize(object, specifiedType: FullType(DepositRailBase))!;
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required DepositRailBaseBuilder result,
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
            specifiedType: const FullType(int),
          ) as int;
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
        case r'minimum_amount':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.minimumAmount = valueDes;
          break;
        case r'confirmations_required':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.confirmationsRequired = valueDes;
          break;
        case r'availability':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DepositRailAvailability),
          ) as DepositRailAvailability;
          result.availability.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  $DepositRailBase deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = $DepositRailBaseBuilder();
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


//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:rwa_api_client/src/model/bstock_testnet_funding_target_balance_snapshot.dart';
import 'package:built_collection/built_collection.dart';
import 'package:rwa_api_client/src/model/bstock_testnet_funding_target_credit_observation.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'bstock_testnet_funding_transfer_target.g.dart';

/// BstockTestnetFundingTransferTarget
///
/// Properties:
/// * [rail] 
/// * [target] 
/// * [targetCredit] 
@BuiltValue()
abstract class BstockTestnetFundingTransferTarget implements Built<BstockTestnetFundingTransferTarget, BstockTestnetFundingTransferTargetBuilder> {
  @BuiltValueField(wireName: r'rail')
  BstockTestnetFundingTransferTargetRailEnum get rail;
  // enum railEnum {  bstock,  };

  @BuiltValueField(wireName: r'target')
  BstockTestnetFundingTargetBalanceSnapshot get target;

  @BuiltValueField(wireName: r'target_credit')
  BstockTestnetFundingTargetCreditObservation? get targetCredit;

  BstockTestnetFundingTransferTarget._();

  factory BstockTestnetFundingTransferTarget([void updates(BstockTestnetFundingTransferTargetBuilder b)]) = _$BstockTestnetFundingTransferTarget;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(BstockTestnetFundingTransferTargetBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<BstockTestnetFundingTransferTarget> get serializer => _$BstockTestnetFundingTransferTargetSerializer();
}

class _$BstockTestnetFundingTransferTargetSerializer implements PrimitiveSerializer<BstockTestnetFundingTransferTarget> {
  @override
  final Iterable<Type> types = const [BstockTestnetFundingTransferTarget, _$BstockTestnetFundingTransferTarget];

  @override
  final String wireName = r'BstockTestnetFundingTransferTarget';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    BstockTestnetFundingTransferTarget object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'rail';
    yield serializers.serialize(
      object.rail,
      specifiedType: const FullType(BstockTestnetFundingTransferTargetRailEnum),
    );
    yield r'target';
    yield serializers.serialize(
      object.target,
      specifiedType: const FullType(BstockTestnetFundingTargetBalanceSnapshot),
    );
    if (object.targetCredit != null) {
      yield r'target_credit';
      yield serializers.serialize(
        object.targetCredit,
        specifiedType: const FullType.nullable(BstockTestnetFundingTargetCreditObservation),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    BstockTestnetFundingTransferTarget object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required BstockTestnetFundingTransferTargetBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'rail':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BstockTestnetFundingTransferTargetRailEnum),
          ) as BstockTestnetFundingTransferTargetRailEnum;
          result.rail = valueDes;
          break;
        case r'target':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BstockTestnetFundingTargetBalanceSnapshot),
          ) as BstockTestnetFundingTargetBalanceSnapshot;
          result.target.replace(valueDes);
          break;
        case r'target_credit':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(BstockTestnetFundingTargetCreditObservation),
          ) as BstockTestnetFundingTargetCreditObservation?;
          if (valueDes == null) continue;
          result.targetCredit.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  BstockTestnetFundingTransferTarget deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = BstockTestnetFundingTransferTargetBuilder();
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

class BstockTestnetFundingTransferTargetRailEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'bstock')
  static const BstockTestnetFundingTransferTargetRailEnum bstock = _$bstockTestnetFundingTransferTargetRailEnum_bstock;

  static Serializer<BstockTestnetFundingTransferTargetRailEnum> get serializer => _$bstockTestnetFundingTransferTargetRailEnumSerializer;

  const BstockTestnetFundingTransferTargetRailEnum._(String name): super(name);

  static BuiltSet<BstockTestnetFundingTransferTargetRailEnum> get values => _$bstockTestnetFundingTransferTargetRailEnumValues;
  static BstockTestnetFundingTransferTargetRailEnum valueOf(String name) => _$bstockTestnetFundingTransferTargetRailEnumValueOf(name);
}


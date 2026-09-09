//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:rwa_api_client/src/model/bstock_funding_target_credit_observation.dart';
import 'package:built_collection/built_collection.dart';
import 'package:rwa_api_client/src/model/bstock_funding_target_balance_snapshot.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'bstock_funding_transfer_target.g.dart';

/// BstockFundingTransferTarget
///
/// Properties:
/// * [rail]
/// * [target]
/// * [targetCredit]
@BuiltValue()
abstract class BstockFundingTransferTarget
    implements
        Built<BstockFundingTransferTarget, BstockFundingTransferTargetBuilder> {
  @BuiltValueField(wireName: r'rail')
  BstockFundingTransferTargetRailEnum get rail;
  // enum railEnum {  bstock,  };

  @BuiltValueField(wireName: r'target')
  BstockFundingTargetBalanceSnapshot get target;

  @BuiltValueField(wireName: r'target_credit')
  BstockFundingTargetCreditObservation? get targetCredit;

  BstockFundingTransferTarget._();

  factory BstockFundingTransferTarget(
          [void updates(BstockFundingTransferTargetBuilder b)]) =
      _$BstockFundingTransferTarget;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(BstockFundingTransferTargetBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<BstockFundingTransferTarget> get serializer =>
      _$BstockFundingTransferTargetSerializer();
}

class _$BstockFundingTransferTargetSerializer
    implements PrimitiveSerializer<BstockFundingTransferTarget> {
  @override
  final Iterable<Type> types = const [
    BstockFundingTransferTarget,
    _$BstockFundingTransferTarget
  ];

  @override
  final String wireName = r'BstockFundingTransferTarget';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    BstockFundingTransferTarget object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'rail';
    yield serializers.serialize(
      object.rail,
      specifiedType: const FullType(BstockFundingTransferTargetRailEnum),
    );
    yield r'target';
    yield serializers.serialize(
      object.target,
      specifiedType: const FullType(BstockFundingTargetBalanceSnapshot),
    );
    if (object.targetCredit != null) {
      yield r'target_credit';
      yield serializers.serialize(
        object.targetCredit,
        specifiedType:
            const FullType.nullable(BstockFundingTargetCreditObservation),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    BstockFundingTransferTarget object, {
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
    required BstockFundingTransferTargetBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'rail':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BstockFundingTransferTargetRailEnum),
          ) as BstockFundingTransferTargetRailEnum;
          result.rail = valueDes;
          break;
        case r'target':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BstockFundingTargetBalanceSnapshot),
          ) as BstockFundingTargetBalanceSnapshot;
          result.target.replace(valueDes);
          break;
        case r'target_credit':
          final valueDes = serializers.deserialize(
            value,
            specifiedType:
                const FullType.nullable(BstockFundingTargetCreditObservation),
          ) as BstockFundingTargetCreditObservation?;
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
  BstockFundingTransferTarget deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = BstockFundingTransferTargetBuilder();
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

class BstockFundingTransferTargetRailEnum extends EnumClass {
  @BuiltValueEnumConst(wireName: r'bstock')
  static const BstockFundingTransferTargetRailEnum bstock =
      _$bstockFundingTransferTargetRailEnum_bstock;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const BstockFundingTransferTargetRailEnum unknownDefaultOpenApi =
      _$bstockFundingTransferTargetRailEnum_unknownDefaultOpenApi;

  static Serializer<BstockFundingTransferTargetRailEnum> get serializer =>
      _$bstockFundingTransferTargetRailEnumSerializer;

  const BstockFundingTransferTargetRailEnum._(String name) : super(name);

  static BuiltSet<BstockFundingTransferTargetRailEnum> get values =>
      _$bstockFundingTransferTargetRailEnumValues;
  static BstockFundingTransferTargetRailEnum valueOf(String name) =>
      _$bstockFundingTransferTargetRailEnumValueOf(name);
}

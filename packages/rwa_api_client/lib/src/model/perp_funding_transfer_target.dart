//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:rwa_api_client/src/model/perp_funding_target_credit_observation.dart';
import 'package:built_collection/built_collection.dart';
import 'package:rwa_api_client/src/model/perp_funding_target_balance_snapshot.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'perp_funding_transfer_target.g.dart';

/// PerpFundingTransferTarget
///
/// Properties:
/// * [rail] 
/// * [target] 
/// * [targetCredit] 
@BuiltValue()
abstract class PerpFundingTransferTarget implements Built<PerpFundingTransferTarget, PerpFundingTransferTargetBuilder> {
  @BuiltValueField(wireName: r'rail')
  PerpFundingTransferTargetRailEnum get rail;
  // enum railEnum {  perp,  };

  @BuiltValueField(wireName: r'target')
  PerpFundingTargetBalanceSnapshot get target;

  @BuiltValueField(wireName: r'target_credit')
  PerpFundingTargetCreditObservation? get targetCredit;

  PerpFundingTransferTarget._();

  factory PerpFundingTransferTarget([void updates(PerpFundingTransferTargetBuilder b)]) = _$PerpFundingTransferTarget;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(PerpFundingTransferTargetBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<PerpFundingTransferTarget> get serializer => _$PerpFundingTransferTargetSerializer();
}

class _$PerpFundingTransferTargetSerializer implements PrimitiveSerializer<PerpFundingTransferTarget> {
  @override
  final Iterable<Type> types = const [PerpFundingTransferTarget, _$PerpFundingTransferTarget];

  @override
  final String wireName = r'PerpFundingTransferTarget';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    PerpFundingTransferTarget object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'rail';
    yield serializers.serialize(
      object.rail,
      specifiedType: const FullType(PerpFundingTransferTargetRailEnum),
    );
    yield r'target';
    yield serializers.serialize(
      object.target,
      specifiedType: const FullType(PerpFundingTargetBalanceSnapshot),
    );
    if (object.targetCredit != null) {
      yield r'target_credit';
      yield serializers.serialize(
        object.targetCredit,
        specifiedType: const FullType.nullable(PerpFundingTargetCreditObservation),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    PerpFundingTransferTarget object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required PerpFundingTransferTargetBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'rail':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(PerpFundingTransferTargetRailEnum),
          ) as PerpFundingTransferTargetRailEnum;
          result.rail = valueDes;
          break;
        case r'target':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(PerpFundingTargetBalanceSnapshot),
          ) as PerpFundingTargetBalanceSnapshot;
          result.target.replace(valueDes);
          break;
        case r'target_credit':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(PerpFundingTargetCreditObservation),
          ) as PerpFundingTargetCreditObservation?;
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
  PerpFundingTransferTarget deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = PerpFundingTransferTargetBuilder();
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

class PerpFundingTransferTargetRailEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'perp')
  static const PerpFundingTransferTargetRailEnum perp = _$perpFundingTransferTargetRailEnum_perp;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const PerpFundingTransferTargetRailEnum unknownDefaultOpenApi = _$perpFundingTransferTargetRailEnum_unknownDefaultOpenApi;

  static Serializer<PerpFundingTransferTargetRailEnum> get serializer => _$perpFundingTransferTargetRailEnumSerializer;

  const PerpFundingTransferTargetRailEnum._(String name): super(name);

  static BuiltSet<PerpFundingTransferTargetRailEnum> get values => _$perpFundingTransferTargetRailEnumValues;
  static PerpFundingTransferTargetRailEnum valueOf(String name) => _$perpFundingTransferTargetRailEnumValueOf(name);
}


//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:rwa_api_client/src/model/multi_source_funding_leg_status.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'trade_intent_funding_leg_binding.g.dart';

/// Read-only binding between a TradeIntent, one frozen funding-plan leg and its dedicated Transfer.
///
/// Properties:
/// * [legId] 
/// * [ordinal] 
/// * [transferId] - Null until the server creates the dedicated Transfer for this sequential leg.
/// * [status] 
@BuiltValue()
abstract class TradeIntentFundingLegBinding implements Built<TradeIntentFundingLegBinding, TradeIntentFundingLegBindingBuilder> {
  @BuiltValueField(wireName: r'leg_id')
  String get legId;

  @BuiltValueField(wireName: r'ordinal')
  int get ordinal;

  /// Null until the server creates the dedicated Transfer for this sequential leg.
  @BuiltValueField(wireName: r'transfer_id')
  String? get transferId;

  @BuiltValueField(wireName: r'status')
  MultiSourceFundingLegStatus get status;
  // enum statusEnum {  planned,  action_released,  submitted,  origin_confirmed,  provider_confirmed,  target_confirmed,  completed,  cancelled_as_unneeded,  failed,  ambiguous,  manual_review,  };

  TradeIntentFundingLegBinding._();

  factory TradeIntentFundingLegBinding([void updates(TradeIntentFundingLegBindingBuilder b)]) = _$TradeIntentFundingLegBinding;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(TradeIntentFundingLegBindingBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<TradeIntentFundingLegBinding> get serializer => _$TradeIntentFundingLegBindingSerializer();
}

class _$TradeIntentFundingLegBindingSerializer implements PrimitiveSerializer<TradeIntentFundingLegBinding> {
  @override
  final Iterable<Type> types = const [TradeIntentFundingLegBinding, _$TradeIntentFundingLegBinding];

  @override
  final String wireName = r'TradeIntentFundingLegBinding';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    TradeIntentFundingLegBinding object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'leg_id';
    yield serializers.serialize(
      object.legId,
      specifiedType: const FullType(String),
    );
    yield r'ordinal';
    yield serializers.serialize(
      object.ordinal,
      specifiedType: const FullType(int),
    );
    yield r'transfer_id';
    yield object.transferId == null ? null : serializers.serialize(
      object.transferId,
      specifiedType: const FullType.nullable(String),
    );
    yield r'status';
    yield serializers.serialize(
      object.status,
      specifiedType: const FullType(MultiSourceFundingLegStatus),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    TradeIntentFundingLegBinding object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required TradeIntentFundingLegBindingBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'leg_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.legId = valueDes;
          break;
        case r'ordinal':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.ordinal = valueDes;
          break;
        case r'transfer_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.transferId = valueDes;
          break;
        case r'status':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(MultiSourceFundingLegStatus),
          ) as MultiSourceFundingLegStatus;
          result.status = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  TradeIntentFundingLegBinding deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = TradeIntentFundingLegBindingBuilder();
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


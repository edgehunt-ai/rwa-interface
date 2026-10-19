//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:rwa_api_client/src/model/activity_cash_flow_endpoint.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'activity_cash_flow.g.dart';

/// ActivityCashFlow
///
/// Properties:
/// * [source_] - Origin asset and account network.
/// * [destination] - Destination asset and account network.
@BuiltValue()
abstract class ActivityCashFlow implements Built<ActivityCashFlow, ActivityCashFlowBuilder> {
  /// Origin asset and account network.
  @BuiltValueField(wireName: r'source')
  ActivityCashFlowEndpoint get source_;

  /// Destination asset and account network.
  @BuiltValueField(wireName: r'destination')
  ActivityCashFlowEndpoint get destination;

  ActivityCashFlow._();

  factory ActivityCashFlow([void updates(ActivityCashFlowBuilder b)]) = _$ActivityCashFlow;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ActivityCashFlowBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ActivityCashFlow> get serializer => _$ActivityCashFlowSerializer();
}

class _$ActivityCashFlowSerializer implements PrimitiveSerializer<ActivityCashFlow> {
  @override
  final Iterable<Type> types = const [ActivityCashFlow, _$ActivityCashFlow];

  @override
  final String wireName = r'ActivityCashFlow';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ActivityCashFlow object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'source';
    yield serializers.serialize(
      object.source_,
      specifiedType: const FullType(ActivityCashFlowEndpoint),
    );
    yield r'destination';
    yield serializers.serialize(
      object.destination,
      specifiedType: const FullType(ActivityCashFlowEndpoint),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    ActivityCashFlow object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required ActivityCashFlowBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'source':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(ActivityCashFlowEndpoint),
          ) as ActivityCashFlowEndpoint;
          result.source_.replace(valueDes);
          break;
        case r'destination':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(ActivityCashFlowEndpoint),
          ) as ActivityCashFlowEndpoint;
          result.destination.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  ActivityCashFlow deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ActivityCashFlowBuilder();
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


//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'realtime_resync_required_event_all_of_data.g.dart';

/// RealtimeResyncRequiredEventAllOfData
///
/// Properties:
/// * [reason] 
@BuiltValue()
abstract class RealtimeResyncRequiredEventAllOfData implements Built<RealtimeResyncRequiredEventAllOfData, RealtimeResyncRequiredEventAllOfDataBuilder> {
  @BuiltValueField(wireName: r'reason')
  RealtimeResyncRequiredEventAllOfDataReasonEnum get reason;
  // enum reasonEnum {  event_retention_expired,  };

  RealtimeResyncRequiredEventAllOfData._();

  factory RealtimeResyncRequiredEventAllOfData([void updates(RealtimeResyncRequiredEventAllOfDataBuilder b)]) = _$RealtimeResyncRequiredEventAllOfData;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(RealtimeResyncRequiredEventAllOfDataBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<RealtimeResyncRequiredEventAllOfData> get serializer => _$RealtimeResyncRequiredEventAllOfDataSerializer();
}

class _$RealtimeResyncRequiredEventAllOfDataSerializer implements PrimitiveSerializer<RealtimeResyncRequiredEventAllOfData> {
  @override
  final Iterable<Type> types = const [RealtimeResyncRequiredEventAllOfData, _$RealtimeResyncRequiredEventAllOfData];

  @override
  final String wireName = r'RealtimeResyncRequiredEventAllOfData';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    RealtimeResyncRequiredEventAllOfData object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'reason';
    yield serializers.serialize(
      object.reason,
      specifiedType: const FullType(RealtimeResyncRequiredEventAllOfDataReasonEnum),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    RealtimeResyncRequiredEventAllOfData object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required RealtimeResyncRequiredEventAllOfDataBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'reason':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(RealtimeResyncRequiredEventAllOfDataReasonEnum),
          ) as RealtimeResyncRequiredEventAllOfDataReasonEnum;
          result.reason = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  RealtimeResyncRequiredEventAllOfData deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = RealtimeResyncRequiredEventAllOfDataBuilder();
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

class RealtimeResyncRequiredEventAllOfDataReasonEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'event_retention_expired')
  static const RealtimeResyncRequiredEventAllOfDataReasonEnum eventRetentionExpired = _$realtimeResyncRequiredEventAllOfDataReasonEnum_eventRetentionExpired;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const RealtimeResyncRequiredEventAllOfDataReasonEnum unknownDefaultOpenApi = _$realtimeResyncRequiredEventAllOfDataReasonEnum_unknownDefaultOpenApi;

  static Serializer<RealtimeResyncRequiredEventAllOfDataReasonEnum> get serializer => _$realtimeResyncRequiredEventAllOfDataReasonEnumSerializer;

  const RealtimeResyncRequiredEventAllOfDataReasonEnum._(String name): super(name);

  static BuiltSet<RealtimeResyncRequiredEventAllOfDataReasonEnum> get values => _$realtimeResyncRequiredEventAllOfDataReasonEnumValues;
  static RealtimeResyncRequiredEventAllOfDataReasonEnum valueOf(String name) => _$realtimeResyncRequiredEventAllOfDataReasonEnumValueOf(name);
}


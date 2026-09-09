//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'activity_record_reference.g.dart';

/// 指向经过严格枚举的实际业务实体，未知内部资源不得兜底映射为订单。
///
/// Properties:
/// * [type] 
/// * [id] 
@BuiltValue()
abstract class ActivityRecordReference implements Built<ActivityRecordReference, ActivityRecordReferenceBuilder> {
  @BuiltValueField(wireName: r'type')
  ActivityRecordReferenceTypeEnum get type;
  // enum typeEnum {  order,  position,  transfer,  claim,  deposit,  withdrawal,  };

  @BuiltValueField(wireName: r'id')
  String get id;

  ActivityRecordReference._();

  factory ActivityRecordReference([void updates(ActivityRecordReferenceBuilder b)]) = _$ActivityRecordReference;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ActivityRecordReferenceBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ActivityRecordReference> get serializer => _$ActivityRecordReferenceSerializer();
}

class _$ActivityRecordReferenceSerializer implements PrimitiveSerializer<ActivityRecordReference> {
  @override
  final Iterable<Type> types = const [ActivityRecordReference, _$ActivityRecordReference];

  @override
  final String wireName = r'ActivityRecordReference';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ActivityRecordReference object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'type';
    yield serializers.serialize(
      object.type,
      specifiedType: const FullType(ActivityRecordReferenceTypeEnum),
    );
    yield r'id';
    yield serializers.serialize(
      object.id,
      specifiedType: const FullType(String),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    ActivityRecordReference object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required ActivityRecordReferenceBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'type':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(ActivityRecordReferenceTypeEnum),
          ) as ActivityRecordReferenceTypeEnum;
          result.type = valueDes;
          break;
        case r'id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.id = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  ActivityRecordReference deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ActivityRecordReferenceBuilder();
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

class ActivityRecordReferenceTypeEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'order')
  static const ActivityRecordReferenceTypeEnum order = _$activityRecordReferenceTypeEnum_order;
  @BuiltValueEnumConst(wireName: r'position')
  static const ActivityRecordReferenceTypeEnum position = _$activityRecordReferenceTypeEnum_position;
  @BuiltValueEnumConst(wireName: r'transfer')
  static const ActivityRecordReferenceTypeEnum transfer = _$activityRecordReferenceTypeEnum_transfer;
  @BuiltValueEnumConst(wireName: r'claim')
  static const ActivityRecordReferenceTypeEnum claim = _$activityRecordReferenceTypeEnum_claim;
  @BuiltValueEnumConst(wireName: r'deposit')
  static const ActivityRecordReferenceTypeEnum deposit = _$activityRecordReferenceTypeEnum_deposit;
  @BuiltValueEnumConst(wireName: r'withdrawal')
  static const ActivityRecordReferenceTypeEnum withdrawal = _$activityRecordReferenceTypeEnum_withdrawal;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const ActivityRecordReferenceTypeEnum unknownDefaultOpenApi = _$activityRecordReferenceTypeEnum_unknownDefaultOpenApi;

  static Serializer<ActivityRecordReferenceTypeEnum> get serializer => _$activityRecordReferenceTypeEnumSerializer;

  const ActivityRecordReferenceTypeEnum._(String name): super(name);

  static BuiltSet<ActivityRecordReferenceTypeEnum> get values => _$activityRecordReferenceTypeEnumValues;
  static ActivityRecordReferenceTypeEnum valueOf(String name) => _$activityRecordReferenceTypeEnumValueOf(name);
}


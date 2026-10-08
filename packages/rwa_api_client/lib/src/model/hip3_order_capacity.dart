//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:rwa_api_client/src/model/hip3_order_capacity_side.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'hip3_order_capacity.g.dart';

/// 额度观测的有效期与外层 context 的签名确认期限不同；到期后刷新，不保证有效期内成交。long 对应上游数组索引 0，short 对应索引 1。
///
/// Properties:
/// * [long] 
/// * [short] 
/// * [observedAt] 
/// * [validUntil] 
@BuiltValue()
abstract class Hip3OrderCapacity implements Built<Hip3OrderCapacity, Hip3OrderCapacityBuilder> {
  @BuiltValueField(wireName: r'long')
  Hip3OrderCapacitySide get long;

  @BuiltValueField(wireName: r'short')
  Hip3OrderCapacitySide get short;

  @BuiltValueField(wireName: r'observed_at')
  DateTime get observedAt;

  @BuiltValueField(wireName: r'valid_until')
  DateTime get validUntil;

  Hip3OrderCapacity._();

  factory Hip3OrderCapacity([void updates(Hip3OrderCapacityBuilder b)]) = _$Hip3OrderCapacity;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(Hip3OrderCapacityBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<Hip3OrderCapacity> get serializer => _$Hip3OrderCapacitySerializer();
}

class _$Hip3OrderCapacitySerializer implements PrimitiveSerializer<Hip3OrderCapacity> {
  @override
  final Iterable<Type> types = const [Hip3OrderCapacity, _$Hip3OrderCapacity];

  @override
  final String wireName = r'Hip3OrderCapacity';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    Hip3OrderCapacity object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'long';
    yield serializers.serialize(
      object.long,
      specifiedType: const FullType(Hip3OrderCapacitySide),
    );
    yield r'short';
    yield serializers.serialize(
      object.short,
      specifiedType: const FullType(Hip3OrderCapacitySide),
    );
    yield r'observed_at';
    yield serializers.serialize(
      object.observedAt,
      specifiedType: const FullType(DateTime),
    );
    yield r'valid_until';
    yield serializers.serialize(
      object.validUntil,
      specifiedType: const FullType(DateTime),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    Hip3OrderCapacity object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required Hip3OrderCapacityBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'long':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(Hip3OrderCapacitySide),
          ) as Hip3OrderCapacitySide;
          result.long.replace(valueDes);
          break;
        case r'short':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(Hip3OrderCapacitySide),
          ) as Hip3OrderCapacitySide;
          result.short.replace(valueDes);
          break;
        case r'observed_at':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DateTime),
          ) as DateTime;
          result.observedAt = valueDes;
          break;
        case r'valid_until':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DateTime),
          ) as DateTime;
          result.validUntil = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  Hip3OrderCapacity deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = Hip3OrderCapacityBuilder();
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


//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'unknown_financial_raw_amount.g.dart';

/// UnknownFinancialRawAmount
///
/// Properties:
/// * [status] 
/// * [reason] 
@BuiltValue()
abstract class UnknownFinancialRawAmount implements Built<UnknownFinancialRawAmount, UnknownFinancialRawAmountBuilder> {
  @BuiltValueField(wireName: r'status')
  UnknownFinancialRawAmountStatusEnum get status;
  // enum statusEnum {  unknown,  };

  @BuiltValueField(wireName: r'reason')
  String get reason;

  UnknownFinancialRawAmount._();

  factory UnknownFinancialRawAmount([void updates(UnknownFinancialRawAmountBuilder b)]) = _$UnknownFinancialRawAmount;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(UnknownFinancialRawAmountBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<UnknownFinancialRawAmount> get serializer => _$UnknownFinancialRawAmountSerializer();
}

class _$UnknownFinancialRawAmountSerializer implements PrimitiveSerializer<UnknownFinancialRawAmount> {
  @override
  final Iterable<Type> types = const [UnknownFinancialRawAmount, _$UnknownFinancialRawAmount];

  @override
  final String wireName = r'UnknownFinancialRawAmount';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    UnknownFinancialRawAmount object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'status';
    yield serializers.serialize(
      object.status,
      specifiedType: const FullType(UnknownFinancialRawAmountStatusEnum),
    );
    yield r'reason';
    yield serializers.serialize(
      object.reason,
      specifiedType: const FullType(String),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    UnknownFinancialRawAmount object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required UnknownFinancialRawAmountBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'status':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(UnknownFinancialRawAmountStatusEnum),
          ) as UnknownFinancialRawAmountStatusEnum;
          result.status = valueDes;
          break;
        case r'reason':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
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
  UnknownFinancialRawAmount deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = UnknownFinancialRawAmountBuilder();
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

class UnknownFinancialRawAmountStatusEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'unknown')
  static const UnknownFinancialRawAmountStatusEnum unknown = _$unknownFinancialRawAmountStatusEnum_unknown;

  static Serializer<UnknownFinancialRawAmountStatusEnum> get serializer => _$unknownFinancialRawAmountStatusEnumSerializer;

  const UnknownFinancialRawAmountStatusEnum._(String name): super(name);

  static BuiltSet<UnknownFinancialRawAmountStatusEnum> get values => _$unknownFinancialRawAmountStatusEnumValues;
  static UnknownFinancialRawAmountStatusEnum valueOf(String name) => _$unknownFinancialRawAmountStatusEnumValueOf(name);
}


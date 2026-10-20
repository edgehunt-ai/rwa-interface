//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'financial_business_reference.g.dart';

/// Stable persisted business identity independent of execution, hash or Activity. type is an extensible resource name; unknown types remain visible but must not route to an unrelated resource.
///
/// Properties:
/// * [type] 
/// * [id] 
@BuiltValue()
abstract class FinancialBusinessReference implements Built<FinancialBusinessReference, FinancialBusinessReferenceBuilder> {
  @BuiltValueField(wireName: r'type')
  String get type;

  @BuiltValueField(wireName: r'id')
  String get id;

  FinancialBusinessReference._();

  factory FinancialBusinessReference([void updates(FinancialBusinessReferenceBuilder b)]) = _$FinancialBusinessReference;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(FinancialBusinessReferenceBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<FinancialBusinessReference> get serializer => _$FinancialBusinessReferenceSerializer();
}

class _$FinancialBusinessReferenceSerializer implements PrimitiveSerializer<FinancialBusinessReference> {
  @override
  final Iterable<Type> types = const [FinancialBusinessReference, _$FinancialBusinessReference];

  @override
  final String wireName = r'FinancialBusinessReference';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    FinancialBusinessReference object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'type';
    yield serializers.serialize(
      object.type,
      specifiedType: const FullType(String),
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
    FinancialBusinessReference object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required FinancialBusinessReferenceBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'type':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
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
  FinancialBusinessReference deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = FinancialBusinessReferenceBuilder();
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


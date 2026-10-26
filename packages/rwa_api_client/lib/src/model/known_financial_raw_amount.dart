//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'known_financial_raw_amount.g.dart';

/// KnownFinancialRawAmount
///
/// Properties:
/// * [status] 
/// * [amountRaw] 
@BuiltValue()
abstract class KnownFinancialRawAmount implements Built<KnownFinancialRawAmount, KnownFinancialRawAmountBuilder> {
  @BuiltValueField(wireName: r'status')
  KnownFinancialRawAmountStatusEnum get status;
  // enum statusEnum {  known,  };

  @BuiltValueField(wireName: r'amount_raw')
  String get amountRaw;

  KnownFinancialRawAmount._();

  factory KnownFinancialRawAmount([void updates(KnownFinancialRawAmountBuilder b)]) = _$KnownFinancialRawAmount;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(KnownFinancialRawAmountBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<KnownFinancialRawAmount> get serializer => _$KnownFinancialRawAmountSerializer();
}

class _$KnownFinancialRawAmountSerializer implements PrimitiveSerializer<KnownFinancialRawAmount> {
  @override
  final Iterable<Type> types = const [KnownFinancialRawAmount, _$KnownFinancialRawAmount];

  @override
  final String wireName = r'KnownFinancialRawAmount';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    KnownFinancialRawAmount object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'status';
    yield serializers.serialize(
      object.status,
      specifiedType: const FullType(KnownFinancialRawAmountStatusEnum),
    );
    yield r'amount_raw';
    yield serializers.serialize(
      object.amountRaw,
      specifiedType: const FullType(String),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    KnownFinancialRawAmount object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required KnownFinancialRawAmountBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'status':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(KnownFinancialRawAmountStatusEnum),
          ) as KnownFinancialRawAmountStatusEnum;
          result.status = valueDes;
          break;
        case r'amount_raw':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.amountRaw = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  KnownFinancialRawAmount deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = KnownFinancialRawAmountBuilder();
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

class KnownFinancialRawAmountStatusEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'known')
  static const KnownFinancialRawAmountStatusEnum known = _$knownFinancialRawAmountStatusEnum_known;

  static Serializer<KnownFinancialRawAmountStatusEnum> get serializer => _$knownFinancialRawAmountStatusEnumSerializer;

  const KnownFinancialRawAmountStatusEnum._(String name): super(name);

  static BuiltSet<KnownFinancialRawAmountStatusEnum> get values => _$knownFinancialRawAmountStatusEnumValues;
  static KnownFinancialRawAmountStatusEnum valueOf(String name) => _$knownFinancialRawAmountStatusEnumValueOf(name);
}


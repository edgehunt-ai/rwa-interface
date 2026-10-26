//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:rwa_api_client/src/model/unknown_financial_raw_amount.dart';
import 'package:rwa_api_client/src/model/known_financial_raw_amount.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:one_of/one_of.dart';

part 'financial_raw_amount.g.dart';

/// Exact nonnegative raw units or explicit unknown. Zero is known amount_raw \"0\"; unknown never implies zero. Scientific notation, signs, fractions and numeric JSON values are forbidden.
///
/// Properties:
/// * [status] 
/// * [amountRaw] 
/// * [reason] 
@BuiltValue()
abstract class FinancialRawAmount implements Built<FinancialRawAmount, FinancialRawAmountBuilder> {
  /// One Of [KnownFinancialRawAmount], [UnknownFinancialRawAmount]
  OneOf get oneOf;

  static const String discriminatorFieldName = r'status';

  static const Map<String, Type> discriminatorMapping = {
    r'known': KnownFinancialRawAmount,
    r'unknown': UnknownFinancialRawAmount,
  };

  FinancialRawAmount._();

  factory FinancialRawAmount([void updates(FinancialRawAmountBuilder b)]) = _$FinancialRawAmount;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(FinancialRawAmountBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<FinancialRawAmount> get serializer => _$FinancialRawAmountSerializer();
}

extension FinancialRawAmountDiscriminatorExt on FinancialRawAmount {
    String? get discriminatorValue {
        if (this is KnownFinancialRawAmount) {
            return r'known';
        }
        if (this is UnknownFinancialRawAmount) {
            return r'unknown';
        }
        return null;
    }
}
extension FinancialRawAmountBuilderDiscriminatorExt on FinancialRawAmountBuilder {
    String? get discriminatorValue {
        if (this is KnownFinancialRawAmountBuilder) {
            return r'known';
        }
        if (this is UnknownFinancialRawAmountBuilder) {
            return r'unknown';
        }
        return null;
    }
}

class _$FinancialRawAmountSerializer implements PrimitiveSerializer<FinancialRawAmount> {
  @override
  final Iterable<Type> types = const [FinancialRawAmount, _$FinancialRawAmount];

  @override
  final String wireName = r'FinancialRawAmount';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    FinancialRawAmount object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
  }

  @override
  Object serialize(
    Serializers serializers,
    FinancialRawAmount object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final oneOf = object.oneOf;
    return serializers.serialize(oneOf.value, specifiedType: FullType(oneOf.valueType))!;
  }

  @override
  FinancialRawAmount deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = FinancialRawAmountBuilder();
    Object? oneOfDataSrc;
    final serializedList = (serialized as Iterable<Object?>).toList();
    final discIndex = serializedList.indexOf(FinancialRawAmount.discriminatorFieldName) + 1;
    final discValue = serializers.deserialize(serializedList[discIndex], specifiedType: FullType(String)) as String;
    oneOfDataSrc = serialized;
    final oneOfTypes = [KnownFinancialRawAmount, UnknownFinancialRawAmount, ];
    Object oneOfResult;
    Type oneOfType;
    switch (discValue) {
      case r'known':
        oneOfResult = serializers.deserialize(
          oneOfDataSrc,
          specifiedType: FullType(KnownFinancialRawAmount),
        ) as KnownFinancialRawAmount;
        oneOfType = KnownFinancialRawAmount;
        break;
      case r'unknown':
        oneOfResult = serializers.deserialize(
          oneOfDataSrc,
          specifiedType: FullType(UnknownFinancialRawAmount),
        ) as UnknownFinancialRawAmount;
        oneOfType = UnknownFinancialRawAmount;
        break;
      default:
        throw UnsupportedError("Couldn't deserialize oneOf for the discriminator value: ${discValue}");
    }
    result.oneOf = OneOfDynamic(typeIndex: oneOfTypes.indexOf(oneOfType), types: oneOfTypes, value: oneOfResult);
    return result.build();
  }
}

class FinancialRawAmountStatusEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'unknown')
  static const FinancialRawAmountStatusEnum unknown = _$financialRawAmountStatusEnum_unknown;

  static Serializer<FinancialRawAmountStatusEnum> get serializer => _$financialRawAmountStatusEnumSerializer;

  const FinancialRawAmountStatusEnum._(String name): super(name);

  static BuiltSet<FinancialRawAmountStatusEnum> get values => _$financialRawAmountStatusEnumValues;
  static FinancialRawAmountStatusEnum valueOf(String name) => _$financialRawAmountStatusEnumValueOf(name);
}


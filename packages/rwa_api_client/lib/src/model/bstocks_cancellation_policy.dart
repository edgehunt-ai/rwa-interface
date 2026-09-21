//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'bstocks_cancellation_policy.g.dart';

/// BstocksCancellationPolicy
///
/// Properties:
/// * [insufficientBalance] 
/// * [insufficientAllowance] 
@BuiltValue()
abstract class BstocksCancellationPolicy implements Built<BstocksCancellationPolicy, BstocksCancellationPolicyBuilder> {
  @BuiltValueField(wireName: r'insufficient_balance')
  BstocksCancellationPolicyInsufficientBalanceEnum get insufficientBalance;
  // enum insufficientBalanceEnum {  permanent,  };

  @BuiltValueField(wireName: r'insufficient_allowance')
  BstocksCancellationPolicyInsufficientAllowanceEnum get insufficientAllowance;
  // enum insufficientAllowanceEnum {  permanent,  };

  BstocksCancellationPolicy._();

  factory BstocksCancellationPolicy([void updates(BstocksCancellationPolicyBuilder b)]) = _$BstocksCancellationPolicy;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(BstocksCancellationPolicyBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<BstocksCancellationPolicy> get serializer => _$BstocksCancellationPolicySerializer();
}

class _$BstocksCancellationPolicySerializer implements PrimitiveSerializer<BstocksCancellationPolicy> {
  @override
  final Iterable<Type> types = const [BstocksCancellationPolicy, _$BstocksCancellationPolicy];

  @override
  final String wireName = r'BstocksCancellationPolicy';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    BstocksCancellationPolicy object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'insufficient_balance';
    yield serializers.serialize(
      object.insufficientBalance,
      specifiedType: const FullType(BstocksCancellationPolicyInsufficientBalanceEnum),
    );
    yield r'insufficient_allowance';
    yield serializers.serialize(
      object.insufficientAllowance,
      specifiedType: const FullType(BstocksCancellationPolicyInsufficientAllowanceEnum),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    BstocksCancellationPolicy object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required BstocksCancellationPolicyBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'insufficient_balance':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BstocksCancellationPolicyInsufficientBalanceEnum),
          ) as BstocksCancellationPolicyInsufficientBalanceEnum;
          result.insufficientBalance = valueDes;
          break;
        case r'insufficient_allowance':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BstocksCancellationPolicyInsufficientAllowanceEnum),
          ) as BstocksCancellationPolicyInsufficientAllowanceEnum;
          result.insufficientAllowance = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  BstocksCancellationPolicy deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = BstocksCancellationPolicyBuilder();
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

class BstocksCancellationPolicyInsufficientBalanceEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'permanent')
  static const BstocksCancellationPolicyInsufficientBalanceEnum permanent = _$bstocksCancellationPolicyInsufficientBalanceEnum_permanent;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const BstocksCancellationPolicyInsufficientBalanceEnum unknownDefaultOpenApi = _$bstocksCancellationPolicyInsufficientBalanceEnum_unknownDefaultOpenApi;

  static Serializer<BstocksCancellationPolicyInsufficientBalanceEnum> get serializer => _$bstocksCancellationPolicyInsufficientBalanceEnumSerializer;

  const BstocksCancellationPolicyInsufficientBalanceEnum._(String name): super(name);

  static BuiltSet<BstocksCancellationPolicyInsufficientBalanceEnum> get values => _$bstocksCancellationPolicyInsufficientBalanceEnumValues;
  static BstocksCancellationPolicyInsufficientBalanceEnum valueOf(String name) => _$bstocksCancellationPolicyInsufficientBalanceEnumValueOf(name);
}

class BstocksCancellationPolicyInsufficientAllowanceEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'permanent')
  static const BstocksCancellationPolicyInsufficientAllowanceEnum permanent = _$bstocksCancellationPolicyInsufficientAllowanceEnum_permanent;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const BstocksCancellationPolicyInsufficientAllowanceEnum unknownDefaultOpenApi = _$bstocksCancellationPolicyInsufficientAllowanceEnum_unknownDefaultOpenApi;

  static Serializer<BstocksCancellationPolicyInsufficientAllowanceEnum> get serializer => _$bstocksCancellationPolicyInsufficientAllowanceEnumSerializer;

  const BstocksCancellationPolicyInsufficientAllowanceEnum._(String name): super(name);

  static BuiltSet<BstocksCancellationPolicyInsufficientAllowanceEnum> get values => _$bstocksCancellationPolicyInsufficientAllowanceEnumValues;
  static BstocksCancellationPolicyInsufficientAllowanceEnum valueOf(String name) => _$bstocksCancellationPolicyInsufficientAllowanceEnumValueOf(name);
}


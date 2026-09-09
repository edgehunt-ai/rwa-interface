//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'frozen_evm_transaction.g.dart';

/// Exact server-frozen EVM call; clients cannot submit or override any field. In v1 `value` is always the canonical zero quantity `0x0`; calldata is non-empty, lowercased by the server before hashing, and represents complete bytes rather than odd-length nibbles. 
///
/// Properties:
/// * [to] 
/// * [data] 
/// * [value] - Exact canonical EVM zero quantity; native-value transfers are not supported in v1.
@BuiltValue()
abstract class FrozenEvmTransaction implements Built<FrozenEvmTransaction, FrozenEvmTransactionBuilder> {
  @BuiltValueField(wireName: r'to')
  String get to;

  @BuiltValueField(wireName: r'data')
  String get data;

  /// Exact canonical EVM zero quantity; native-value transfers are not supported in v1.
  @BuiltValueField(wireName: r'value')
  FrozenEvmTransactionValueEnum get value;
  // enum valueEnum {  0x0,  };

  FrozenEvmTransaction._();

  factory FrozenEvmTransaction([void updates(FrozenEvmTransactionBuilder b)]) = _$FrozenEvmTransaction;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(FrozenEvmTransactionBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<FrozenEvmTransaction> get serializer => _$FrozenEvmTransactionSerializer();
}

class _$FrozenEvmTransactionSerializer implements PrimitiveSerializer<FrozenEvmTransaction> {
  @override
  final Iterable<Type> types = const [FrozenEvmTransaction, _$FrozenEvmTransaction];

  @override
  final String wireName = r'FrozenEvmTransaction';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    FrozenEvmTransaction object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'to';
    yield serializers.serialize(
      object.to,
      specifiedType: const FullType(String),
    );
    yield r'data';
    yield serializers.serialize(
      object.data,
      specifiedType: const FullType(String),
    );
    yield r'value';
    yield serializers.serialize(
      object.value,
      specifiedType: const FullType(FrozenEvmTransactionValueEnum),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    FrozenEvmTransaction object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required FrozenEvmTransactionBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'to':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.to = valueDes;
          break;
        case r'data':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.data = valueDes;
          break;
        case r'value':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(FrozenEvmTransactionValueEnum),
          ) as FrozenEvmTransactionValueEnum;
          result.value = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  FrozenEvmTransaction deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = FrozenEvmTransactionBuilder();
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

class FrozenEvmTransactionValueEnum extends EnumClass {

  /// Exact canonical EVM zero quantity; native-value transfers are not supported in v1.
  @BuiltValueEnumConst(wireName: r'0x0')
  static const FrozenEvmTransactionValueEnum n0x0 = _$frozenEvmTransactionValueEnum_n0x0;
  /// Exact canonical EVM zero quantity; native-value transfers are not supported in v1.
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const FrozenEvmTransactionValueEnum unknownDefaultOpenApi = _$frozenEvmTransactionValueEnum_unknownDefaultOpenApi;

  static Serializer<FrozenEvmTransactionValueEnum> get serializer => _$frozenEvmTransactionValueEnumSerializer;

  const FrozenEvmTransactionValueEnum._(String name): super(name);

  static BuiltSet<FrozenEvmTransactionValueEnum> get values => _$frozenEvmTransactionValueEnumValues;
  static FrozenEvmTransactionValueEnum valueOf(String name) => _$frozenEvmTransactionValueEnumValueOf(name);
}


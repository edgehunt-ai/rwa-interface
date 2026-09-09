//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'privy_authorization_transaction.g.dart';

/// PrivyAuthorizationTransaction
///
/// Properties:
/// * [from] - Exact server-bound Privy wallet address; the client cannot override it.
/// * [to] 
/// * [data] 
/// * [value] 
@BuiltValue()
abstract class PrivyAuthorizationTransaction implements Built<PrivyAuthorizationTransaction, PrivyAuthorizationTransactionBuilder> {
  /// Exact server-bound Privy wallet address; the client cannot override it.
  @BuiltValueField(wireName: r'from')
  String get from;

  @BuiltValueField(wireName: r'to')
  String get to;

  @BuiltValueField(wireName: r'data')
  String get data;

  @BuiltValueField(wireName: r'value')
  PrivyAuthorizationTransactionValueEnum get value;
  // enum valueEnum {  0x0,  };

  PrivyAuthorizationTransaction._();

  factory PrivyAuthorizationTransaction([void updates(PrivyAuthorizationTransactionBuilder b)]) = _$PrivyAuthorizationTransaction;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(PrivyAuthorizationTransactionBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<PrivyAuthorizationTransaction> get serializer => _$PrivyAuthorizationTransactionSerializer();
}

class _$PrivyAuthorizationTransactionSerializer implements PrimitiveSerializer<PrivyAuthorizationTransaction> {
  @override
  final Iterable<Type> types = const [PrivyAuthorizationTransaction, _$PrivyAuthorizationTransaction];

  @override
  final String wireName = r'PrivyAuthorizationTransaction';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    PrivyAuthorizationTransaction object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'from';
    yield serializers.serialize(
      object.from,
      specifiedType: const FullType(String),
    );
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
      specifiedType: const FullType(PrivyAuthorizationTransactionValueEnum),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    PrivyAuthorizationTransaction object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required PrivyAuthorizationTransactionBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'from':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.from = valueDes;
          break;
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
            specifiedType: const FullType(PrivyAuthorizationTransactionValueEnum),
          ) as PrivyAuthorizationTransactionValueEnum;
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
  PrivyAuthorizationTransaction deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = PrivyAuthorizationTransactionBuilder();
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

class PrivyAuthorizationTransactionValueEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'0x0')
  static const PrivyAuthorizationTransactionValueEnum n0x0 = _$privyAuthorizationTransactionValueEnum_n0x0;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const PrivyAuthorizationTransactionValueEnum unknownDefaultOpenApi = _$privyAuthorizationTransactionValueEnum_unknownDefaultOpenApi;

  static Serializer<PrivyAuthorizationTransactionValueEnum> get serializer => _$privyAuthorizationTransactionValueEnumSerializer;

  const PrivyAuthorizationTransactionValueEnum._(String name): super(name);

  static BuiltSet<PrivyAuthorizationTransactionValueEnum> get values => _$privyAuthorizationTransactionValueEnumValues;
  static PrivyAuthorizationTransactionValueEnum valueOf(String name) => _$privyAuthorizationTransactionValueEnumValueOf(name);
}


//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'hip3_withdrawal_nonce_mapping.g.dart';

/// 仅 relay rail 创建响应返回：提交时必需的 `RelayNonceMapping` EIP-712 签名材料。 客户端先签此 typed_data，将其签名作为 `nonce_mapping_signature` 与 venue 签名一并提交。 
///
/// Properties:
/// * [typedData] - 精确 EIP-712 typed data JSON；客户端必须原样签名。
/// * [payloadHash] - 该 typed data 的 EIP-712 digest。
@BuiltValue()
abstract class Hip3WithdrawalNonceMapping implements Built<Hip3WithdrawalNonceMapping, Hip3WithdrawalNonceMappingBuilder> {
  /// 精确 EIP-712 typed data JSON；客户端必须原样签名。
  @BuiltValueField(wireName: r'typed_data')
  String? get typedData;

  /// 该 typed data 的 EIP-712 digest。
  @BuiltValueField(wireName: r'payload_hash')
  String? get payloadHash;

  Hip3WithdrawalNonceMapping._();

  factory Hip3WithdrawalNonceMapping([void updates(Hip3WithdrawalNonceMappingBuilder b)]) = _$Hip3WithdrawalNonceMapping;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(Hip3WithdrawalNonceMappingBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<Hip3WithdrawalNonceMapping> get serializer => _$Hip3WithdrawalNonceMappingSerializer();
}

class _$Hip3WithdrawalNonceMappingSerializer implements PrimitiveSerializer<Hip3WithdrawalNonceMapping> {
  @override
  final Iterable<Type> types = const [Hip3WithdrawalNonceMapping, _$Hip3WithdrawalNonceMapping];

  @override
  final String wireName = r'Hip3WithdrawalNonceMapping';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    Hip3WithdrawalNonceMapping object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.typedData != null) {
      yield r'typed_data';
      yield serializers.serialize(
        object.typedData,
        specifiedType: const FullType(String),
      );
    }
    if (object.payloadHash != null) {
      yield r'payload_hash';
      yield serializers.serialize(
        object.payloadHash,
        specifiedType: const FullType(String),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    Hip3WithdrawalNonceMapping object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required Hip3WithdrawalNonceMappingBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'typed_data':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.typedData = valueDes;
          break;
        case r'payload_hash':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.payloadHash = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  Hip3WithdrawalNonceMapping deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = Hip3WithdrawalNonceMappingBuilder();
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


//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:rwa_api_client/src/model/privy_authorization_transaction.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'privy_authorization_params.g.dart';

/// PrivyAuthorizationParams
///
/// Properties:
/// * [transaction]
@BuiltValue()
abstract class PrivyAuthorizationParams
    implements
        Built<PrivyAuthorizationParams, PrivyAuthorizationParamsBuilder> {
  @BuiltValueField(wireName: r'transaction')
  PrivyAuthorizationTransaction get transaction;

  PrivyAuthorizationParams._();

  factory PrivyAuthorizationParams(
          [void updates(PrivyAuthorizationParamsBuilder b)]) =
      _$PrivyAuthorizationParams;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(PrivyAuthorizationParamsBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<PrivyAuthorizationParams> get serializer =>
      _$PrivyAuthorizationParamsSerializer();
}

class _$PrivyAuthorizationParamsSerializer
    implements PrimitiveSerializer<PrivyAuthorizationParams> {
  @override
  final Iterable<Type> types = const [
    PrivyAuthorizationParams,
    _$PrivyAuthorizationParams
  ];

  @override
  final String wireName = r'PrivyAuthorizationParams';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    PrivyAuthorizationParams object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'transaction';
    yield serializers.serialize(
      object.transaction,
      specifiedType: const FullType(PrivyAuthorizationTransaction),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    PrivyAuthorizationParams object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object,
            specifiedType: specifiedType)
        .toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required PrivyAuthorizationParamsBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'transaction':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(PrivyAuthorizationTransaction),
          ) as PrivyAuthorizationTransaction;
          result.transaction.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  PrivyAuthorizationParams deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = PrivyAuthorizationParamsBuilder();
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

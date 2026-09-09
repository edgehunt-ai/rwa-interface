//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'wallet_action_complete_request.g.dart';

/// WalletActionCompleteRequest
///
/// Properties:
/// * [signature] - Privy-produced signature for the exact server-frozen legacy order action.
@BuiltValue()
abstract class WalletActionCompleteRequest
    implements
        Built<WalletActionCompleteRequest, WalletActionCompleteRequestBuilder> {
  /// Privy-produced signature for the exact server-frozen legacy order action.
  @BuiltValueField(wireName: r'signature')
  String get signature;

  WalletActionCompleteRequest._();

  factory WalletActionCompleteRequest(
          [void updates(WalletActionCompleteRequestBuilder b)]) =
      _$WalletActionCompleteRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(WalletActionCompleteRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<WalletActionCompleteRequest> get serializer =>
      _$WalletActionCompleteRequestSerializer();
}

class _$WalletActionCompleteRequestSerializer
    implements PrimitiveSerializer<WalletActionCompleteRequest> {
  @override
  final Iterable<Type> types = const [
    WalletActionCompleteRequest,
    _$WalletActionCompleteRequest
  ];

  @override
  final String wireName = r'WalletActionCompleteRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    WalletActionCompleteRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'signature';
    yield serializers.serialize(
      object.signature,
      specifiedType: const FullType(String),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    WalletActionCompleteRequest object, {
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
    required WalletActionCompleteRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'signature':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.signature = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  WalletActionCompleteRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = WalletActionCompleteRequestBuilder();
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

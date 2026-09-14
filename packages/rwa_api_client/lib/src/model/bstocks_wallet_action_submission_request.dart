//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'bstocks_wallet_action_submission_request.g.dart';

/// BstocksWalletActionSubmissionRequest
///
/// Properties:
/// * [txHash] - Untrusted transaction locator; the Router observer independently verifies it.
@BuiltValue()
abstract class BstocksWalletActionSubmissionRequest implements Built<BstocksWalletActionSubmissionRequest, BstocksWalletActionSubmissionRequestBuilder> {
  /// Untrusted transaction locator; the Router observer independently verifies it.
  @BuiltValueField(wireName: r'tx_hash')
  String get txHash;

  BstocksWalletActionSubmissionRequest._();

  factory BstocksWalletActionSubmissionRequest([void updates(BstocksWalletActionSubmissionRequestBuilder b)]) = _$BstocksWalletActionSubmissionRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(BstocksWalletActionSubmissionRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<BstocksWalletActionSubmissionRequest> get serializer => _$BstocksWalletActionSubmissionRequestSerializer();
}

class _$BstocksWalletActionSubmissionRequestSerializer implements PrimitiveSerializer<BstocksWalletActionSubmissionRequest> {
  @override
  final Iterable<Type> types = const [BstocksWalletActionSubmissionRequest, _$BstocksWalletActionSubmissionRequest];

  @override
  final String wireName = r'BstocksWalletActionSubmissionRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    BstocksWalletActionSubmissionRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'tx_hash';
    yield serializers.serialize(
      object.txHash,
      specifiedType: const FullType(String),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    BstocksWalletActionSubmissionRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required BstocksWalletActionSubmissionRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'tx_hash':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.txHash = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  BstocksWalletActionSubmissionRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = BstocksWalletActionSubmissionRequestBuilder();
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


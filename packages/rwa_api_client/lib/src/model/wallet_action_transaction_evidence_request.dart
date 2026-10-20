//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'wallet_action_transaction_evidence_request.g.dart';

/// WalletActionTransactionEvidenceRequest
///
/// Properties:
/// * [txHash] - Read-only historical user_wallet transaction locator, never permission to broadcast. The server independently verifies the frozen call and canonical receipt; new privy_native executions require authorization signatures instead and reject this variant. 
@BuiltValue()
abstract class WalletActionTransactionEvidenceRequest implements Built<WalletActionTransactionEvidenceRequest, WalletActionTransactionEvidenceRequestBuilder> {
  /// Read-only historical user_wallet transaction locator, never permission to broadcast. The server independently verifies the frozen call and canonical receipt; new privy_native executions require authorization signatures instead and reject this variant. 
  @BuiltValueField(wireName: r'tx_hash')
  String get txHash;

  WalletActionTransactionEvidenceRequest._();

  factory WalletActionTransactionEvidenceRequest([void updates(WalletActionTransactionEvidenceRequestBuilder b)]) = _$WalletActionTransactionEvidenceRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(WalletActionTransactionEvidenceRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<WalletActionTransactionEvidenceRequest> get serializer => _$WalletActionTransactionEvidenceRequestSerializer();
}

class _$WalletActionTransactionEvidenceRequestSerializer implements PrimitiveSerializer<WalletActionTransactionEvidenceRequest> {
  @override
  final Iterable<Type> types = const [WalletActionTransactionEvidenceRequest, _$WalletActionTransactionEvidenceRequest];

  @override
  final String wireName = r'WalletActionTransactionEvidenceRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    WalletActionTransactionEvidenceRequest object, {
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
    WalletActionTransactionEvidenceRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required WalletActionTransactionEvidenceRequestBuilder result,
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
  WalletActionTransactionEvidenceRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = WalletActionTransactionEvidenceRequestBuilder();
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


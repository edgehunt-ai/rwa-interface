//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'wallet_action_chain_observation.g.dart';

/// Independently verified canonical-chain evidence for the exact frozen call.
///
/// Properties:
/// * [txHash]
/// * [sender]
/// * [recipient]
/// * [payloadHash]
/// * [value]
/// * [receiptSuccess]
/// * [canonical]
/// * [blockNumber]
/// * [blockHash]
/// * [confirmations]
/// * [observedAt]
@BuiltValue()
abstract class WalletActionChainObservation
    implements
        Built<WalletActionChainObservation,
            WalletActionChainObservationBuilder> {
  @BuiltValueField(wireName: r'tx_hash')
  String get txHash;

  @BuiltValueField(wireName: r'sender')
  String get sender;

  @BuiltValueField(wireName: r'recipient')
  String get recipient;

  @BuiltValueField(wireName: r'payload_hash')
  String get payloadHash;

  @BuiltValueField(wireName: r'value')
  WalletActionChainObservationValueEnum get value;
  // enum valueEnum {  0x0,  };

  @BuiltValueField(wireName: r'receipt_success')
  bool get receiptSuccess;

  @BuiltValueField(wireName: r'canonical')
  bool get canonical;

  @BuiltValueField(wireName: r'block_number')
  int get blockNumber;

  @BuiltValueField(wireName: r'block_hash')
  String get blockHash;

  @BuiltValueField(wireName: r'confirmations')
  int get confirmations;

  @BuiltValueField(wireName: r'observed_at')
  DateTime get observedAt;

  WalletActionChainObservation._();

  factory WalletActionChainObservation(
          [void updates(WalletActionChainObservationBuilder b)]) =
      _$WalletActionChainObservation;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(WalletActionChainObservationBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<WalletActionChainObservation> get serializer =>
      _$WalletActionChainObservationSerializer();
}

class _$WalletActionChainObservationSerializer
    implements PrimitiveSerializer<WalletActionChainObservation> {
  @override
  final Iterable<Type> types = const [
    WalletActionChainObservation,
    _$WalletActionChainObservation
  ];

  @override
  final String wireName = r'WalletActionChainObservation';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    WalletActionChainObservation object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'tx_hash';
    yield serializers.serialize(
      object.txHash,
      specifiedType: const FullType(String),
    );
    yield r'sender';
    yield serializers.serialize(
      object.sender,
      specifiedType: const FullType(String),
    );
    yield r'recipient';
    yield serializers.serialize(
      object.recipient,
      specifiedType: const FullType(String),
    );
    yield r'payload_hash';
    yield serializers.serialize(
      object.payloadHash,
      specifiedType: const FullType(String),
    );
    yield r'value';
    yield serializers.serialize(
      object.value,
      specifiedType: const FullType(WalletActionChainObservationValueEnum),
    );
    yield r'receipt_success';
    yield serializers.serialize(
      object.receiptSuccess,
      specifiedType: const FullType(bool),
    );
    yield r'canonical';
    yield serializers.serialize(
      object.canonical,
      specifiedType: const FullType(bool),
    );
    yield r'block_number';
    yield serializers.serialize(
      object.blockNumber,
      specifiedType: const FullType(int),
    );
    yield r'block_hash';
    yield serializers.serialize(
      object.blockHash,
      specifiedType: const FullType(String),
    );
    yield r'confirmations';
    yield serializers.serialize(
      object.confirmations,
      specifiedType: const FullType(int),
    );
    yield r'observed_at';
    yield serializers.serialize(
      object.observedAt,
      specifiedType: const FullType(DateTime),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    WalletActionChainObservation object, {
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
    required WalletActionChainObservationBuilder result,
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
        case r'sender':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.sender = valueDes;
          break;
        case r'recipient':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.recipient = valueDes;
          break;
        case r'payload_hash':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.payloadHash = valueDes;
          break;
        case r'value':
          final valueDes = serializers.deserialize(
            value,
            specifiedType:
                const FullType(WalletActionChainObservationValueEnum),
          ) as WalletActionChainObservationValueEnum;
          result.value = valueDes;
          break;
        case r'receipt_success':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.receiptSuccess = valueDes;
          break;
        case r'canonical':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.canonical = valueDes;
          break;
        case r'block_number':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.blockNumber = valueDes;
          break;
        case r'block_hash':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.blockHash = valueDes;
          break;
        case r'confirmations':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.confirmations = valueDes;
          break;
        case r'observed_at':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DateTime),
          ) as DateTime;
          result.observedAt = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  WalletActionChainObservation deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = WalletActionChainObservationBuilder();
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

class WalletActionChainObservationValueEnum extends EnumClass {
  @BuiltValueEnumConst(wireName: r'0x0')
  static const WalletActionChainObservationValueEnum n0x0 =
      _$walletActionChainObservationValueEnum_n0x0;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const WalletActionChainObservationValueEnum unknownDefaultOpenApi =
      _$walletActionChainObservationValueEnum_unknownDefaultOpenApi;

  static Serializer<WalletActionChainObservationValueEnum> get serializer =>
      _$walletActionChainObservationValueEnumSerializer;

  const WalletActionChainObservationValueEnum._(String name) : super(name);

  static BuiltSet<WalletActionChainObservationValueEnum> get values =>
      _$walletActionChainObservationValueEnumValues;
  static WalletActionChainObservationValueEnum valueOf(String name) =>
      _$walletActionChainObservationValueEnumValueOf(name);
}

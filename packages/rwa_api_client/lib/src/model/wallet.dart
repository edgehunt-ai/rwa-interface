//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:rwa_api_client/src/model/wallet_status.dart';
import 'package:rwa_api_client/src/model/chain.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'wallet.g.dart';

/// Wallet
///
/// Properties:
/// * [walletId] 
/// * [address] 
/// * [chain] 
/// * [status] 
/// * [createdAt] - RFC 3339 UTC timestamp
@BuiltValue()
abstract class Wallet implements Built<Wallet, WalletBuilder> {
  @BuiltValueField(wireName: r'wallet_id')
  String get walletId;

  @BuiltValueField(wireName: r'address')
  String get address;

  @BuiltValueField(wireName: r'chain')
  Chain get chain;
  // enum chainEnum {  BSC,  Arbitrum,  Base,  Ethereum,  Hyperliquid,  Polygon,  Solana,  };

  @BuiltValueField(wireName: r'status')
  WalletStatus get status;
  // enum statusEnum {  active,  verification_required,  disabled,  };

  /// RFC 3339 UTC timestamp
  @BuiltValueField(wireName: r'created_at')
  DateTime get createdAt;

  Wallet._();

  factory Wallet([void updates(WalletBuilder b)]) = _$Wallet;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(WalletBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<Wallet> get serializer => _$WalletSerializer();
}

class _$WalletSerializer implements PrimitiveSerializer<Wallet> {
  @override
  final Iterable<Type> types = const [Wallet, _$Wallet];

  @override
  final String wireName = r'Wallet';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    Wallet object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'wallet_id';
    yield serializers.serialize(
      object.walletId,
      specifiedType: const FullType(String),
    );
    yield r'address';
    yield serializers.serialize(
      object.address,
      specifiedType: const FullType(String),
    );
    yield r'chain';
    yield serializers.serialize(
      object.chain,
      specifiedType: const FullType(Chain),
    );
    yield r'status';
    yield serializers.serialize(
      object.status,
      specifiedType: const FullType(WalletStatus),
    );
    yield r'created_at';
    yield serializers.serialize(
      object.createdAt,
      specifiedType: const FullType(DateTime),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    Wallet object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required WalletBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'wallet_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.walletId = valueDes;
          break;
        case r'address':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.address = valueDes;
          break;
        case r'chain':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(Chain),
          ) as Chain;
          result.chain = valueDes;
          break;
        case r'status':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(WalletStatus),
          ) as WalletStatus;
          result.status = valueDes;
          break;
        case r'created_at':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DateTime),
          ) as DateTime;
          result.createdAt = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  Wallet deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = WalletBuilder();
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


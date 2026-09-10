//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:rwa_api_client/src/model/deposit_instruction_wallet.dart';
import 'package:rwa_api_client/src/model/deposit_instruction_item.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'deposit_instructions_response.g.dart';

/// Account-specific source of truth for the Embedded EVM Wallet and all eight supported deposit rails. Target settlement identities, Provider capability matrices and route selection are intentionally excluded and are returned only by a frozen funding plan. 
///
/// Properties:
/// * [catalogVersion] 
/// * [wallet] - Null when no unique active verified Embedded EVM Wallet is available. In that state every item must be unavailable and therefore omit `qr_payload`. 
/// * [items] - Runtime invariant: exactly one item for each canonical Ethereum/Arbitrum/Base/BSC USDC/USDT identity, with every identity appearing exactly once. OpenAPI 3.0 cannot express uniqueness by nested identity, so the server must enforce this invariant before serialization. Items are ordered by numeric `chain_id` ascending, then by `token_contract` lexicographic ascending within the same chain. 
/// * [updatedAt] 
@BuiltValue()
abstract class DepositInstructionsResponse implements Built<DepositInstructionsResponse, DepositInstructionsResponseBuilder> {
  @BuiltValueField(wireName: r'catalog_version')
  String get catalogVersion;

  /// Null when no unique active verified Embedded EVM Wallet is available. In that state every item must be unavailable and therefore omit `qr_payload`. 
  @BuiltValueField(wireName: r'wallet')
  DepositInstructionWallet? get wallet;

  /// Runtime invariant: exactly one item for each canonical Ethereum/Arbitrum/Base/BSC USDC/USDT identity, with every identity appearing exactly once. OpenAPI 3.0 cannot express uniqueness by nested identity, so the server must enforce this invariant before serialization. Items are ordered by numeric `chain_id` ascending, then by `token_contract` lexicographic ascending within the same chain. 
  @BuiltValueField(wireName: r'items')
  BuiltList<DepositInstructionItem> get items;

  @BuiltValueField(wireName: r'updated_at')
  DateTime get updatedAt;

  DepositInstructionsResponse._();

  factory DepositInstructionsResponse([void updates(DepositInstructionsResponseBuilder b)]) = _$DepositInstructionsResponse;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(DepositInstructionsResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<DepositInstructionsResponse> get serializer => _$DepositInstructionsResponseSerializer();
}

class _$DepositInstructionsResponseSerializer implements PrimitiveSerializer<DepositInstructionsResponse> {
  @override
  final Iterable<Type> types = const [DepositInstructionsResponse, _$DepositInstructionsResponse];

  @override
  final String wireName = r'DepositInstructionsResponse';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    DepositInstructionsResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'catalog_version';
    yield serializers.serialize(
      object.catalogVersion,
      specifiedType: const FullType(String),
    );
    yield r'wallet';
    yield object.wallet == null ? null : serializers.serialize(
      object.wallet,
      specifiedType: const FullType.nullable(DepositInstructionWallet),
    );
    yield r'items';
    yield serializers.serialize(
      object.items,
      specifiedType: const FullType(BuiltList, [FullType(DepositInstructionItem)]),
    );
    yield r'updated_at';
    yield serializers.serialize(
      object.updatedAt,
      specifiedType: const FullType(DateTime),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    DepositInstructionsResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required DepositInstructionsResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'catalog_version':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.catalogVersion = valueDes;
          break;
        case r'wallet':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(DepositInstructionWallet),
          ) as DepositInstructionWallet?;
          if (valueDes == null) continue;
          result.wallet.replace(valueDes);
          break;
        case r'items':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(DepositInstructionItem)]),
          ) as BuiltList<DepositInstructionItem>;
          result.items.replace(valueDes);
          break;
        case r'updated_at':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DateTime),
          ) as DateTime;
          result.updatedAt = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  DepositInstructionsResponse deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = DepositInstructionsResponseBuilder();
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


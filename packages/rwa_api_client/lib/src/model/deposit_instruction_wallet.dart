//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'deposit_instruction_wallet.g.dart';

/// The current account's unique active and verified Embedded EVM Wallet.
///
/// Properties:
/// * [walletId] 
/// * [address] 
/// * [custody] 
@BuiltValue()
abstract class DepositInstructionWallet implements Built<DepositInstructionWallet, DepositInstructionWalletBuilder> {
  @BuiltValueField(wireName: r'wallet_id')
  String get walletId;

  @BuiltValueField(wireName: r'address')
  String get address;

  @BuiltValueField(wireName: r'custody')
  DepositInstructionWalletCustodyEnum get custody;
  // enum custodyEnum {  embedded_wallet,  };

  DepositInstructionWallet._();

  factory DepositInstructionWallet([void updates(DepositInstructionWalletBuilder b)]) = _$DepositInstructionWallet;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(DepositInstructionWalletBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<DepositInstructionWallet> get serializer => _$DepositInstructionWalletSerializer();
}

class _$DepositInstructionWalletSerializer implements PrimitiveSerializer<DepositInstructionWallet> {
  @override
  final Iterable<Type> types = const [DepositInstructionWallet, _$DepositInstructionWallet];

  @override
  final String wireName = r'DepositInstructionWallet';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    DepositInstructionWallet object, {
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
    yield r'custody';
    yield serializers.serialize(
      object.custody,
      specifiedType: const FullType(DepositInstructionWalletCustodyEnum),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    DepositInstructionWallet object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required DepositInstructionWalletBuilder result,
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
        case r'custody':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DepositInstructionWalletCustodyEnum),
          ) as DepositInstructionWalletCustodyEnum;
          result.custody = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  DepositInstructionWallet deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = DepositInstructionWalletBuilder();
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

class DepositInstructionWalletCustodyEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'embedded_wallet')
  static const DepositInstructionWalletCustodyEnum embeddedWallet = _$depositInstructionWalletCustodyEnum_embeddedWallet;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const DepositInstructionWalletCustodyEnum unknownDefaultOpenApi = _$depositInstructionWalletCustodyEnum_unknownDefaultOpenApi;

  static Serializer<DepositInstructionWalletCustodyEnum> get serializer => _$depositInstructionWalletCustodyEnumSerializer;

  const DepositInstructionWalletCustodyEnum._(String name): super(name);

  static BuiltSet<DepositInstructionWalletCustodyEnum> get values => _$depositInstructionWalletCustodyEnumValues;
  static DepositInstructionWalletCustodyEnum valueOf(String name) => _$depositInstructionWalletCustodyEnumValueOf(name);
}


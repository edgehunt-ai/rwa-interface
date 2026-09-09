//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:rwa_api_client/src/model/gas_payment_quote.dart';
import 'package:rwa_api_client/src/model/origin_transaction_action.dart';
import 'package:rwa_api_client/src/model/transfer_action_status.dart';
import 'package:built_collection/built_collection.dart';
import 'package:rwa_api_client/src/model/erc20_approval_action.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:one_of/one_of.dart';

part 'ready_funding_wallet_action.g.dart';

/// The server must return only actions whose `status` is `ready`.
///
/// Properties:
/// * [actionId] 
/// * [ordinal] 
/// * [kind] 
/// * [chainId] 
/// * [from] 
/// * [to] 
/// * [data] 
/// * [value] - Native-value transfer is forbidden; v1 only executes zero-value contract calls.
/// * [payloadHash] 
/// * [validUntil] 
/// * [status] 
/// * [gasPayment] 
/// * [tokenContract] 
/// * [spender] 
/// * [approvalAmount] - 十进制字符串，避免浮点误差
/// * [recipient] 
/// * [refundAddress] 
@BuiltValue()
abstract class ReadyFundingWalletAction implements Built<ReadyFundingWalletAction, ReadyFundingWalletActionBuilder> {
  /// One Of [Erc20ApprovalAction], [OriginTransactionAction]
  OneOf get oneOf;

  static const String discriminatorFieldName = r'kind';

  static const Map<String, Type> discriminatorMapping = {
    r'erc20_approval': Erc20ApprovalAction,
    r'origin_transaction': OriginTransactionAction,
  };

  ReadyFundingWalletAction._();

  factory ReadyFundingWalletAction([void updates(ReadyFundingWalletActionBuilder b)]) = _$ReadyFundingWalletAction;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ReadyFundingWalletActionBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ReadyFundingWalletAction> get serializer => _$ReadyFundingWalletActionSerializer();
}

extension ReadyFundingWalletActionDiscriminatorExt on ReadyFundingWalletAction {
    String? get discriminatorValue {
        if (this is Erc20ApprovalAction) {
            return r'erc20_approval';
        }
        if (this is OriginTransactionAction) {
            return r'origin_transaction';
        }
        return null;
    }
}
extension ReadyFundingWalletActionBuilderDiscriminatorExt on ReadyFundingWalletActionBuilder {
    String? get discriminatorValue {
        if (this is Erc20ApprovalActionBuilder) {
            return r'erc20_approval';
        }
        if (this is OriginTransactionActionBuilder) {
            return r'origin_transaction';
        }
        return null;
    }
}

class _$ReadyFundingWalletActionSerializer implements PrimitiveSerializer<ReadyFundingWalletAction> {
  @override
  final Iterable<Type> types = const [ReadyFundingWalletAction, _$ReadyFundingWalletAction];

  @override
  final String wireName = r'ReadyFundingWalletAction';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ReadyFundingWalletAction object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
  }

  @override
  Object serialize(
    Serializers serializers,
    ReadyFundingWalletAction object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final oneOf = object.oneOf;
    return serializers.serialize(oneOf.value, specifiedType: FullType(oneOf.valueType))!;
  }

  @override
  ReadyFundingWalletAction deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ReadyFundingWalletActionBuilder();
    Object? oneOfDataSrc;
    final serializedList = (serialized as Iterable<Object?>).toList();
    final discIndex = serializedList.indexOf(ReadyFundingWalletAction.discriminatorFieldName) + 1;
    final discValue = serializers.deserialize(serializedList[discIndex], specifiedType: FullType(String)) as String;
    oneOfDataSrc = serialized;
    final oneOfTypes = [Erc20ApprovalAction, OriginTransactionAction, ];
    Object oneOfResult;
    Type oneOfType;
    switch (discValue) {
      case r'erc20_approval':
        oneOfResult = serializers.deserialize(
          oneOfDataSrc,
          specifiedType: FullType(Erc20ApprovalAction),
        ) as Erc20ApprovalAction;
        oneOfType = Erc20ApprovalAction;
        break;
      case r'origin_transaction':
        oneOfResult = serializers.deserialize(
          oneOfDataSrc,
          specifiedType: FullType(OriginTransactionAction),
        ) as OriginTransactionAction;
        oneOfType = OriginTransactionAction;
        break;
      default:
        throw UnsupportedError("Couldn't deserialize oneOf for the discriminator value: ${discValue}");
    }
    result.oneOf = OneOfDynamic(typeIndex: oneOfTypes.indexOf(oneOfType), types: oneOfTypes, value: oneOfResult);
    return result.build();
  }
}

class ReadyFundingWalletActionKindEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'origin_transaction')
  static const ReadyFundingWalletActionKindEnum originTransaction = _$readyFundingWalletActionKindEnum_originTransaction;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const ReadyFundingWalletActionKindEnum unknownDefaultOpenApi = _$readyFundingWalletActionKindEnum_unknownDefaultOpenApi;

  static Serializer<ReadyFundingWalletActionKindEnum> get serializer => _$readyFundingWalletActionKindEnumSerializer;

  const ReadyFundingWalletActionKindEnum._(String name): super(name);

  static BuiltSet<ReadyFundingWalletActionKindEnum> get values => _$readyFundingWalletActionKindEnumValues;
  static ReadyFundingWalletActionKindEnum valueOf(String name) => _$readyFundingWalletActionKindEnumValueOf(name);
}

class ReadyFundingWalletActionChainIdEnum extends EnumClass {

  @BuiltValueEnumConst(wireNumber: 1)
  static const ReadyFundingWalletActionChainIdEnum number1 = _$readyFundingWalletActionChainIdEnum_number1;
  @BuiltValueEnumConst(wireNumber: 56)
  static const ReadyFundingWalletActionChainIdEnum number56 = _$readyFundingWalletActionChainIdEnum_number56;
  @BuiltValueEnumConst(wireNumber: 8453)
  static const ReadyFundingWalletActionChainIdEnum number8453 = _$readyFundingWalletActionChainIdEnum_number8453;
  @BuiltValueEnumConst(wireNumber: 42161)
  static const ReadyFundingWalletActionChainIdEnum number42161 = _$readyFundingWalletActionChainIdEnum_number42161;
  @BuiltValueEnumConst(wireNumber: 11184809, fallback: true)
  static const ReadyFundingWalletActionChainIdEnum unknownDefaultOpenApi = _$readyFundingWalletActionChainIdEnum_unknownDefaultOpenApi;

  static Serializer<ReadyFundingWalletActionChainIdEnum> get serializer => _$readyFundingWalletActionChainIdEnumSerializer;

  const ReadyFundingWalletActionChainIdEnum._(String name): super(name);

  static BuiltSet<ReadyFundingWalletActionChainIdEnum> get values => _$readyFundingWalletActionChainIdEnumValues;
  static ReadyFundingWalletActionChainIdEnum valueOf(String name) => _$readyFundingWalletActionChainIdEnumValueOf(name);
}

class ReadyFundingWalletActionValueEnum extends EnumClass {

  /// Native-value transfer is forbidden; v1 only executes zero-value contract calls.
  @BuiltValueEnumConst(wireName: r'0x0')
  static const ReadyFundingWalletActionValueEnum n0x0 = _$readyFundingWalletActionValueEnum_n0x0;
  /// Native-value transfer is forbidden; v1 only executes zero-value contract calls.
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const ReadyFundingWalletActionValueEnum unknownDefaultOpenApi = _$readyFundingWalletActionValueEnum_unknownDefaultOpenApi;

  static Serializer<ReadyFundingWalletActionValueEnum> get serializer => _$readyFundingWalletActionValueEnumSerializer;

  const ReadyFundingWalletActionValueEnum._(String name): super(name);

  static BuiltSet<ReadyFundingWalletActionValueEnum> get values => _$readyFundingWalletActionValueEnumValues;
  static ReadyFundingWalletActionValueEnum valueOf(String name) => _$readyFundingWalletActionValueEnumValueOf(name);
}


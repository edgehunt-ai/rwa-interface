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

part 'funding_wallet_action.g.dart';

/// A server-frozen action. Provider signature steps, permit, gasless, calls arrays, multicall and embedded destination actions are not representable by this contract. 
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
abstract class FundingWalletAction implements Built<FundingWalletAction, FundingWalletActionBuilder> {
  /// One Of [Erc20ApprovalAction], [OriginTransactionAction]
  OneOf get oneOf;

  static const String discriminatorFieldName = r'kind';

  static const Map<String, Type> discriminatorMapping = {
    r'erc20_approval': Erc20ApprovalAction,
    r'origin_transaction': OriginTransactionAction,
  };

  FundingWalletAction._();

  factory FundingWalletAction([void updates(FundingWalletActionBuilder b)]) = _$FundingWalletAction;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(FundingWalletActionBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<FundingWalletAction> get serializer => _$FundingWalletActionSerializer();
}

extension FundingWalletActionDiscriminatorExt on FundingWalletAction {
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
extension FundingWalletActionBuilderDiscriminatorExt on FundingWalletActionBuilder {
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

class _$FundingWalletActionSerializer implements PrimitiveSerializer<FundingWalletAction> {
  @override
  final Iterable<Type> types = const [FundingWalletAction, _$FundingWalletAction];

  @override
  final String wireName = r'FundingWalletAction';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    FundingWalletAction object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
  }

  @override
  Object serialize(
    Serializers serializers,
    FundingWalletAction object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final oneOf = object.oneOf;
    return serializers.serialize(oneOf.value, specifiedType: FullType(oneOf.valueType))!;
  }

  @override
  FundingWalletAction deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = FundingWalletActionBuilder();
    Object? oneOfDataSrc;
    final serializedList = (serialized as Iterable<Object?>).toList();
    final discIndex = serializedList.indexOf(FundingWalletAction.discriminatorFieldName) + 1;
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

class FundingWalletActionKindEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'origin_transaction')
  static const FundingWalletActionKindEnum originTransaction = _$fundingWalletActionKindEnum_originTransaction;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const FundingWalletActionKindEnum unknownDefaultOpenApi = _$fundingWalletActionKindEnum_unknownDefaultOpenApi;

  static Serializer<FundingWalletActionKindEnum> get serializer => _$fundingWalletActionKindEnumSerializer;

  const FundingWalletActionKindEnum._(String name): super(name);

  static BuiltSet<FundingWalletActionKindEnum> get values => _$fundingWalletActionKindEnumValues;
  static FundingWalletActionKindEnum valueOf(String name) => _$fundingWalletActionKindEnumValueOf(name);
}

class FundingWalletActionChainIdEnum extends EnumClass {

  @BuiltValueEnumConst(wireNumber: 1)
  static const FundingWalletActionChainIdEnum number1 = _$fundingWalletActionChainIdEnum_number1;
  @BuiltValueEnumConst(wireNumber: 56)
  static const FundingWalletActionChainIdEnum number56 = _$fundingWalletActionChainIdEnum_number56;
  @BuiltValueEnumConst(wireNumber: 8453)
  static const FundingWalletActionChainIdEnum number8453 = _$fundingWalletActionChainIdEnum_number8453;
  @BuiltValueEnumConst(wireNumber: 42161)
  static const FundingWalletActionChainIdEnum number42161 = _$fundingWalletActionChainIdEnum_number42161;
  @BuiltValueEnumConst(wireNumber: 11184809, fallback: true)
  static const FundingWalletActionChainIdEnum unknownDefaultOpenApi = _$fundingWalletActionChainIdEnum_unknownDefaultOpenApi;

  static Serializer<FundingWalletActionChainIdEnum> get serializer => _$fundingWalletActionChainIdEnumSerializer;

  const FundingWalletActionChainIdEnum._(String name): super(name);

  static BuiltSet<FundingWalletActionChainIdEnum> get values => _$fundingWalletActionChainIdEnumValues;
  static FundingWalletActionChainIdEnum valueOf(String name) => _$fundingWalletActionChainIdEnumValueOf(name);
}

class FundingWalletActionValueEnum extends EnumClass {

  /// Native-value transfer is forbidden; v1 only executes zero-value contract calls.
  @BuiltValueEnumConst(wireName: r'0x0')
  static const FundingWalletActionValueEnum n0x0 = _$fundingWalletActionValueEnum_n0x0;
  /// Native-value transfer is forbidden; v1 only executes zero-value contract calls.
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const FundingWalletActionValueEnum unknownDefaultOpenApi = _$fundingWalletActionValueEnum_unknownDefaultOpenApi;

  static Serializer<FundingWalletActionValueEnum> get serializer => _$fundingWalletActionValueEnumSerializer;

  const FundingWalletActionValueEnum._(String name): super(name);

  static BuiltSet<FundingWalletActionValueEnum> get values => _$fundingWalletActionValueEnumValues;
  static FundingWalletActionValueEnum valueOf(String name) => _$fundingWalletActionValueEnumValueOf(name);
}


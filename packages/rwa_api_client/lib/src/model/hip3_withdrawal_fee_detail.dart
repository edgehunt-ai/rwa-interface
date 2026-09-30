//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'hip3_withdrawal_fee_detail.g.dart';

/// Hip3WithdrawalFeeDetail
///
/// Properties:
/// * [type] - withdrawal 为该通道提现费用；bridge2 对应官方桥费用。network 为单独披露的网络成本。
/// * [amount] - 以 currency 计价；未知为 null，不能展示成免费。当前平台承担的 ETH Gas 不额外查询估算。
/// * [currency] 
/// * [payer] - platform 项不从用户到账金额扣除，前端显示“平台承担”。
@BuiltValue()
abstract class Hip3WithdrawalFeeDetail implements Built<Hip3WithdrawalFeeDetail, Hip3WithdrawalFeeDetailBuilder> {
  /// withdrawal 为该通道提现费用；bridge2 对应官方桥费用。network 为单独披露的网络成本。
  @BuiltValueField(wireName: r'type')
  Hip3WithdrawalFeeDetailTypeEnum get type;
  // enum typeEnum {  withdrawal,  network,  };

  /// 以 currency 计价；未知为 null，不能展示成免费。当前平台承担的 ETH Gas 不额外查询估算。
  @BuiltValueField(wireName: r'amount')
  String? get amount;

  @BuiltValueField(wireName: r'currency')
  Hip3WithdrawalFeeDetailCurrencyEnum get currency;
  // enum currencyEnum {  USDC,  ETH,  };

  /// platform 项不从用户到账金额扣除，前端显示“平台承担”。
  @BuiltValueField(wireName: r'payer')
  Hip3WithdrawalFeeDetailPayerEnum get payer;
  // enum payerEnum {  user,  platform,  };

  Hip3WithdrawalFeeDetail._();

  factory Hip3WithdrawalFeeDetail([void updates(Hip3WithdrawalFeeDetailBuilder b)]) = _$Hip3WithdrawalFeeDetail;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(Hip3WithdrawalFeeDetailBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<Hip3WithdrawalFeeDetail> get serializer => _$Hip3WithdrawalFeeDetailSerializer();
}

class _$Hip3WithdrawalFeeDetailSerializer implements PrimitiveSerializer<Hip3WithdrawalFeeDetail> {
  @override
  final Iterable<Type> types = const [Hip3WithdrawalFeeDetail, _$Hip3WithdrawalFeeDetail];

  @override
  final String wireName = r'Hip3WithdrawalFeeDetail';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    Hip3WithdrawalFeeDetail object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'type';
    yield serializers.serialize(
      object.type,
      specifiedType: const FullType(Hip3WithdrawalFeeDetailTypeEnum),
    );
    yield r'amount';
    yield object.amount == null ? null : serializers.serialize(
      object.amount,
      specifiedType: const FullType.nullable(String),
    );
    yield r'currency';
    yield serializers.serialize(
      object.currency,
      specifiedType: const FullType(Hip3WithdrawalFeeDetailCurrencyEnum),
    );
    yield r'payer';
    yield serializers.serialize(
      object.payer,
      specifiedType: const FullType(Hip3WithdrawalFeeDetailPayerEnum),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    Hip3WithdrawalFeeDetail object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required Hip3WithdrawalFeeDetailBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'type':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(Hip3WithdrawalFeeDetailTypeEnum),
          ) as Hip3WithdrawalFeeDetailTypeEnum;
          result.type = valueDes;
          break;
        case r'amount':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.amount = valueDes;
          break;
        case r'currency':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(Hip3WithdrawalFeeDetailCurrencyEnum),
          ) as Hip3WithdrawalFeeDetailCurrencyEnum;
          result.currency = valueDes;
          break;
        case r'payer':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(Hip3WithdrawalFeeDetailPayerEnum),
          ) as Hip3WithdrawalFeeDetailPayerEnum;
          result.payer = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  Hip3WithdrawalFeeDetail deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = Hip3WithdrawalFeeDetailBuilder();
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

class Hip3WithdrawalFeeDetailTypeEnum extends EnumClass {

  /// withdrawal 为该通道提现费用；bridge2 对应官方桥费用。network 为单独披露的网络成本。
  @BuiltValueEnumConst(wireName: r'withdrawal')
  static const Hip3WithdrawalFeeDetailTypeEnum withdrawal = _$hip3WithdrawalFeeDetailTypeEnum_withdrawal;
  /// withdrawal 为该通道提现费用；bridge2 对应官方桥费用。network 为单独披露的网络成本。
  @BuiltValueEnumConst(wireName: r'network')
  static const Hip3WithdrawalFeeDetailTypeEnum network = _$hip3WithdrawalFeeDetailTypeEnum_network;

  static Serializer<Hip3WithdrawalFeeDetailTypeEnum> get serializer => _$hip3WithdrawalFeeDetailTypeEnumSerializer;

  const Hip3WithdrawalFeeDetailTypeEnum._(String name): super(name);

  static BuiltSet<Hip3WithdrawalFeeDetailTypeEnum> get values => _$hip3WithdrawalFeeDetailTypeEnumValues;
  static Hip3WithdrawalFeeDetailTypeEnum valueOf(String name) => _$hip3WithdrawalFeeDetailTypeEnumValueOf(name);
}

class Hip3WithdrawalFeeDetailCurrencyEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'USDC')
  static const Hip3WithdrawalFeeDetailCurrencyEnum USDC = _$hip3WithdrawalFeeDetailCurrencyEnum_USDC;
  @BuiltValueEnumConst(wireName: r'ETH')
  static const Hip3WithdrawalFeeDetailCurrencyEnum ETH = _$hip3WithdrawalFeeDetailCurrencyEnum_ETH;

  static Serializer<Hip3WithdrawalFeeDetailCurrencyEnum> get serializer => _$hip3WithdrawalFeeDetailCurrencyEnumSerializer;

  const Hip3WithdrawalFeeDetailCurrencyEnum._(String name): super(name);

  static BuiltSet<Hip3WithdrawalFeeDetailCurrencyEnum> get values => _$hip3WithdrawalFeeDetailCurrencyEnumValues;
  static Hip3WithdrawalFeeDetailCurrencyEnum valueOf(String name) => _$hip3WithdrawalFeeDetailCurrencyEnumValueOf(name);
}

class Hip3WithdrawalFeeDetailPayerEnum extends EnumClass {

  /// platform 项不从用户到账金额扣除，前端显示“平台承担”。
  @BuiltValueEnumConst(wireName: r'user')
  static const Hip3WithdrawalFeeDetailPayerEnum user = _$hip3WithdrawalFeeDetailPayerEnum_user;
  /// platform 项不从用户到账金额扣除，前端显示“平台承担”。
  @BuiltValueEnumConst(wireName: r'platform')
  static const Hip3WithdrawalFeeDetailPayerEnum platform = _$hip3WithdrawalFeeDetailPayerEnum_platform;

  static Serializer<Hip3WithdrawalFeeDetailPayerEnum> get serializer => _$hip3WithdrawalFeeDetailPayerEnumSerializer;

  const Hip3WithdrawalFeeDetailPayerEnum._(String name): super(name);

  static BuiltSet<Hip3WithdrawalFeeDetailPayerEnum> get values => _$hip3WithdrawalFeeDetailPayerEnumValues;
  static Hip3WithdrawalFeeDetailPayerEnum valueOf(String name) => _$hip3WithdrawalFeeDetailPayerEnumValueOf(name);
}


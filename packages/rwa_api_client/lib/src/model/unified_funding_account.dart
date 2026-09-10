//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:rwa_api_client/src/model/unified_funding_transfer.dart';
import 'package:rwa_api_client/src/model/unified_funding_position.dart';
import 'package:rwa_api_client/src/model/unified_funding_data_status.dart';
import 'package:rwa_api_client/src/model/unified_funding_blocker.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'unified_funding_account.g.dart';

/// Non-custodial aggregate read model over supported stablecoins held in the current account's Embedded EVM Wallet. Values are evidence-backed snapshots, not an omnibus platform balance. 
///
/// Properties:
/// * [accountId] 
/// * [valuationCurrency] 
/// * [valuedTotalUsd] - 十进制字符串，避免浮点误差
/// * [availableToFundValueUsd] - 十进制字符串，避免浮点误差
/// * [reservedValueUsd] - 十进制字符串，避免浮点误差
/// * [inTransitValueUsd] - 十进制字符串，避免浮点误差
/// * [unavailableValueUsd] - 十进制字符串，避免浮点误差
/// * [unvaluedPositionCount] 
/// * [positions] 
/// * [transfers] 
/// * [dataStatus] 
/// * [blockers] 
/// * [calculatedAt] 
@BuiltValue()
abstract class UnifiedFundingAccount implements Built<UnifiedFundingAccount, UnifiedFundingAccountBuilder> {
  @BuiltValueField(wireName: r'account_id')
  String get accountId;

  @BuiltValueField(wireName: r'valuation_currency')
  UnifiedFundingAccountValuationCurrencyEnum get valuationCurrency;
  // enum valuationCurrencyEnum {  USD,  };

  /// 十进制字符串，避免浮点误差
  @BuiltValueField(wireName: r'valued_total_usd')
  String get valuedTotalUsd;

  /// 十进制字符串，避免浮点误差
  @BuiltValueField(wireName: r'available_to_fund_value_usd')
  String get availableToFundValueUsd;

  /// 十进制字符串，避免浮点误差
  @BuiltValueField(wireName: r'reserved_value_usd')
  String get reservedValueUsd;

  /// 十进制字符串，避免浮点误差
  @BuiltValueField(wireName: r'in_transit_value_usd')
  String get inTransitValueUsd;

  /// 十进制字符串，避免浮点误差
  @BuiltValueField(wireName: r'unavailable_value_usd')
  String get unavailableValueUsd;

  @BuiltValueField(wireName: r'unvalued_position_count')
  int get unvaluedPositionCount;

  @BuiltValueField(wireName: r'positions')
  BuiltList<UnifiedFundingPosition> get positions;

  @BuiltValueField(wireName: r'transfers')
  BuiltList<UnifiedFundingTransfer> get transfers;

  @BuiltValueField(wireName: r'data_status')
  UnifiedFundingDataStatus get dataStatus;
  // enum dataStatusEnum {  complete,  partial,  unavailable,  };

  @BuiltValueField(wireName: r'blockers')
  BuiltSet<UnifiedFundingBlocker> get blockers;

  @BuiltValueField(wireName: r'calculated_at')
  DateTime get calculatedAt;

  UnifiedFundingAccount._();

  factory UnifiedFundingAccount([void updates(UnifiedFundingAccountBuilder b)]) = _$UnifiedFundingAccount;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(UnifiedFundingAccountBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<UnifiedFundingAccount> get serializer => _$UnifiedFundingAccountSerializer();
}

class _$UnifiedFundingAccountSerializer implements PrimitiveSerializer<UnifiedFundingAccount> {
  @override
  final Iterable<Type> types = const [UnifiedFundingAccount, _$UnifiedFundingAccount];

  @override
  final String wireName = r'UnifiedFundingAccount';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    UnifiedFundingAccount object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'account_id';
    yield serializers.serialize(
      object.accountId,
      specifiedType: const FullType(String),
    );
    yield r'valuation_currency';
    yield serializers.serialize(
      object.valuationCurrency,
      specifiedType: const FullType(UnifiedFundingAccountValuationCurrencyEnum),
    );
    yield r'valued_total_usd';
    yield serializers.serialize(
      object.valuedTotalUsd,
      specifiedType: const FullType(String),
    );
    yield r'available_to_fund_value_usd';
    yield serializers.serialize(
      object.availableToFundValueUsd,
      specifiedType: const FullType(String),
    );
    yield r'reserved_value_usd';
    yield serializers.serialize(
      object.reservedValueUsd,
      specifiedType: const FullType(String),
    );
    yield r'in_transit_value_usd';
    yield serializers.serialize(
      object.inTransitValueUsd,
      specifiedType: const FullType(String),
    );
    yield r'unavailable_value_usd';
    yield serializers.serialize(
      object.unavailableValueUsd,
      specifiedType: const FullType(String),
    );
    yield r'unvalued_position_count';
    yield serializers.serialize(
      object.unvaluedPositionCount,
      specifiedType: const FullType(int),
    );
    yield r'positions';
    yield serializers.serialize(
      object.positions,
      specifiedType: const FullType(BuiltList, [FullType(UnifiedFundingPosition)]),
    );
    yield r'transfers';
    yield serializers.serialize(
      object.transfers,
      specifiedType: const FullType(BuiltList, [FullType(UnifiedFundingTransfer)]),
    );
    yield r'data_status';
    yield serializers.serialize(
      object.dataStatus,
      specifiedType: const FullType(UnifiedFundingDataStatus),
    );
    yield r'blockers';
    yield serializers.serialize(
      object.blockers,
      specifiedType: const FullType(BuiltSet, [FullType(UnifiedFundingBlocker)]),
    );
    yield r'calculated_at';
    yield serializers.serialize(
      object.calculatedAt,
      specifiedType: const FullType(DateTime),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    UnifiedFundingAccount object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required UnifiedFundingAccountBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'account_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.accountId = valueDes;
          break;
        case r'valuation_currency':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(UnifiedFundingAccountValuationCurrencyEnum),
          ) as UnifiedFundingAccountValuationCurrencyEnum;
          result.valuationCurrency = valueDes;
          break;
        case r'valued_total_usd':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.valuedTotalUsd = valueDes;
          break;
        case r'available_to_fund_value_usd':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.availableToFundValueUsd = valueDes;
          break;
        case r'reserved_value_usd':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.reservedValueUsd = valueDes;
          break;
        case r'in_transit_value_usd':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.inTransitValueUsd = valueDes;
          break;
        case r'unavailable_value_usd':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.unavailableValueUsd = valueDes;
          break;
        case r'unvalued_position_count':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.unvaluedPositionCount = valueDes;
          break;
        case r'positions':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(UnifiedFundingPosition)]),
          ) as BuiltList<UnifiedFundingPosition>;
          result.positions.replace(valueDes);
          break;
        case r'transfers':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(UnifiedFundingTransfer)]),
          ) as BuiltList<UnifiedFundingTransfer>;
          result.transfers.replace(valueDes);
          break;
        case r'data_status':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(UnifiedFundingDataStatus),
          ) as UnifiedFundingDataStatus;
          result.dataStatus = valueDes;
          break;
        case r'blockers':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltSet, [FullType(UnifiedFundingBlocker)]),
          ) as BuiltSet<UnifiedFundingBlocker>;
          result.blockers.replace(valueDes);
          break;
        case r'calculated_at':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DateTime),
          ) as DateTime;
          result.calculatedAt = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  UnifiedFundingAccount deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = UnifiedFundingAccountBuilder();
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

class UnifiedFundingAccountValuationCurrencyEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'USD')
  static const UnifiedFundingAccountValuationCurrencyEnum USD = _$unifiedFundingAccountValuationCurrencyEnum_USD;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const UnifiedFundingAccountValuationCurrencyEnum unknownDefaultOpenApi = _$unifiedFundingAccountValuationCurrencyEnum_unknownDefaultOpenApi;

  static Serializer<UnifiedFundingAccountValuationCurrencyEnum> get serializer => _$unifiedFundingAccountValuationCurrencyEnumSerializer;

  const UnifiedFundingAccountValuationCurrencyEnum._(String name): super(name);

  static BuiltSet<UnifiedFundingAccountValuationCurrencyEnum> get values => _$unifiedFundingAccountValuationCurrencyEnumValues;
  static UnifiedFundingAccountValuationCurrencyEnum valueOf(String name) => _$unifiedFundingAccountValuationCurrencyEnumValueOf(name);
}


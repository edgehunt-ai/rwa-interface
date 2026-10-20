//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:rwa_api_client/src/model/financial_asset_identity.dart';
import 'package:rwa_api_client/src/model/financial_raw_amount.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'financial_obligation_amounts.g.dart';

/// One exact asset per row; never sum different chains/contracts. All buckets are explicit, including known zero and unknown. Not a second wallet balance. source_debited is cumulative net debit measured within each source execution; reserved is the current unspent hold; released is proven reservation removal, not a refund. in_transit/refund_due are current claims. outstanding is the remaining economic obligation and may overlap these buckets; do not add them together. credited/refunded/ compensated are actual net receipts. actual_fee is observed user expense, never an estimated budget or released fee allowance. Platform gas invoices remain admin-only, not customer funds. A refund already included in its source receipt's net debit must not be subtracted again. outstanding is the server's evidence-scoped remainder, not source_debited minus all refunds. Cross-asset reconciliation uses the frozen route, never subtraction of unlike raw amounts. An unknown user fee may remain after principal settlement. 
///
/// Properties:
/// * [asset] 
/// * [reserved] 
/// * [sourceDebited] 
/// * [inTransit] 
/// * [credited] 
/// * [refundDue] 
/// * [refunded] 
/// * [actualFee] 
/// * [released] 
/// * [compensated] 
/// * [outstanding] 
@BuiltValue()
abstract class FinancialObligationAmounts implements Built<FinancialObligationAmounts, FinancialObligationAmountsBuilder> {
  @BuiltValueField(wireName: r'asset')
  FinancialAssetIdentity get asset;

  @BuiltValueField(wireName: r'reserved')
  FinancialRawAmount get reserved;

  @BuiltValueField(wireName: r'source_debited')
  FinancialRawAmount get sourceDebited;

  @BuiltValueField(wireName: r'in_transit')
  FinancialRawAmount get inTransit;

  @BuiltValueField(wireName: r'credited')
  FinancialRawAmount get credited;

  @BuiltValueField(wireName: r'refund_due')
  FinancialRawAmount get refundDue;

  @BuiltValueField(wireName: r'refunded')
  FinancialRawAmount get refunded;

  @BuiltValueField(wireName: r'actual_fee')
  FinancialRawAmount get actualFee;

  @BuiltValueField(wireName: r'released')
  FinancialRawAmount get released;

  @BuiltValueField(wireName: r'compensated')
  FinancialRawAmount get compensated;

  @BuiltValueField(wireName: r'outstanding')
  FinancialRawAmount get outstanding;

  FinancialObligationAmounts._();

  factory FinancialObligationAmounts([void updates(FinancialObligationAmountsBuilder b)]) = _$FinancialObligationAmounts;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(FinancialObligationAmountsBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<FinancialObligationAmounts> get serializer => _$FinancialObligationAmountsSerializer();
}

class _$FinancialObligationAmountsSerializer implements PrimitiveSerializer<FinancialObligationAmounts> {
  @override
  final Iterable<Type> types = const [FinancialObligationAmounts, _$FinancialObligationAmounts];

  @override
  final String wireName = r'FinancialObligationAmounts';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    FinancialObligationAmounts object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'asset';
    yield serializers.serialize(
      object.asset,
      specifiedType: const FullType(FinancialAssetIdentity),
    );
    yield r'reserved';
    yield serializers.serialize(
      object.reserved,
      specifiedType: const FullType(FinancialRawAmount),
    );
    yield r'source_debited';
    yield serializers.serialize(
      object.sourceDebited,
      specifiedType: const FullType(FinancialRawAmount),
    );
    yield r'in_transit';
    yield serializers.serialize(
      object.inTransit,
      specifiedType: const FullType(FinancialRawAmount),
    );
    yield r'credited';
    yield serializers.serialize(
      object.credited,
      specifiedType: const FullType(FinancialRawAmount),
    );
    yield r'refund_due';
    yield serializers.serialize(
      object.refundDue,
      specifiedType: const FullType(FinancialRawAmount),
    );
    yield r'refunded';
    yield serializers.serialize(
      object.refunded,
      specifiedType: const FullType(FinancialRawAmount),
    );
    yield r'actual_fee';
    yield serializers.serialize(
      object.actualFee,
      specifiedType: const FullType(FinancialRawAmount),
    );
    yield r'released';
    yield serializers.serialize(
      object.released,
      specifiedType: const FullType(FinancialRawAmount),
    );
    yield r'compensated';
    yield serializers.serialize(
      object.compensated,
      specifiedType: const FullType(FinancialRawAmount),
    );
    yield r'outstanding';
    yield serializers.serialize(
      object.outstanding,
      specifiedType: const FullType(FinancialRawAmount),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    FinancialObligationAmounts object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required FinancialObligationAmountsBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'asset':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(FinancialAssetIdentity),
          ) as FinancialAssetIdentity;
          result.asset.replace(valueDes);
          break;
        case r'reserved':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(FinancialRawAmount),
          ) as FinancialRawAmount;
          result.reserved.replace(valueDes);
          break;
        case r'source_debited':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(FinancialRawAmount),
          ) as FinancialRawAmount;
          result.sourceDebited.replace(valueDes);
          break;
        case r'in_transit':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(FinancialRawAmount),
          ) as FinancialRawAmount;
          result.inTransit.replace(valueDes);
          break;
        case r'credited':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(FinancialRawAmount),
          ) as FinancialRawAmount;
          result.credited.replace(valueDes);
          break;
        case r'refund_due':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(FinancialRawAmount),
          ) as FinancialRawAmount;
          result.refundDue.replace(valueDes);
          break;
        case r'refunded':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(FinancialRawAmount),
          ) as FinancialRawAmount;
          result.refunded.replace(valueDes);
          break;
        case r'actual_fee':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(FinancialRawAmount),
          ) as FinancialRawAmount;
          result.actualFee.replace(valueDes);
          break;
        case r'released':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(FinancialRawAmount),
          ) as FinancialRawAmount;
          result.released.replace(valueDes);
          break;
        case r'compensated':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(FinancialRawAmount),
          ) as FinancialRawAmount;
          result.compensated.replace(valueDes);
          break;
        case r'outstanding':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(FinancialRawAmount),
          ) as FinancialRawAmount;
          result.outstanding.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  FinancialObligationAmounts deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = FinancialObligationAmountsBuilder();
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


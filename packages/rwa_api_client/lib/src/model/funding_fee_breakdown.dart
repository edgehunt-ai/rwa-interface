//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'funding_fee_breakdown.g.dart';

/// Normalized quote-cost breakdown. `provider_fee`, `bridge_fee`, `swap_fee`, and `network_fee` are component costs expressed in `fee_asset`; current funding Providers normalize these components to USD. `swap_fee` is the quoted currency conversion price-impact cost, not necessarily a separately charged fee. `total_fee` is the gross sum of the components. `total_cost_usd` is the net normalized comparison cost after favorable signed price improvement is credited and the result is floored at zero, so it may be less than `total_fee`. Components explain the quote and must not be deducted again from `minimum_received`. 
///
/// Properties:
/// * [feeAsset] - Unit used by the component and total fee fields; current funding Providers return USD.
/// * [providerFee] - Provider cost normalized to `fee_asset`; already reflected in the quote and not deducted again.
/// * [bridgeFee] - Bridge cost normalized to `fee_asset`; already reflected in the quote and not deducted again.
/// * [swapFee] - Currency-conversion price-impact cost normalized to `fee_asset`, not necessarily a separately charged fee; do not deduct it again.
/// * [networkFee] - Network cost normalized to `fee_asset`; already reflected in the quote and not deducted again.
/// * [totalFee] - Gross sum of the component costs in `fee_asset`; informational and already reflected in the quote.
/// * [totalCostUsd] - Net USD-normalized comparison cost for route ranking and audit after favorable signed price improvement is credited and the result is floored at zero; it may be less than the gross total_fee and must not be reconstructed by summing or deducted in addition to the component costs.
@BuiltValue()
abstract class FundingFeeBreakdown implements Built<FundingFeeBreakdown, FundingFeeBreakdownBuilder> {
  /// Unit used by the component and total fee fields; current funding Providers return USD.
  @BuiltValueField(wireName: r'fee_asset')
  String get feeAsset;

  /// Provider cost normalized to `fee_asset`; already reflected in the quote and not deducted again.
  @BuiltValueField(wireName: r'provider_fee')
  String get providerFee;

  /// Bridge cost normalized to `fee_asset`; already reflected in the quote and not deducted again.
  @BuiltValueField(wireName: r'bridge_fee')
  String get bridgeFee;

  /// Currency-conversion price-impact cost normalized to `fee_asset`, not necessarily a separately charged fee; do not deduct it again.
  @BuiltValueField(wireName: r'swap_fee')
  String get swapFee;

  /// Network cost normalized to `fee_asset`; already reflected in the quote and not deducted again.
  @BuiltValueField(wireName: r'network_fee')
  String get networkFee;

  /// Gross sum of the component costs in `fee_asset`; informational and already reflected in the quote.
  @BuiltValueField(wireName: r'total_fee')
  String get totalFee;

  /// Net USD-normalized comparison cost for route ranking and audit after favorable signed price improvement is credited and the result is floored at zero; it may be less than the gross total_fee and must not be reconstructed by summing or deducted in addition to the component costs.
  @BuiltValueField(wireName: r'total_cost_usd')
  String get totalCostUsd;

  FundingFeeBreakdown._();

  factory FundingFeeBreakdown([void updates(FundingFeeBreakdownBuilder b)]) = _$FundingFeeBreakdown;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(FundingFeeBreakdownBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<FundingFeeBreakdown> get serializer => _$FundingFeeBreakdownSerializer();
}

class _$FundingFeeBreakdownSerializer implements PrimitiveSerializer<FundingFeeBreakdown> {
  @override
  final Iterable<Type> types = const [FundingFeeBreakdown, _$FundingFeeBreakdown];

  @override
  final String wireName = r'FundingFeeBreakdown';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    FundingFeeBreakdown object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'fee_asset';
    yield serializers.serialize(
      object.feeAsset,
      specifiedType: const FullType(String),
    );
    yield r'provider_fee';
    yield serializers.serialize(
      object.providerFee,
      specifiedType: const FullType(String),
    );
    yield r'bridge_fee';
    yield serializers.serialize(
      object.bridgeFee,
      specifiedType: const FullType(String),
    );
    yield r'swap_fee';
    yield serializers.serialize(
      object.swapFee,
      specifiedType: const FullType(String),
    );
    yield r'network_fee';
    yield serializers.serialize(
      object.networkFee,
      specifiedType: const FullType(String),
    );
    yield r'total_fee';
    yield serializers.serialize(
      object.totalFee,
      specifiedType: const FullType(String),
    );
    yield r'total_cost_usd';
    yield serializers.serialize(
      object.totalCostUsd,
      specifiedType: const FullType(String),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    FundingFeeBreakdown object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required FundingFeeBreakdownBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'fee_asset':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.feeAsset = valueDes;
          break;
        case r'provider_fee':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.providerFee = valueDes;
          break;
        case r'bridge_fee':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.bridgeFee = valueDes;
          break;
        case r'swap_fee':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.swapFee = valueDes;
          break;
        case r'network_fee':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.networkFee = valueDes;
          break;
        case r'total_fee':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.totalFee = valueDes;
          break;
        case r'total_cost_usd':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.totalCostUsd = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  FundingFeeBreakdown deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = FundingFeeBreakdownBuilder();
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


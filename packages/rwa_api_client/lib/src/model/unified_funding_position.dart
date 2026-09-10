//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:rwa_api_client/src/model/funding_source_asset_identity.dart';
import 'package:built_collection/built_collection.dart';
import 'package:rwa_api_client/src/model/portfolio_freshness.dart';
import 'package:rwa_api_client/src/model/funding_position_eligibility.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'unified_funding_position.g.dart';

/// One account-scoped view of an exact supported stablecoin held by the user's Embedded EVM Wallet. This is not a platform ledger balance and does not imply that the platform has custody of the asset. 
///
/// Properties:
/// * [positionId] - Account-scoped opaque identifier; clients must not derive wallet or asset identities from it.
/// * [custody] 
/// * [walletId] 
/// * [walletAddress] 
/// * [asset] 
/// * [totalAmount] - 十进制字符串，避免浮点误差
/// * [availableAmount] - 十进制字符串，避免浮点误差
/// * [reservedAmount] - 十进制字符串，避免浮点误差
/// * [inTransitAmount] - 十进制字符串，避免浮点误差
/// * [valueUsd] - Null when the position cannot be valued from fresh authoritative market data.
/// * [freshness] 
/// * [eligibility] 
/// * [observedAt] 
/// * [validUntil] - Position evidence must be re-read after this instant before funding allocation.
@BuiltValue()
abstract class UnifiedFundingPosition implements Built<UnifiedFundingPosition, UnifiedFundingPositionBuilder> {
  /// Account-scoped opaque identifier; clients must not derive wallet or asset identities from it.
  @BuiltValueField(wireName: r'position_id')
  String get positionId;

  @BuiltValueField(wireName: r'custody')
  UnifiedFundingPositionCustodyEnum get custody;
  // enum custodyEnum {  embedded_wallet,  };

  @BuiltValueField(wireName: r'wallet_id')
  String get walletId;

  @BuiltValueField(wireName: r'wallet_address')
  String get walletAddress;

  @BuiltValueField(wireName: r'asset')
  FundingSourceAssetIdentity get asset;

  /// 十进制字符串，避免浮点误差
  @BuiltValueField(wireName: r'total_amount')
  String get totalAmount;

  /// 十进制字符串，避免浮点误差
  @BuiltValueField(wireName: r'available_amount')
  String get availableAmount;

  /// 十进制字符串，避免浮点误差
  @BuiltValueField(wireName: r'reserved_amount')
  String get reservedAmount;

  /// 十进制字符串，避免浮点误差
  @BuiltValueField(wireName: r'in_transit_amount')
  String get inTransitAmount;

  /// Null when the position cannot be valued from fresh authoritative market data.
  @BuiltValueField(wireName: r'value_usd')
  String? get valueUsd;

  @BuiltValueField(wireName: r'freshness')
  PortfolioFreshness get freshness;
  // enum freshnessEnum {  live,  cached,  stale,  };

  @BuiltValueField(wireName: r'eligibility')
  FundingPositionEligibility get eligibility;

  @BuiltValueField(wireName: r'observed_at')
  DateTime get observedAt;

  /// Position evidence must be re-read after this instant before funding allocation.
  @BuiltValueField(wireName: r'valid_until')
  DateTime get validUntil;

  UnifiedFundingPosition._();

  factory UnifiedFundingPosition([void updates(UnifiedFundingPositionBuilder b)]) = _$UnifiedFundingPosition;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(UnifiedFundingPositionBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<UnifiedFundingPosition> get serializer => _$UnifiedFundingPositionSerializer();
}

class _$UnifiedFundingPositionSerializer implements PrimitiveSerializer<UnifiedFundingPosition> {
  @override
  final Iterable<Type> types = const [UnifiedFundingPosition, _$UnifiedFundingPosition];

  @override
  final String wireName = r'UnifiedFundingPosition';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    UnifiedFundingPosition object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'position_id';
    yield serializers.serialize(
      object.positionId,
      specifiedType: const FullType(String),
    );
    yield r'custody';
    yield serializers.serialize(
      object.custody,
      specifiedType: const FullType(UnifiedFundingPositionCustodyEnum),
    );
    yield r'wallet_id';
    yield serializers.serialize(
      object.walletId,
      specifiedType: const FullType(String),
    );
    yield r'wallet_address';
    yield serializers.serialize(
      object.walletAddress,
      specifiedType: const FullType(String),
    );
    yield r'asset';
    yield serializers.serialize(
      object.asset,
      specifiedType: const FullType(FundingSourceAssetIdentity),
    );
    yield r'total_amount';
    yield serializers.serialize(
      object.totalAmount,
      specifiedType: const FullType(String),
    );
    yield r'available_amount';
    yield serializers.serialize(
      object.availableAmount,
      specifiedType: const FullType(String),
    );
    yield r'reserved_amount';
    yield serializers.serialize(
      object.reservedAmount,
      specifiedType: const FullType(String),
    );
    yield r'in_transit_amount';
    yield serializers.serialize(
      object.inTransitAmount,
      specifiedType: const FullType(String),
    );
    yield r'value_usd';
    yield object.valueUsd == null ? null : serializers.serialize(
      object.valueUsd,
      specifiedType: const FullType.nullable(String),
    );
    yield r'freshness';
    yield serializers.serialize(
      object.freshness,
      specifiedType: const FullType(PortfolioFreshness),
    );
    yield r'eligibility';
    yield serializers.serialize(
      object.eligibility,
      specifiedType: const FullType(FundingPositionEligibility),
    );
    yield r'observed_at';
    yield serializers.serialize(
      object.observedAt,
      specifiedType: const FullType(DateTime),
    );
    yield r'valid_until';
    yield serializers.serialize(
      object.validUntil,
      specifiedType: const FullType(DateTime),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    UnifiedFundingPosition object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required UnifiedFundingPositionBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'position_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.positionId = valueDes;
          break;
        case r'custody':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(UnifiedFundingPositionCustodyEnum),
          ) as UnifiedFundingPositionCustodyEnum;
          result.custody = valueDes;
          break;
        case r'wallet_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.walletId = valueDes;
          break;
        case r'wallet_address':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.walletAddress = valueDes;
          break;
        case r'asset':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(FundingSourceAssetIdentity),
          ) as FundingSourceAssetIdentity;
          result.asset.replace(valueDes);
          break;
        case r'total_amount':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.totalAmount = valueDes;
          break;
        case r'available_amount':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.availableAmount = valueDes;
          break;
        case r'reserved_amount':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.reservedAmount = valueDes;
          break;
        case r'in_transit_amount':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.inTransitAmount = valueDes;
          break;
        case r'value_usd':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.valueUsd = valueDes;
          break;
        case r'freshness':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(PortfolioFreshness),
          ) as PortfolioFreshness;
          result.freshness = valueDes;
          break;
        case r'eligibility':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(FundingPositionEligibility),
          ) as FundingPositionEligibility;
          result.eligibility.replace(valueDes);
          break;
        case r'observed_at':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DateTime),
          ) as DateTime;
          result.observedAt = valueDes;
          break;
        case r'valid_until':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DateTime),
          ) as DateTime;
          result.validUntil = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  UnifiedFundingPosition deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = UnifiedFundingPositionBuilder();
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

class UnifiedFundingPositionCustodyEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'embedded_wallet')
  static const UnifiedFundingPositionCustodyEnum embeddedWallet = _$unifiedFundingPositionCustodyEnum_embeddedWallet;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const UnifiedFundingPositionCustodyEnum unknownDefaultOpenApi = _$unifiedFundingPositionCustodyEnum_unknownDefaultOpenApi;

  static Serializer<UnifiedFundingPositionCustodyEnum> get serializer => _$unifiedFundingPositionCustodyEnumSerializer;

  const UnifiedFundingPositionCustodyEnum._(String name): super(name);

  static BuiltSet<UnifiedFundingPositionCustodyEnum> get values => _$unifiedFundingPositionCustodyEnumValues;
  static UnifiedFundingPositionCustodyEnum valueOf(String name) => _$unifiedFundingPositionCustodyEnumValueOf(name);
}


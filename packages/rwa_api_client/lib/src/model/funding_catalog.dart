//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:rwa_api_client/src/model/funding_source_asset_catalog.dart';
import 'package:rwa_api_client/src/model/deposit_rail.dart';
import 'package:rwa_api_client/src/model/funding_rail.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'funding_catalog.g.dart';

/// FundingCatalog
///
/// Properties:
/// * [catalogVersion] - Immutable allowlist/config version frozen into every selected quote.
/// * [sourceAssets] - Exactly the eight v1 Ethereum/Arbitrum/Base/BSC USDC/USDT source identities. Each identity includes dynamic Across/Relay capability freshness for both target rails. 
/// * [rails] - Backward-compatible target rail collection; each item has an exact settlement identity.
/// * [depositRails] - 当前账号可查看的真实钱包入金 rail 及其只读 observer readiness。
/// * [updatedAt] 
@BuiltValue()
abstract class FundingCatalog implements Built<FundingCatalog, FundingCatalogBuilder> {
  /// Immutable allowlist/config version frozen into every selected quote.
  @BuiltValueField(wireName: r'catalog_version')
  String get catalogVersion;

  /// Exactly the eight v1 Ethereum/Arbitrum/Base/BSC USDC/USDT source identities. Each identity includes dynamic Across/Relay capability freshness for both target rails. 
  @BuiltValueField(wireName: r'source_assets')
  FundingSourceAssetCatalog get sourceAssets;

  /// Backward-compatible target rail collection; each item has an exact settlement identity.
  @BuiltValueField(wireName: r'rails')
  BuiltSet<FundingRail> get rails;

  /// 当前账号可查看的真实钱包入金 rail 及其只读 observer readiness。
  @BuiltValueField(wireName: r'deposit_rails')
  BuiltList<DepositRail> get depositRails;

  @BuiltValueField(wireName: r'updated_at')
  DateTime get updatedAt;

  FundingCatalog._();

  factory FundingCatalog([void updates(FundingCatalogBuilder b)]) = _$FundingCatalog;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(FundingCatalogBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<FundingCatalog> get serializer => _$FundingCatalogSerializer();
}

class _$FundingCatalogSerializer implements PrimitiveSerializer<FundingCatalog> {
  @override
  final Iterable<Type> types = const [FundingCatalog, _$FundingCatalog];

  @override
  final String wireName = r'FundingCatalog';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    FundingCatalog object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'catalog_version';
    yield serializers.serialize(
      object.catalogVersion,
      specifiedType: const FullType(String),
    );
    yield r'source_assets';
    yield serializers.serialize(
      object.sourceAssets,
      specifiedType: const FullType(FundingSourceAssetCatalog),
    );
    yield r'rails';
    yield serializers.serialize(
      object.rails,
      specifiedType: const FullType(BuiltSet, [FullType(FundingRail)]),
    );
    yield r'deposit_rails';
    yield serializers.serialize(
      object.depositRails,
      specifiedType: const FullType(BuiltList, [FullType(DepositRail)]),
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
    FundingCatalog object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required FundingCatalogBuilder result,
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
        case r'source_assets':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(FundingSourceAssetCatalog),
          ) as FundingSourceAssetCatalog;
          result.sourceAssets.replace(valueDes);
          break;
        case r'rails':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltSet, [FullType(FundingRail)]),
          ) as BuiltSet<FundingRail>;
          result.rails.replace(valueDes);
          break;
        case r'deposit_rails':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(DepositRail)]),
          ) as BuiltList<DepositRail>;
          result.depositRails.replace(valueDes);
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
  FundingCatalog deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = FundingCatalogBuilder();
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


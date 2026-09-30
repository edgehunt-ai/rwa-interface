//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:rwa_api_client/src/model/portfolio_account_allocation_breakdown.dart';
import 'package:rwa_api_client/src/model/portfolio_availability_status.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'portfolio_account_allocation_item.g.dart';

/// PortfolioAccountAllocationItem
///
/// Properties:
/// * [account] 
/// * [status] 
/// * [valueUsd] - Spot 是 EVM 钱包已估值资产小计；Perps 是 HL 资产小计，与总资产使用同一快照。 不累加仓位名义价值或保证金。该组全部来源失败或所有资产未估值时为 null。 部分来源失败时允许返回已知小计，必须配合 status=partial 展示。 
/// * [percent] - 0..100 的百分数；任一组不完整时两个百分比均为 null；完整且总额为零时为0。
/// * [unvaluedAssetCount] 
/// * [breakdown] 
@BuiltValue()
abstract class PortfolioAccountAllocationItem implements Built<PortfolioAccountAllocationItem, PortfolioAccountAllocationItemBuilder> {
  @BuiltValueField(wireName: r'account')
  PortfolioAccountAllocationItemAccountEnum get account;
  // enum accountEnum {  spot,  perps,  };

  @BuiltValueField(wireName: r'status')
  PortfolioAvailabilityStatus get status;
  // enum statusEnum {  available,  partial,  unavailable,  };

  /// Spot 是 EVM 钱包已估值资产小计；Perps 是 HL 资产小计，与总资产使用同一快照。 不累加仓位名义价值或保证金。该组全部来源失败或所有资产未估值时为 null。 部分来源失败时允许返回已知小计，必须配合 status=partial 展示。 
  @BuiltValueField(wireName: r'value_usd')
  String? get valueUsd;

  /// 0..100 的百分数；任一组不完整时两个百分比均为 null；完整且总额为零时为0。
  @BuiltValueField(wireName: r'percent')
  String? get percent;

  @BuiltValueField(wireName: r'unvalued_asset_count')
  int get unvaluedAssetCount;

  @BuiltValueField(wireName: r'breakdown')
  PortfolioAccountAllocationBreakdown? get breakdown;

  PortfolioAccountAllocationItem._();

  factory PortfolioAccountAllocationItem([void updates(PortfolioAccountAllocationItemBuilder b)]) = _$PortfolioAccountAllocationItem;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(PortfolioAccountAllocationItemBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<PortfolioAccountAllocationItem> get serializer => _$PortfolioAccountAllocationItemSerializer();
}

class _$PortfolioAccountAllocationItemSerializer implements PrimitiveSerializer<PortfolioAccountAllocationItem> {
  @override
  final Iterable<Type> types = const [PortfolioAccountAllocationItem, _$PortfolioAccountAllocationItem];

  @override
  final String wireName = r'PortfolioAccountAllocationItem';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    PortfolioAccountAllocationItem object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'account';
    yield serializers.serialize(
      object.account,
      specifiedType: const FullType(PortfolioAccountAllocationItemAccountEnum),
    );
    yield r'status';
    yield serializers.serialize(
      object.status,
      specifiedType: const FullType(PortfolioAvailabilityStatus),
    );
    yield r'value_usd';
    yield object.valueUsd == null ? null : serializers.serialize(
      object.valueUsd,
      specifiedType: const FullType.nullable(String),
    );
    yield r'percent';
    yield object.percent == null ? null : serializers.serialize(
      object.percent,
      specifiedType: const FullType.nullable(String),
    );
    yield r'unvalued_asset_count';
    yield serializers.serialize(
      object.unvaluedAssetCount,
      specifiedType: const FullType(int),
    );
    if (object.breakdown != null) {
      yield r'breakdown';
      yield serializers.serialize(
        object.breakdown,
        specifiedType: const FullType(PortfolioAccountAllocationBreakdown),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    PortfolioAccountAllocationItem object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required PortfolioAccountAllocationItemBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'account':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(PortfolioAccountAllocationItemAccountEnum),
          ) as PortfolioAccountAllocationItemAccountEnum;
          result.account = valueDes;
          break;
        case r'status':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(PortfolioAvailabilityStatus),
          ) as PortfolioAvailabilityStatus;
          result.status = valueDes;
          break;
        case r'value_usd':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.valueUsd = valueDes;
          break;
        case r'percent':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.percent = valueDes;
          break;
        case r'unvalued_asset_count':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.unvaluedAssetCount = valueDes;
          break;
        case r'breakdown':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(PortfolioAccountAllocationBreakdown),
          ) as PortfolioAccountAllocationBreakdown?;
          if (valueDes == null) continue;
          result.breakdown.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  PortfolioAccountAllocationItem deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = PortfolioAccountAllocationItemBuilder();
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

class PortfolioAccountAllocationItemAccountEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'spot')
  static const PortfolioAccountAllocationItemAccountEnum spot = _$portfolioAccountAllocationItemAccountEnum_spot;
  @BuiltValueEnumConst(wireName: r'perps')
  static const PortfolioAccountAllocationItemAccountEnum perps = _$portfolioAccountAllocationItemAccountEnum_perps;

  static Serializer<PortfolioAccountAllocationItemAccountEnum> get serializer => _$portfolioAccountAllocationItemAccountEnumSerializer;

  const PortfolioAccountAllocationItemAccountEnum._(String name): super(name);

  static BuiltSet<PortfolioAccountAllocationItemAccountEnum> get values => _$portfolioAccountAllocationItemAccountEnumValues;
  static PortfolioAccountAllocationItemAccountEnum valueOf(String name) => _$portfolioAccountAllocationItemAccountEnumValueOf(name);
}


//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:rwa_api_client/src/model/portfolio_notice.dart';
import 'package:rwa_api_client/src/model/portfolio_source_summary.dart';
import 'package:built_collection/built_collection.dart';
import 'package:rwa_api_client/src/model/account_balance.dart';
import 'package:rwa_api_client/src/model/portfolio_freshness.dart';
import 'package:rwa_api_client/src/model/portfolio_data_status.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'portfolio_account_page.g.dart';

/// 当前用户 Portfolio snapshot 的账户分组视图。该视图与 summary/assets 使用同一快照， 不代表可提款余额或下单承诺。 
///
/// Properties:
/// * [scope] 
/// * [items] 
/// * [dataStatus] 
/// * [freshness] 
/// * [calculatedAt] 
/// * [oldestObservationAt] 
/// * [warnings] 
/// * [sources] 
@BuiltValue()
abstract class PortfolioAccountPage implements Built<PortfolioAccountPage, PortfolioAccountPageBuilder> {
  @BuiltValueField(wireName: r'scope')
  PortfolioAccountPageScopeEnum get scope;
  // enum scopeEnum {  portfolio,  };

  @BuiltValueField(wireName: r'items')
  BuiltList<AccountBalance> get items;

  @BuiltValueField(wireName: r'data_status')
  PortfolioDataStatus get dataStatus;
  // enum dataStatusEnum {  complete,  partial,  empty,  };

  @BuiltValueField(wireName: r'freshness')
  PortfolioFreshness get freshness;
  // enum freshnessEnum {  live,  cached,  stale,  };

  @BuiltValueField(wireName: r'calculated_at')
  DateTime get calculatedAt;

  @BuiltValueField(wireName: r'oldest_observation_at')
  DateTime? get oldestObservationAt;

  @BuiltValueField(wireName: r'warnings')
  BuiltList<PortfolioNotice> get warnings;

  @BuiltValueField(wireName: r'sources')
  BuiltList<PortfolioSourceSummary> get sources;

  PortfolioAccountPage._();

  factory PortfolioAccountPage([void updates(PortfolioAccountPageBuilder b)]) = _$PortfolioAccountPage;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(PortfolioAccountPageBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<PortfolioAccountPage> get serializer => _$PortfolioAccountPageSerializer();
}

class _$PortfolioAccountPageSerializer implements PrimitiveSerializer<PortfolioAccountPage> {
  @override
  final Iterable<Type> types = const [PortfolioAccountPage, _$PortfolioAccountPage];

  @override
  final String wireName = r'PortfolioAccountPage';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    PortfolioAccountPage object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'scope';
    yield serializers.serialize(
      object.scope,
      specifiedType: const FullType(PortfolioAccountPageScopeEnum),
    );
    yield r'items';
    yield serializers.serialize(
      object.items,
      specifiedType: const FullType(BuiltList, [FullType(AccountBalance)]),
    );
    yield r'data_status';
    yield serializers.serialize(
      object.dataStatus,
      specifiedType: const FullType(PortfolioDataStatus),
    );
    yield r'freshness';
    yield serializers.serialize(
      object.freshness,
      specifiedType: const FullType(PortfolioFreshness),
    );
    yield r'calculated_at';
    yield serializers.serialize(
      object.calculatedAt,
      specifiedType: const FullType(DateTime),
    );
    if (object.oldestObservationAt != null) {
      yield r'oldest_observation_at';
      yield serializers.serialize(
        object.oldestObservationAt,
        specifiedType: const FullType.nullable(DateTime),
      );
    }
    yield r'warnings';
    yield serializers.serialize(
      object.warnings,
      specifiedType: const FullType(BuiltList, [FullType(PortfolioNotice)]),
    );
    yield r'sources';
    yield serializers.serialize(
      object.sources,
      specifiedType: const FullType(BuiltList, [FullType(PortfolioSourceSummary)]),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    PortfolioAccountPage object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required PortfolioAccountPageBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'scope':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(PortfolioAccountPageScopeEnum),
          ) as PortfolioAccountPageScopeEnum;
          result.scope = valueDes;
          break;
        case r'items':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(AccountBalance)]),
          ) as BuiltList<AccountBalance>;
          result.items.replace(valueDes);
          break;
        case r'data_status':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(PortfolioDataStatus),
          ) as PortfolioDataStatus;
          result.dataStatus = valueDes;
          break;
        case r'freshness':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(PortfolioFreshness),
          ) as PortfolioFreshness;
          result.freshness = valueDes;
          break;
        case r'calculated_at':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DateTime),
          ) as DateTime;
          result.calculatedAt = valueDes;
          break;
        case r'oldest_observation_at':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(DateTime),
          ) as DateTime?;
          if (valueDes == null) continue;
          result.oldestObservationAt = valueDes;
          break;
        case r'warnings':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(PortfolioNotice)]),
          ) as BuiltList<PortfolioNotice>;
          result.warnings.replace(valueDes);
          break;
        case r'sources':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(PortfolioSourceSummary)]),
          ) as BuiltList<PortfolioSourceSummary>;
          result.sources.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  PortfolioAccountPage deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = PortfolioAccountPageBuilder();
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

class PortfolioAccountPageScopeEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'portfolio')
  static const PortfolioAccountPageScopeEnum portfolio = _$portfolioAccountPageScopeEnum_portfolio;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const PortfolioAccountPageScopeEnum unknownDefaultOpenApi = _$portfolioAccountPageScopeEnum_unknownDefaultOpenApi;

  static Serializer<PortfolioAccountPageScopeEnum> get serializer => _$portfolioAccountPageScopeEnumSerializer;

  const PortfolioAccountPageScopeEnum._(String name): super(name);

  static BuiltSet<PortfolioAccountPageScopeEnum> get values => _$portfolioAccountPageScopeEnumValues;
  static PortfolioAccountPageScopeEnum valueOf(String name) => _$portfolioAccountPageScopeEnumValueOf(name);
}


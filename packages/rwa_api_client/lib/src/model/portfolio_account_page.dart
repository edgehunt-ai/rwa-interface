//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:rwa_api_client/src/model/portfolio_notice.dart';
import 'package:built_collection/built_collection.dart';
import 'package:rwa_api_client/src/model/account_balance.dart';
import 'package:rwa_api_client/src/model/portfolio_freshness.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'portfolio_account_page.g.dart';

/// 内部账本可能是链上或 venue 外部资产的业务镜像，不能与外部余额双计。 只有已对账且没有 blocker 的余额才可以参与 available-to-trade 计算。
///
/// Properties:
/// * [scope]
/// * [items]
/// * [reconciled] - 是否已与对应的外部资产来源完成对账。
/// * [freshness]
/// * [blockers]
@BuiltValue()
abstract class PortfolioAccountPage
    implements Built<PortfolioAccountPage, PortfolioAccountPageBuilder> {
  @BuiltValueField(wireName: r'scope')
  PortfolioAccountPageScopeEnum get scope;
  // enum scopeEnum {  internal_ledger,  };

  @BuiltValueField(wireName: r'items')
  BuiltList<AccountBalance> get items;

  /// 是否已与对应的外部资产来源完成对账。
  @BuiltValueField(wireName: r'reconciled')
  bool get reconciled;

  @BuiltValueField(wireName: r'freshness')
  PortfolioFreshness get freshness;
  // enum freshnessEnum {  live,  cached,  stale,  };

  @BuiltValueField(wireName: r'blockers')
  BuiltList<PortfolioNotice> get blockers;

  PortfolioAccountPage._();

  factory PortfolioAccountPage([void updates(PortfolioAccountPageBuilder b)]) =
      _$PortfolioAccountPage;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(PortfolioAccountPageBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<PortfolioAccountPage> get serializer =>
      _$PortfolioAccountPageSerializer();
}

class _$PortfolioAccountPageSerializer
    implements PrimitiveSerializer<PortfolioAccountPage> {
  @override
  final Iterable<Type> types = const [
    PortfolioAccountPage,
    _$PortfolioAccountPage
  ];

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
    yield r'reconciled';
    yield serializers.serialize(
      object.reconciled,
      specifiedType: const FullType(bool),
    );
    yield r'freshness';
    yield serializers.serialize(
      object.freshness,
      specifiedType: const FullType(PortfolioFreshness),
    );
    yield r'blockers';
    yield serializers.serialize(
      object.blockers,
      specifiedType: const FullType(BuiltList, [FullType(PortfolioNotice)]),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    PortfolioAccountPage object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object,
            specifiedType: specifiedType)
        .toList();
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
            specifiedType:
                const FullType(BuiltList, [FullType(AccountBalance)]),
          ) as BuiltList<AccountBalance>;
          result.items.replace(valueDes);
          break;
        case r'reconciled':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.reconciled = valueDes;
          break;
        case r'freshness':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(PortfolioFreshness),
          ) as PortfolioFreshness;
          result.freshness = valueDes;
          break;
        case r'blockers':
          final valueDes = serializers.deserialize(
            value,
            specifiedType:
                const FullType(BuiltList, [FullType(PortfolioNotice)]),
          ) as BuiltList<PortfolioNotice>;
          result.blockers.replace(valueDes);
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
  @BuiltValueEnumConst(wireName: r'internal_ledger')
  static const PortfolioAccountPageScopeEnum internalLedger =
      _$portfolioAccountPageScopeEnum_internalLedger;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const PortfolioAccountPageScopeEnum unknownDefaultOpenApi =
      _$portfolioAccountPageScopeEnum_unknownDefaultOpenApi;

  static Serializer<PortfolioAccountPageScopeEnum> get serializer =>
      _$portfolioAccountPageScopeEnumSerializer;

  const PortfolioAccountPageScopeEnum._(String name) : super(name);

  static BuiltSet<PortfolioAccountPageScopeEnum> get values =>
      _$portfolioAccountPageScopeEnumValues;
  static PortfolioAccountPageScopeEnum valueOf(String name) =>
      _$portfolioAccountPageScopeEnumValueOf(name);
}

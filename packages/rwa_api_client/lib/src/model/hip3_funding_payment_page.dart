//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:rwa_api_client/src/model/hip3_funding_payment.dart';
import 'package:built_collection/built_collection.dart';
import 'package:rwa_api_client/src/model/hip3_funding_history_coverage.dart';
import 'package:rwa_api_client/src/model/hip3_archive_coverage.dart';
import 'package:rwa_api_client/src/model/hip3_environment.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'hip3_funding_payment_page.g.dart';

/// Hip3FundingPaymentPage
///
/// Properties:
/// * [querySource] 
/// * [archiveCoverage] 
/// * [snapshotId] 
/// * [environment] 
/// * [observedAt] 
/// * [items] 
/// * [hasMore] 
/// * [nextCursor] 
/// * [coverage] 
/// * [warnings] 
@BuiltValue()
abstract class Hip3FundingPaymentPage implements Built<Hip3FundingPaymentPage, Hip3FundingPaymentPageBuilder> {
  @BuiltValueField(wireName: r'query_source')
  Hip3FundingPaymentPageQuerySourceEnum get querySource;
  // enum querySourceEnum {  live,  archive,  };

  @BuiltValueField(wireName: r'archive_coverage')
  Hip3ArchiveCoverage? get archiveCoverage;

  @BuiltValueField(wireName: r'snapshot_id')
  String get snapshotId;

  @BuiltValueField(wireName: r'environment')
  Hip3Environment get environment;
  // enum environmentEnum {  mainnet,  testnet,  };

  @BuiltValueField(wireName: r'observed_at')
  DateTime get observedAt;

  @BuiltValueField(wireName: r'items')
  BuiltList<Hip3FundingPayment> get items;

  @BuiltValueField(wireName: r'has_more')
  bool get hasMore;

  @BuiltValueField(wireName: r'next_cursor')
  String? get nextCursor;

  @BuiltValueField(wireName: r'coverage')
  Hip3FundingHistoryCoverage get coverage;

  @BuiltValueField(wireName: r'warnings')
  BuiltList<Hip3FundingPaymentPageWarningsEnum> get warnings;
  // enum warningsEnum {  provider_history_retention_not_guaranteed,  funding_settlement_asset_unavailable,  history_archive_gaps,  };

  Hip3FundingPaymentPage._();

  factory Hip3FundingPaymentPage([void updates(Hip3FundingPaymentPageBuilder b)]) = _$Hip3FundingPaymentPage;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(Hip3FundingPaymentPageBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<Hip3FundingPaymentPage> get serializer => _$Hip3FundingPaymentPageSerializer();
}

class _$Hip3FundingPaymentPageSerializer implements PrimitiveSerializer<Hip3FundingPaymentPage> {
  @override
  final Iterable<Type> types = const [Hip3FundingPaymentPage, _$Hip3FundingPaymentPage];

  @override
  final String wireName = r'Hip3FundingPaymentPage';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    Hip3FundingPaymentPage object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'query_source';
    yield serializers.serialize(
      object.querySource,
      specifiedType: const FullType(Hip3FundingPaymentPageQuerySourceEnum),
    );
    yield r'archive_coverage';
    yield object.archiveCoverage == null ? null : serializers.serialize(
      object.archiveCoverage,
      specifiedType: const FullType.nullable(Hip3ArchiveCoverage),
    );
    yield r'snapshot_id';
    yield serializers.serialize(
      object.snapshotId,
      specifiedType: const FullType(String),
    );
    yield r'environment';
    yield serializers.serialize(
      object.environment,
      specifiedType: const FullType(Hip3Environment),
    );
    yield r'observed_at';
    yield serializers.serialize(
      object.observedAt,
      specifiedType: const FullType(DateTime),
    );
    yield r'items';
    yield serializers.serialize(
      object.items,
      specifiedType: const FullType(BuiltList, [FullType(Hip3FundingPayment)]),
    );
    yield r'has_more';
    yield serializers.serialize(
      object.hasMore,
      specifiedType: const FullType(bool),
    );
    yield r'next_cursor';
    yield object.nextCursor == null ? null : serializers.serialize(
      object.nextCursor,
      specifiedType: const FullType.nullable(String),
    );
    yield r'coverage';
    yield serializers.serialize(
      object.coverage,
      specifiedType: const FullType(Hip3FundingHistoryCoverage),
    );
    yield r'warnings';
    yield serializers.serialize(
      object.warnings,
      specifiedType: const FullType(BuiltList, [FullType(Hip3FundingPaymentPageWarningsEnum)]),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    Hip3FundingPaymentPage object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required Hip3FundingPaymentPageBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'query_source':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(Hip3FundingPaymentPageQuerySourceEnum),
          ) as Hip3FundingPaymentPageQuerySourceEnum;
          result.querySource = valueDes;
          break;
        case r'archive_coverage':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(Hip3ArchiveCoverage),
          ) as Hip3ArchiveCoverage?;
          if (valueDes == null) continue;
          result.archiveCoverage.replace(valueDes);
          break;
        case r'snapshot_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.snapshotId = valueDes;
          break;
        case r'environment':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(Hip3Environment),
          ) as Hip3Environment;
          result.environment = valueDes;
          break;
        case r'observed_at':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DateTime),
          ) as DateTime;
          result.observedAt = valueDes;
          break;
        case r'items':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(Hip3FundingPayment)]),
          ) as BuiltList<Hip3FundingPayment>;
          result.items.replace(valueDes);
          break;
        case r'has_more':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.hasMore = valueDes;
          break;
        case r'next_cursor':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.nextCursor = valueDes;
          break;
        case r'coverage':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(Hip3FundingHistoryCoverage),
          ) as Hip3FundingHistoryCoverage;
          result.coverage.replace(valueDes);
          break;
        case r'warnings':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(Hip3FundingPaymentPageWarningsEnum)]),
          ) as BuiltList<Hip3FundingPaymentPageWarningsEnum>;
          result.warnings.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  Hip3FundingPaymentPage deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = Hip3FundingPaymentPageBuilder();
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

class Hip3FundingPaymentPageQuerySourceEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'live')
  static const Hip3FundingPaymentPageQuerySourceEnum live = _$hip3FundingPaymentPageQuerySourceEnum_live;
  @BuiltValueEnumConst(wireName: r'archive')
  static const Hip3FundingPaymentPageQuerySourceEnum archive = _$hip3FundingPaymentPageQuerySourceEnum_archive;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const Hip3FundingPaymentPageQuerySourceEnum unknownDefaultOpenApi = _$hip3FundingPaymentPageQuerySourceEnum_unknownDefaultOpenApi;

  static Serializer<Hip3FundingPaymentPageQuerySourceEnum> get serializer => _$hip3FundingPaymentPageQuerySourceEnumSerializer;

  const Hip3FundingPaymentPageQuerySourceEnum._(String name): super(name);

  static BuiltSet<Hip3FundingPaymentPageQuerySourceEnum> get values => _$hip3FundingPaymentPageQuerySourceEnumValues;
  static Hip3FundingPaymentPageQuerySourceEnum valueOf(String name) => _$hip3FundingPaymentPageQuerySourceEnumValueOf(name);
}

class Hip3FundingPaymentPageWarningsEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'provider_history_retention_not_guaranteed')
  static const Hip3FundingPaymentPageWarningsEnum providerHistoryRetentionNotGuaranteed = _$hip3FundingPaymentPageWarningsEnum_providerHistoryRetentionNotGuaranteed;
  @BuiltValueEnumConst(wireName: r'funding_settlement_asset_unavailable')
  static const Hip3FundingPaymentPageWarningsEnum fundingSettlementAssetUnavailable = _$hip3FundingPaymentPageWarningsEnum_fundingSettlementAssetUnavailable;
  @BuiltValueEnumConst(wireName: r'history_archive_gaps')
  static const Hip3FundingPaymentPageWarningsEnum historyArchiveGaps = _$hip3FundingPaymentPageWarningsEnum_historyArchiveGaps;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const Hip3FundingPaymentPageWarningsEnum unknownDefaultOpenApi = _$hip3FundingPaymentPageWarningsEnum_unknownDefaultOpenApi;

  static Serializer<Hip3FundingPaymentPageWarningsEnum> get serializer => _$hip3FundingPaymentPageWarningsEnumSerializer;

  const Hip3FundingPaymentPageWarningsEnum._(String name): super(name);

  static BuiltSet<Hip3FundingPaymentPageWarningsEnum> get values => _$hip3FundingPaymentPageWarningsEnumValues;
  static Hip3FundingPaymentPageWarningsEnum valueOf(String name) => _$hip3FundingPaymentPageWarningsEnumValueOf(name);
}


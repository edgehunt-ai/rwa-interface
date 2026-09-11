//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:rwa_api_client/src/model/hip3_liquidation.dart';
import 'package:built_collection/built_collection.dart';
import 'package:rwa_api_client/src/model/hip3_liquidation_history_coverage.dart';
import 'package:rwa_api_client/src/model/hip3_archive_coverage.dart';
import 'package:rwa_api_client/src/model/hip3_environment.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'hip3_liquidation_page.g.dart';

/// Hip3LiquidationPage
///
/// Properties:
/// * [querySource] 
/// * [archiveCoverage] 
/// * [snapshotId] 
/// * [environment] 
/// * [observedAt] 
/// * [items] 
/// * [hasMore] - 仅表示当前冻结快照还有后续页，不代表来源完整。
/// * [nextCursor] 
/// * [coverage] 
/// * [warnings] 
@BuiltValue()
abstract class Hip3LiquidationPage implements Built<Hip3LiquidationPage, Hip3LiquidationPageBuilder> {
  @BuiltValueField(wireName: r'query_source')
  Hip3LiquidationPageQuerySourceEnum get querySource;
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
  BuiltList<Hip3Liquidation> get items;

  /// 仅表示当前冻结快照还有后续页，不代表来源完整。
  @BuiltValueField(wireName: r'has_more')
  bool get hasMore;

  @BuiltValueField(wireName: r'next_cursor')
  String? get nextCursor;

  @BuiltValueField(wireName: r'coverage')
  Hip3LiquidationHistoryCoverage get coverage;

  @BuiltValueField(wireName: r'warnings')
  BuiltList<Hip3LiquidationPageWarningsEnum> get warnings;
  // enum warningsEnum {  provider_history_retention_not_guaranteed,  history_archive_gaps,  };

  Hip3LiquidationPage._();

  factory Hip3LiquidationPage([void updates(Hip3LiquidationPageBuilder b)]) = _$Hip3LiquidationPage;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(Hip3LiquidationPageBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<Hip3LiquidationPage> get serializer => _$Hip3LiquidationPageSerializer();
}

class _$Hip3LiquidationPageSerializer implements PrimitiveSerializer<Hip3LiquidationPage> {
  @override
  final Iterable<Type> types = const [Hip3LiquidationPage, _$Hip3LiquidationPage];

  @override
  final String wireName = r'Hip3LiquidationPage';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    Hip3LiquidationPage object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'query_source';
    yield serializers.serialize(
      object.querySource,
      specifiedType: const FullType(Hip3LiquidationPageQuerySourceEnum),
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
      specifiedType: const FullType(BuiltList, [FullType(Hip3Liquidation)]),
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
      specifiedType: const FullType(Hip3LiquidationHistoryCoverage),
    );
    yield r'warnings';
    yield serializers.serialize(
      object.warnings,
      specifiedType: const FullType(BuiltList, [FullType(Hip3LiquidationPageWarningsEnum)]),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    Hip3LiquidationPage object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required Hip3LiquidationPageBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'query_source':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(Hip3LiquidationPageQuerySourceEnum),
          ) as Hip3LiquidationPageQuerySourceEnum;
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
            specifiedType: const FullType(BuiltList, [FullType(Hip3Liquidation)]),
          ) as BuiltList<Hip3Liquidation>;
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
            specifiedType: const FullType(Hip3LiquidationHistoryCoverage),
          ) as Hip3LiquidationHistoryCoverage;
          result.coverage.replace(valueDes);
          break;
        case r'warnings':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(Hip3LiquidationPageWarningsEnum)]),
          ) as BuiltList<Hip3LiquidationPageWarningsEnum>;
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
  Hip3LiquidationPage deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = Hip3LiquidationPageBuilder();
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

class Hip3LiquidationPageQuerySourceEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'live')
  static const Hip3LiquidationPageQuerySourceEnum live = _$hip3LiquidationPageQuerySourceEnum_live;
  @BuiltValueEnumConst(wireName: r'archive')
  static const Hip3LiquidationPageQuerySourceEnum archive = _$hip3LiquidationPageQuerySourceEnum_archive;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const Hip3LiquidationPageQuerySourceEnum unknownDefaultOpenApi = _$hip3LiquidationPageQuerySourceEnum_unknownDefaultOpenApi;

  static Serializer<Hip3LiquidationPageQuerySourceEnum> get serializer => _$hip3LiquidationPageQuerySourceEnumSerializer;

  const Hip3LiquidationPageQuerySourceEnum._(String name): super(name);

  static BuiltSet<Hip3LiquidationPageQuerySourceEnum> get values => _$hip3LiquidationPageQuerySourceEnumValues;
  static Hip3LiquidationPageQuerySourceEnum valueOf(String name) => _$hip3LiquidationPageQuerySourceEnumValueOf(name);
}

class Hip3LiquidationPageWarningsEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'provider_history_retention_not_guaranteed')
  static const Hip3LiquidationPageWarningsEnum providerHistoryRetentionNotGuaranteed = _$hip3LiquidationPageWarningsEnum_providerHistoryRetentionNotGuaranteed;
  @BuiltValueEnumConst(wireName: r'history_archive_gaps')
  static const Hip3LiquidationPageWarningsEnum historyArchiveGaps = _$hip3LiquidationPageWarningsEnum_historyArchiveGaps;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const Hip3LiquidationPageWarningsEnum unknownDefaultOpenApi = _$hip3LiquidationPageWarningsEnum_unknownDefaultOpenApi;

  static Serializer<Hip3LiquidationPageWarningsEnum> get serializer => _$hip3LiquidationPageWarningsEnumSerializer;

  const Hip3LiquidationPageWarningsEnum._(String name): super(name);

  static BuiltSet<Hip3LiquidationPageWarningsEnum> get values => _$hip3LiquidationPageWarningsEnumValues;
  static Hip3LiquidationPageWarningsEnum valueOf(String name) => _$hip3LiquidationPageWarningsEnumValueOf(name);
}


//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:rwa_api_client/src/model/portfolio_source_kind.dart';
import 'package:rwa_api_client/src/model/portfolio_source_state.dart';
import 'package:rwa_api_client/src/model/portfolio_freshness.dart';
import 'package:rwa_api_client/src/model/portfolio_warning_code.dart';
import 'package:rwa_api_client/src/model/portfolio_asset_network.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'portfolio_source_summary.g.dart';

/// 单个只读余额、价格或内部账本来源的可用性与缓存新鲜度。`status=available` 时 freshness 必须非 null；`status=unavailable` 且没有可用 last-good 时 freshness 必须为 null；使用 last-good 时必须返回 `status=available`、 `freshness=stale`，并附带 `using_last_good` warning。
///
/// Properties:
/// * [source_]
/// * [network]
/// * [status]
/// * [freshness]
/// * [observedAt]
/// * [warningCode]
@BuiltValue()
abstract class PortfolioSourceSummary
    implements Built<PortfolioSourceSummary, PortfolioSourceSummaryBuilder> {
  @BuiltValueField(wireName: r'source')
  PortfolioSourceKind get source_;
  // enum source_Enum {  evm_rpc,  hyperliquid_info,  dodoex_price,  fixed_peg,  internal_ledger,  };

  @BuiltValueField(wireName: r'network')
  PortfolioAssetNetwork? get network;
  // enum networkEnum {  BSC,  Arbitrum,  Base,  Ethereum,  Hyperliquid,  };

  @BuiltValueField(wireName: r'status')
  PortfolioSourceState get status;
  // enum statusEnum {  available,  unavailable,  };

  @BuiltValueField(wireName: r'freshness')
  PortfolioFreshness? get freshness;
  // enum freshnessEnum {  live,  cached,  stale,  };

  @BuiltValueField(wireName: r'observed_at')
  DateTime? get observedAt;

  @BuiltValueField(wireName: r'warning_code')
  PortfolioWarningCode? get warningCode;
  // enum warningCodeEnum {  evm_rpc_unavailable,  hyperliquid_unavailable,  price_unavailable,  asset_unvalued,  using_last_good,  wallet_set_changed,  internal_ledger_stale,  internal_ledger_unreconciled,  };

  PortfolioSourceSummary._();

  factory PortfolioSourceSummary(
          [void updates(PortfolioSourceSummaryBuilder b)]) =
      _$PortfolioSourceSummary;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(PortfolioSourceSummaryBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<PortfolioSourceSummary> get serializer =>
      _$PortfolioSourceSummarySerializer();
}

class _$PortfolioSourceSummarySerializer
    implements PrimitiveSerializer<PortfolioSourceSummary> {
  @override
  final Iterable<Type> types = const [
    PortfolioSourceSummary,
    _$PortfolioSourceSummary
  ];

  @override
  final String wireName = r'PortfolioSourceSummary';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    PortfolioSourceSummary object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'source';
    yield serializers.serialize(
      object.source_,
      specifiedType: const FullType(PortfolioSourceKind),
    );
    if (object.network != null) {
      yield r'network';
      yield serializers.serialize(
        object.network,
        specifiedType: const FullType.nullable(PortfolioAssetNetwork),
      );
    }
    yield r'status';
    yield serializers.serialize(
      object.status,
      specifiedType: const FullType(PortfolioSourceState),
    );
    yield r'freshness';
    yield object.freshness == null
        ? null
        : serializers.serialize(
            object.freshness,
            specifiedType: const FullType.nullable(PortfolioFreshness),
          );
    if (object.observedAt != null) {
      yield r'observed_at';
      yield serializers.serialize(
        object.observedAt,
        specifiedType: const FullType.nullable(DateTime),
      );
    }
    if (object.warningCode != null) {
      yield r'warning_code';
      yield serializers.serialize(
        object.warningCode,
        specifiedType: const FullType.nullable(PortfolioWarningCode),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    PortfolioSourceSummary object, {
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
    required PortfolioSourceSummaryBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'source':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(PortfolioSourceKind),
          ) as PortfolioSourceKind;
          result.source_ = valueDes;
          break;
        case r'network':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(PortfolioAssetNetwork),
          ) as PortfolioAssetNetwork?;
          if (valueDes == null) continue;
          result.network = valueDes;
          break;
        case r'status':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(PortfolioSourceState),
          ) as PortfolioSourceState;
          result.status = valueDes;
          break;
        case r'freshness':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(PortfolioFreshness),
          ) as PortfolioFreshness?;
          if (valueDes == null) continue;
          result.freshness = valueDes;
          break;
        case r'observed_at':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(DateTime),
          ) as DateTime?;
          if (valueDes == null) continue;
          result.observedAt = valueDes;
          break;
        case r'warning_code':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(PortfolioWarningCode),
          ) as PortfolioWarningCode?;
          if (valueDes == null) continue;
          result.warningCode = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  PortfolioSourceSummary deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = PortfolioSourceSummaryBuilder();
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

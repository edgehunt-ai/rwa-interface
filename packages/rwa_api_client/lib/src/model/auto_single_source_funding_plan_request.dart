//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:rwa_api_client/src/model/funding_plan_mode.dart';
import 'package:rwa_api_client/src/model/funding_source_asset_id.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'auto_single_source_funding_plan_request.g.dart';

/// AutoSingleSourceFundingPlanRequest
///
/// Properties:
/// * [tradePreviewId] - Immutable trade preview from which purpose, target identity and required target amount are derived.
/// * [mode]
/// * [sourceAssetId] - Optional exact canonical source asset constraint. If supplied, planning must not quote or select any other source.
@BuiltValue()
abstract class AutoSingleSourceFundingPlanRequest
    implements
        Built<AutoSingleSourceFundingPlanRequest,
            AutoSingleSourceFundingPlanRequestBuilder> {
  /// Immutable trade preview from which purpose, target identity and required target amount are derived.
  @BuiltValueField(wireName: r'trade_preview_id')
  String get tradePreviewId;

  @BuiltValueField(wireName: r'mode')
  FundingPlanMode get mode;
  // enum modeEnum {  auto_single_source,  };

  /// Optional exact canonical source asset constraint. If supplied, planning must not quote or select any other source.
  @BuiltValueField(wireName: r'source_asset_id')
  FundingSourceAssetId? get sourceAssetId;
  // enum sourceAssetIdEnum {  eip155:1/erc20:0xa0b86991c6218b36c1d19d4a2e9eb0ce3606eb48,  eip155:1/erc20:0xdac17f958d2ee523a2206206994597c13d831ec7,  eip155:42161/erc20:0xaf88d065e77c8cc2239327c5edb3a432268e5831,  eip155:42161/erc20:0xfd086bc7cd5c481dcc9c85ebe478a1c0b69fcbb9,  eip155:8453/erc20:0x833589fcd6edb6e08f4c7c32d4f71b54bda02913,  eip155:8453/erc20:0xfde4c96c8593536e31f229ea8f37b2ada2699bb2,  eip155:56/erc20:0x8ac76a51cc950d9822d68b83fe1ad97b32cd580d,  eip155:56/erc20:0x55d398326f99059ff775485246999027b3197955,  };

  AutoSingleSourceFundingPlanRequest._();

  factory AutoSingleSourceFundingPlanRequest(
          [void updates(AutoSingleSourceFundingPlanRequestBuilder b)]) =
      _$AutoSingleSourceFundingPlanRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(AutoSingleSourceFundingPlanRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<AutoSingleSourceFundingPlanRequest> get serializer =>
      _$AutoSingleSourceFundingPlanRequestSerializer();
}

class _$AutoSingleSourceFundingPlanRequestSerializer
    implements PrimitiveSerializer<AutoSingleSourceFundingPlanRequest> {
  @override
  final Iterable<Type> types = const [
    AutoSingleSourceFundingPlanRequest,
    _$AutoSingleSourceFundingPlanRequest
  ];

  @override
  final String wireName = r'AutoSingleSourceFundingPlanRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    AutoSingleSourceFundingPlanRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'trade_preview_id';
    yield serializers.serialize(
      object.tradePreviewId,
      specifiedType: const FullType(String),
    );
    yield r'mode';
    yield serializers.serialize(
      object.mode,
      specifiedType: const FullType(FundingPlanMode),
    );
    if (object.sourceAssetId != null) {
      yield r'source_asset_id';
      yield serializers.serialize(
        object.sourceAssetId,
        specifiedType: const FullType(FundingSourceAssetId),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    AutoSingleSourceFundingPlanRequest object, {
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
    required AutoSingleSourceFundingPlanRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'trade_preview_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.tradePreviewId = valueDes;
          break;
        case r'mode':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(FundingPlanMode),
          ) as FundingPlanMode;
          result.mode = valueDes;
          break;
        case r'source_asset_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(FundingSourceAssetId),
          ) as FundingSourceAssetId?;
          if (valueDes == null) continue;
          result.sourceAssetId = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  AutoSingleSourceFundingPlanRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = AutoSingleSourceFundingPlanRequestBuilder();
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

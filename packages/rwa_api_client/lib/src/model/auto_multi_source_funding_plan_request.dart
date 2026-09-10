//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'auto_multi_source_funding_plan_request.g.dart';

/// Requests deterministic automatic allocation from the current account's eligible positions. Provider, route, target, calldata, action payloads and the three-leg limit are server-owned. 
///
/// Properties:
/// * [tradePreviewId] - Immutable preview from which the target identity and required amount are derived.
/// * [mode] 
/// * [excludedSourcePositionIds] - Optional account-scoped opaque positions that the allocator must not use.
@BuiltValue()
abstract class AutoMultiSourceFundingPlanRequest implements Built<AutoMultiSourceFundingPlanRequest, AutoMultiSourceFundingPlanRequestBuilder> {
  /// Immutable preview from which the target identity and required amount are derived.
  @BuiltValueField(wireName: r'trade_preview_id')
  String get tradePreviewId;

  @BuiltValueField(wireName: r'mode')
  AutoMultiSourceFundingPlanRequestModeEnum get mode;
  // enum modeEnum {  auto_multi_source,  };

  /// Optional account-scoped opaque positions that the allocator must not use.
  @BuiltValueField(wireName: r'excluded_source_position_ids')
  BuiltSet<String>? get excludedSourcePositionIds;

  AutoMultiSourceFundingPlanRequest._();

  factory AutoMultiSourceFundingPlanRequest([void updates(AutoMultiSourceFundingPlanRequestBuilder b)]) = _$AutoMultiSourceFundingPlanRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(AutoMultiSourceFundingPlanRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<AutoMultiSourceFundingPlanRequest> get serializer => _$AutoMultiSourceFundingPlanRequestSerializer();
}

class _$AutoMultiSourceFundingPlanRequestSerializer implements PrimitiveSerializer<AutoMultiSourceFundingPlanRequest> {
  @override
  final Iterable<Type> types = const [AutoMultiSourceFundingPlanRequest, _$AutoMultiSourceFundingPlanRequest];

  @override
  final String wireName = r'AutoMultiSourceFundingPlanRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    AutoMultiSourceFundingPlanRequest object, {
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
      specifiedType: const FullType(AutoMultiSourceFundingPlanRequestModeEnum),
    );
    if (object.excludedSourcePositionIds != null) {
      yield r'excluded_source_position_ids';
      yield serializers.serialize(
        object.excludedSourcePositionIds,
        specifiedType: const FullType(BuiltSet, [FullType(String)]),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    AutoMultiSourceFundingPlanRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required AutoMultiSourceFundingPlanRequestBuilder result,
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
            specifiedType: const FullType(AutoMultiSourceFundingPlanRequestModeEnum),
          ) as AutoMultiSourceFundingPlanRequestModeEnum;
          result.mode = valueDes;
          break;
        case r'excluded_source_position_ids':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(BuiltSet, [FullType(String)]),
          ) as BuiltSet<String>?;
          if (valueDes == null) continue;
          result.excludedSourcePositionIds.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  AutoMultiSourceFundingPlanRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = AutoMultiSourceFundingPlanRequestBuilder();
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

class AutoMultiSourceFundingPlanRequestModeEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'auto_multi_source')
  static const AutoMultiSourceFundingPlanRequestModeEnum autoMultiSource = _$autoMultiSourceFundingPlanRequestModeEnum_autoMultiSource;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const AutoMultiSourceFundingPlanRequestModeEnum unknownDefaultOpenApi = _$autoMultiSourceFundingPlanRequestModeEnum_unknownDefaultOpenApi;

  static Serializer<AutoMultiSourceFundingPlanRequestModeEnum> get serializer => _$autoMultiSourceFundingPlanRequestModeEnumSerializer;

  const AutoMultiSourceFundingPlanRequestModeEnum._(String name): super(name);

  static BuiltSet<AutoMultiSourceFundingPlanRequestModeEnum> get values => _$autoMultiSourceFundingPlanRequestModeEnumValues;
  static AutoMultiSourceFundingPlanRequestModeEnum valueOf(String name) => _$autoMultiSourceFundingPlanRequestModeEnumValueOf(name);
}


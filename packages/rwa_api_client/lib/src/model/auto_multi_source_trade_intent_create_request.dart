//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:rwa_api_client/src/model/trade_intent_execution_policy.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'auto_multi_source_trade_intent_create_request.g.dart';

/// AutoMultiSourceTradeIntentCreateRequest
///
/// Properties:
/// * [previewId] 
/// * [authorizationId] - Order authorization; funding Transfers require a separate authorization for each leg.
/// * [fundingMode] 
/// * [executionPolicy] 
@Deprecated('AutoMultiSourceTradeIntentCreateRequest has been deprecated')
@BuiltValue()
abstract class AutoMultiSourceTradeIntentCreateRequest implements Built<AutoMultiSourceTradeIntentCreateRequest, AutoMultiSourceTradeIntentCreateRequestBuilder> {
  @BuiltValueField(wireName: r'preview_id')
  String get previewId;

  /// Order authorization; funding Transfers require a separate authorization for each leg.
  @BuiltValueField(wireName: r'authorization_id')
  String get authorizationId;

  @BuiltValueField(wireName: r'funding_mode')
  AutoMultiSourceTradeIntentCreateRequestFundingModeEnum get fundingMode;
  // enum fundingModeEnum {  auto_multi_source,  };

  @BuiltValueField(wireName: r'execution_policy')
  TradeIntentExecutionPolicy get executionPolicy;

  AutoMultiSourceTradeIntentCreateRequest._();

  factory AutoMultiSourceTradeIntentCreateRequest([void updates(AutoMultiSourceTradeIntentCreateRequestBuilder b)]) = _$AutoMultiSourceTradeIntentCreateRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(AutoMultiSourceTradeIntentCreateRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<AutoMultiSourceTradeIntentCreateRequest> get serializer => _$AutoMultiSourceTradeIntentCreateRequestSerializer();
}

class _$AutoMultiSourceTradeIntentCreateRequestSerializer implements PrimitiveSerializer<AutoMultiSourceTradeIntentCreateRequest> {
  @override
  final Iterable<Type> types = const [AutoMultiSourceTradeIntentCreateRequest, _$AutoMultiSourceTradeIntentCreateRequest];

  @override
  final String wireName = r'AutoMultiSourceTradeIntentCreateRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    AutoMultiSourceTradeIntentCreateRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'preview_id';
    yield serializers.serialize(
      object.previewId,
      specifiedType: const FullType(String),
    );
    yield r'authorization_id';
    yield serializers.serialize(
      object.authorizationId,
      specifiedType: const FullType(String),
    );
    yield r'funding_mode';
    yield serializers.serialize(
      object.fundingMode,
      specifiedType: const FullType(AutoMultiSourceTradeIntentCreateRequestFundingModeEnum),
    );
    yield r'execution_policy';
    yield serializers.serialize(
      object.executionPolicy,
      specifiedType: const FullType(TradeIntentExecutionPolicy),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    AutoMultiSourceTradeIntentCreateRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required AutoMultiSourceTradeIntentCreateRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'preview_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.previewId = valueDes;
          break;
        case r'authorization_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.authorizationId = valueDes;
          break;
        case r'funding_mode':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(AutoMultiSourceTradeIntentCreateRequestFundingModeEnum),
          ) as AutoMultiSourceTradeIntentCreateRequestFundingModeEnum;
          result.fundingMode = valueDes;
          break;
        case r'execution_policy':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(TradeIntentExecutionPolicy),
          ) as TradeIntentExecutionPolicy;
          result.executionPolicy.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  AutoMultiSourceTradeIntentCreateRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = AutoMultiSourceTradeIntentCreateRequestBuilder();
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

@Deprecated('AutoMultiSourceTradeIntentCreateRequestFundingModeEnum has been deprecated')
class AutoMultiSourceTradeIntentCreateRequestFundingModeEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'auto_multi_source')
  static const AutoMultiSourceTradeIntentCreateRequestFundingModeEnum autoMultiSource = _$autoMultiSourceTradeIntentCreateRequestFundingModeEnum_autoMultiSource;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const AutoMultiSourceTradeIntentCreateRequestFundingModeEnum unknownDefaultOpenApi = _$autoMultiSourceTradeIntentCreateRequestFundingModeEnum_unknownDefaultOpenApi;

  static Serializer<AutoMultiSourceTradeIntentCreateRequestFundingModeEnum> get serializer => _$autoMultiSourceTradeIntentCreateRequestFundingModeEnumSerializer;

  const AutoMultiSourceTradeIntentCreateRequestFundingModeEnum._(String name): super(name);

  static BuiltSet<AutoMultiSourceTradeIntentCreateRequestFundingModeEnum> get values => _$autoMultiSourceTradeIntentCreateRequestFundingModeEnumValues;
  static AutoMultiSourceTradeIntentCreateRequestFundingModeEnum valueOf(String name) => _$autoMultiSourceTradeIntentCreateRequestFundingModeEnumValueOf(name);
}


//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:rwa_api_client/src/model/trade_intent_execution_policy.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'funding_session_trade_intent_create_request.g.dart';

/// In one idempotent API command, obtains fresh market and risk evidence, creates the executable Preview and consumes it into a TradeIntent after the referenced FundingSession is funded. The server derives the account-owned HIP-3 wallet; the client never races a short-lived preview or wallet identity through the funding flow. 
///
/// Properties:
/// * [fundingSessionId] 
/// * [fundingSessionVersion] 
/// * [executionPolicy] 
/// * [fundingMode] 
@BuiltValue()
abstract class FundingSessionTradeIntentCreateRequest implements Built<FundingSessionTradeIntentCreateRequest, FundingSessionTradeIntentCreateRequestBuilder> {
  @BuiltValueField(wireName: r'funding_session_id')
  String get fundingSessionId;

  @BuiltValueField(wireName: r'funding_session_version')
  int get fundingSessionVersion;

  @BuiltValueField(wireName: r'execution_policy')
  TradeIntentExecutionPolicy get executionPolicy;

  @BuiltValueField(wireName: r'funding_mode')
  FundingSessionTradeIntentCreateRequestFundingModeEnum get fundingMode;
  // enum fundingModeEnum {  funding_session,  };

  FundingSessionTradeIntentCreateRequest._();

  factory FundingSessionTradeIntentCreateRequest([void updates(FundingSessionTradeIntentCreateRequestBuilder b)]) = _$FundingSessionTradeIntentCreateRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(FundingSessionTradeIntentCreateRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<FundingSessionTradeIntentCreateRequest> get serializer => _$FundingSessionTradeIntentCreateRequestSerializer();
}

class _$FundingSessionTradeIntentCreateRequestSerializer implements PrimitiveSerializer<FundingSessionTradeIntentCreateRequest> {
  @override
  final Iterable<Type> types = const [FundingSessionTradeIntentCreateRequest, _$FundingSessionTradeIntentCreateRequest];

  @override
  final String wireName = r'FundingSessionTradeIntentCreateRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    FundingSessionTradeIntentCreateRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'funding_session_id';
    yield serializers.serialize(
      object.fundingSessionId,
      specifiedType: const FullType(String),
    );
    yield r'funding_session_version';
    yield serializers.serialize(
      object.fundingSessionVersion,
      specifiedType: const FullType(int),
    );
    yield r'execution_policy';
    yield serializers.serialize(
      object.executionPolicy,
      specifiedType: const FullType(TradeIntentExecutionPolicy),
    );
    yield r'funding_mode';
    yield serializers.serialize(
      object.fundingMode,
      specifiedType: const FullType(FundingSessionTradeIntentCreateRequestFundingModeEnum),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    FundingSessionTradeIntentCreateRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required FundingSessionTradeIntentCreateRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'funding_session_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.fundingSessionId = valueDes;
          break;
        case r'funding_session_version':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.fundingSessionVersion = valueDes;
          break;
        case r'execution_policy':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(TradeIntentExecutionPolicy),
          ) as TradeIntentExecutionPolicy;
          result.executionPolicy.replace(valueDes);
          break;
        case r'funding_mode':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(FundingSessionTradeIntentCreateRequestFundingModeEnum),
          ) as FundingSessionTradeIntentCreateRequestFundingModeEnum;
          result.fundingMode = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  FundingSessionTradeIntentCreateRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = FundingSessionTradeIntentCreateRequestBuilder();
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

class FundingSessionTradeIntentCreateRequestFundingModeEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'funding_session')
  static const FundingSessionTradeIntentCreateRequestFundingModeEnum fundingSession = _$fundingSessionTradeIntentCreateRequestFundingModeEnum_fundingSession;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const FundingSessionTradeIntentCreateRequestFundingModeEnum unknownDefaultOpenApi = _$fundingSessionTradeIntentCreateRequestFundingModeEnum_unknownDefaultOpenApi;

  static Serializer<FundingSessionTradeIntentCreateRequestFundingModeEnum> get serializer => _$fundingSessionTradeIntentCreateRequestFundingModeEnumSerializer;

  const FundingSessionTradeIntentCreateRequestFundingModeEnum._(String name): super(name);

  static BuiltSet<FundingSessionTradeIntentCreateRequestFundingModeEnum> get values => _$fundingSessionTradeIntentCreateRequestFundingModeEnumValues;
  static FundingSessionTradeIntentCreateRequestFundingModeEnum valueOf(String name) => _$fundingSessionTradeIntentCreateRequestFundingModeEnumValueOf(name);
}


//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:rwa_api_client/src/model/order_preview_request.dart';
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'funding_session_continuation.g.dart';

/// Server-owned resume hint emitted only when a funded session still owes a follow-up order action (today: a bStocks order whose immutable trade input survives funding). It is navigational context only: clients must rebuild preview, quote and executable actions through the trading endpoints; `auto_submit` is always `false`. 
///
/// Properties:
/// * [action] 
/// * [status] 
/// * [fundingSessionId] 
/// * [trade] 
/// * [requiresNewQuote] - Always `true`; funding never preserves a usable quote.
/// * [autoSubmit] - Always `false`; resuming requires an explicit user action.
@BuiltValue()
abstract class FundingSessionContinuation implements Built<FundingSessionContinuation, FundingSessionContinuationBuilder> {
  @BuiltValueField(wireName: r'action')
  FundingSessionContinuationActionEnum? get action;
  // enum actionEnum {  resume_bstocks_order,  };

  @BuiltValueField(wireName: r'status')
  FundingSessionContinuationStatusEnum? get status;
  // enum statusEnum {  ready_to_requote,  };

  @BuiltValueField(wireName: r'funding_session_id')
  String? get fundingSessionId;

  @BuiltValueField(wireName: r'trade')
  OrderPreviewRequest? get trade;

  /// Always `true`; funding never preserves a usable quote.
  @BuiltValueField(wireName: r'requires_new_quote')
  bool? get requiresNewQuote;

  /// Always `false`; resuming requires an explicit user action.
  @BuiltValueField(wireName: r'auto_submit')
  bool? get autoSubmit;

  FundingSessionContinuation._();

  factory FundingSessionContinuation([void updates(FundingSessionContinuationBuilder b)]) = _$FundingSessionContinuation;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(FundingSessionContinuationBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<FundingSessionContinuation> get serializer => _$FundingSessionContinuationSerializer();
}

class _$FundingSessionContinuationSerializer implements PrimitiveSerializer<FundingSessionContinuation> {
  @override
  final Iterable<Type> types = const [FundingSessionContinuation, _$FundingSessionContinuation];

  @override
  final String wireName = r'FundingSessionContinuation';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    FundingSessionContinuation object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.action != null) {
      yield r'action';
      yield serializers.serialize(
        object.action,
        specifiedType: const FullType.nullable(FundingSessionContinuationActionEnum),
      );
    }
    if (object.status != null) {
      yield r'status';
      yield serializers.serialize(
        object.status,
        specifiedType: const FullType.nullable(FundingSessionContinuationStatusEnum),
      );
    }
    if (object.fundingSessionId != null) {
      yield r'funding_session_id';
      yield serializers.serialize(
        object.fundingSessionId,
        specifiedType: const FullType.nullable(String),
      );
    }
    if (object.trade != null) {
      yield r'trade';
      yield serializers.serialize(
        object.trade,
        specifiedType: const FullType(OrderPreviewRequest),
      );
    }
    if (object.requiresNewQuote != null) {
      yield r'requires_new_quote';
      yield serializers.serialize(
        object.requiresNewQuote,
        specifiedType: const FullType.nullable(bool),
      );
    }
    if (object.autoSubmit != null) {
      yield r'auto_submit';
      yield serializers.serialize(
        object.autoSubmit,
        specifiedType: const FullType.nullable(bool),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    FundingSessionContinuation object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required FundingSessionContinuationBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'action':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(FundingSessionContinuationActionEnum),
          ) as FundingSessionContinuationActionEnum?;
          if (valueDes == null) continue;
          result.action = valueDes;
          break;
        case r'status':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(FundingSessionContinuationStatusEnum),
          ) as FundingSessionContinuationStatusEnum?;
          if (valueDes == null) continue;
          result.status = valueDes;
          break;
        case r'funding_session_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.fundingSessionId = valueDes;
          break;
        case r'trade':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(OrderPreviewRequest),
          ) as OrderPreviewRequest?;
          if (valueDes == null) continue;
          result.trade.replace(valueDes);
          break;
        case r'requires_new_quote':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(bool),
          ) as bool?;
          if (valueDes == null) continue;
          result.requiresNewQuote = valueDes;
          break;
        case r'auto_submit':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(bool),
          ) as bool?;
          if (valueDes == null) continue;
          result.autoSubmit = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  FundingSessionContinuation deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = FundingSessionContinuationBuilder();
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

class FundingSessionContinuationActionEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'resume_bstocks_order')
  static const FundingSessionContinuationActionEnum resumeBstocksOrder = _$fundingSessionContinuationActionEnum_resumeBstocksOrder;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const FundingSessionContinuationActionEnum unknownDefaultOpenApi = _$fundingSessionContinuationActionEnum_unknownDefaultOpenApi;

  static Serializer<FundingSessionContinuationActionEnum> get serializer => _$fundingSessionContinuationActionEnumSerializer;

  const FundingSessionContinuationActionEnum._(String name): super(name);

  static BuiltSet<FundingSessionContinuationActionEnum> get values => _$fundingSessionContinuationActionEnumValues;
  static FundingSessionContinuationActionEnum valueOf(String name) => _$fundingSessionContinuationActionEnumValueOf(name);
}

class FundingSessionContinuationStatusEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'ready_to_requote')
  static const FundingSessionContinuationStatusEnum readyToRequote = _$fundingSessionContinuationStatusEnum_readyToRequote;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const FundingSessionContinuationStatusEnum unknownDefaultOpenApi = _$fundingSessionContinuationStatusEnum_unknownDefaultOpenApi;

  static Serializer<FundingSessionContinuationStatusEnum> get serializer => _$fundingSessionContinuationStatusEnumSerializer;

  const FundingSessionContinuationStatusEnum._(String name): super(name);

  static BuiltSet<FundingSessionContinuationStatusEnum> get values => _$fundingSessionContinuationStatusEnumValues;
  static FundingSessionContinuationStatusEnum valueOf(String name) => _$fundingSessionContinuationStatusEnumValueOf(name);
}


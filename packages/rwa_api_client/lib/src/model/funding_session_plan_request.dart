//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'funding_session_plan_request.g.dart';

/// Creates a frozen funding plan from the latest accepted user selection; Provider and executable actions remain server-owned.
///
/// Properties:
/// * [fundingSessionId] 
/// * [selectionVersion] 
@BuiltValue()
abstract class FundingSessionPlanRequest implements Built<FundingSessionPlanRequest, FundingSessionPlanRequestBuilder> {
  @BuiltValueField(wireName: r'funding_session_id')
  String get fundingSessionId;

  @BuiltValueField(wireName: r'selection_version')
  int get selectionVersion;

  FundingSessionPlanRequest._();

  factory FundingSessionPlanRequest([void updates(FundingSessionPlanRequestBuilder b)]) = _$FundingSessionPlanRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(FundingSessionPlanRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<FundingSessionPlanRequest> get serializer => _$FundingSessionPlanRequestSerializer();
}

class _$FundingSessionPlanRequestSerializer implements PrimitiveSerializer<FundingSessionPlanRequest> {
  @override
  final Iterable<Type> types = const [FundingSessionPlanRequest, _$FundingSessionPlanRequest];

  @override
  final String wireName = r'FundingSessionPlanRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    FundingSessionPlanRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'funding_session_id';
    yield serializers.serialize(
      object.fundingSessionId,
      specifiedType: const FullType(String),
    );
    yield r'selection_version';
    yield serializers.serialize(
      object.selectionVersion,
      specifiedType: const FullType(int),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    FundingSessionPlanRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required FundingSessionPlanRequestBuilder result,
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
        case r'selection_version':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.selectionVersion = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  FundingSessionPlanRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = FundingSessionPlanRequestBuilder();
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


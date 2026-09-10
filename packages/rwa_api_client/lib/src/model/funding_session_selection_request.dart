//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:rwa_api_client/src/model/funding_session_source_allocation_input.dart';
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'funding_session_selection_request.g.dart';

/// Replaces the editable source selection for the expected session version. A selection below the minimum may be saved, but the returned session must keep transfer confirmation disabled. 
///
/// Properties:
/// * [version] 
/// * [allocations] 
@BuiltValue()
abstract class FundingSessionSelectionRequest implements Built<FundingSessionSelectionRequest, FundingSessionSelectionRequestBuilder> {
  @BuiltValueField(wireName: r'version')
  int get version;

  @BuiltValueField(wireName: r'allocations')
  BuiltSet<FundingSessionSourceAllocationInput> get allocations;

  FundingSessionSelectionRequest._();

  factory FundingSessionSelectionRequest([void updates(FundingSessionSelectionRequestBuilder b)]) = _$FundingSessionSelectionRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(FundingSessionSelectionRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<FundingSessionSelectionRequest> get serializer => _$FundingSessionSelectionRequestSerializer();
}

class _$FundingSessionSelectionRequestSerializer implements PrimitiveSerializer<FundingSessionSelectionRequest> {
  @override
  final Iterable<Type> types = const [FundingSessionSelectionRequest, _$FundingSessionSelectionRequest];

  @override
  final String wireName = r'FundingSessionSelectionRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    FundingSessionSelectionRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'version';
    yield serializers.serialize(
      object.version,
      specifiedType: const FullType(int),
    );
    yield r'allocations';
    yield serializers.serialize(
      object.allocations,
      specifiedType: const FullType(BuiltSet, [FullType(FundingSessionSourceAllocationInput)]),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    FundingSessionSelectionRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required FundingSessionSelectionRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'version':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.version = valueDes;
          break;
        case r'allocations':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltSet, [FullType(FundingSessionSourceAllocationInput)]),
          ) as BuiltSet<FundingSessionSourceAllocationInput>;
          result.allocations.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  FundingSessionSelectionRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = FundingSessionSelectionRequestBuilder();
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


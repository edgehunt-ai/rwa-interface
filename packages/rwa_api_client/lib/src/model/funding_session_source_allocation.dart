//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'funding_session_source_allocation.g.dart';

/// Server-valued view of one user-selected source amount.
///
/// Properties:
/// * [sourcePositionId] 
/// * [inputAmount] - 十进制字符串，避免浮点误差
/// * [estimatedTargetAmount] - 十进制字符串，避免浮点误差
@BuiltValue()
abstract class FundingSessionSourceAllocation implements Built<FundingSessionSourceAllocation, FundingSessionSourceAllocationBuilder> {
  @BuiltValueField(wireName: r'source_position_id')
  String get sourcePositionId;

  /// 十进制字符串，避免浮点误差
  @BuiltValueField(wireName: r'input_amount')
  String get inputAmount;

  /// 十进制字符串，避免浮点误差
  @BuiltValueField(wireName: r'estimated_target_amount')
  String get estimatedTargetAmount;

  FundingSessionSourceAllocation._();

  factory FundingSessionSourceAllocation([void updates(FundingSessionSourceAllocationBuilder b)]) = _$FundingSessionSourceAllocation;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(FundingSessionSourceAllocationBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<FundingSessionSourceAllocation> get serializer => _$FundingSessionSourceAllocationSerializer();
}

class _$FundingSessionSourceAllocationSerializer implements PrimitiveSerializer<FundingSessionSourceAllocation> {
  @override
  final Iterable<Type> types = const [FundingSessionSourceAllocation, _$FundingSessionSourceAllocation];

  @override
  final String wireName = r'FundingSessionSourceAllocation';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    FundingSessionSourceAllocation object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'source_position_id';
    yield serializers.serialize(
      object.sourcePositionId,
      specifiedType: const FullType(String),
    );
    yield r'input_amount';
    yield serializers.serialize(
      object.inputAmount,
      specifiedType: const FullType(String),
    );
    yield r'estimated_target_amount';
    yield serializers.serialize(
      object.estimatedTargetAmount,
      specifiedType: const FullType(String),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    FundingSessionSourceAllocation object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required FundingSessionSourceAllocationBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'source_position_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.sourcePositionId = valueDes;
          break;
        case r'input_amount':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.inputAmount = valueDes;
          break;
        case r'estimated_target_amount':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.estimatedTargetAmount = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  FundingSessionSourceAllocation deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = FundingSessionSourceAllocationBuilder();
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


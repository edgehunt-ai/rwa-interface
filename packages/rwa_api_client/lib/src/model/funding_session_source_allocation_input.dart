//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'funding_session_source_allocation_input.g.dart';

/// User-selected spend from one current account-scoped funding position.
///
/// Properties:
/// * [sourcePositionId] 
/// * [inputAmount] - 十进制字符串，避免浮点误差
@BuiltValue()
abstract class FundingSessionSourceAllocationInput implements Built<FundingSessionSourceAllocationInput, FundingSessionSourceAllocationInputBuilder> {
  @BuiltValueField(wireName: r'source_position_id')
  String get sourcePositionId;

  /// 十进制字符串，避免浮点误差
  @BuiltValueField(wireName: r'input_amount')
  String get inputAmount;

  FundingSessionSourceAllocationInput._();

  factory FundingSessionSourceAllocationInput([void updates(FundingSessionSourceAllocationInputBuilder b)]) = _$FundingSessionSourceAllocationInput;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(FundingSessionSourceAllocationInputBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<FundingSessionSourceAllocationInput> get serializer => _$FundingSessionSourceAllocationInputSerializer();
}

class _$FundingSessionSourceAllocationInputSerializer implements PrimitiveSerializer<FundingSessionSourceAllocationInput> {
  @override
  final Iterable<Type> types = const [FundingSessionSourceAllocationInput, _$FundingSessionSourceAllocationInput];

  @override
  final String wireName = r'FundingSessionSourceAllocationInput';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    FundingSessionSourceAllocationInput object, {
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
  }

  @override
  Object serialize(
    Serializers serializers,
    FundingSessionSourceAllocationInput object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required FundingSessionSourceAllocationInputBuilder result,
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
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  FundingSessionSourceAllocationInput deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = FundingSessionSourceAllocationInputBuilder();
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


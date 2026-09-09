//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:rwa_api_client/src/model/margin_mode.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'update_position_leverage_request.g.dart';

/// UpdatePositionLeverageRequest
///
/// Properties:
/// * [leverage] - Decimal string leverage; allowed range is 1 to 50.
/// * [marginMode]
@BuiltValue()
abstract class UpdatePositionLeverageRequest
    implements
        Built<UpdatePositionLeverageRequest,
            UpdatePositionLeverageRequestBuilder> {
  /// Decimal string leverage; allowed range is 1 to 50.
  @BuiltValueField(wireName: r'leverage')
  String? get leverage;

  @BuiltValueField(wireName: r'margin_mode')
  MarginMode? get marginMode;
  // enum marginModeEnum {  isolated,  cross,  };

  UpdatePositionLeverageRequest._();

  factory UpdatePositionLeverageRequest(
          [void updates(UpdatePositionLeverageRequestBuilder b)]) =
      _$UpdatePositionLeverageRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(UpdatePositionLeverageRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<UpdatePositionLeverageRequest> get serializer =>
      _$UpdatePositionLeverageRequestSerializer();
}

class _$UpdatePositionLeverageRequestSerializer
    implements PrimitiveSerializer<UpdatePositionLeverageRequest> {
  @override
  final Iterable<Type> types = const [
    UpdatePositionLeverageRequest,
    _$UpdatePositionLeverageRequest
  ];

  @override
  final String wireName = r'UpdatePositionLeverageRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    UpdatePositionLeverageRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.leverage != null) {
      yield r'leverage';
      yield serializers.serialize(
        object.leverage,
        specifiedType: const FullType(String),
      );
    }
    if (object.marginMode != null) {
      yield r'margin_mode';
      yield serializers.serialize(
        object.marginMode,
        specifiedType: const FullType(MarginMode),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    UpdatePositionLeverageRequest object, {
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
    required UpdatePositionLeverageRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'leverage':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.leverage = valueDes;
          break;
        case r'margin_mode':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(MarginMode),
          ) as MarginMode?;
          if (valueDes == null) continue;
          result.marginMode = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  UpdatePositionLeverageRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = UpdatePositionLeverageRequestBuilder();
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

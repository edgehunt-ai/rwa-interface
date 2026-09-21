//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:rwa_api_client/src/model/bstocks_depth_status.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'bstocks_depth_side_state.g.dart';

/// BstocksDepthSideState
///
/// Properties:
/// * [status] 
/// * [reason] - 首个失败点终止该侧。quote_rejected 不推断具体库存事实，最小规模失败也不证明所有规模均失败。
@BuiltValue()
abstract class BstocksDepthSideState implements Built<BstocksDepthSideState, BstocksDepthSideStateBuilder> {
  @BuiltValueField(wireName: r'status')
  BstocksDepthStatus get status;
  // enum statusEnum {  complete,  partial,  unavailable,  };

  /// 首个失败点终止该侧。quote_rejected 不推断具体库存事实，最小规模失败也不证明所有规模均失败。
  @BuiltValueField(wireName: r'reason')
  BstocksDepthSideStateReasonEnum? get reason;
  // enum reasonEnum {  admission_input_limit,  quote_rejected,  quoter_unavailable,  sampling_timeout,  };

  BstocksDepthSideState._();

  factory BstocksDepthSideState([void updates(BstocksDepthSideStateBuilder b)]) = _$BstocksDepthSideState;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(BstocksDepthSideStateBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<BstocksDepthSideState> get serializer => _$BstocksDepthSideStateSerializer();
}

class _$BstocksDepthSideStateSerializer implements PrimitiveSerializer<BstocksDepthSideState> {
  @override
  final Iterable<Type> types = const [BstocksDepthSideState, _$BstocksDepthSideState];

  @override
  final String wireName = r'BstocksDepthSideState';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    BstocksDepthSideState object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'status';
    yield serializers.serialize(
      object.status,
      specifiedType: const FullType(BstocksDepthStatus),
    );
    yield r'reason';
    yield object.reason == null ? null : serializers.serialize(
      object.reason,
      specifiedType: const FullType.nullable(BstocksDepthSideStateReasonEnum),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    BstocksDepthSideState object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required BstocksDepthSideStateBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'status':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BstocksDepthStatus),
          ) as BstocksDepthStatus;
          result.status = valueDes;
          break;
        case r'reason':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(BstocksDepthSideStateReasonEnum),
          ) as BstocksDepthSideStateReasonEnum?;
          if (valueDes == null) continue;
          result.reason = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  BstocksDepthSideState deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = BstocksDepthSideStateBuilder();
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

class BstocksDepthSideStateReasonEnum extends EnumClass {

  /// 首个失败点终止该侧。quote_rejected 不推断具体库存事实，最小规模失败也不证明所有规模均失败。
  @BuiltValueEnumConst(wireName: r'admission_input_limit')
  static const BstocksDepthSideStateReasonEnum admissionInputLimit = _$bstocksDepthSideStateReasonEnum_admissionInputLimit;
  /// 首个失败点终止该侧。quote_rejected 不推断具体库存事实，最小规模失败也不证明所有规模均失败。
  @BuiltValueEnumConst(wireName: r'quote_rejected')
  static const BstocksDepthSideStateReasonEnum quoteRejected = _$bstocksDepthSideStateReasonEnum_quoteRejected;
  /// 首个失败点终止该侧。quote_rejected 不推断具体库存事实，最小规模失败也不证明所有规模均失败。
  @BuiltValueEnumConst(wireName: r'quoter_unavailable')
  static const BstocksDepthSideStateReasonEnum quoterUnavailable = _$bstocksDepthSideStateReasonEnum_quoterUnavailable;
  /// 首个失败点终止该侧。quote_rejected 不推断具体库存事实，最小规模失败也不证明所有规模均失败。
  @BuiltValueEnumConst(wireName: r'sampling_timeout')
  static const BstocksDepthSideStateReasonEnum samplingTimeout = _$bstocksDepthSideStateReasonEnum_samplingTimeout;
  /// 首个失败点终止该侧。quote_rejected 不推断具体库存事实，最小规模失败也不证明所有规模均失败。
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const BstocksDepthSideStateReasonEnum unknownDefaultOpenApi = _$bstocksDepthSideStateReasonEnum_unknownDefaultOpenApi;

  static Serializer<BstocksDepthSideStateReasonEnum> get serializer => _$bstocksDepthSideStateReasonEnumSerializer;

  const BstocksDepthSideStateReasonEnum._(String name): super(name);

  static BuiltSet<BstocksDepthSideStateReasonEnum> get values => _$bstocksDepthSideStateReasonEnumValues;
  static BstocksDepthSideStateReasonEnum valueOf(String name) => _$bstocksDepthSideStateReasonEnumValueOf(name);
}


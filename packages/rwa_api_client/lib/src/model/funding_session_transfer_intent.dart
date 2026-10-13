//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'funding_session_transfer_intent.g.dart';

/// Account-scoped top-up intent. `destination` names the internal account receiving funds; `amount` is the exact quantity of the destination settlement asset to add. HIP3补资amount须为正且精确到目标8位小数；末尾零等价可接受，不通过舍入修正超精度输入。 
///
/// Properties:
/// * [destination] - Internal destination account. `hip3_margin` tops up HIP-3 perpetual margin.
/// * [amount] - 十进制字符串，避免浮点误差。请求最多60位整数和18位小数，不接受整数部分多余前导零； 各操作另行校验正负、范围及资产精度，不以此通用响应标量代替业务准入。 
@BuiltValue()
abstract class FundingSessionTransferIntent implements Built<FundingSessionTransferIntent, FundingSessionTransferIntentBuilder> {
  /// Internal destination account. `hip3_margin` tops up HIP-3 perpetual margin.
  @BuiltValueField(wireName: r'destination')
  FundingSessionTransferIntentDestinationEnum get destination;
  // enum destinationEnum {  hip3_margin,  };

  /// 十进制字符串，避免浮点误差。请求最多60位整数和18位小数，不接受整数部分多余前导零； 各操作另行校验正负、范围及资产精度，不以此通用响应标量代替业务准入。 
  @BuiltValueField(wireName: r'amount')
  String get amount;

  FundingSessionTransferIntent._();

  factory FundingSessionTransferIntent([void updates(FundingSessionTransferIntentBuilder b)]) = _$FundingSessionTransferIntent;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(FundingSessionTransferIntentBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<FundingSessionTransferIntent> get serializer => _$FundingSessionTransferIntentSerializer();
}

class _$FundingSessionTransferIntentSerializer implements PrimitiveSerializer<FundingSessionTransferIntent> {
  @override
  final Iterable<Type> types = const [FundingSessionTransferIntent, _$FundingSessionTransferIntent];

  @override
  final String wireName = r'FundingSessionTransferIntent';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    FundingSessionTransferIntent object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'destination';
    yield serializers.serialize(
      object.destination,
      specifiedType: const FullType(FundingSessionTransferIntentDestinationEnum),
    );
    yield r'amount';
    yield serializers.serialize(
      object.amount,
      specifiedType: const FullType(String),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    FundingSessionTransferIntent object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required FundingSessionTransferIntentBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'destination':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(FundingSessionTransferIntentDestinationEnum),
          ) as FundingSessionTransferIntentDestinationEnum;
          result.destination = valueDes;
          break;
        case r'amount':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.amount = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  FundingSessionTransferIntent deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = FundingSessionTransferIntentBuilder();
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

class FundingSessionTransferIntentDestinationEnum extends EnumClass {

  /// Internal destination account. `hip3_margin` tops up HIP-3 perpetual margin.
  @BuiltValueEnumConst(wireName: r'hip3_margin')
  static const FundingSessionTransferIntentDestinationEnum hip3Margin = _$fundingSessionTransferIntentDestinationEnum_hip3Margin;

  static Serializer<FundingSessionTransferIntentDestinationEnum> get serializer => _$fundingSessionTransferIntentDestinationEnumSerializer;

  const FundingSessionTransferIntentDestinationEnum._(String name): super(name);

  static BuiltSet<FundingSessionTransferIntentDestinationEnum> get values => _$fundingSessionTransferIntentDestinationEnumValues;
  static FundingSessionTransferIntentDestinationEnum valueOf(String name) => _$fundingSessionTransferIntentDestinationEnumValueOf(name);
}


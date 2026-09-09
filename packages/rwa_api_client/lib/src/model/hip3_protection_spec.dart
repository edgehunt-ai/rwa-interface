//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:rwa_api_client/src/model/hip3_trigger_spec.dart';
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'hip3_protection_spec.g.dart';

/// 至少一个 take_profit/stop_loss。size_mode=quantity 需 quantity 且禁止 percent； percent 需 (0,100] 的 percent 且禁止 quantity；entire_position 禁止两者。 比例按准备时仓位绝对数量计算并冻结，entire_position 使用 Provider 支持的全仓 reduce-only 语义；所有子订单只减仓。两 leg 均存在时为同组保护，后端对成交、 部分成交和仓位变化持续对账，缩减或取消另一 leg，不能把本地创建当成保护已生效。 
///
/// Properties:
/// * [sizeMode] 
/// * [quantity] - 十进制字符串，避免浮点误差
/// * [percent] - 十进制字符串，避免浮点误差
/// * [takeProfit] 
/// * [stopLoss] 
@BuiltValue()
abstract class Hip3ProtectionSpec implements Built<Hip3ProtectionSpec, Hip3ProtectionSpecBuilder> {
  @BuiltValueField(wireName: r'size_mode')
  Hip3ProtectionSpecSizeModeEnum get sizeMode;
  // enum sizeModeEnum {  entire_position,  quantity,  percent,  };

  /// 十进制字符串，避免浮点误差
  @BuiltValueField(wireName: r'quantity')
  String? get quantity;

  /// 十进制字符串，避免浮点误差
  @BuiltValueField(wireName: r'percent')
  String? get percent;

  @BuiltValueField(wireName: r'take_profit')
  Hip3TriggerSpec? get takeProfit;

  @BuiltValueField(wireName: r'stop_loss')
  Hip3TriggerSpec? get stopLoss;

  Hip3ProtectionSpec._();

  factory Hip3ProtectionSpec([void updates(Hip3ProtectionSpecBuilder b)]) = _$Hip3ProtectionSpec;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(Hip3ProtectionSpecBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<Hip3ProtectionSpec> get serializer => _$Hip3ProtectionSpecSerializer();
}

class _$Hip3ProtectionSpecSerializer implements PrimitiveSerializer<Hip3ProtectionSpec> {
  @override
  final Iterable<Type> types = const [Hip3ProtectionSpec, _$Hip3ProtectionSpec];

  @override
  final String wireName = r'Hip3ProtectionSpec';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    Hip3ProtectionSpec object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'size_mode';
    yield serializers.serialize(
      object.sizeMode,
      specifiedType: const FullType(Hip3ProtectionSpecSizeModeEnum),
    );
    if (object.quantity != null) {
      yield r'quantity';
      yield serializers.serialize(
        object.quantity,
        specifiedType: const FullType(String),
      );
    }
    if (object.percent != null) {
      yield r'percent';
      yield serializers.serialize(
        object.percent,
        specifiedType: const FullType(String),
      );
    }
    if (object.takeProfit != null) {
      yield r'take_profit';
      yield serializers.serialize(
        object.takeProfit,
        specifiedType: const FullType(Hip3TriggerSpec),
      );
    }
    if (object.stopLoss != null) {
      yield r'stop_loss';
      yield serializers.serialize(
        object.stopLoss,
        specifiedType: const FullType(Hip3TriggerSpec),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    Hip3ProtectionSpec object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required Hip3ProtectionSpecBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'size_mode':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(Hip3ProtectionSpecSizeModeEnum),
          ) as Hip3ProtectionSpecSizeModeEnum;
          result.sizeMode = valueDes;
          break;
        case r'quantity':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.quantity = valueDes;
          break;
        case r'percent':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.percent = valueDes;
          break;
        case r'take_profit':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(Hip3TriggerSpec),
          ) as Hip3TriggerSpec?;
          if (valueDes == null) continue;
          result.takeProfit.replace(valueDes);
          break;
        case r'stop_loss':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(Hip3TriggerSpec),
          ) as Hip3TriggerSpec?;
          if (valueDes == null) continue;
          result.stopLoss.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  Hip3ProtectionSpec deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = Hip3ProtectionSpecBuilder();
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

class Hip3ProtectionSpecSizeModeEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'entire_position')
  static const Hip3ProtectionSpecSizeModeEnum entirePosition = _$hip3ProtectionSpecSizeModeEnum_entirePosition;
  @BuiltValueEnumConst(wireName: r'quantity')
  static const Hip3ProtectionSpecSizeModeEnum quantity = _$hip3ProtectionSpecSizeModeEnum_quantity;
  @BuiltValueEnumConst(wireName: r'percent')
  static const Hip3ProtectionSpecSizeModeEnum percent = _$hip3ProtectionSpecSizeModeEnum_percent;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const Hip3ProtectionSpecSizeModeEnum unknownDefaultOpenApi = _$hip3ProtectionSpecSizeModeEnum_unknownDefaultOpenApi;

  static Serializer<Hip3ProtectionSpecSizeModeEnum> get serializer => _$hip3ProtectionSpecSizeModeEnumSerializer;

  const Hip3ProtectionSpecSizeModeEnum._(String name): super(name);

  static BuiltSet<Hip3ProtectionSpecSizeModeEnum> get values => _$hip3ProtectionSpecSizeModeEnumValues;
  static Hip3ProtectionSpecSizeModeEnum valueOf(String name) => _$hip3ProtectionSpecSizeModeEnumValueOf(name);
}


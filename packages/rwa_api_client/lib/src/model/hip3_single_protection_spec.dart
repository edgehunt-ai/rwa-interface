//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:rwa_api_client/src/model/hip3_trigger_spec.dart';
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'hip3_single_protection_spec.g.dart';

/// 每次显式变更恰好一笔保护订单，数量和价格规范与Hip3ProtectionSpec一致。 quantity必须提供quantity且禁止percent；percent必须提供percent且禁止quantity；entire_position禁止两者。 修改必须提交完整新参数，不继承省略的价格、数量或执行类型。 
///
/// Properties:
/// * [sizeMode] 
/// * [quantity] - 十进制字符串，避免浮点误差。请求最多60位整数和18位小数，不接受整数部分多余前导零； 各操作另行校验正负、范围及资产精度，不以此通用响应标量代替业务准入。 
/// * [percent] - 十进制字符串，避免浮点误差。请求最多60位整数和18位小数，不接受整数部分多余前导零； 各操作另行校验正负、范围及资产精度，不以此通用响应标量代替业务准入。 
/// * [takeProfit] 
/// * [stopLoss] 
@BuiltValue()
abstract class Hip3SingleProtectionSpec implements Built<Hip3SingleProtectionSpec, Hip3SingleProtectionSpecBuilder> {
  @BuiltValueField(wireName: r'size_mode')
  Hip3SingleProtectionSpecSizeModeEnum get sizeMode;
  // enum sizeModeEnum {  entire_position,  quantity,  percent,  };

  /// 十进制字符串，避免浮点误差。请求最多60位整数和18位小数，不接受整数部分多余前导零； 各操作另行校验正负、范围及资产精度，不以此通用响应标量代替业务准入。 
  @BuiltValueField(wireName: r'quantity')
  String? get quantity;

  /// 十进制字符串，避免浮点误差。请求最多60位整数和18位小数，不接受整数部分多余前导零； 各操作另行校验正负、范围及资产精度，不以此通用响应标量代替业务准入。 
  @BuiltValueField(wireName: r'percent')
  String? get percent;

  @BuiltValueField(wireName: r'take_profit')
  Hip3TriggerSpec? get takeProfit;

  @BuiltValueField(wireName: r'stop_loss')
  Hip3TriggerSpec? get stopLoss;

  Hip3SingleProtectionSpec._();

  factory Hip3SingleProtectionSpec([void updates(Hip3SingleProtectionSpecBuilder b)]) = _$Hip3SingleProtectionSpec;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(Hip3SingleProtectionSpecBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<Hip3SingleProtectionSpec> get serializer => _$Hip3SingleProtectionSpecSerializer();
}

class _$Hip3SingleProtectionSpecSerializer implements PrimitiveSerializer<Hip3SingleProtectionSpec> {
  @override
  final Iterable<Type> types = const [Hip3SingleProtectionSpec, _$Hip3SingleProtectionSpec];

  @override
  final String wireName = r'Hip3SingleProtectionSpec';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    Hip3SingleProtectionSpec object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'size_mode';
    yield serializers.serialize(
      object.sizeMode,
      specifiedType: const FullType(Hip3SingleProtectionSpecSizeModeEnum),
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
    Hip3SingleProtectionSpec object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required Hip3SingleProtectionSpecBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'size_mode':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(Hip3SingleProtectionSpecSizeModeEnum),
          ) as Hip3SingleProtectionSpecSizeModeEnum;
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
  Hip3SingleProtectionSpec deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = Hip3SingleProtectionSpecBuilder();
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

class Hip3SingleProtectionSpecSizeModeEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'entire_position')
  static const Hip3SingleProtectionSpecSizeModeEnum entirePosition = _$hip3SingleProtectionSpecSizeModeEnum_entirePosition;
  @BuiltValueEnumConst(wireName: r'quantity')
  static const Hip3SingleProtectionSpecSizeModeEnum quantity = _$hip3SingleProtectionSpecSizeModeEnum_quantity;
  @BuiltValueEnumConst(wireName: r'percent')
  static const Hip3SingleProtectionSpecSizeModeEnum percent = _$hip3SingleProtectionSpecSizeModeEnum_percent;

  static Serializer<Hip3SingleProtectionSpecSizeModeEnum> get serializer => _$hip3SingleProtectionSpecSizeModeEnumSerializer;

  const Hip3SingleProtectionSpecSizeModeEnum._(String name): super(name);

  static BuiltSet<Hip3SingleProtectionSpecSizeModeEnum> get values => _$hip3SingleProtectionSpecSizeModeEnumValues;
  static Hip3SingleProtectionSpecSizeModeEnum valueOf(String name) => _$hip3SingleProtectionSpecSizeModeEnumValueOf(name);
}


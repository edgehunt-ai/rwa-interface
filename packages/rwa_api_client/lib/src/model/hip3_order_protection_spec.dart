//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:rwa_api_client/src/model/hip3_trigger_spec.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'hip3_order_protection_spec.g.dart';

/// 本单止盈止损：至少传一个 take_profit/stop_loss，使用 Hyperliquid 原生 normalTpsl 父子单。 保护数量固定等于本次开仓订单的规范化数量，不随持仓变化调整，不接受 size_mode、quantity 或 percent。 父单与保护子单在同一个 action 中由前端签名、后端广播，不要求未来成交后补签。 已提交附带保护不等于已生效；子单待激活时必须显示待激活，只有 Provider 确认激活后才能显示生效。 激活、部分成交和撤销以 Provider 父子单实际状态为准，不得仅凭父单部分成交推定子单已生效。 部分成交后主动取消父单会取消子保护；必须提示剩余持仓的实际保护状态，不自动补保护。 生效后的触发执行不需要再次签名；用户后续修改或主动撤销仍需要签名，不使用后端私钥或 agent 代签。 
///
/// Properties:
/// * [takeProfit] 
/// * [stopLoss] 
@BuiltValue()
abstract class Hip3OrderProtectionSpec implements Built<Hip3OrderProtectionSpec, Hip3OrderProtectionSpecBuilder> {
  @BuiltValueField(wireName: r'take_profit')
  Hip3TriggerSpec? get takeProfit;

  @BuiltValueField(wireName: r'stop_loss')
  Hip3TriggerSpec? get stopLoss;

  Hip3OrderProtectionSpec._();

  factory Hip3OrderProtectionSpec([void updates(Hip3OrderProtectionSpecBuilder b)]) = _$Hip3OrderProtectionSpec;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(Hip3OrderProtectionSpecBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<Hip3OrderProtectionSpec> get serializer => _$Hip3OrderProtectionSpecSerializer();
}

class _$Hip3OrderProtectionSpecSerializer implements PrimitiveSerializer<Hip3OrderProtectionSpec> {
  @override
  final Iterable<Type> types = const [Hip3OrderProtectionSpec, _$Hip3OrderProtectionSpec];

  @override
  final String wireName = r'Hip3OrderProtectionSpec';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    Hip3OrderProtectionSpec object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
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
    Hip3OrderProtectionSpec object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required Hip3OrderProtectionSpecBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
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
  Hip3OrderProtectionSpec deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = Hip3OrderProtectionSpecBuilder();
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


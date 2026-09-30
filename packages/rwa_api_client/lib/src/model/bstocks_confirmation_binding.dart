//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'bstocks_confirmation_binding.g.dart';

/// BstocksConfirmationBinding
///
/// Properties:
/// * [status] 
/// * [expiresAt] 
/// * [deadlineKind] 
/// * [maximumInputRaw] - 原始最小单位的无符号十进制整数字符串；不允许指数、小数或负号。
/// * [minimumOutputRaw] - IOC 预览同意的最低输出边界（原始单位，向下取整），GTC 为 null。 与 estimated_receive 区分：这是旧预览对后续新报价的下限，不表示原样编码成链上 minAmountOut。 当前新路由必须不突破该下限，交易编码却使用新路由自身的报价输出作为更严格的下限。 
/// * [approvalRequiresNewPreview] - true 表示该预览要求授权后重新预览（兼容旧服务/已保存快照）。 false 表示授权 action 确认后，可用同一 preview_id 和新的创建幂等键生成一次交易 action。 复用不延长服务端或报价区块有效期，不放宽最大支付/最低收到、账户/钱包/订单/准入绑定。 交易前仍重新核验余额和 allowance 并取得满足原边界的新报价；过期或条件改变须重新预览。 
@BuiltValue()
abstract class BstocksConfirmationBinding implements Built<BstocksConfirmationBinding, BstocksConfirmationBindingBuilder> {
  @BuiltValueField(wireName: r'status')
  BstocksConfirmationBindingStatusEnum get status;
  // enum statusEnum {  frozen,  };

  @BuiltValueField(wireName: r'expires_at')
  DateTime get expiresAt;

  @BuiltValueField(wireName: r'deadline_kind')
  BstocksConfirmationBindingDeadlineKindEnum get deadlineKind;
  // enum deadlineKindEnum {  server_preview_deadline,  };

  /// 原始最小单位的无符号十进制整数字符串；不允许指数、小数或负号。
  @BuiltValueField(wireName: r'maximum_input_raw')
  String get maximumInputRaw;

  /// IOC 预览同意的最低输出边界（原始单位，向下取整），GTC 为 null。 与 estimated_receive 区分：这是旧预览对后续新报价的下限，不表示原样编码成链上 minAmountOut。 当前新路由必须不突破该下限，交易编码却使用新路由自身的报价输出作为更严格的下限。 
  @BuiltValueField(wireName: r'minimum_output_raw')
  String? get minimumOutputRaw;

  /// true 表示该预览要求授权后重新预览（兼容旧服务/已保存快照）。 false 表示授权 action 确认后，可用同一 preview_id 和新的创建幂等键生成一次交易 action。 复用不延长服务端或报价区块有效期，不放宽最大支付/最低收到、账户/钱包/订单/准入绑定。 交易前仍重新核验余额和 allowance 并取得满足原边界的新报价；过期或条件改变须重新预览。 
  @BuiltValueField(wireName: r'approval_requires_new_preview')
  bool get approvalRequiresNewPreview;

  BstocksConfirmationBinding._();

  factory BstocksConfirmationBinding([void updates(BstocksConfirmationBindingBuilder b)]) = _$BstocksConfirmationBinding;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(BstocksConfirmationBindingBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<BstocksConfirmationBinding> get serializer => _$BstocksConfirmationBindingSerializer();
}

class _$BstocksConfirmationBindingSerializer implements PrimitiveSerializer<BstocksConfirmationBinding> {
  @override
  final Iterable<Type> types = const [BstocksConfirmationBinding, _$BstocksConfirmationBinding];

  @override
  final String wireName = r'BstocksConfirmationBinding';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    BstocksConfirmationBinding object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'status';
    yield serializers.serialize(
      object.status,
      specifiedType: const FullType(BstocksConfirmationBindingStatusEnum),
    );
    yield r'expires_at';
    yield serializers.serialize(
      object.expiresAt,
      specifiedType: const FullType(DateTime),
    );
    yield r'deadline_kind';
    yield serializers.serialize(
      object.deadlineKind,
      specifiedType: const FullType(BstocksConfirmationBindingDeadlineKindEnum),
    );
    yield r'maximum_input_raw';
    yield serializers.serialize(
      object.maximumInputRaw,
      specifiedType: const FullType(String),
    );
    yield r'minimum_output_raw';
    yield object.minimumOutputRaw == null ? null : serializers.serialize(
      object.minimumOutputRaw,
      specifiedType: const FullType.nullable(String),
    );
    yield r'approval_requires_new_preview';
    yield serializers.serialize(
      object.approvalRequiresNewPreview,
      specifiedType: const FullType(bool),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    BstocksConfirmationBinding object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required BstocksConfirmationBindingBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'status':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BstocksConfirmationBindingStatusEnum),
          ) as BstocksConfirmationBindingStatusEnum;
          result.status = valueDes;
          break;
        case r'expires_at':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DateTime),
          ) as DateTime;
          result.expiresAt = valueDes;
          break;
        case r'deadline_kind':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BstocksConfirmationBindingDeadlineKindEnum),
          ) as BstocksConfirmationBindingDeadlineKindEnum;
          result.deadlineKind = valueDes;
          break;
        case r'maximum_input_raw':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.maximumInputRaw = valueDes;
          break;
        case r'minimum_output_raw':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.minimumOutputRaw = valueDes;
          break;
        case r'approval_requires_new_preview':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.approvalRequiresNewPreview = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  BstocksConfirmationBinding deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = BstocksConfirmationBindingBuilder();
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

class BstocksConfirmationBindingStatusEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'frozen')
  static const BstocksConfirmationBindingStatusEnum frozen = _$bstocksConfirmationBindingStatusEnum_frozen;

  static Serializer<BstocksConfirmationBindingStatusEnum> get serializer => _$bstocksConfirmationBindingStatusEnumSerializer;

  const BstocksConfirmationBindingStatusEnum._(String name): super(name);

  static BuiltSet<BstocksConfirmationBindingStatusEnum> get values => _$bstocksConfirmationBindingStatusEnumValues;
  static BstocksConfirmationBindingStatusEnum valueOf(String name) => _$bstocksConfirmationBindingStatusEnumValueOf(name);
}

class BstocksConfirmationBindingDeadlineKindEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'server_preview_deadline')
  static const BstocksConfirmationBindingDeadlineKindEnum serverPreviewDeadline = _$bstocksConfirmationBindingDeadlineKindEnum_serverPreviewDeadline;

  static Serializer<BstocksConfirmationBindingDeadlineKindEnum> get serializer => _$bstocksConfirmationBindingDeadlineKindEnumSerializer;

  const BstocksConfirmationBindingDeadlineKindEnum._(String name): super(name);

  static BuiltSet<BstocksConfirmationBindingDeadlineKindEnum> get values => _$bstocksConfirmationBindingDeadlineKindEnumValues;
  static BstocksConfirmationBindingDeadlineKindEnum valueOf(String name) => _$bstocksConfirmationBindingDeadlineKindEnumValueOf(name);
}


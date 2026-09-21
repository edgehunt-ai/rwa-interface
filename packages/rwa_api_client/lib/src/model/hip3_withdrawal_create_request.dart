//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'hip3_withdrawal_create_request.g.dart';

/// 创建 HIP-3 提现只需金额；目标地址固定为账户自己的 unified EVM 地址，请求不接受 `destination`、`signature`、`nonce` 或任意 venue action 字段。 
///
/// Properties:
/// * [amount] - 十进制字符串，避免浮点误差
/// * [rail] - 出金通道选择；缺省或 `auto` 时平台池已配置走 `float`、否则回落 `bridge2`。 显式请求 `float` 而平台池未配置时返回错误，不会静默降级。 
@BuiltValue()
abstract class Hip3WithdrawalCreateRequest implements Built<Hip3WithdrawalCreateRequest, Hip3WithdrawalCreateRequestBuilder> {
  /// 十进制字符串，避免浮点误差
  @BuiltValueField(wireName: r'amount')
  String get amount;

  /// 出金通道选择；缺省或 `auto` 时平台池已配置走 `float`、否则回落 `bridge2`。 显式请求 `float` 而平台池未配置时返回错误，不会静默降级。 
  @BuiltValueField(wireName: r'rail')
  Hip3WithdrawalCreateRequestRailEnum? get rail;
  // enum railEnum {  auto,  bridge2,  float,  };

  Hip3WithdrawalCreateRequest._();

  factory Hip3WithdrawalCreateRequest([void updates(Hip3WithdrawalCreateRequestBuilder b)]) = _$Hip3WithdrawalCreateRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(Hip3WithdrawalCreateRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<Hip3WithdrawalCreateRequest> get serializer => _$Hip3WithdrawalCreateRequestSerializer();
}

class _$Hip3WithdrawalCreateRequestSerializer implements PrimitiveSerializer<Hip3WithdrawalCreateRequest> {
  @override
  final Iterable<Type> types = const [Hip3WithdrawalCreateRequest, _$Hip3WithdrawalCreateRequest];

  @override
  final String wireName = r'Hip3WithdrawalCreateRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    Hip3WithdrawalCreateRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'amount';
    yield serializers.serialize(
      object.amount,
      specifiedType: const FullType(String),
    );
    if (object.rail != null) {
      yield r'rail';
      yield serializers.serialize(
        object.rail,
        specifiedType: const FullType(Hip3WithdrawalCreateRequestRailEnum),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    Hip3WithdrawalCreateRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required Hip3WithdrawalCreateRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'amount':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.amount = valueDes;
          break;
        case r'rail':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(Hip3WithdrawalCreateRequestRailEnum),
          ) as Hip3WithdrawalCreateRequestRailEnum?;
          if (valueDes == null) continue;
          result.rail = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  Hip3WithdrawalCreateRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = Hip3WithdrawalCreateRequestBuilder();
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

class Hip3WithdrawalCreateRequestRailEnum extends EnumClass {

  /// 出金通道选择；缺省或 `auto` 时平台池已配置走 `float`、否则回落 `bridge2`。 显式请求 `float` 而平台池未配置时返回错误，不会静默降级。 
  @BuiltValueEnumConst(wireName: r'auto')
  static const Hip3WithdrawalCreateRequestRailEnum auto = _$hip3WithdrawalCreateRequestRailEnum_auto;
  /// 出金通道选择；缺省或 `auto` 时平台池已配置走 `float`、否则回落 `bridge2`。 显式请求 `float` 而平台池未配置时返回错误，不会静默降级。 
  @BuiltValueEnumConst(wireName: r'bridge2')
  static const Hip3WithdrawalCreateRequestRailEnum bridge2 = _$hip3WithdrawalCreateRequestRailEnum_bridge2;
  /// 出金通道选择；缺省或 `auto` 时平台池已配置走 `float`、否则回落 `bridge2`。 显式请求 `float` 而平台池未配置时返回错误，不会静默降级。 
  @BuiltValueEnumConst(wireName: r'float')
  static const Hip3WithdrawalCreateRequestRailEnum float = _$hip3WithdrawalCreateRequestRailEnum_float;
  /// 出金通道选择；缺省或 `auto` 时平台池已配置走 `float`、否则回落 `bridge2`。 显式请求 `float` 而平台池未配置时返回错误，不会静默降级。 
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const Hip3WithdrawalCreateRequestRailEnum unknownDefaultOpenApi = _$hip3WithdrawalCreateRequestRailEnum_unknownDefaultOpenApi;

  static Serializer<Hip3WithdrawalCreateRequestRailEnum> get serializer => _$hip3WithdrawalCreateRequestRailEnumSerializer;

  const Hip3WithdrawalCreateRequestRailEnum._(String name): super(name);

  static BuiltSet<Hip3WithdrawalCreateRequestRailEnum> get values => _$hip3WithdrawalCreateRequestRailEnumValues;
  static Hip3WithdrawalCreateRequestRailEnum valueOf(String name) => _$hip3WithdrawalCreateRequestRailEnumValueOf(name);
}


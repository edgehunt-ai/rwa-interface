//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'user_settings.g.dart';

/// 需要跨设备保留的用户偏好。随 `GET /v1/me` 返回，用 `PATCH /v1/me/settings` 更新。
///
/// Properties:
/// * [language] - 界面语言。服务端也用它决定推送通知的语言 —— 推送由后端发起， 拿不到请求头里的 `Accept-Language`，所以这个偏好必须存在服务端。 
/// * [pushEnabled] - 推送总开关。关闭后后端不再向该用户的任何设备推送， 下面三个分类开关的取值被忽略（但保留，重新打开总开关后恢复原样）。 
/// * [notifyOrderFilled] - 订单成交。市价成交、限价单被撮合、止盈止损触发都归这一类。
/// * [notifyOrderFailed] - 订单失败。下单被拒、超出滑点、资金准备失败等。
/// * [notifyLiquidationWarning] - 强平预警。仅对 HIP-3 合约仓位有效，现货持仓不会触发。 触发阈值由平台统一设定，暂不支持用户自定义。 
@BuiltValue()
abstract class UserSettings implements Built<UserSettings, UserSettingsBuilder> {
  /// 界面语言。服务端也用它决定推送通知的语言 —— 推送由后端发起， 拿不到请求头里的 `Accept-Language`，所以这个偏好必须存在服务端。 
  @BuiltValueField(wireName: r'language')
  UserSettingsLanguageEnum get language;
  // enum languageEnum {  zh-CN,  en,  };

  /// 推送总开关。关闭后后端不再向该用户的任何设备推送， 下面三个分类开关的取值被忽略（但保留，重新打开总开关后恢复原样）。 
  @BuiltValueField(wireName: r'push_enabled')
  bool get pushEnabled;

  /// 订单成交。市价成交、限价单被撮合、止盈止损触发都归这一类。
  @BuiltValueField(wireName: r'notify_order_filled')
  bool get notifyOrderFilled;

  /// 订单失败。下单被拒、超出滑点、资金准备失败等。
  @BuiltValueField(wireName: r'notify_order_failed')
  bool get notifyOrderFailed;

  /// 强平预警。仅对 HIP-3 合约仓位有效，现货持仓不会触发。 触发阈值由平台统一设定，暂不支持用户自定义。 
  @BuiltValueField(wireName: r'notify_liquidation_warning')
  bool get notifyLiquidationWarning;

  UserSettings._();

  factory UserSettings([void updates(UserSettingsBuilder b)]) = _$UserSettings;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(UserSettingsBuilder b) => b
      ..language = UserSettingsLanguageEnum.valueOf('zh-CN')
      ..pushEnabled = true
      ..notifyOrderFilled = true
      ..notifyOrderFailed = true
      ..notifyLiquidationWarning = true;

  @BuiltValueSerializer(custom: true)
  static Serializer<UserSettings> get serializer => _$UserSettingsSerializer();
}

class _$UserSettingsSerializer implements PrimitiveSerializer<UserSettings> {
  @override
  final Iterable<Type> types = const [UserSettings, _$UserSettings];

  @override
  final String wireName = r'UserSettings';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    UserSettings object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'language';
    yield serializers.serialize(
      object.language,
      specifiedType: const FullType(UserSettingsLanguageEnum),
    );
    yield r'push_enabled';
    yield serializers.serialize(
      object.pushEnabled,
      specifiedType: const FullType(bool),
    );
    yield r'notify_order_filled';
    yield serializers.serialize(
      object.notifyOrderFilled,
      specifiedType: const FullType(bool),
    );
    yield r'notify_order_failed';
    yield serializers.serialize(
      object.notifyOrderFailed,
      specifiedType: const FullType(bool),
    );
    yield r'notify_liquidation_warning';
    yield serializers.serialize(
      object.notifyLiquidationWarning,
      specifiedType: const FullType(bool),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    UserSettings object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required UserSettingsBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'language':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(UserSettingsLanguageEnum),
          ) as UserSettingsLanguageEnum;
          result.language = valueDes;
          break;
        case r'push_enabled':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.pushEnabled = valueDes;
          break;
        case r'notify_order_filled':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.notifyOrderFilled = valueDes;
          break;
        case r'notify_order_failed':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.notifyOrderFailed = valueDes;
          break;
        case r'notify_liquidation_warning':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.notifyLiquidationWarning = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  UserSettings deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = UserSettingsBuilder();
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

class UserSettingsLanguageEnum extends EnumClass {

  /// 界面语言。服务端也用它决定推送通知的语言 —— 推送由后端发起， 拿不到请求头里的 `Accept-Language`，所以这个偏好必须存在服务端。 
  @BuiltValueEnumConst(wireName: r'zh-CN')
  static const UserSettingsLanguageEnum zhCN = _$userSettingsLanguageEnum_zhCN;
  /// 界面语言。服务端也用它决定推送通知的语言 —— 推送由后端发起， 拿不到请求头里的 `Accept-Language`，所以这个偏好必须存在服务端。 
  @BuiltValueEnumConst(wireName: r'en')
  static const UserSettingsLanguageEnum en = _$userSettingsLanguageEnum_en;
  /// 界面语言。服务端也用它决定推送通知的语言 —— 推送由后端发起， 拿不到请求头里的 `Accept-Language`，所以这个偏好必须存在服务端。 
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const UserSettingsLanguageEnum unknownDefaultOpenApi = _$userSettingsLanguageEnum_unknownDefaultOpenApi;

  static Serializer<UserSettingsLanguageEnum> get serializer => _$userSettingsLanguageEnumSerializer;

  const UserSettingsLanguageEnum._(String name): super(name);

  static BuiltSet<UserSettingsLanguageEnum> get values => _$userSettingsLanguageEnumValues;
  static UserSettingsLanguageEnum valueOf(String name) => _$userSettingsLanguageEnumValueOf(name);
}


//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:rwa_api_client/src/model/user_language.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'user_settings.g.dart';

/// 需要跨设备保留的用户偏好。随 `GET /v1/me` 返回，用 `PATCH /v1/me/settings` 更新。
///
/// Properties:
/// * [language] 
/// * [pushEnabled] - 推送总开关。关闭后后端不再向该用户的任何设备推送， 下面三个分类开关的取值被忽略（但保留，重新打开总开关后恢复原样）。 
/// * [notifyOrderFilled] - 订单成交。市价成交、限价单被撮合、止盈止损触发都归这一类。
/// * [notifyOrderFailed] - 订单失败。下单被拒、超出滑点、资金准备失败等。
/// * [notifyLiquidationWarning] - 强平预警。仅对 HIP-3 合约仓位有效，现货持仓不会触发。 触发阈值由平台统一设定，暂不支持用户自定义。 
@BuiltValue()
abstract class UserSettings implements Built<UserSettings, UserSettingsBuilder> {
  @BuiltValueField(wireName: r'language')
  UserLanguage get language;
  // enum languageEnum {  zh-CN,  en,  ja,  ko,  };

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
      specifiedType: const FullType(UserLanguage),
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
            specifiedType: const FullType(UserLanguage),
          ) as UserLanguage;
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


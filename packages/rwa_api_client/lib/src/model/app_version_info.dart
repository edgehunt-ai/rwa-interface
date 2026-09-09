//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'app_version_info.g.dart';

/// AppVersionInfo
///
/// Properties:
/// * [platform] - 客户端平台。当前为 `ios` / `android`，**后续可能新增**（如 `harmony`、`web`）。  这里刻意用开放字符串而不是枚举：服务端新增平台时，老客户端反序列化 不会因为遇到未知枚举值而崩溃。客户端只需认得自己那个值。
/// * [latestVersion] - 当前已发布的最新版本
/// * [minSupportedVersion] - 仍被支持的最低版本。客户端版本低于此值时必须强制升级， 不允许继续使用（用于服务端接口不兼容变更后的兜底）。
/// * [releaseNotes]
/// * [storeUrl] - App Store / 应用市场地址
/// * [publishedAt]
/// * [updatedAt]
@BuiltValue()
abstract class AppVersionInfo
    implements Built<AppVersionInfo, AppVersionInfoBuilder> {
  /// 客户端平台。当前为 `ios` / `android`，**后续可能新增**（如 `harmony`、`web`）。  这里刻意用开放字符串而不是枚举：服务端新增平台时，老客户端反序列化 不会因为遇到未知枚举值而崩溃。客户端只需认得自己那个值。
  @BuiltValueField(wireName: r'platform')
  String get platform;

  /// 当前已发布的最新版本
  @BuiltValueField(wireName: r'latest_version')
  String get latestVersion;

  /// 仍被支持的最低版本。客户端版本低于此值时必须强制升级， 不允许继续使用（用于服务端接口不兼容变更后的兜底）。
  @BuiltValueField(wireName: r'min_supported_version')
  String get minSupportedVersion;

  @BuiltValueField(wireName: r'release_notes')
  String? get releaseNotes;

  /// App Store / 应用市场地址
  @BuiltValueField(wireName: r'store_url')
  String? get storeUrl;

  @BuiltValueField(wireName: r'published_at')
  DateTime? get publishedAt;

  @BuiltValueField(wireName: r'updated_at')
  DateTime? get updatedAt;

  AppVersionInfo._();

  factory AppVersionInfo([void updates(AppVersionInfoBuilder b)]) =
      _$AppVersionInfo;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(AppVersionInfoBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<AppVersionInfo> get serializer =>
      _$AppVersionInfoSerializer();
}

class _$AppVersionInfoSerializer
    implements PrimitiveSerializer<AppVersionInfo> {
  @override
  final Iterable<Type> types = const [AppVersionInfo, _$AppVersionInfo];

  @override
  final String wireName = r'AppVersionInfo';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    AppVersionInfo object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'platform';
    yield serializers.serialize(
      object.platform,
      specifiedType: const FullType(String),
    );
    yield r'latest_version';
    yield serializers.serialize(
      object.latestVersion,
      specifiedType: const FullType(String),
    );
    yield r'min_supported_version';
    yield serializers.serialize(
      object.minSupportedVersion,
      specifiedType: const FullType(String),
    );
    if (object.releaseNotes != null) {
      yield r'release_notes';
      yield serializers.serialize(
        object.releaseNotes,
        specifiedType: const FullType.nullable(String),
      );
    }
    if (object.storeUrl != null) {
      yield r'store_url';
      yield serializers.serialize(
        object.storeUrl,
        specifiedType: const FullType.nullable(String),
      );
    }
    if (object.publishedAt != null) {
      yield r'published_at';
      yield serializers.serialize(
        object.publishedAt,
        specifiedType: const FullType.nullable(DateTime),
      );
    }
    if (object.updatedAt != null) {
      yield r'updated_at';
      yield serializers.serialize(
        object.updatedAt,
        specifiedType: const FullType(DateTime),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    AppVersionInfo object, {
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
    required AppVersionInfoBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'platform':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.platform = valueDes;
          break;
        case r'latest_version':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.latestVersion = valueDes;
          break;
        case r'min_supported_version':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.minSupportedVersion = valueDes;
          break;
        case r'release_notes':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.releaseNotes = valueDes;
          break;
        case r'store_url':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.storeUrl = valueDes;
          break;
        case r'published_at':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(DateTime),
          ) as DateTime?;
          if (valueDes == null) continue;
          result.publishedAt = valueDes;
          break;
        case r'updated_at':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(DateTime),
          ) as DateTime?;
          if (valueDes == null) continue;
          result.updatedAt = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  AppVersionInfo deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = AppVersionInfoBuilder();
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

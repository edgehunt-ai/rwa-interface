// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_settings_update.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const UserSettingsUpdateLanguageEnum _$userSettingsUpdateLanguageEnum_zhCN =
    const UserSettingsUpdateLanguageEnum._('zhCN');
const UserSettingsUpdateLanguageEnum _$userSettingsUpdateLanguageEnum_en =
    const UserSettingsUpdateLanguageEnum._('en');
const UserSettingsUpdateLanguageEnum
    _$userSettingsUpdateLanguageEnum_unknownDefaultOpenApi =
    const UserSettingsUpdateLanguageEnum._('unknownDefaultOpenApi');

UserSettingsUpdateLanguageEnum _$userSettingsUpdateLanguageEnumValueOf(
    String name) {
  switch (name) {
    case 'zhCN':
      return _$userSettingsUpdateLanguageEnum_zhCN;
    case 'en':
      return _$userSettingsUpdateLanguageEnum_en;
    case 'unknownDefaultOpenApi':
      return _$userSettingsUpdateLanguageEnum_unknownDefaultOpenApi;
    default:
      return _$userSettingsUpdateLanguageEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<UserSettingsUpdateLanguageEnum>
    _$userSettingsUpdateLanguageEnumValues = BuiltSet<
        UserSettingsUpdateLanguageEnum>(const <UserSettingsUpdateLanguageEnum>[
  _$userSettingsUpdateLanguageEnum_zhCN,
  _$userSettingsUpdateLanguageEnum_en,
  _$userSettingsUpdateLanguageEnum_unknownDefaultOpenApi,
]);

Serializer<UserSettingsUpdateLanguageEnum>
    _$userSettingsUpdateLanguageEnumSerializer =
    _$UserSettingsUpdateLanguageEnumSerializer();

class _$UserSettingsUpdateLanguageEnumSerializer
    implements PrimitiveSerializer<UserSettingsUpdateLanguageEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'zhCN': 'zh-CN',
    'en': 'en',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'zh-CN': 'zhCN',
    'en': 'en',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[UserSettingsUpdateLanguageEnum];
  @override
  final String wireName = 'UserSettingsUpdateLanguageEnum';

  @override
  Object serialize(
          Serializers serializers, UserSettingsUpdateLanguageEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  UserSettingsUpdateLanguageEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      UserSettingsUpdateLanguageEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$UserSettingsUpdate extends UserSettingsUpdate {
  @override
  final UserSettingsUpdateLanguageEnum? language;
  @override
  final bool? pushEnabled;
  @override
  final bool? notifyOrderFilled;
  @override
  final bool? notifyOrderFailed;
  @override
  final bool? notifyLiquidationWarning;

  factory _$UserSettingsUpdate(
          [void Function(UserSettingsUpdateBuilder)? updates]) =>
      (UserSettingsUpdateBuilder()..update(updates))._build();

  _$UserSettingsUpdate._(
      {this.language,
      this.pushEnabled,
      this.notifyOrderFilled,
      this.notifyOrderFailed,
      this.notifyLiquidationWarning})
      : super._();
  @override
  UserSettingsUpdate rebuild(
          void Function(UserSettingsUpdateBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  UserSettingsUpdateBuilder toBuilder() =>
      UserSettingsUpdateBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is UserSettingsUpdate &&
        language == other.language &&
        pushEnabled == other.pushEnabled &&
        notifyOrderFilled == other.notifyOrderFilled &&
        notifyOrderFailed == other.notifyOrderFailed &&
        notifyLiquidationWarning == other.notifyLiquidationWarning;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, language.hashCode);
    _$hash = $jc(_$hash, pushEnabled.hashCode);
    _$hash = $jc(_$hash, notifyOrderFilled.hashCode);
    _$hash = $jc(_$hash, notifyOrderFailed.hashCode);
    _$hash = $jc(_$hash, notifyLiquidationWarning.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'UserSettingsUpdate')
          ..add('language', language)
          ..add('pushEnabled', pushEnabled)
          ..add('notifyOrderFilled', notifyOrderFilled)
          ..add('notifyOrderFailed', notifyOrderFailed)
          ..add('notifyLiquidationWarning', notifyLiquidationWarning))
        .toString();
  }
}

class UserSettingsUpdateBuilder
    implements Builder<UserSettingsUpdate, UserSettingsUpdateBuilder> {
  _$UserSettingsUpdate? _$v;

  UserSettingsUpdateLanguageEnum? _language;
  UserSettingsUpdateLanguageEnum? get language => _$this._language;
  set language(UserSettingsUpdateLanguageEnum? language) =>
      _$this._language = language;

  bool? _pushEnabled;
  bool? get pushEnabled => _$this._pushEnabled;
  set pushEnabled(bool? pushEnabled) => _$this._pushEnabled = pushEnabled;

  bool? _notifyOrderFilled;
  bool? get notifyOrderFilled => _$this._notifyOrderFilled;
  set notifyOrderFilled(bool? notifyOrderFilled) =>
      _$this._notifyOrderFilled = notifyOrderFilled;

  bool? _notifyOrderFailed;
  bool? get notifyOrderFailed => _$this._notifyOrderFailed;
  set notifyOrderFailed(bool? notifyOrderFailed) =>
      _$this._notifyOrderFailed = notifyOrderFailed;

  bool? _notifyLiquidationWarning;
  bool? get notifyLiquidationWarning => _$this._notifyLiquidationWarning;
  set notifyLiquidationWarning(bool? notifyLiquidationWarning) =>
      _$this._notifyLiquidationWarning = notifyLiquidationWarning;

  UserSettingsUpdateBuilder() {
    UserSettingsUpdate._defaults(this);
  }

  UserSettingsUpdateBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _language = $v.language;
      _pushEnabled = $v.pushEnabled;
      _notifyOrderFilled = $v.notifyOrderFilled;
      _notifyOrderFailed = $v.notifyOrderFailed;
      _notifyLiquidationWarning = $v.notifyLiquidationWarning;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(UserSettingsUpdate other) {
    _$v = other as _$UserSettingsUpdate;
  }

  @override
  void update(void Function(UserSettingsUpdateBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  UserSettingsUpdate build() => _build();

  _$UserSettingsUpdate _build() {
    final _$result = _$v ??
        _$UserSettingsUpdate._(
          language: language,
          pushEnabled: pushEnabled,
          notifyOrderFilled: notifyOrderFilled,
          notifyOrderFailed: notifyOrderFailed,
          notifyLiquidationWarning: notifyLiquidationWarning,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint

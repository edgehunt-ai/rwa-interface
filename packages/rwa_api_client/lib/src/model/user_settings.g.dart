// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_settings.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$UserSettings extends UserSettings {
  @override
  final UserLanguage language;
  @override
  final bool pushEnabled;
  @override
  final bool notifyOrderFilled;
  @override
  final bool notifyOrderFailed;
  @override
  final bool notifyLiquidationWarning;

  factory _$UserSettings([void Function(UserSettingsBuilder)? updates]) =>
      (UserSettingsBuilder()..update(updates))._build();

  _$UserSettings._(
      {required this.language,
      required this.pushEnabled,
      required this.notifyOrderFilled,
      required this.notifyOrderFailed,
      required this.notifyLiquidationWarning})
      : super._();
  @override
  UserSettings rebuild(void Function(UserSettingsBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  UserSettingsBuilder toBuilder() => UserSettingsBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is UserSettings &&
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
    return (newBuiltValueToStringHelper(r'UserSettings')
          ..add('language', language)
          ..add('pushEnabled', pushEnabled)
          ..add('notifyOrderFilled', notifyOrderFilled)
          ..add('notifyOrderFailed', notifyOrderFailed)
          ..add('notifyLiquidationWarning', notifyLiquidationWarning))
        .toString();
  }
}

class UserSettingsBuilder
    implements Builder<UserSettings, UserSettingsBuilder> {
  _$UserSettings? _$v;

  UserLanguage? _language;
  UserLanguage? get language => _$this._language;
  set language(UserLanguage? language) => _$this._language = language;

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

  UserSettingsBuilder() {
    UserSettings._defaults(this);
  }

  UserSettingsBuilder get _$this {
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
  void replace(UserSettings other) {
    _$v = other as _$UserSettings;
  }

  @override
  void update(void Function(UserSettingsBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  UserSettings build() => _build();

  _$UserSettings _build() {
    final _$result = _$v ??
        _$UserSettings._(
          language: BuiltValueNullFieldError.checkNotNull(
              language, r'UserSettings', 'language'),
          pushEnabled: BuiltValueNullFieldError.checkNotNull(
              pushEnabled, r'UserSettings', 'pushEnabled'),
          notifyOrderFilled: BuiltValueNullFieldError.checkNotNull(
              notifyOrderFilled, r'UserSettings', 'notifyOrderFilled'),
          notifyOrderFailed: BuiltValueNullFieldError.checkNotNull(
              notifyOrderFailed, r'UserSettings', 'notifyOrderFailed'),
          notifyLiquidationWarning: BuiltValueNullFieldError.checkNotNull(
              notifyLiquidationWarning,
              r'UserSettings',
              'notifyLiquidationWarning'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint

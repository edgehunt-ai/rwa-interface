// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_version_info.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$AppVersionInfo extends AppVersionInfo {
  @override
  final String platform;
  @override
  final String latestVersion;
  @override
  final String minSupportedVersion;
  @override
  final String? releaseNotes;
  @override
  final String? storeUrl;
  @override
  final DateTime? publishedAt;
  @override
  final DateTime? updatedAt;

  factory _$AppVersionInfo([void Function(AppVersionInfoBuilder)? updates]) =>
      (AppVersionInfoBuilder()..update(updates))._build();

  _$AppVersionInfo._(
      {required this.platform,
      required this.latestVersion,
      required this.minSupportedVersion,
      this.releaseNotes,
      this.storeUrl,
      this.publishedAt,
      this.updatedAt})
      : super._();
  @override
  AppVersionInfo rebuild(void Function(AppVersionInfoBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  AppVersionInfoBuilder toBuilder() => AppVersionInfoBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is AppVersionInfo &&
        platform == other.platform &&
        latestVersion == other.latestVersion &&
        minSupportedVersion == other.minSupportedVersion &&
        releaseNotes == other.releaseNotes &&
        storeUrl == other.storeUrl &&
        publishedAt == other.publishedAt &&
        updatedAt == other.updatedAt;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, platform.hashCode);
    _$hash = $jc(_$hash, latestVersion.hashCode);
    _$hash = $jc(_$hash, minSupportedVersion.hashCode);
    _$hash = $jc(_$hash, releaseNotes.hashCode);
    _$hash = $jc(_$hash, storeUrl.hashCode);
    _$hash = $jc(_$hash, publishedAt.hashCode);
    _$hash = $jc(_$hash, updatedAt.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'AppVersionInfo')
          ..add('platform', platform)
          ..add('latestVersion', latestVersion)
          ..add('minSupportedVersion', minSupportedVersion)
          ..add('releaseNotes', releaseNotes)
          ..add('storeUrl', storeUrl)
          ..add('publishedAt', publishedAt)
          ..add('updatedAt', updatedAt))
        .toString();
  }
}

class AppVersionInfoBuilder
    implements Builder<AppVersionInfo, AppVersionInfoBuilder> {
  _$AppVersionInfo? _$v;

  String? _platform;
  String? get platform => _$this._platform;
  set platform(String? platform) => _$this._platform = platform;

  String? _latestVersion;
  String? get latestVersion => _$this._latestVersion;
  set latestVersion(String? latestVersion) =>
      _$this._latestVersion = latestVersion;

  String? _minSupportedVersion;
  String? get minSupportedVersion => _$this._minSupportedVersion;
  set minSupportedVersion(String? minSupportedVersion) =>
      _$this._minSupportedVersion = minSupportedVersion;

  String? _releaseNotes;
  String? get releaseNotes => _$this._releaseNotes;
  set releaseNotes(String? releaseNotes) => _$this._releaseNotes = releaseNotes;

  String? _storeUrl;
  String? get storeUrl => _$this._storeUrl;
  set storeUrl(String? storeUrl) => _$this._storeUrl = storeUrl;

  DateTime? _publishedAt;
  DateTime? get publishedAt => _$this._publishedAt;
  set publishedAt(DateTime? publishedAt) => _$this._publishedAt = publishedAt;

  DateTime? _updatedAt;
  DateTime? get updatedAt => _$this._updatedAt;
  set updatedAt(DateTime? updatedAt) => _$this._updatedAt = updatedAt;

  AppVersionInfoBuilder() {
    AppVersionInfo._defaults(this);
  }

  AppVersionInfoBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _platform = $v.platform;
      _latestVersion = $v.latestVersion;
      _minSupportedVersion = $v.minSupportedVersion;
      _releaseNotes = $v.releaseNotes;
      _storeUrl = $v.storeUrl;
      _publishedAt = $v.publishedAt;
      _updatedAt = $v.updatedAt;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(AppVersionInfo other) {
    _$v = other as _$AppVersionInfo;
  }

  @override
  void update(void Function(AppVersionInfoBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  AppVersionInfo build() => _build();

  _$AppVersionInfo _build() {
    final _$result = _$v ??
        _$AppVersionInfo._(
          platform: BuiltValueNullFieldError.checkNotNull(
              platform, r'AppVersionInfo', 'platform'),
          latestVersion: BuiltValueNullFieldError.checkNotNull(
              latestVersion, r'AppVersionInfo', 'latestVersion'),
          minSupportedVersion: BuiltValueNullFieldError.checkNotNull(
              minSupportedVersion, r'AppVersionInfo', 'minSupportedVersion'),
          releaseNotes: releaseNotes,
          storeUrl: storeUrl,
          publishedAt: publishedAt,
          updatedAt: updatedAt,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint

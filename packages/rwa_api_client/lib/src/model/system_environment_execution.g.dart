// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'system_environment_execution.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$SystemEnvironmentExecution extends SystemEnvironmentExecution {
  @override
  final bool enabled;
  @override
  final bool signing;

  factory _$SystemEnvironmentExecution(
          [void Function(SystemEnvironmentExecutionBuilder)? updates]) =>
      (SystemEnvironmentExecutionBuilder()..update(updates))._build();

  _$SystemEnvironmentExecution._({required this.enabled, required this.signing})
      : super._();
  @override
  SystemEnvironmentExecution rebuild(
          void Function(SystemEnvironmentExecutionBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  SystemEnvironmentExecutionBuilder toBuilder() =>
      SystemEnvironmentExecutionBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is SystemEnvironmentExecution &&
        enabled == other.enabled &&
        signing == other.signing;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, enabled.hashCode);
    _$hash = $jc(_$hash, signing.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'SystemEnvironmentExecution')
          ..add('enabled', enabled)
          ..add('signing', signing))
        .toString();
  }
}

class SystemEnvironmentExecutionBuilder
    implements
        Builder<SystemEnvironmentExecution, SystemEnvironmentExecutionBuilder> {
  _$SystemEnvironmentExecution? _$v;

  bool? _enabled;
  bool? get enabled => _$this._enabled;
  set enabled(bool? enabled) => _$this._enabled = enabled;

  bool? _signing;
  bool? get signing => _$this._signing;
  set signing(bool? signing) => _$this._signing = signing;

  SystemEnvironmentExecutionBuilder() {
    SystemEnvironmentExecution._defaults(this);
  }

  SystemEnvironmentExecutionBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _enabled = $v.enabled;
      _signing = $v.signing;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(SystemEnvironmentExecution other) {
    _$v = other as _$SystemEnvironmentExecution;
  }

  @override
  void update(void Function(SystemEnvironmentExecutionBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  SystemEnvironmentExecution build() => _build();

  _$SystemEnvironmentExecution _build() {
    final _$result = _$v ??
        _$SystemEnvironmentExecution._(
          enabled: BuiltValueNullFieldError.checkNotNull(
              enabled, r'SystemEnvironmentExecution', 'enabled'),
          signing: BuiltValueNullFieldError.checkNotNull(
              signing, r'SystemEnvironmentExecution', 'signing'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint

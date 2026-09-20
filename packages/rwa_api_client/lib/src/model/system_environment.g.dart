// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'system_environment.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$SystemEnvironment extends SystemEnvironment {
  @override
  final ServiceEnvironment environment;
  @override
  final SystemEnvironmentExecution execution;
  @override
  final SystemEnvironmentHip3 hip3;
  @override
  final SystemEnvironmentBstocks bstocks;

  factory _$SystemEnvironment(
          [void Function(SystemEnvironmentBuilder)? updates]) =>
      (SystemEnvironmentBuilder()..update(updates))._build();

  _$SystemEnvironment._(
      {required this.environment,
      required this.execution,
      required this.hip3,
      required this.bstocks})
      : super._();
  @override
  SystemEnvironment rebuild(void Function(SystemEnvironmentBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  SystemEnvironmentBuilder toBuilder() =>
      SystemEnvironmentBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is SystemEnvironment &&
        environment == other.environment &&
        execution == other.execution &&
        hip3 == other.hip3 &&
        bstocks == other.bstocks;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, environment.hashCode);
    _$hash = $jc(_$hash, execution.hashCode);
    _$hash = $jc(_$hash, hip3.hashCode);
    _$hash = $jc(_$hash, bstocks.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'SystemEnvironment')
          ..add('environment', environment)
          ..add('execution', execution)
          ..add('hip3', hip3)
          ..add('bstocks', bstocks))
        .toString();
  }
}

class SystemEnvironmentBuilder
    implements Builder<SystemEnvironment, SystemEnvironmentBuilder> {
  _$SystemEnvironment? _$v;

  ServiceEnvironment? _environment;
  ServiceEnvironment? get environment => _$this._environment;
  set environment(ServiceEnvironment? environment) =>
      _$this._environment = environment;

  SystemEnvironmentExecutionBuilder? _execution;
  SystemEnvironmentExecutionBuilder get execution =>
      _$this._execution ??= SystemEnvironmentExecutionBuilder();
  set execution(SystemEnvironmentExecutionBuilder? execution) =>
      _$this._execution = execution;

  SystemEnvironmentHip3Builder? _hip3;
  SystemEnvironmentHip3Builder get hip3 =>
      _$this._hip3 ??= SystemEnvironmentHip3Builder();
  set hip3(SystemEnvironmentHip3Builder? hip3) => _$this._hip3 = hip3;

  SystemEnvironmentBstocksBuilder? _bstocks;
  SystemEnvironmentBstocksBuilder get bstocks =>
      _$this._bstocks ??= SystemEnvironmentBstocksBuilder();
  set bstocks(SystemEnvironmentBstocksBuilder? bstocks) =>
      _$this._bstocks = bstocks;

  SystemEnvironmentBuilder() {
    SystemEnvironment._defaults(this);
  }

  SystemEnvironmentBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _environment = $v.environment;
      _execution = $v.execution.toBuilder();
      _hip3 = $v.hip3.toBuilder();
      _bstocks = $v.bstocks.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(SystemEnvironment other) {
    _$v = other as _$SystemEnvironment;
  }

  @override
  void update(void Function(SystemEnvironmentBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  SystemEnvironment build() => _build();

  _$SystemEnvironment _build() {
    _$SystemEnvironment _$result;
    try {
      _$result = _$v ??
          _$SystemEnvironment._(
            environment: BuiltValueNullFieldError.checkNotNull(
                environment, r'SystemEnvironment', 'environment'),
            execution: execution.build(),
            hip3: hip3.build(),
            bstocks: bstocks.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'execution';
        execution.build();
        _$failedField = 'hip3';
        hip3.build();
        _$failedField = 'bstocks';
        bstocks.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'SystemEnvironment', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint

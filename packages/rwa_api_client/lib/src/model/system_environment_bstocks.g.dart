// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'system_environment_bstocks.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$SystemEnvironmentBstocks extends SystemEnvironmentBstocks {
  @override
  final bool configured;
  @override
  final String? environment;
  @override
  final int? chainId;
  @override
  final SystemEnvironmentBstocksQuoteToken? quoteToken;

  factory _$SystemEnvironmentBstocks(
          [void Function(SystemEnvironmentBstocksBuilder)? updates]) =>
      (SystemEnvironmentBstocksBuilder()..update(updates))._build();

  _$SystemEnvironmentBstocks._(
      {required this.configured,
      this.environment,
      this.chainId,
      this.quoteToken})
      : super._();
  @override
  SystemEnvironmentBstocks rebuild(
          void Function(SystemEnvironmentBstocksBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  SystemEnvironmentBstocksBuilder toBuilder() =>
      SystemEnvironmentBstocksBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is SystemEnvironmentBstocks &&
        configured == other.configured &&
        environment == other.environment &&
        chainId == other.chainId &&
        quoteToken == other.quoteToken;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, configured.hashCode);
    _$hash = $jc(_$hash, environment.hashCode);
    _$hash = $jc(_$hash, chainId.hashCode);
    _$hash = $jc(_$hash, quoteToken.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'SystemEnvironmentBstocks')
          ..add('configured', configured)
          ..add('environment', environment)
          ..add('chainId', chainId)
          ..add('quoteToken', quoteToken))
        .toString();
  }
}

class SystemEnvironmentBstocksBuilder
    implements
        Builder<SystemEnvironmentBstocks, SystemEnvironmentBstocksBuilder> {
  _$SystemEnvironmentBstocks? _$v;

  bool? _configured;
  bool? get configured => _$this._configured;
  set configured(bool? configured) => _$this._configured = configured;

  String? _environment;
  String? get environment => _$this._environment;
  set environment(String? environment) => _$this._environment = environment;

  int? _chainId;
  int? get chainId => _$this._chainId;
  set chainId(int? chainId) => _$this._chainId = chainId;

  SystemEnvironmentBstocksQuoteTokenBuilder? _quoteToken;
  SystemEnvironmentBstocksQuoteTokenBuilder get quoteToken =>
      _$this._quoteToken ??= SystemEnvironmentBstocksQuoteTokenBuilder();
  set quoteToken(SystemEnvironmentBstocksQuoteTokenBuilder? quoteToken) =>
      _$this._quoteToken = quoteToken;

  SystemEnvironmentBstocksBuilder() {
    SystemEnvironmentBstocks._defaults(this);
  }

  SystemEnvironmentBstocksBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _configured = $v.configured;
      _environment = $v.environment;
      _chainId = $v.chainId;
      _quoteToken = $v.quoteToken?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(SystemEnvironmentBstocks other) {
    _$v = other as _$SystemEnvironmentBstocks;
  }

  @override
  void update(void Function(SystemEnvironmentBstocksBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  SystemEnvironmentBstocks build() => _build();

  _$SystemEnvironmentBstocks _build() {
    _$SystemEnvironmentBstocks _$result;
    try {
      _$result = _$v ??
          _$SystemEnvironmentBstocks._(
            configured: BuiltValueNullFieldError.checkNotNull(
                configured, r'SystemEnvironmentBstocks', 'configured'),
            environment: environment,
            chainId: chainId,
            quoteToken: _quoteToken?.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'quoteToken';
        _quoteToken?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'SystemEnvironmentBstocks', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'system_environment_bstocks_quote_token.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$SystemEnvironmentBstocksQuoteToken
    extends SystemEnvironmentBstocksQuoteToken {
  @override
  final String symbol;
  @override
  final String contract;
  @override
  final int decimals;

  factory _$SystemEnvironmentBstocksQuoteToken(
          [void Function(SystemEnvironmentBstocksQuoteTokenBuilder)?
              updates]) =>
      (SystemEnvironmentBstocksQuoteTokenBuilder()..update(updates))._build();

  _$SystemEnvironmentBstocksQuoteToken._(
      {required this.symbol, required this.contract, required this.decimals})
      : super._();
  @override
  SystemEnvironmentBstocksQuoteToken rebuild(
          void Function(SystemEnvironmentBstocksQuoteTokenBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  SystemEnvironmentBstocksQuoteTokenBuilder toBuilder() =>
      SystemEnvironmentBstocksQuoteTokenBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is SystemEnvironmentBstocksQuoteToken &&
        symbol == other.symbol &&
        contract == other.contract &&
        decimals == other.decimals;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, symbol.hashCode);
    _$hash = $jc(_$hash, contract.hashCode);
    _$hash = $jc(_$hash, decimals.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'SystemEnvironmentBstocksQuoteToken')
          ..add('symbol', symbol)
          ..add('contract', contract)
          ..add('decimals', decimals))
        .toString();
  }
}

class SystemEnvironmentBstocksQuoteTokenBuilder
    implements
        Builder<SystemEnvironmentBstocksQuoteToken,
            SystemEnvironmentBstocksQuoteTokenBuilder> {
  _$SystemEnvironmentBstocksQuoteToken? _$v;

  String? _symbol;
  String? get symbol => _$this._symbol;
  set symbol(String? symbol) => _$this._symbol = symbol;

  String? _contract;
  String? get contract => _$this._contract;
  set contract(String? contract) => _$this._contract = contract;

  int? _decimals;
  int? get decimals => _$this._decimals;
  set decimals(int? decimals) => _$this._decimals = decimals;

  SystemEnvironmentBstocksQuoteTokenBuilder() {
    SystemEnvironmentBstocksQuoteToken._defaults(this);
  }

  SystemEnvironmentBstocksQuoteTokenBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _symbol = $v.symbol;
      _contract = $v.contract;
      _decimals = $v.decimals;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(SystemEnvironmentBstocksQuoteToken other) {
    _$v = other as _$SystemEnvironmentBstocksQuoteToken;
  }

  @override
  void update(
      void Function(SystemEnvironmentBstocksQuoteTokenBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  SystemEnvironmentBstocksQuoteToken build() => _build();

  _$SystemEnvironmentBstocksQuoteToken _build() {
    final _$result = _$v ??
        _$SystemEnvironmentBstocksQuoteToken._(
          symbol: BuiltValueNullFieldError.checkNotNull(
              symbol, r'SystemEnvironmentBstocksQuoteToken', 'symbol'),
          contract: BuiltValueNullFieldError.checkNotNull(
              contract, r'SystemEnvironmentBstocksQuoteToken', 'contract'),
          decimals: BuiltValueNullFieldError.checkNotNull(
              decimals, r'SystemEnvironmentBstocksQuoteToken', 'decimals'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint

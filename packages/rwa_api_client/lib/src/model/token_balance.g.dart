// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'token_balance.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$TokenBalance extends TokenBalance {
  @override
  final String symbol;
  @override
  final String balance;
  @override
  final String? valueUsd;
  @override
  final int? decimals;
  @override
  final Chain? chain;

  factory _$TokenBalance([void Function(TokenBalanceBuilder)? updates]) =>
      (TokenBalanceBuilder()..update(updates))._build();

  _$TokenBalance._(
      {required this.symbol,
      required this.balance,
      this.valueUsd,
      this.decimals,
      this.chain})
      : super._();
  @override
  TokenBalance rebuild(void Function(TokenBalanceBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  TokenBalanceBuilder toBuilder() => TokenBalanceBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is TokenBalance &&
        symbol == other.symbol &&
        balance == other.balance &&
        valueUsd == other.valueUsd &&
        decimals == other.decimals &&
        chain == other.chain;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, symbol.hashCode);
    _$hash = $jc(_$hash, balance.hashCode);
    _$hash = $jc(_$hash, valueUsd.hashCode);
    _$hash = $jc(_$hash, decimals.hashCode);
    _$hash = $jc(_$hash, chain.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'TokenBalance')
          ..add('symbol', symbol)
          ..add('balance', balance)
          ..add('valueUsd', valueUsd)
          ..add('decimals', decimals)
          ..add('chain', chain))
        .toString();
  }
}

class TokenBalanceBuilder
    implements Builder<TokenBalance, TokenBalanceBuilder> {
  _$TokenBalance? _$v;

  String? _symbol;
  String? get symbol => _$this._symbol;
  set symbol(String? symbol) => _$this._symbol = symbol;

  String? _balance;
  String? get balance => _$this._balance;
  set balance(String? balance) => _$this._balance = balance;

  String? _valueUsd;
  String? get valueUsd => _$this._valueUsd;
  set valueUsd(String? valueUsd) => _$this._valueUsd = valueUsd;

  int? _decimals;
  int? get decimals => _$this._decimals;
  set decimals(int? decimals) => _$this._decimals = decimals;

  Chain? _chain;
  Chain? get chain => _$this._chain;
  set chain(Chain? chain) => _$this._chain = chain;

  TokenBalanceBuilder() {
    TokenBalance._defaults(this);
  }

  TokenBalanceBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _symbol = $v.symbol;
      _balance = $v.balance;
      _valueUsd = $v.valueUsd;
      _decimals = $v.decimals;
      _chain = $v.chain;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(TokenBalance other) {
    _$v = other as _$TokenBalance;
  }

  @override
  void update(void Function(TokenBalanceBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  TokenBalance build() => _build();

  _$TokenBalance _build() {
    final _$result = _$v ??
        _$TokenBalance._(
          symbol: BuiltValueNullFieldError.checkNotNull(
              symbol, r'TokenBalance', 'symbol'),
          balance: BuiltValueNullFieldError.checkNotNull(
              balance, r'TokenBalance', 'balance'),
          valueUsd: valueUsd,
          decimals: decimals,
          chain: chain,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint

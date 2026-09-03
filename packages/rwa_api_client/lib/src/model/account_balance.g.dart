// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'account_balance.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$AccountBalance extends AccountBalance {
  @override
  final AccountKind account;
  @override
  final String? label;
  @override
  final String? address;
  @override
  final Chain? chain;
  @override
  final String? totalValueUsd;
  @override
  final String? availableUsd;
  @override
  final String? marginUsedUsd;
  @override
  final BuiltList<TokenBalance> balances;

  factory _$AccountBalance([void Function(AccountBalanceBuilder)? updates]) =>
      (AccountBalanceBuilder()..update(updates))._build();

  _$AccountBalance._(
      {required this.account,
      this.label,
      this.address,
      this.chain,
      this.totalValueUsd,
      this.availableUsd,
      this.marginUsedUsd,
      required this.balances})
      : super._();
  @override
  AccountBalance rebuild(void Function(AccountBalanceBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  AccountBalanceBuilder toBuilder() => AccountBalanceBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is AccountBalance &&
        account == other.account &&
        label == other.label &&
        address == other.address &&
        chain == other.chain &&
        totalValueUsd == other.totalValueUsd &&
        availableUsd == other.availableUsd &&
        marginUsedUsd == other.marginUsedUsd &&
        balances == other.balances;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, account.hashCode);
    _$hash = $jc(_$hash, label.hashCode);
    _$hash = $jc(_$hash, address.hashCode);
    _$hash = $jc(_$hash, chain.hashCode);
    _$hash = $jc(_$hash, totalValueUsd.hashCode);
    _$hash = $jc(_$hash, availableUsd.hashCode);
    _$hash = $jc(_$hash, marginUsedUsd.hashCode);
    _$hash = $jc(_$hash, balances.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'AccountBalance')
          ..add('account', account)
          ..add('label', label)
          ..add('address', address)
          ..add('chain', chain)
          ..add('totalValueUsd', totalValueUsd)
          ..add('availableUsd', availableUsd)
          ..add('marginUsedUsd', marginUsedUsd)
          ..add('balances', balances))
        .toString();
  }
}

class AccountBalanceBuilder
    implements Builder<AccountBalance, AccountBalanceBuilder> {
  _$AccountBalance? _$v;

  AccountKind? _account;
  AccountKind? get account => _$this._account;
  set account(AccountKind? account) => _$this._account = account;

  String? _label;
  String? get label => _$this._label;
  set label(String? label) => _$this._label = label;

  String? _address;
  String? get address => _$this._address;
  set address(String? address) => _$this._address = address;

  Chain? _chain;
  Chain? get chain => _$this._chain;
  set chain(Chain? chain) => _$this._chain = chain;

  String? _totalValueUsd;
  String? get totalValueUsd => _$this._totalValueUsd;
  set totalValueUsd(String? totalValueUsd) =>
      _$this._totalValueUsd = totalValueUsd;

  String? _availableUsd;
  String? get availableUsd => _$this._availableUsd;
  set availableUsd(String? availableUsd) => _$this._availableUsd = availableUsd;

  String? _marginUsedUsd;
  String? get marginUsedUsd => _$this._marginUsedUsd;
  set marginUsedUsd(String? marginUsedUsd) =>
      _$this._marginUsedUsd = marginUsedUsd;

  ListBuilder<TokenBalance>? _balances;
  ListBuilder<TokenBalance> get balances =>
      _$this._balances ??= ListBuilder<TokenBalance>();
  set balances(ListBuilder<TokenBalance>? balances) =>
      _$this._balances = balances;

  AccountBalanceBuilder() {
    AccountBalance._defaults(this);
  }

  AccountBalanceBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _account = $v.account;
      _label = $v.label;
      _address = $v.address;
      _chain = $v.chain;
      _totalValueUsd = $v.totalValueUsd;
      _availableUsd = $v.availableUsd;
      _marginUsedUsd = $v.marginUsedUsd;
      _balances = $v.balances.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(AccountBalance other) {
    _$v = other as _$AccountBalance;
  }

  @override
  void update(void Function(AccountBalanceBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  AccountBalance build() => _build();

  _$AccountBalance _build() {
    _$AccountBalance _$result;
    try {
      _$result = _$v ??
          _$AccountBalance._(
            account: BuiltValueNullFieldError.checkNotNull(
                account, r'AccountBalance', 'account'),
            label: label,
            address: address,
            chain: chain,
            totalValueUsd: totalValueUsd,
            availableUsd: availableUsd,
            marginUsedUsd: marginUsedUsd,
            balances: balances.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'balances';
        balances.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'AccountBalance', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint

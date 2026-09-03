// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wallet.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$Wallet extends Wallet {
  @override
  final String walletId;
  @override
  final String address;
  @override
  final Chain chain;
  @override
  final WalletStatus status;
  @override
  final DateTime createdAt;

  factory _$Wallet([void Function(WalletBuilder)? updates]) =>
      (WalletBuilder()..update(updates))._build();

  _$Wallet._(
      {required this.walletId,
      required this.address,
      required this.chain,
      required this.status,
      required this.createdAt})
      : super._();
  @override
  Wallet rebuild(void Function(WalletBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  WalletBuilder toBuilder() => WalletBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Wallet &&
        walletId == other.walletId &&
        address == other.address &&
        chain == other.chain &&
        status == other.status &&
        createdAt == other.createdAt;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, walletId.hashCode);
    _$hash = $jc(_$hash, address.hashCode);
    _$hash = $jc(_$hash, chain.hashCode);
    _$hash = $jc(_$hash, status.hashCode);
    _$hash = $jc(_$hash, createdAt.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'Wallet')
          ..add('walletId', walletId)
          ..add('address', address)
          ..add('chain', chain)
          ..add('status', status)
          ..add('createdAt', createdAt))
        .toString();
  }
}

class WalletBuilder implements Builder<Wallet, WalletBuilder> {
  _$Wallet? _$v;

  String? _walletId;
  String? get walletId => _$this._walletId;
  set walletId(String? walletId) => _$this._walletId = walletId;

  String? _address;
  String? get address => _$this._address;
  set address(String? address) => _$this._address = address;

  Chain? _chain;
  Chain? get chain => _$this._chain;
  set chain(Chain? chain) => _$this._chain = chain;

  WalletStatus? _status;
  WalletStatus? get status => _$this._status;
  set status(WalletStatus? status) => _$this._status = status;

  DateTime? _createdAt;
  DateTime? get createdAt => _$this._createdAt;
  set createdAt(DateTime? createdAt) => _$this._createdAt = createdAt;

  WalletBuilder() {
    Wallet._defaults(this);
  }

  WalletBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _walletId = $v.walletId;
      _address = $v.address;
      _chain = $v.chain;
      _status = $v.status;
      _createdAt = $v.createdAt;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Wallet other) {
    _$v = other as _$Wallet;
  }

  @override
  void update(void Function(WalletBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  Wallet build() => _build();

  _$Wallet _build() {
    final _$result = _$v ??
        _$Wallet._(
          walletId: BuiltValueNullFieldError.checkNotNull(
              walletId, r'Wallet', 'walletId'),
          address: BuiltValueNullFieldError.checkNotNull(
              address, r'Wallet', 'address'),
          chain:
              BuiltValueNullFieldError.checkNotNull(chain, r'Wallet', 'chain'),
          status: BuiltValueNullFieldError.checkNotNull(
              status, r'Wallet', 'status'),
          createdAt: BuiltValueNullFieldError.checkNotNull(
              createdAt, r'Wallet', 'createdAt'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint

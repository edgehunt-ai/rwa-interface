// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bstocks_preview_fees.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$BstocksPreviewFees extends BstocksPreviewFees {
  @override
  final BstocksPreviewFee trading;
  @override
  final BstocksPreviewFee network;

  factory _$BstocksPreviewFees(
          [void Function(BstocksPreviewFeesBuilder)? updates]) =>
      (BstocksPreviewFeesBuilder()..update(updates))._build();

  _$BstocksPreviewFees._({required this.trading, required this.network})
      : super._();
  @override
  BstocksPreviewFees rebuild(
          void Function(BstocksPreviewFeesBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  BstocksPreviewFeesBuilder toBuilder() =>
      BstocksPreviewFeesBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is BstocksPreviewFees &&
        trading == other.trading &&
        network == other.network;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, trading.hashCode);
    _$hash = $jc(_$hash, network.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'BstocksPreviewFees')
          ..add('trading', trading)
          ..add('network', network))
        .toString();
  }
}

class BstocksPreviewFeesBuilder
    implements Builder<BstocksPreviewFees, BstocksPreviewFeesBuilder> {
  _$BstocksPreviewFees? _$v;

  BstocksPreviewFeeBuilder? _trading;
  BstocksPreviewFeeBuilder get trading =>
      _$this._trading ??= BstocksPreviewFeeBuilder();
  set trading(BstocksPreviewFeeBuilder? trading) => _$this._trading = trading;

  BstocksPreviewFeeBuilder? _network;
  BstocksPreviewFeeBuilder get network =>
      _$this._network ??= BstocksPreviewFeeBuilder();
  set network(BstocksPreviewFeeBuilder? network) => _$this._network = network;

  BstocksPreviewFeesBuilder() {
    BstocksPreviewFees._defaults(this);
  }

  BstocksPreviewFeesBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _trading = $v.trading.toBuilder();
      _network = $v.network.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(BstocksPreviewFees other) {
    _$v = other as _$BstocksPreviewFees;
  }

  @override
  void update(void Function(BstocksPreviewFeesBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  BstocksPreviewFees build() => _build();

  _$BstocksPreviewFees _build() {
    _$BstocksPreviewFees _$result;
    try {
      _$result = _$v ??
          _$BstocksPreviewFees._(
            trading: trading.build(),
            network: network.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'trading';
        trading.build();
        _$failedField = 'network';
        network.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'BstocksPreviewFees', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint

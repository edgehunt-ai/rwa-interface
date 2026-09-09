// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'deposit_rail_base.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

abstract class DepositRailBaseBuilder {
  void replace(DepositRailBase other);
  void update(void Function(DepositRailBaseBuilder) updates);
  String? get chain;
  set chain(String? chain);

  int? get chainId;
  set chainId(int? chainId);

  String? get token;
  set token(String? token);

  String? get tokenContract;
  set tokenContract(String? tokenContract);

  int? get tokenDecimals;
  set tokenDecimals(int? tokenDecimals);

  String? get minimumAmount;
  set minimumAmount(String? minimumAmount);

  int? get confirmationsRequired;
  set confirmationsRequired(int? confirmationsRequired);

  DepositRailAvailabilityBuilder get availability;
  set availability(DepositRailAvailabilityBuilder? availability);
}

class _$$DepositRailBase extends $DepositRailBase {
  @override
  final String chain;
  @override
  final int chainId;
  @override
  final String token;
  @override
  final String tokenContract;
  @override
  final int tokenDecimals;
  @override
  final String minimumAmount;
  @override
  final int confirmationsRequired;
  @override
  final DepositRailAvailability availability;

  factory _$$DepositRailBase(
          [void Function($DepositRailBaseBuilder)? updates]) =>
      ($DepositRailBaseBuilder()..update(updates))._build();

  _$$DepositRailBase._(
      {required this.chain,
      required this.chainId,
      required this.token,
      required this.tokenContract,
      required this.tokenDecimals,
      required this.minimumAmount,
      required this.confirmationsRequired,
      required this.availability})
      : super._();
  @override
  $DepositRailBase rebuild(void Function($DepositRailBaseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  $DepositRailBaseBuilder toBuilder() =>
      $DepositRailBaseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is $DepositRailBase &&
        chain == other.chain &&
        chainId == other.chainId &&
        token == other.token &&
        tokenContract == other.tokenContract &&
        tokenDecimals == other.tokenDecimals &&
        minimumAmount == other.minimumAmount &&
        confirmationsRequired == other.confirmationsRequired &&
        availability == other.availability;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, chain.hashCode);
    _$hash = $jc(_$hash, chainId.hashCode);
    _$hash = $jc(_$hash, token.hashCode);
    _$hash = $jc(_$hash, tokenContract.hashCode);
    _$hash = $jc(_$hash, tokenDecimals.hashCode);
    _$hash = $jc(_$hash, minimumAmount.hashCode);
    _$hash = $jc(_$hash, confirmationsRequired.hashCode);
    _$hash = $jc(_$hash, availability.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'$DepositRailBase')
          ..add('chain', chain)
          ..add('chainId', chainId)
          ..add('token', token)
          ..add('tokenContract', tokenContract)
          ..add('tokenDecimals', tokenDecimals)
          ..add('minimumAmount', minimumAmount)
          ..add('confirmationsRequired', confirmationsRequired)
          ..add('availability', availability))
        .toString();
  }
}

class $DepositRailBaseBuilder
    implements
        Builder<$DepositRailBase, $DepositRailBaseBuilder>,
        DepositRailBaseBuilder {
  _$$DepositRailBase? _$v;

  String? _chain;
  String? get chain => _$this._chain;
  set chain(covariant String? chain) => _$this._chain = chain;

  int? _chainId;
  int? get chainId => _$this._chainId;
  set chainId(covariant int? chainId) => _$this._chainId = chainId;

  String? _token;
  String? get token => _$this._token;
  set token(covariant String? token) => _$this._token = token;

  String? _tokenContract;
  String? get tokenContract => _$this._tokenContract;
  set tokenContract(covariant String? tokenContract) =>
      _$this._tokenContract = tokenContract;

  int? _tokenDecimals;
  int? get tokenDecimals => _$this._tokenDecimals;
  set tokenDecimals(covariant int? tokenDecimals) =>
      _$this._tokenDecimals = tokenDecimals;

  String? _minimumAmount;
  String? get minimumAmount => _$this._minimumAmount;
  set minimumAmount(covariant String? minimumAmount) =>
      _$this._minimumAmount = minimumAmount;

  int? _confirmationsRequired;
  int? get confirmationsRequired => _$this._confirmationsRequired;
  set confirmationsRequired(covariant int? confirmationsRequired) =>
      _$this._confirmationsRequired = confirmationsRequired;

  DepositRailAvailabilityBuilder? _availability;
  DepositRailAvailabilityBuilder get availability =>
      _$this._availability ??= DepositRailAvailabilityBuilder();
  set availability(covariant DepositRailAvailabilityBuilder? availability) =>
      _$this._availability = availability;

  $DepositRailBaseBuilder() {
    $DepositRailBase._defaults(this);
  }

  $DepositRailBaseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _chain = $v.chain;
      _chainId = $v.chainId;
      _token = $v.token;
      _tokenContract = $v.tokenContract;
      _tokenDecimals = $v.tokenDecimals;
      _minimumAmount = $v.minimumAmount;
      _confirmationsRequired = $v.confirmationsRequired;
      _availability = $v.availability.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(covariant $DepositRailBase other) {
    _$v = other as _$$DepositRailBase;
  }

  @override
  void update(void Function($DepositRailBaseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  $DepositRailBase build() => _build();

  _$$DepositRailBase _build() {
    _$$DepositRailBase _$result;
    try {
      _$result = _$v ??
          _$$DepositRailBase._(
            chain: BuiltValueNullFieldError.checkNotNull(
                chain, r'$DepositRailBase', 'chain'),
            chainId: BuiltValueNullFieldError.checkNotNull(
                chainId, r'$DepositRailBase', 'chainId'),
            token: BuiltValueNullFieldError.checkNotNull(
                token, r'$DepositRailBase', 'token'),
            tokenContract: BuiltValueNullFieldError.checkNotNull(
                tokenContract, r'$DepositRailBase', 'tokenContract'),
            tokenDecimals: BuiltValueNullFieldError.checkNotNull(
                tokenDecimals, r'$DepositRailBase', 'tokenDecimals'),
            minimumAmount: BuiltValueNullFieldError.checkNotNull(
                minimumAmount, r'$DepositRailBase', 'minimumAmount'),
            confirmationsRequired: BuiltValueNullFieldError.checkNotNull(
                confirmationsRequired,
                r'$DepositRailBase',
                'confirmationsRequired'),
            availability: availability.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'availability';
        availability.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'$DepositRailBase', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint

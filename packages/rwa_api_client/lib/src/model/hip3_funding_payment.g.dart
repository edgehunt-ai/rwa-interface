// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hip3_funding_payment.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$Hip3FundingPayment extends Hip3FundingPayment {
  @override
  final String id;
  @override
  final String productId;
  @override
  final String amount;
  @override
  final String? settlementAsset;
  @override
  final int? collateralToken;
  @override
  final String signedPositionSize;
  @override
  final String fundingRate;
  @override
  final String transactionHash;
  @override
  final DateTime occurredAt;

  factory _$Hip3FundingPayment(
          [void Function(Hip3FundingPaymentBuilder)? updates]) =>
      (Hip3FundingPaymentBuilder()..update(updates))._build();

  _$Hip3FundingPayment._(
      {required this.id,
      required this.productId,
      required this.amount,
      this.settlementAsset,
      this.collateralToken,
      required this.signedPositionSize,
      required this.fundingRate,
      required this.transactionHash,
      required this.occurredAt})
      : super._();
  @override
  Hip3FundingPayment rebuild(
          void Function(Hip3FundingPaymentBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  Hip3FundingPaymentBuilder toBuilder() =>
      Hip3FundingPaymentBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Hip3FundingPayment &&
        id == other.id &&
        productId == other.productId &&
        amount == other.amount &&
        settlementAsset == other.settlementAsset &&
        collateralToken == other.collateralToken &&
        signedPositionSize == other.signedPositionSize &&
        fundingRate == other.fundingRate &&
        transactionHash == other.transactionHash &&
        occurredAt == other.occurredAt;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, productId.hashCode);
    _$hash = $jc(_$hash, amount.hashCode);
    _$hash = $jc(_$hash, settlementAsset.hashCode);
    _$hash = $jc(_$hash, collateralToken.hashCode);
    _$hash = $jc(_$hash, signedPositionSize.hashCode);
    _$hash = $jc(_$hash, fundingRate.hashCode);
    _$hash = $jc(_$hash, transactionHash.hashCode);
    _$hash = $jc(_$hash, occurredAt.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'Hip3FundingPayment')
          ..add('id', id)
          ..add('productId', productId)
          ..add('amount', amount)
          ..add('settlementAsset', settlementAsset)
          ..add('collateralToken', collateralToken)
          ..add('signedPositionSize', signedPositionSize)
          ..add('fundingRate', fundingRate)
          ..add('transactionHash', transactionHash)
          ..add('occurredAt', occurredAt))
        .toString();
  }
}

class Hip3FundingPaymentBuilder
    implements Builder<Hip3FundingPayment, Hip3FundingPaymentBuilder> {
  _$Hip3FundingPayment? _$v;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  String? _productId;
  String? get productId => _$this._productId;
  set productId(String? productId) => _$this._productId = productId;

  String? _amount;
  String? get amount => _$this._amount;
  set amount(String? amount) => _$this._amount = amount;

  String? _settlementAsset;
  String? get settlementAsset => _$this._settlementAsset;
  set settlementAsset(String? settlementAsset) =>
      _$this._settlementAsset = settlementAsset;

  int? _collateralToken;
  int? get collateralToken => _$this._collateralToken;
  set collateralToken(int? collateralToken) =>
      _$this._collateralToken = collateralToken;

  String? _signedPositionSize;
  String? get signedPositionSize => _$this._signedPositionSize;
  set signedPositionSize(String? signedPositionSize) =>
      _$this._signedPositionSize = signedPositionSize;

  String? _fundingRate;
  String? get fundingRate => _$this._fundingRate;
  set fundingRate(String? fundingRate) => _$this._fundingRate = fundingRate;

  String? _transactionHash;
  String? get transactionHash => _$this._transactionHash;
  set transactionHash(String? transactionHash) =>
      _$this._transactionHash = transactionHash;

  DateTime? _occurredAt;
  DateTime? get occurredAt => _$this._occurredAt;
  set occurredAt(DateTime? occurredAt) => _$this._occurredAt = occurredAt;

  Hip3FundingPaymentBuilder() {
    Hip3FundingPayment._defaults(this);
  }

  Hip3FundingPaymentBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _productId = $v.productId;
      _amount = $v.amount;
      _settlementAsset = $v.settlementAsset;
      _collateralToken = $v.collateralToken;
      _signedPositionSize = $v.signedPositionSize;
      _fundingRate = $v.fundingRate;
      _transactionHash = $v.transactionHash;
      _occurredAt = $v.occurredAt;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Hip3FundingPayment other) {
    _$v = other as _$Hip3FundingPayment;
  }

  @override
  void update(void Function(Hip3FundingPaymentBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  Hip3FundingPayment build() => _build();

  _$Hip3FundingPayment _build() {
    final _$result = _$v ??
        _$Hip3FundingPayment._(
          id: BuiltValueNullFieldError.checkNotNull(
              id, r'Hip3FundingPayment', 'id'),
          productId: BuiltValueNullFieldError.checkNotNull(
              productId, r'Hip3FundingPayment', 'productId'),
          amount: BuiltValueNullFieldError.checkNotNull(
              amount, r'Hip3FundingPayment', 'amount'),
          settlementAsset: settlementAsset,
          collateralToken: collateralToken,
          signedPositionSize: BuiltValueNullFieldError.checkNotNull(
              signedPositionSize, r'Hip3FundingPayment', 'signedPositionSize'),
          fundingRate: BuiltValueNullFieldError.checkNotNull(
              fundingRate, r'Hip3FundingPayment', 'fundingRate'),
          transactionHash: BuiltValueNullFieldError.checkNotNull(
              transactionHash, r'Hip3FundingPayment', 'transactionHash'),
          occurredAt: BuiltValueNullFieldError.checkNotNull(
              occurredAt, r'Hip3FundingPayment', 'occurredAt'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint

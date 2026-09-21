// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_book_level.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$OrderBookLevel extends OrderBookLevel {
  @override
  final String price;
  @override
  final String size;
  @override
  final String? quoteAmount;
  @override
  final String? nominalInputRaw;
  @override
  final String? grossInputRaw;
  @override
  final String? inputFeeRaw;
  @override
  final String? outputRaw;
  @override
  final int? validAfterBlock;
  @override
  final int? validUntilBlock;

  factory _$OrderBookLevel([void Function(OrderBookLevelBuilder)? updates]) =>
      (OrderBookLevelBuilder()..update(updates))._build();

  _$OrderBookLevel._(
      {required this.price,
      required this.size,
      this.quoteAmount,
      this.nominalInputRaw,
      this.grossInputRaw,
      this.inputFeeRaw,
      this.outputRaw,
      this.validAfterBlock,
      this.validUntilBlock})
      : super._();
  @override
  OrderBookLevel rebuild(void Function(OrderBookLevelBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  OrderBookLevelBuilder toBuilder() => OrderBookLevelBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is OrderBookLevel &&
        price == other.price &&
        size == other.size &&
        quoteAmount == other.quoteAmount &&
        nominalInputRaw == other.nominalInputRaw &&
        grossInputRaw == other.grossInputRaw &&
        inputFeeRaw == other.inputFeeRaw &&
        outputRaw == other.outputRaw &&
        validAfterBlock == other.validAfterBlock &&
        validUntilBlock == other.validUntilBlock;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, price.hashCode);
    _$hash = $jc(_$hash, size.hashCode);
    _$hash = $jc(_$hash, quoteAmount.hashCode);
    _$hash = $jc(_$hash, nominalInputRaw.hashCode);
    _$hash = $jc(_$hash, grossInputRaw.hashCode);
    _$hash = $jc(_$hash, inputFeeRaw.hashCode);
    _$hash = $jc(_$hash, outputRaw.hashCode);
    _$hash = $jc(_$hash, validAfterBlock.hashCode);
    _$hash = $jc(_$hash, validUntilBlock.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'OrderBookLevel')
          ..add('price', price)
          ..add('size', size)
          ..add('quoteAmount', quoteAmount)
          ..add('nominalInputRaw', nominalInputRaw)
          ..add('grossInputRaw', grossInputRaw)
          ..add('inputFeeRaw', inputFeeRaw)
          ..add('outputRaw', outputRaw)
          ..add('validAfterBlock', validAfterBlock)
          ..add('validUntilBlock', validUntilBlock))
        .toString();
  }
}

class OrderBookLevelBuilder
    implements Builder<OrderBookLevel, OrderBookLevelBuilder> {
  _$OrderBookLevel? _$v;

  String? _price;
  String? get price => _$this._price;
  set price(String? price) => _$this._price = price;

  String? _size;
  String? get size => _$this._size;
  set size(String? size) => _$this._size = size;

  String? _quoteAmount;
  String? get quoteAmount => _$this._quoteAmount;
  set quoteAmount(String? quoteAmount) => _$this._quoteAmount = quoteAmount;

  String? _nominalInputRaw;
  String? get nominalInputRaw => _$this._nominalInputRaw;
  set nominalInputRaw(String? nominalInputRaw) =>
      _$this._nominalInputRaw = nominalInputRaw;

  String? _grossInputRaw;
  String? get grossInputRaw => _$this._grossInputRaw;
  set grossInputRaw(String? grossInputRaw) =>
      _$this._grossInputRaw = grossInputRaw;

  String? _inputFeeRaw;
  String? get inputFeeRaw => _$this._inputFeeRaw;
  set inputFeeRaw(String? inputFeeRaw) => _$this._inputFeeRaw = inputFeeRaw;

  String? _outputRaw;
  String? get outputRaw => _$this._outputRaw;
  set outputRaw(String? outputRaw) => _$this._outputRaw = outputRaw;

  int? _validAfterBlock;
  int? get validAfterBlock => _$this._validAfterBlock;
  set validAfterBlock(int? validAfterBlock) =>
      _$this._validAfterBlock = validAfterBlock;

  int? _validUntilBlock;
  int? get validUntilBlock => _$this._validUntilBlock;
  set validUntilBlock(int? validUntilBlock) =>
      _$this._validUntilBlock = validUntilBlock;

  OrderBookLevelBuilder() {
    OrderBookLevel._defaults(this);
  }

  OrderBookLevelBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _price = $v.price;
      _size = $v.size;
      _quoteAmount = $v.quoteAmount;
      _nominalInputRaw = $v.nominalInputRaw;
      _grossInputRaw = $v.grossInputRaw;
      _inputFeeRaw = $v.inputFeeRaw;
      _outputRaw = $v.outputRaw;
      _validAfterBlock = $v.validAfterBlock;
      _validUntilBlock = $v.validUntilBlock;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(OrderBookLevel other) {
    _$v = other as _$OrderBookLevel;
  }

  @override
  void update(void Function(OrderBookLevelBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  OrderBookLevel build() => _build();

  _$OrderBookLevel _build() {
    final _$result = _$v ??
        _$OrderBookLevel._(
          price: BuiltValueNullFieldError.checkNotNull(
              price, r'OrderBookLevel', 'price'),
          size: BuiltValueNullFieldError.checkNotNull(
              size, r'OrderBookLevel', 'size'),
          quoteAmount: quoteAmount,
          nominalInputRaw: nominalInputRaw,
          grossInputRaw: grossInputRaw,
          inputFeeRaw: inputFeeRaw,
          outputRaw: outputRaw,
          validAfterBlock: validAfterBlock,
          validUntilBlock: validUntilBlock,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint

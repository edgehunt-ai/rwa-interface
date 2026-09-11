// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hip3_liquidation_position.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$Hip3LiquidationPosition extends Hip3LiquidationPosition {
  @override
  final String productId;
  @override
  final String signedPositionSize;

  factory _$Hip3LiquidationPosition(
          [void Function(Hip3LiquidationPositionBuilder)? updates]) =>
      (Hip3LiquidationPositionBuilder()..update(updates))._build();

  _$Hip3LiquidationPosition._(
      {required this.productId, required this.signedPositionSize})
      : super._();
  @override
  Hip3LiquidationPosition rebuild(
          void Function(Hip3LiquidationPositionBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  Hip3LiquidationPositionBuilder toBuilder() =>
      Hip3LiquidationPositionBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Hip3LiquidationPosition &&
        productId == other.productId &&
        signedPositionSize == other.signedPositionSize;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, productId.hashCode);
    _$hash = $jc(_$hash, signedPositionSize.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'Hip3LiquidationPosition')
          ..add('productId', productId)
          ..add('signedPositionSize', signedPositionSize))
        .toString();
  }
}

class Hip3LiquidationPositionBuilder
    implements
        Builder<Hip3LiquidationPosition, Hip3LiquidationPositionBuilder> {
  _$Hip3LiquidationPosition? _$v;

  String? _productId;
  String? get productId => _$this._productId;
  set productId(String? productId) => _$this._productId = productId;

  String? _signedPositionSize;
  String? get signedPositionSize => _$this._signedPositionSize;
  set signedPositionSize(String? signedPositionSize) =>
      _$this._signedPositionSize = signedPositionSize;

  Hip3LiquidationPositionBuilder() {
    Hip3LiquidationPosition._defaults(this);
  }

  Hip3LiquidationPositionBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _productId = $v.productId;
      _signedPositionSize = $v.signedPositionSize;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Hip3LiquidationPosition other) {
    _$v = other as _$Hip3LiquidationPosition;
  }

  @override
  void update(void Function(Hip3LiquidationPositionBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  Hip3LiquidationPosition build() => _build();

  _$Hip3LiquidationPosition _build() {
    final _$result = _$v ??
        _$Hip3LiquidationPosition._(
          productId: BuiltValueNullFieldError.checkNotNull(
              productId, r'Hip3LiquidationPosition', 'productId'),
          signedPositionSize: BuiltValueNullFieldError.checkNotNull(
              signedPositionSize,
              r'Hip3LiquidationPosition',
              'signedPositionSize'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint

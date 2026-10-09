// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bstocks_order_continuation_preview.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$BstocksOrderContinuationPreview
    extends BstocksOrderContinuationPreview {
  @override
  final String boundOrderId;
  @override
  final OrderPreview preview;

  factory _$BstocksOrderContinuationPreview(
          [void Function(BstocksOrderContinuationPreviewBuilder)? updates]) =>
      (BstocksOrderContinuationPreviewBuilder()..update(updates))._build();

  _$BstocksOrderContinuationPreview._(
      {required this.boundOrderId, required this.preview})
      : super._();
  @override
  BstocksOrderContinuationPreview rebuild(
          void Function(BstocksOrderContinuationPreviewBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  BstocksOrderContinuationPreviewBuilder toBuilder() =>
      BstocksOrderContinuationPreviewBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is BstocksOrderContinuationPreview &&
        boundOrderId == other.boundOrderId &&
        preview == other.preview;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, boundOrderId.hashCode);
    _$hash = $jc(_$hash, preview.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'BstocksOrderContinuationPreview')
          ..add('boundOrderId', boundOrderId)
          ..add('preview', preview))
        .toString();
  }
}

class BstocksOrderContinuationPreviewBuilder
    implements
        Builder<BstocksOrderContinuationPreview,
            BstocksOrderContinuationPreviewBuilder> {
  _$BstocksOrderContinuationPreview? _$v;

  String? _boundOrderId;
  String? get boundOrderId => _$this._boundOrderId;
  set boundOrderId(String? boundOrderId) => _$this._boundOrderId = boundOrderId;

  OrderPreviewBuilder? _preview;
  OrderPreviewBuilder get preview => _$this._preview ??= OrderPreviewBuilder();
  set preview(OrderPreviewBuilder? preview) => _$this._preview = preview;

  BstocksOrderContinuationPreviewBuilder() {
    BstocksOrderContinuationPreview._defaults(this);
  }

  BstocksOrderContinuationPreviewBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _boundOrderId = $v.boundOrderId;
      _preview = $v.preview.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(BstocksOrderContinuationPreview other) {
    _$v = other as _$BstocksOrderContinuationPreview;
  }

  @override
  void update(void Function(BstocksOrderContinuationPreviewBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  BstocksOrderContinuationPreview build() => _build();

  _$BstocksOrderContinuationPreview _build() {
    _$BstocksOrderContinuationPreview _$result;
    try {
      _$result = _$v ??
          _$BstocksOrderContinuationPreview._(
            boundOrderId: BuiltValueNullFieldError.checkNotNull(boundOrderId,
                r'BstocksOrderContinuationPreview', 'boundOrderId'),
            preview: preview.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'preview';
        preview.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'BstocksOrderContinuationPreview', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint

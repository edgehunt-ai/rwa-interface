// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bstocks_order_action_create_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$BstocksOrderActionCreateRequest
    extends BstocksOrderActionCreateRequest {
  @override
  final String previewId;

  factory _$BstocksOrderActionCreateRequest(
          [void Function(BstocksOrderActionCreateRequestBuilder)? updates]) =>
      (BstocksOrderActionCreateRequestBuilder()..update(updates))._build();

  _$BstocksOrderActionCreateRequest._({required this.previewId}) : super._();
  @override
  BstocksOrderActionCreateRequest rebuild(
          void Function(BstocksOrderActionCreateRequestBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  BstocksOrderActionCreateRequestBuilder toBuilder() =>
      BstocksOrderActionCreateRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is BstocksOrderActionCreateRequest &&
        previewId == other.previewId;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, previewId.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'BstocksOrderActionCreateRequest')
          ..add('previewId', previewId))
        .toString();
  }
}

class BstocksOrderActionCreateRequestBuilder
    implements
        Builder<BstocksOrderActionCreateRequest,
            BstocksOrderActionCreateRequestBuilder> {
  _$BstocksOrderActionCreateRequest? _$v;

  String? _previewId;
  String? get previewId => _$this._previewId;
  set previewId(String? previewId) => _$this._previewId = previewId;

  BstocksOrderActionCreateRequestBuilder() {
    BstocksOrderActionCreateRequest._defaults(this);
  }

  BstocksOrderActionCreateRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _previewId = $v.previewId;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(BstocksOrderActionCreateRequest other) {
    _$v = other as _$BstocksOrderActionCreateRequest;
  }

  @override
  void update(void Function(BstocksOrderActionCreateRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  BstocksOrderActionCreateRequest build() => _build();

  _$BstocksOrderActionCreateRequest _build() {
    final _$result = _$v ??
        _$BstocksOrderActionCreateRequest._(
          previewId: BuiltValueNullFieldError.checkNotNull(
              previewId, r'BstocksOrderActionCreateRequest', 'previewId'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint

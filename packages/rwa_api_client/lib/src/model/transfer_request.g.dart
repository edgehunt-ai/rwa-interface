// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transfer_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$TransferRequest extends TransferRequest {
  @override
  final OneOf oneOf;

  factory _$TransferRequest([void Function(TransferRequestBuilder)? updates]) =>
      (TransferRequestBuilder()..update(updates))._build();

  _$TransferRequest._({required this.oneOf}) : super._();
  @override
  TransferRequest rebuild(void Function(TransferRequestBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  TransferRequestBuilder toBuilder() => TransferRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is TransferRequest && oneOf == other.oneOf;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, oneOf.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'TransferRequest')
          ..add('oneOf', oneOf))
        .toString();
  }
}

class TransferRequestBuilder
    implements Builder<TransferRequest, TransferRequestBuilder> {
  _$TransferRequest? _$v;

  OneOf? _oneOf;
  OneOf? get oneOf => _$this._oneOf;
  set oneOf(OneOf? oneOf) => _$this._oneOf = oneOf;

  TransferRequestBuilder() {
    TransferRequest._defaults(this);
  }

  TransferRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _oneOf = $v.oneOf;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(TransferRequest other) {
    _$v = other as _$TransferRequest;
  }

  @override
  void update(void Function(TransferRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  TransferRequest build() => _build();

  _$TransferRequest _build() {
    final _$result = _$v ??
        _$TransferRequest._(
          oneOf: BuiltValueNullFieldError.checkNotNull(
              oneOf, r'TransferRequest', 'oneOf'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint

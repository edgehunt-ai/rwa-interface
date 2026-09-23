// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'funding_session_create_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$FundingSessionCreateRequest extends FundingSessionCreateRequest {
  @override
  final OneOf oneOf;

  factory _$FundingSessionCreateRequest(
          [void Function(FundingSessionCreateRequestBuilder)? updates]) =>
      (FundingSessionCreateRequestBuilder()..update(updates))._build();

  _$FundingSessionCreateRequest._({required this.oneOf}) : super._();
  @override
  FundingSessionCreateRequest rebuild(
          void Function(FundingSessionCreateRequestBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  FundingSessionCreateRequestBuilder toBuilder() =>
      FundingSessionCreateRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is FundingSessionCreateRequest && oneOf == other.oneOf;
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
    return (newBuiltValueToStringHelper(r'FundingSessionCreateRequest')
          ..add('oneOf', oneOf))
        .toString();
  }
}

class FundingSessionCreateRequestBuilder
    implements
        Builder<FundingSessionCreateRequest,
            FundingSessionCreateRequestBuilder> {
  _$FundingSessionCreateRequest? _$v;

  OneOf? _oneOf;
  OneOf? get oneOf => _$this._oneOf;
  set oneOf(OneOf? oneOf) => _$this._oneOf = oneOf;

  FundingSessionCreateRequestBuilder() {
    FundingSessionCreateRequest._defaults(this);
  }

  FundingSessionCreateRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _oneOf = $v.oneOf;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(FundingSessionCreateRequest other) {
    _$v = other as _$FundingSessionCreateRequest;
  }

  @override
  void update(void Function(FundingSessionCreateRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  FundingSessionCreateRequest build() => _build();

  _$FundingSessionCreateRequest _build() {
    final _$result = _$v ??
        _$FundingSessionCreateRequest._(
          oneOf: BuiltValueNullFieldError.checkNotNull(
              oneOf, r'FundingSessionCreateRequest', 'oneOf'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint

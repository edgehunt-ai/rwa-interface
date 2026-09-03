// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hip3_challenge_complete_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$Hip3ChallengeCompleteRequest extends Hip3ChallengeCompleteRequest {
  @override
  final String signature;

  factory _$Hip3ChallengeCompleteRequest(
          [void Function(Hip3ChallengeCompleteRequestBuilder)? updates]) =>
      (Hip3ChallengeCompleteRequestBuilder()..update(updates))._build();

  _$Hip3ChallengeCompleteRequest._({required this.signature}) : super._();
  @override
  Hip3ChallengeCompleteRequest rebuild(
          void Function(Hip3ChallengeCompleteRequestBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  Hip3ChallengeCompleteRequestBuilder toBuilder() =>
      Hip3ChallengeCompleteRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Hip3ChallengeCompleteRequest &&
        signature == other.signature;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, signature.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'Hip3ChallengeCompleteRequest')
          ..add('signature', signature))
        .toString();
  }
}

class Hip3ChallengeCompleteRequestBuilder
    implements
        Builder<Hip3ChallengeCompleteRequest,
            Hip3ChallengeCompleteRequestBuilder> {
  _$Hip3ChallengeCompleteRequest? _$v;

  String? _signature;
  String? get signature => _$this._signature;
  set signature(String? signature) => _$this._signature = signature;

  Hip3ChallengeCompleteRequestBuilder() {
    Hip3ChallengeCompleteRequest._defaults(this);
  }

  Hip3ChallengeCompleteRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _signature = $v.signature;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Hip3ChallengeCompleteRequest other) {
    _$v = other as _$Hip3ChallengeCompleteRequest;
  }

  @override
  void update(void Function(Hip3ChallengeCompleteRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  Hip3ChallengeCompleteRequest build() => _build();

  _$Hip3ChallengeCompleteRequest _build() {
    final _$result = _$v ??
        _$Hip3ChallengeCompleteRequest._(
          signature: BuiltValueNullFieldError.checkNotNull(
              signature, r'Hip3ChallengeCompleteRequest', 'signature'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint

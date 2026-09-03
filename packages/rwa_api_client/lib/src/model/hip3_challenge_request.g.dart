// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hip3_challenge_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$Hip3ChallengeRequest extends Hip3ChallengeRequest {
  @override
  final String? label;

  factory _$Hip3ChallengeRequest(
          [void Function(Hip3ChallengeRequestBuilder)? updates]) =>
      (Hip3ChallengeRequestBuilder()..update(updates))._build();

  _$Hip3ChallengeRequest._({this.label}) : super._();
  @override
  Hip3ChallengeRequest rebuild(
          void Function(Hip3ChallengeRequestBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  Hip3ChallengeRequestBuilder toBuilder() =>
      Hip3ChallengeRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Hip3ChallengeRequest && label == other.label;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, label.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'Hip3ChallengeRequest')
          ..add('label', label))
        .toString();
  }
}

class Hip3ChallengeRequestBuilder
    implements Builder<Hip3ChallengeRequest, Hip3ChallengeRequestBuilder> {
  _$Hip3ChallengeRequest? _$v;

  String? _label;
  String? get label => _$this._label;
  set label(String? label) => _$this._label = label;

  Hip3ChallengeRequestBuilder() {
    Hip3ChallengeRequest._defaults(this);
  }

  Hip3ChallengeRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _label = $v.label;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Hip3ChallengeRequest other) {
    _$v = other as _$Hip3ChallengeRequest;
  }

  @override
  void update(void Function(Hip3ChallengeRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  Hip3ChallengeRequest build() => _build();

  _$Hip3ChallengeRequest _build() {
    final _$result = _$v ??
        _$Hip3ChallengeRequest._(
          label: label,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint

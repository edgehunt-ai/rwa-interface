// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hip3_action_submission_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$Hip3ActionSubmissionRequest extends Hip3ActionSubmissionRequest {
  @override
  final HyperliquidSignature signature;

  factory _$Hip3ActionSubmissionRequest(
          [void Function(Hip3ActionSubmissionRequestBuilder)? updates]) =>
      (Hip3ActionSubmissionRequestBuilder()..update(updates))._build();

  _$Hip3ActionSubmissionRequest._({required this.signature}) : super._();
  @override
  Hip3ActionSubmissionRequest rebuild(
          void Function(Hip3ActionSubmissionRequestBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  Hip3ActionSubmissionRequestBuilder toBuilder() =>
      Hip3ActionSubmissionRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Hip3ActionSubmissionRequest && signature == other.signature;
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
    return (newBuiltValueToStringHelper(r'Hip3ActionSubmissionRequest')
          ..add('signature', signature))
        .toString();
  }
}

class Hip3ActionSubmissionRequestBuilder
    implements
        Builder<Hip3ActionSubmissionRequest,
            Hip3ActionSubmissionRequestBuilder> {
  _$Hip3ActionSubmissionRequest? _$v;

  HyperliquidSignatureBuilder? _signature;
  HyperliquidSignatureBuilder get signature =>
      _$this._signature ??= HyperliquidSignatureBuilder();
  set signature(HyperliquidSignatureBuilder? signature) =>
      _$this._signature = signature;

  Hip3ActionSubmissionRequestBuilder() {
    Hip3ActionSubmissionRequest._defaults(this);
  }

  Hip3ActionSubmissionRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _signature = $v.signature.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Hip3ActionSubmissionRequest other) {
    _$v = other as _$Hip3ActionSubmissionRequest;
  }

  @override
  void update(void Function(Hip3ActionSubmissionRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  Hip3ActionSubmissionRequest build() => _build();

  _$Hip3ActionSubmissionRequest _build() {
    _$Hip3ActionSubmissionRequest _$result;
    try {
      _$result = _$v ??
          _$Hip3ActionSubmissionRequest._(
            signature: signature.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'signature';
        signature.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'Hip3ActionSubmissionRequest', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint

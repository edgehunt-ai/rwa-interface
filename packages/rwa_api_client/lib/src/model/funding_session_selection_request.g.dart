// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'funding_session_selection_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$FundingSessionSelectionRequest extends FundingSessionSelectionRequest {
  @override
  final int version;
  @override
  final BuiltSet<FundingSessionSourceAllocationInput> allocations;

  factory _$FundingSessionSelectionRequest(
          [void Function(FundingSessionSelectionRequestBuilder)? updates]) =>
      (FundingSessionSelectionRequestBuilder()..update(updates))._build();

  _$FundingSessionSelectionRequest._(
      {required this.version, required this.allocations})
      : super._();
  @override
  FundingSessionSelectionRequest rebuild(
          void Function(FundingSessionSelectionRequestBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  FundingSessionSelectionRequestBuilder toBuilder() =>
      FundingSessionSelectionRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is FundingSessionSelectionRequest &&
        version == other.version &&
        allocations == other.allocations;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, version.hashCode);
    _$hash = $jc(_$hash, allocations.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'FundingSessionSelectionRequest')
          ..add('version', version)
          ..add('allocations', allocations))
        .toString();
  }
}

class FundingSessionSelectionRequestBuilder
    implements
        Builder<FundingSessionSelectionRequest,
            FundingSessionSelectionRequestBuilder> {
  _$FundingSessionSelectionRequest? _$v;

  int? _version;
  int? get version => _$this._version;
  set version(int? version) => _$this._version = version;

  SetBuilder<FundingSessionSourceAllocationInput>? _allocations;
  SetBuilder<FundingSessionSourceAllocationInput> get allocations =>
      _$this._allocations ??= SetBuilder<FundingSessionSourceAllocationInput>();
  set allocations(
          SetBuilder<FundingSessionSourceAllocationInput>? allocations) =>
      _$this._allocations = allocations;

  FundingSessionSelectionRequestBuilder() {
    FundingSessionSelectionRequest._defaults(this);
  }

  FundingSessionSelectionRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _version = $v.version;
      _allocations = $v.allocations.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(FundingSessionSelectionRequest other) {
    _$v = other as _$FundingSessionSelectionRequest;
  }

  @override
  void update(void Function(FundingSessionSelectionRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  FundingSessionSelectionRequest build() => _build();

  _$FundingSessionSelectionRequest _build() {
    _$FundingSessionSelectionRequest _$result;
    try {
      _$result = _$v ??
          _$FundingSessionSelectionRequest._(
            version: BuiltValueNullFieldError.checkNotNull(
                version, r'FundingSessionSelectionRequest', 'version'),
            allocations: allocations.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'allocations';
        allocations.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'FundingSessionSelectionRequest', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint

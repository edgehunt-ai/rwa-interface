// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'funding_session_unavailable_sources_inner.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const FundingSessionUnavailableSourcesInnerFailureReasonEnum
    _$fundingSessionUnavailableSourcesInnerFailureReasonEnum_unavailable =
    const FundingSessionUnavailableSourcesInnerFailureReasonEnum._(
        'unavailable');
const FundingSessionUnavailableSourcesInnerFailureReasonEnum
    _$fundingSessionUnavailableSourcesInnerFailureReasonEnum_stale =
    const FundingSessionUnavailableSourcesInnerFailureReasonEnum._('stale');
const FundingSessionUnavailableSourcesInnerFailureReasonEnum
    _$fundingSessionUnavailableSourcesInnerFailureReasonEnum_invalid =
    const FundingSessionUnavailableSourcesInnerFailureReasonEnum._('invalid');

FundingSessionUnavailableSourcesInnerFailureReasonEnum
    _$fundingSessionUnavailableSourcesInnerFailureReasonEnumValueOf(
        String name) {
  switch (name) {
    case 'unavailable':
      return _$fundingSessionUnavailableSourcesInnerFailureReasonEnum_unavailable;
    case 'stale':
      return _$fundingSessionUnavailableSourcesInnerFailureReasonEnum_stale;
    case 'invalid':
      return _$fundingSessionUnavailableSourcesInnerFailureReasonEnum_invalid;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<FundingSessionUnavailableSourcesInnerFailureReasonEnum>
    _$fundingSessionUnavailableSourcesInnerFailureReasonEnumValues = BuiltSet<
        FundingSessionUnavailableSourcesInnerFailureReasonEnum>(const <FundingSessionUnavailableSourcesInnerFailureReasonEnum>[
  _$fundingSessionUnavailableSourcesInnerFailureReasonEnum_unavailable,
  _$fundingSessionUnavailableSourcesInnerFailureReasonEnum_stale,
  _$fundingSessionUnavailableSourcesInnerFailureReasonEnum_invalid,
]);

Serializer<FundingSessionUnavailableSourcesInnerFailureReasonEnum>
    _$fundingSessionUnavailableSourcesInnerFailureReasonEnumSerializer =
    _$FundingSessionUnavailableSourcesInnerFailureReasonEnumSerializer();

class _$FundingSessionUnavailableSourcesInnerFailureReasonEnumSerializer
    implements
        PrimitiveSerializer<
            FundingSessionUnavailableSourcesInnerFailureReasonEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'unavailable': 'unavailable',
    'stale': 'stale',
    'invalid': 'invalid',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'unavailable': 'unavailable',
    'stale': 'stale',
    'invalid': 'invalid',
  };

  @override
  final Iterable<Type> types = const <Type>[
    FundingSessionUnavailableSourcesInnerFailureReasonEnum
  ];
  @override
  final String wireName =
      'FundingSessionUnavailableSourcesInnerFailureReasonEnum';

  @override
  Object serialize(Serializers serializers,
          FundingSessionUnavailableSourcesInnerFailureReasonEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  FundingSessionUnavailableSourcesInnerFailureReasonEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      FundingSessionUnavailableSourcesInnerFailureReasonEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$FundingSessionUnavailableSourcesInner
    extends FundingSessionUnavailableSourcesInner {
  @override
  final FundingSourceAssetIdentity asset;
  @override
  final FundingSessionUnavailableSourcesInnerFailureReasonEnum failureReason;

  factory _$FundingSessionUnavailableSourcesInner(
          [void Function(FundingSessionUnavailableSourcesInnerBuilder)?
              updates]) =>
      (FundingSessionUnavailableSourcesInnerBuilder()..update(updates))
          ._build();

  _$FundingSessionUnavailableSourcesInner._(
      {required this.asset, required this.failureReason})
      : super._();
  @override
  FundingSessionUnavailableSourcesInner rebuild(
          void Function(FundingSessionUnavailableSourcesInnerBuilder)
              updates) =>
      (toBuilder()..update(updates)).build();

  @override
  FundingSessionUnavailableSourcesInnerBuilder toBuilder() =>
      FundingSessionUnavailableSourcesInnerBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is FundingSessionUnavailableSourcesInner &&
        asset == other.asset &&
        failureReason == other.failureReason;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, asset.hashCode);
    _$hash = $jc(_$hash, failureReason.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(
            r'FundingSessionUnavailableSourcesInner')
          ..add('asset', asset)
          ..add('failureReason', failureReason))
        .toString();
  }
}

class FundingSessionUnavailableSourcesInnerBuilder
    implements
        Builder<FundingSessionUnavailableSourcesInner,
            FundingSessionUnavailableSourcesInnerBuilder> {
  _$FundingSessionUnavailableSourcesInner? _$v;

  FundingSourceAssetIdentityBuilder? _asset;
  FundingSourceAssetIdentityBuilder get asset =>
      _$this._asset ??= FundingSourceAssetIdentityBuilder();
  set asset(FundingSourceAssetIdentityBuilder? asset) => _$this._asset = asset;

  FundingSessionUnavailableSourcesInnerFailureReasonEnum? _failureReason;
  FundingSessionUnavailableSourcesInnerFailureReasonEnum? get failureReason =>
      _$this._failureReason;
  set failureReason(
          FundingSessionUnavailableSourcesInnerFailureReasonEnum?
              failureReason) =>
      _$this._failureReason = failureReason;

  FundingSessionUnavailableSourcesInnerBuilder() {
    FundingSessionUnavailableSourcesInner._defaults(this);
  }

  FundingSessionUnavailableSourcesInnerBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _asset = $v.asset.toBuilder();
      _failureReason = $v.failureReason;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(FundingSessionUnavailableSourcesInner other) {
    _$v = other as _$FundingSessionUnavailableSourcesInner;
  }

  @override
  void update(
      void Function(FundingSessionUnavailableSourcesInnerBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  FundingSessionUnavailableSourcesInner build() => _build();

  _$FundingSessionUnavailableSourcesInner _build() {
    _$FundingSessionUnavailableSourcesInner _$result;
    try {
      _$result = _$v ??
          _$FundingSessionUnavailableSourcesInner._(
            asset: asset.build(),
            failureReason: BuiltValueNullFieldError.checkNotNull(failureReason,
                r'FundingSessionUnavailableSourcesInner', 'failureReason'),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'asset';
        asset.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'FundingSessionUnavailableSourcesInner',
            _$failedField,
            e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bstocks_preview_fee.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const BstocksPreviewFeeStatusEnum _$bstocksPreviewFeeStatusEnum_quoted =
    const BstocksPreviewFeeStatusEnum._('quoted');
const BstocksPreviewFeeStatusEnum _$bstocksPreviewFeeStatusEnum_unavailable =
    const BstocksPreviewFeeStatusEnum._('unavailable');
const BstocksPreviewFeeStatusEnum _$bstocksPreviewFeeStatusEnum_notEstimated =
    const BstocksPreviewFeeStatusEnum._('notEstimated');
const BstocksPreviewFeeStatusEnum
    _$bstocksPreviewFeeStatusEnum_unknownDefaultOpenApi =
    const BstocksPreviewFeeStatusEnum._('unknownDefaultOpenApi');

BstocksPreviewFeeStatusEnum _$bstocksPreviewFeeStatusEnumValueOf(String name) {
  switch (name) {
    case 'quoted':
      return _$bstocksPreviewFeeStatusEnum_quoted;
    case 'unavailable':
      return _$bstocksPreviewFeeStatusEnum_unavailable;
    case 'notEstimated':
      return _$bstocksPreviewFeeStatusEnum_notEstimated;
    case 'unknownDefaultOpenApi':
      return _$bstocksPreviewFeeStatusEnum_unknownDefaultOpenApi;
    default:
      return _$bstocksPreviewFeeStatusEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<BstocksPreviewFeeStatusEnum>
    _$bstocksPreviewFeeStatusEnumValues =
    BuiltSet<BstocksPreviewFeeStatusEnum>(const <BstocksPreviewFeeStatusEnum>[
  _$bstocksPreviewFeeStatusEnum_quoted,
  _$bstocksPreviewFeeStatusEnum_unavailable,
  _$bstocksPreviewFeeStatusEnum_notEstimated,
  _$bstocksPreviewFeeStatusEnum_unknownDefaultOpenApi,
]);

Serializer<BstocksPreviewFeeStatusEnum>
    _$bstocksPreviewFeeStatusEnumSerializer =
    _$BstocksPreviewFeeStatusEnumSerializer();

class _$BstocksPreviewFeeStatusEnumSerializer
    implements PrimitiveSerializer<BstocksPreviewFeeStatusEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'quoted': 'quoted',
    'unavailable': 'unavailable',
    'notEstimated': 'not_estimated',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'quoted': 'quoted',
    'unavailable': 'unavailable',
    'not_estimated': 'notEstimated',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[BstocksPreviewFeeStatusEnum];
  @override
  final String wireName = 'BstocksPreviewFeeStatusEnum';

  @override
  Object serialize(Serializers serializers, BstocksPreviewFeeStatusEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  BstocksPreviewFeeStatusEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      BstocksPreviewFeeStatusEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$BstocksPreviewFee extends BstocksPreviewFee {
  @override
  final BstocksPreviewFeeStatusEnum status;
  @override
  final BstocksFeeAsset asset;
  @override
  final String? amount;
  @override
  final String? ratePercent;
  @override
  final bool? includedInTotalInput;

  factory _$BstocksPreviewFee(
          [void Function(BstocksPreviewFeeBuilder)? updates]) =>
      (BstocksPreviewFeeBuilder()..update(updates))._build();

  _$BstocksPreviewFee._(
      {required this.status,
      required this.asset,
      this.amount,
      this.ratePercent,
      this.includedInTotalInput})
      : super._();
  @override
  BstocksPreviewFee rebuild(void Function(BstocksPreviewFeeBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  BstocksPreviewFeeBuilder toBuilder() =>
      BstocksPreviewFeeBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is BstocksPreviewFee &&
        status == other.status &&
        asset == other.asset &&
        amount == other.amount &&
        ratePercent == other.ratePercent &&
        includedInTotalInput == other.includedInTotalInput;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, status.hashCode);
    _$hash = $jc(_$hash, asset.hashCode);
    _$hash = $jc(_$hash, amount.hashCode);
    _$hash = $jc(_$hash, ratePercent.hashCode);
    _$hash = $jc(_$hash, includedInTotalInput.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'BstocksPreviewFee')
          ..add('status', status)
          ..add('asset', asset)
          ..add('amount', amount)
          ..add('ratePercent', ratePercent)
          ..add('includedInTotalInput', includedInTotalInput))
        .toString();
  }
}

class BstocksPreviewFeeBuilder
    implements Builder<BstocksPreviewFee, BstocksPreviewFeeBuilder> {
  _$BstocksPreviewFee? _$v;

  BstocksPreviewFeeStatusEnum? _status;
  BstocksPreviewFeeStatusEnum? get status => _$this._status;
  set status(BstocksPreviewFeeStatusEnum? status) => _$this._status = status;

  BstocksFeeAssetBuilder? _asset;
  BstocksFeeAssetBuilder get asset =>
      _$this._asset ??= BstocksFeeAssetBuilder();
  set asset(BstocksFeeAssetBuilder? asset) => _$this._asset = asset;

  String? _amount;
  String? get amount => _$this._amount;
  set amount(String? amount) => _$this._amount = amount;

  String? _ratePercent;
  String? get ratePercent => _$this._ratePercent;
  set ratePercent(String? ratePercent) => _$this._ratePercent = ratePercent;

  bool? _includedInTotalInput;
  bool? get includedInTotalInput => _$this._includedInTotalInput;
  set includedInTotalInput(bool? includedInTotalInput) =>
      _$this._includedInTotalInput = includedInTotalInput;

  BstocksPreviewFeeBuilder() {
    BstocksPreviewFee._defaults(this);
  }

  BstocksPreviewFeeBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _status = $v.status;
      _asset = $v.asset.toBuilder();
      _amount = $v.amount;
      _ratePercent = $v.ratePercent;
      _includedInTotalInput = $v.includedInTotalInput;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(BstocksPreviewFee other) {
    _$v = other as _$BstocksPreviewFee;
  }

  @override
  void update(void Function(BstocksPreviewFeeBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  BstocksPreviewFee build() => _build();

  _$BstocksPreviewFee _build() {
    _$BstocksPreviewFee _$result;
    try {
      _$result = _$v ??
          _$BstocksPreviewFee._(
            status: BuiltValueNullFieldError.checkNotNull(
                status, r'BstocksPreviewFee', 'status'),
            asset: asset.build(),
            amount: amount,
            ratePercent: ratePercent,
            includedInTotalInput: includedInTotalInput,
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'asset';
        asset.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'BstocksPreviewFee', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint

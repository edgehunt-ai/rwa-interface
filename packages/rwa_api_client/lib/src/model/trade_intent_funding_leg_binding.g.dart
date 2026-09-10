// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trade_intent_funding_leg_binding.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$TradeIntentFundingLegBinding extends TradeIntentFundingLegBinding {
  @override
  final String legId;
  @override
  final int ordinal;
  @override
  final String? transferId;
  @override
  final MultiSourceFundingLegStatus status;

  factory _$TradeIntentFundingLegBinding(
          [void Function(TradeIntentFundingLegBindingBuilder)? updates]) =>
      (TradeIntentFundingLegBindingBuilder()..update(updates))._build();

  _$TradeIntentFundingLegBinding._(
      {required this.legId,
      required this.ordinal,
      this.transferId,
      required this.status})
      : super._();
  @override
  TradeIntentFundingLegBinding rebuild(
          void Function(TradeIntentFundingLegBindingBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  TradeIntentFundingLegBindingBuilder toBuilder() =>
      TradeIntentFundingLegBindingBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is TradeIntentFundingLegBinding &&
        legId == other.legId &&
        ordinal == other.ordinal &&
        transferId == other.transferId &&
        status == other.status;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, legId.hashCode);
    _$hash = $jc(_$hash, ordinal.hashCode);
    _$hash = $jc(_$hash, transferId.hashCode);
    _$hash = $jc(_$hash, status.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'TradeIntentFundingLegBinding')
          ..add('legId', legId)
          ..add('ordinal', ordinal)
          ..add('transferId', transferId)
          ..add('status', status))
        .toString();
  }
}

class TradeIntentFundingLegBindingBuilder
    implements
        Builder<TradeIntentFundingLegBinding,
            TradeIntentFundingLegBindingBuilder> {
  _$TradeIntentFundingLegBinding? _$v;

  String? _legId;
  String? get legId => _$this._legId;
  set legId(String? legId) => _$this._legId = legId;

  int? _ordinal;
  int? get ordinal => _$this._ordinal;
  set ordinal(int? ordinal) => _$this._ordinal = ordinal;

  String? _transferId;
  String? get transferId => _$this._transferId;
  set transferId(String? transferId) => _$this._transferId = transferId;

  MultiSourceFundingLegStatus? _status;
  MultiSourceFundingLegStatus? get status => _$this._status;
  set status(MultiSourceFundingLegStatus? status) => _$this._status = status;

  TradeIntentFundingLegBindingBuilder() {
    TradeIntentFundingLegBinding._defaults(this);
  }

  TradeIntentFundingLegBindingBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _legId = $v.legId;
      _ordinal = $v.ordinal;
      _transferId = $v.transferId;
      _status = $v.status;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(TradeIntentFundingLegBinding other) {
    _$v = other as _$TradeIntentFundingLegBinding;
  }

  @override
  void update(void Function(TradeIntentFundingLegBindingBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  TradeIntentFundingLegBinding build() => _build();

  _$TradeIntentFundingLegBinding _build() {
    final _$result = _$v ??
        _$TradeIntentFundingLegBinding._(
          legId: BuiltValueNullFieldError.checkNotNull(
              legId, r'TradeIntentFundingLegBinding', 'legId'),
          ordinal: BuiltValueNullFieldError.checkNotNull(
              ordinal, r'TradeIntentFundingLegBinding', 'ordinal'),
          transferId: transferId,
          status: BuiltValueNullFieldError.checkNotNull(
              status, r'TradeIntentFundingLegBinding', 'status'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint

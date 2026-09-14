// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'deposit_instruction_item.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$DepositInstructionItem extends DepositInstructionItem {
  @override
  final FundingSourceAssetIdentity identity;
  @override
  final String minDeposit;
  @override
  final int confirmationsRequired;
  @override
  final int estimatedArrivalSeconds;
  @override
  final String? qrPayload;
  @override
  final DepositCreditTarget creditedTo;
  @override
  final DepositInstructionAvailability availability;
  @override
  final String warning;

  factory _$DepositInstructionItem(
          [void Function(DepositInstructionItemBuilder)? updates]) =>
      (DepositInstructionItemBuilder()..update(updates))._build();

  _$DepositInstructionItem._(
      {required this.identity,
      required this.minDeposit,
      required this.confirmationsRequired,
      required this.estimatedArrivalSeconds,
      this.qrPayload,
      required this.creditedTo,
      required this.availability,
      required this.warning})
      : super._();
  @override
  DepositInstructionItem rebuild(
          void Function(DepositInstructionItemBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  DepositInstructionItemBuilder toBuilder() =>
      DepositInstructionItemBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is DepositInstructionItem &&
        identity == other.identity &&
        minDeposit == other.minDeposit &&
        confirmationsRequired == other.confirmationsRequired &&
        estimatedArrivalSeconds == other.estimatedArrivalSeconds &&
        qrPayload == other.qrPayload &&
        creditedTo == other.creditedTo &&
        availability == other.availability &&
        warning == other.warning;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, identity.hashCode);
    _$hash = $jc(_$hash, minDeposit.hashCode);
    _$hash = $jc(_$hash, confirmationsRequired.hashCode);
    _$hash = $jc(_$hash, estimatedArrivalSeconds.hashCode);
    _$hash = $jc(_$hash, qrPayload.hashCode);
    _$hash = $jc(_$hash, creditedTo.hashCode);
    _$hash = $jc(_$hash, availability.hashCode);
    _$hash = $jc(_$hash, warning.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'DepositInstructionItem')
          ..add('identity', identity)
          ..add('minDeposit', minDeposit)
          ..add('confirmationsRequired', confirmationsRequired)
          ..add('estimatedArrivalSeconds', estimatedArrivalSeconds)
          ..add('qrPayload', qrPayload)
          ..add('creditedTo', creditedTo)
          ..add('availability', availability)
          ..add('warning', warning))
        .toString();
  }
}

class DepositInstructionItemBuilder
    implements Builder<DepositInstructionItem, DepositInstructionItemBuilder> {
  _$DepositInstructionItem? _$v;

  FundingSourceAssetIdentityBuilder? _identity;
  FundingSourceAssetIdentityBuilder get identity =>
      _$this._identity ??= FundingSourceAssetIdentityBuilder();
  set identity(FundingSourceAssetIdentityBuilder? identity) =>
      _$this._identity = identity;

  String? _minDeposit;
  String? get minDeposit => _$this._minDeposit;
  set minDeposit(String? minDeposit) => _$this._minDeposit = minDeposit;

  int? _confirmationsRequired;
  int? get confirmationsRequired => _$this._confirmationsRequired;
  set confirmationsRequired(int? confirmationsRequired) =>
      _$this._confirmationsRequired = confirmationsRequired;

  int? _estimatedArrivalSeconds;
  int? get estimatedArrivalSeconds => _$this._estimatedArrivalSeconds;
  set estimatedArrivalSeconds(int? estimatedArrivalSeconds) =>
      _$this._estimatedArrivalSeconds = estimatedArrivalSeconds;

  String? _qrPayload;
  String? get qrPayload => _$this._qrPayload;
  set qrPayload(String? qrPayload) => _$this._qrPayload = qrPayload;

  DepositCreditTarget? _creditedTo;
  DepositCreditTarget? get creditedTo => _$this._creditedTo;
  set creditedTo(DepositCreditTarget? creditedTo) =>
      _$this._creditedTo = creditedTo;

  DepositInstructionAvailabilityBuilder? _availability;
  DepositInstructionAvailabilityBuilder get availability =>
      _$this._availability ??= DepositInstructionAvailabilityBuilder();
  set availability(DepositInstructionAvailabilityBuilder? availability) =>
      _$this._availability = availability;

  String? _warning;
  String? get warning => _$this._warning;
  set warning(String? warning) => _$this._warning = warning;

  DepositInstructionItemBuilder() {
    DepositInstructionItem._defaults(this);
  }

  DepositInstructionItemBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _identity = $v.identity.toBuilder();
      _minDeposit = $v.minDeposit;
      _confirmationsRequired = $v.confirmationsRequired;
      _estimatedArrivalSeconds = $v.estimatedArrivalSeconds;
      _qrPayload = $v.qrPayload;
      _creditedTo = $v.creditedTo;
      _availability = $v.availability.toBuilder();
      _warning = $v.warning;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(DepositInstructionItem other) {
    _$v = other as _$DepositInstructionItem;
  }

  @override
  void update(void Function(DepositInstructionItemBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  DepositInstructionItem build() => _build();

  _$DepositInstructionItem _build() {
    _$DepositInstructionItem _$result;
    try {
      _$result = _$v ??
          _$DepositInstructionItem._(
            identity: identity.build(),
            minDeposit: BuiltValueNullFieldError.checkNotNull(
                minDeposit, r'DepositInstructionItem', 'minDeposit'),
            confirmationsRequired: BuiltValueNullFieldError.checkNotNull(
                confirmationsRequired,
                r'DepositInstructionItem',
                'confirmationsRequired'),
            estimatedArrivalSeconds: BuiltValueNullFieldError.checkNotNull(
                estimatedArrivalSeconds,
                r'DepositInstructionItem',
                'estimatedArrivalSeconds'),
            qrPayload: qrPayload,
            creditedTo: BuiltValueNullFieldError.checkNotNull(
                creditedTo, r'DepositInstructionItem', 'creditedTo'),
            availability: availability.build(),
            warning: BuiltValueNullFieldError.checkNotNull(
                warning, r'DepositInstructionItem', 'warning'),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'identity';
        identity.build();

        _$failedField = 'availability';
        availability.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'DepositInstructionItem', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint

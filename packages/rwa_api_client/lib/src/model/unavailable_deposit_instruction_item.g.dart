// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'unavailable_deposit_instruction_item.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$UnavailableDepositInstructionItem
    extends UnavailableDepositInstructionItem {
  @override
  final FundingSourceAssetIdentity identity;
  @override
  final String minDeposit;
  @override
  final int confirmationsRequired;
  @override
  final int estimatedArrivalSeconds;
  @override
  final DepositCreditTarget creditedTo;
  @override
  final UnavailableDepositRailAvailability availability;
  @override
  final String warning;

  factory _$UnavailableDepositInstructionItem(
          [void Function(UnavailableDepositInstructionItemBuilder)? updates]) =>
      (UnavailableDepositInstructionItemBuilder()..update(updates))._build();

  _$UnavailableDepositInstructionItem._(
      {required this.identity,
      required this.minDeposit,
      required this.confirmationsRequired,
      required this.estimatedArrivalSeconds,
      required this.creditedTo,
      required this.availability,
      required this.warning})
      : super._();
  @override
  UnavailableDepositInstructionItem rebuild(
          void Function(UnavailableDepositInstructionItemBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  UnavailableDepositInstructionItemBuilder toBuilder() =>
      UnavailableDepositInstructionItemBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is UnavailableDepositInstructionItem &&
        identity == other.identity &&
        minDeposit == other.minDeposit &&
        confirmationsRequired == other.confirmationsRequired &&
        estimatedArrivalSeconds == other.estimatedArrivalSeconds &&
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
    _$hash = $jc(_$hash, creditedTo.hashCode);
    _$hash = $jc(_$hash, availability.hashCode);
    _$hash = $jc(_$hash, warning.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'UnavailableDepositInstructionItem')
          ..add('identity', identity)
          ..add('minDeposit', minDeposit)
          ..add('confirmationsRequired', confirmationsRequired)
          ..add('estimatedArrivalSeconds', estimatedArrivalSeconds)
          ..add('creditedTo', creditedTo)
          ..add('availability', availability)
          ..add('warning', warning))
        .toString();
  }
}

class UnavailableDepositInstructionItemBuilder
    implements
        Builder<UnavailableDepositInstructionItem,
            UnavailableDepositInstructionItemBuilder> {
  _$UnavailableDepositInstructionItem? _$v;

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

  DepositCreditTarget? _creditedTo;
  DepositCreditTarget? get creditedTo => _$this._creditedTo;
  set creditedTo(DepositCreditTarget? creditedTo) =>
      _$this._creditedTo = creditedTo;

  UnavailableDepositRailAvailabilityBuilder? _availability;
  UnavailableDepositRailAvailabilityBuilder get availability =>
      _$this._availability ??= UnavailableDepositRailAvailabilityBuilder();
  set availability(UnavailableDepositRailAvailabilityBuilder? availability) =>
      _$this._availability = availability;

  String? _warning;
  String? get warning => _$this._warning;
  set warning(String? warning) => _$this._warning = warning;

  UnavailableDepositInstructionItemBuilder() {
    UnavailableDepositInstructionItem._defaults(this);
  }

  UnavailableDepositInstructionItemBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _identity = $v.identity.toBuilder();
      _minDeposit = $v.minDeposit;
      _confirmationsRequired = $v.confirmationsRequired;
      _estimatedArrivalSeconds = $v.estimatedArrivalSeconds;
      _creditedTo = $v.creditedTo;
      _availability = $v.availability.toBuilder();
      _warning = $v.warning;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(UnavailableDepositInstructionItem other) {
    _$v = other as _$UnavailableDepositInstructionItem;
  }

  @override
  void update(
      void Function(UnavailableDepositInstructionItemBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  UnavailableDepositInstructionItem build() => _build();

  _$UnavailableDepositInstructionItem _build() {
    _$UnavailableDepositInstructionItem _$result;
    try {
      _$result = _$v ??
          _$UnavailableDepositInstructionItem._(
            identity: identity.build(),
            minDeposit: BuiltValueNullFieldError.checkNotNull(
                minDeposit, r'UnavailableDepositInstructionItem', 'minDeposit'),
            confirmationsRequired: BuiltValueNullFieldError.checkNotNull(
                confirmationsRequired,
                r'UnavailableDepositInstructionItem',
                'confirmationsRequired'),
            estimatedArrivalSeconds: BuiltValueNullFieldError.checkNotNull(
                estimatedArrivalSeconds,
                r'UnavailableDepositInstructionItem',
                'estimatedArrivalSeconds'),
            creditedTo: BuiltValueNullFieldError.checkNotNull(
                creditedTo, r'UnavailableDepositInstructionItem', 'creditedTo'),
            availability: availability.build(),
            warning: BuiltValueNullFieldError.checkNotNull(
                warning, r'UnavailableDepositInstructionItem', 'warning'),
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
            r'UnavailableDepositInstructionItem', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint

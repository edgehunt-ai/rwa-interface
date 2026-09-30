// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'portfolio_account_allocation_item.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const PortfolioAccountAllocationItemAccountEnum
    _$portfolioAccountAllocationItemAccountEnum_spot =
    const PortfolioAccountAllocationItemAccountEnum._('spot');
const PortfolioAccountAllocationItemAccountEnum
    _$portfolioAccountAllocationItemAccountEnum_perps =
    const PortfolioAccountAllocationItemAccountEnum._('perps');

PortfolioAccountAllocationItemAccountEnum
    _$portfolioAccountAllocationItemAccountEnumValueOf(String name) {
  switch (name) {
    case 'spot':
      return _$portfolioAccountAllocationItemAccountEnum_spot;
    case 'perps':
      return _$portfolioAccountAllocationItemAccountEnum_perps;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<PortfolioAccountAllocationItemAccountEnum>
    _$portfolioAccountAllocationItemAccountEnumValues = BuiltSet<
        PortfolioAccountAllocationItemAccountEnum>(const <PortfolioAccountAllocationItemAccountEnum>[
  _$portfolioAccountAllocationItemAccountEnum_spot,
  _$portfolioAccountAllocationItemAccountEnum_perps,
]);

Serializer<PortfolioAccountAllocationItemAccountEnum>
    _$portfolioAccountAllocationItemAccountEnumSerializer =
    _$PortfolioAccountAllocationItemAccountEnumSerializer();

class _$PortfolioAccountAllocationItemAccountEnumSerializer
    implements PrimitiveSerializer<PortfolioAccountAllocationItemAccountEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'spot': 'spot',
    'perps': 'perps',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'spot': 'spot',
    'perps': 'perps',
  };

  @override
  final Iterable<Type> types = const <Type>[
    PortfolioAccountAllocationItemAccountEnum
  ];
  @override
  final String wireName = 'PortfolioAccountAllocationItemAccountEnum';

  @override
  Object serialize(Serializers serializers,
          PortfolioAccountAllocationItemAccountEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  PortfolioAccountAllocationItemAccountEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      PortfolioAccountAllocationItemAccountEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$PortfolioAccountAllocationItem extends PortfolioAccountAllocationItem {
  @override
  final PortfolioAccountAllocationItemAccountEnum account;
  @override
  final PortfolioAvailabilityStatus status;
  @override
  final String? valueUsd;
  @override
  final String? percent;
  @override
  final int unvaluedAssetCount;
  @override
  final PortfolioAccountAllocationBreakdown? breakdown;

  factory _$PortfolioAccountAllocationItem(
          [void Function(PortfolioAccountAllocationItemBuilder)? updates]) =>
      (PortfolioAccountAllocationItemBuilder()..update(updates))._build();

  _$PortfolioAccountAllocationItem._(
      {required this.account,
      required this.status,
      this.valueUsd,
      this.percent,
      required this.unvaluedAssetCount,
      this.breakdown})
      : super._();
  @override
  PortfolioAccountAllocationItem rebuild(
          void Function(PortfolioAccountAllocationItemBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  PortfolioAccountAllocationItemBuilder toBuilder() =>
      PortfolioAccountAllocationItemBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is PortfolioAccountAllocationItem &&
        account == other.account &&
        status == other.status &&
        valueUsd == other.valueUsd &&
        percent == other.percent &&
        unvaluedAssetCount == other.unvaluedAssetCount &&
        breakdown == other.breakdown;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, account.hashCode);
    _$hash = $jc(_$hash, status.hashCode);
    _$hash = $jc(_$hash, valueUsd.hashCode);
    _$hash = $jc(_$hash, percent.hashCode);
    _$hash = $jc(_$hash, unvaluedAssetCount.hashCode);
    _$hash = $jc(_$hash, breakdown.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'PortfolioAccountAllocationItem')
          ..add('account', account)
          ..add('status', status)
          ..add('valueUsd', valueUsd)
          ..add('percent', percent)
          ..add('unvaluedAssetCount', unvaluedAssetCount)
          ..add('breakdown', breakdown))
        .toString();
  }
}

class PortfolioAccountAllocationItemBuilder
    implements
        Builder<PortfolioAccountAllocationItem,
            PortfolioAccountAllocationItemBuilder> {
  _$PortfolioAccountAllocationItem? _$v;

  PortfolioAccountAllocationItemAccountEnum? _account;
  PortfolioAccountAllocationItemAccountEnum? get account => _$this._account;
  set account(PortfolioAccountAllocationItemAccountEnum? account) =>
      _$this._account = account;

  PortfolioAvailabilityStatus? _status;
  PortfolioAvailabilityStatus? get status => _$this._status;
  set status(PortfolioAvailabilityStatus? status) => _$this._status = status;

  String? _valueUsd;
  String? get valueUsd => _$this._valueUsd;
  set valueUsd(String? valueUsd) => _$this._valueUsd = valueUsd;

  String? _percent;
  String? get percent => _$this._percent;
  set percent(String? percent) => _$this._percent = percent;

  int? _unvaluedAssetCount;
  int? get unvaluedAssetCount => _$this._unvaluedAssetCount;
  set unvaluedAssetCount(int? unvaluedAssetCount) =>
      _$this._unvaluedAssetCount = unvaluedAssetCount;

  PortfolioAccountAllocationBreakdownBuilder? _breakdown;
  PortfolioAccountAllocationBreakdownBuilder get breakdown =>
      _$this._breakdown ??= PortfolioAccountAllocationBreakdownBuilder();
  set breakdown(PortfolioAccountAllocationBreakdownBuilder? breakdown) =>
      _$this._breakdown = breakdown;

  PortfolioAccountAllocationItemBuilder() {
    PortfolioAccountAllocationItem._defaults(this);
  }

  PortfolioAccountAllocationItemBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _account = $v.account;
      _status = $v.status;
      _valueUsd = $v.valueUsd;
      _percent = $v.percent;
      _unvaluedAssetCount = $v.unvaluedAssetCount;
      _breakdown = $v.breakdown?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(PortfolioAccountAllocationItem other) {
    _$v = other as _$PortfolioAccountAllocationItem;
  }

  @override
  void update(void Function(PortfolioAccountAllocationItemBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  PortfolioAccountAllocationItem build() => _build();

  _$PortfolioAccountAllocationItem _build() {
    _$PortfolioAccountAllocationItem _$result;
    try {
      _$result = _$v ??
          _$PortfolioAccountAllocationItem._(
            account: BuiltValueNullFieldError.checkNotNull(
                account, r'PortfolioAccountAllocationItem', 'account'),
            status: BuiltValueNullFieldError.checkNotNull(
                status, r'PortfolioAccountAllocationItem', 'status'),
            valueUsd: valueUsd,
            percent: percent,
            unvaluedAssetCount: BuiltValueNullFieldError.checkNotNull(
                unvaluedAssetCount,
                r'PortfolioAccountAllocationItem',
                'unvaluedAssetCount'),
            breakdown: _breakdown?.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'breakdown';
        _breakdown?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'PortfolioAccountAllocationItem', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint

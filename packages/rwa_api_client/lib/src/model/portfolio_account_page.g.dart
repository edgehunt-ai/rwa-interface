// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'portfolio_account_page.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const PortfolioAccountPageScopeEnum _$portfolioAccountPageScopeEnum_portfolio =
    const PortfolioAccountPageScopeEnum._('portfolio');
const PortfolioAccountPageScopeEnum
    _$portfolioAccountPageScopeEnum_unknownDefaultOpenApi =
    const PortfolioAccountPageScopeEnum._('unknownDefaultOpenApi');

PortfolioAccountPageScopeEnum _$portfolioAccountPageScopeEnumValueOf(
    String name) {
  switch (name) {
    case 'portfolio':
      return _$portfolioAccountPageScopeEnum_portfolio;
    case 'unknownDefaultOpenApi':
      return _$portfolioAccountPageScopeEnum_unknownDefaultOpenApi;
    default:
      return _$portfolioAccountPageScopeEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<PortfolioAccountPageScopeEnum>
    _$portfolioAccountPageScopeEnumValues = BuiltSet<
        PortfolioAccountPageScopeEnum>(const <PortfolioAccountPageScopeEnum>[
  _$portfolioAccountPageScopeEnum_portfolio,
  _$portfolioAccountPageScopeEnum_unknownDefaultOpenApi,
]);

Serializer<PortfolioAccountPageScopeEnum>
    _$portfolioAccountPageScopeEnumSerializer =
    _$PortfolioAccountPageScopeEnumSerializer();

class _$PortfolioAccountPageScopeEnumSerializer
    implements PrimitiveSerializer<PortfolioAccountPageScopeEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'portfolio': 'portfolio',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'portfolio': 'portfolio',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[PortfolioAccountPageScopeEnum];
  @override
  final String wireName = 'PortfolioAccountPageScopeEnum';

  @override
  Object serialize(
          Serializers serializers, PortfolioAccountPageScopeEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  PortfolioAccountPageScopeEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      PortfolioAccountPageScopeEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$PortfolioAccountPage extends PortfolioAccountPage {
  @override
  final PortfolioAccountPageScopeEnum scope;
  @override
  final BuiltList<AccountBalance> items;
  @override
  final PortfolioDataStatus dataStatus;
  @override
  final PortfolioFreshness freshness;
  @override
  final DateTime calculatedAt;
  @override
  final DateTime? oldestObservationAt;
  @override
  final BuiltList<PortfolioNotice> warnings;
  @override
  final BuiltList<PortfolioSourceSummary> sources;

  factory _$PortfolioAccountPage(
          [void Function(PortfolioAccountPageBuilder)? updates]) =>
      (PortfolioAccountPageBuilder()..update(updates))._build();

  _$PortfolioAccountPage._(
      {required this.scope,
      required this.items,
      required this.dataStatus,
      required this.freshness,
      required this.calculatedAt,
      this.oldestObservationAt,
      required this.warnings,
      required this.sources})
      : super._();
  @override
  PortfolioAccountPage rebuild(
          void Function(PortfolioAccountPageBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  PortfolioAccountPageBuilder toBuilder() =>
      PortfolioAccountPageBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is PortfolioAccountPage &&
        scope == other.scope &&
        items == other.items &&
        dataStatus == other.dataStatus &&
        freshness == other.freshness &&
        calculatedAt == other.calculatedAt &&
        oldestObservationAt == other.oldestObservationAt &&
        warnings == other.warnings &&
        sources == other.sources;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, scope.hashCode);
    _$hash = $jc(_$hash, items.hashCode);
    _$hash = $jc(_$hash, dataStatus.hashCode);
    _$hash = $jc(_$hash, freshness.hashCode);
    _$hash = $jc(_$hash, calculatedAt.hashCode);
    _$hash = $jc(_$hash, oldestObservationAt.hashCode);
    _$hash = $jc(_$hash, warnings.hashCode);
    _$hash = $jc(_$hash, sources.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'PortfolioAccountPage')
          ..add('scope', scope)
          ..add('items', items)
          ..add('dataStatus', dataStatus)
          ..add('freshness', freshness)
          ..add('calculatedAt', calculatedAt)
          ..add('oldestObservationAt', oldestObservationAt)
          ..add('warnings', warnings)
          ..add('sources', sources))
        .toString();
  }
}

class PortfolioAccountPageBuilder
    implements Builder<PortfolioAccountPage, PortfolioAccountPageBuilder> {
  _$PortfolioAccountPage? _$v;

  PortfolioAccountPageScopeEnum? _scope;
  PortfolioAccountPageScopeEnum? get scope => _$this._scope;
  set scope(PortfolioAccountPageScopeEnum? scope) => _$this._scope = scope;

  ListBuilder<AccountBalance>? _items;
  ListBuilder<AccountBalance> get items =>
      _$this._items ??= ListBuilder<AccountBalance>();
  set items(ListBuilder<AccountBalance>? items) => _$this._items = items;

  PortfolioDataStatus? _dataStatus;
  PortfolioDataStatus? get dataStatus => _$this._dataStatus;
  set dataStatus(PortfolioDataStatus? dataStatus) =>
      _$this._dataStatus = dataStatus;

  PortfolioFreshness? _freshness;
  PortfolioFreshness? get freshness => _$this._freshness;
  set freshness(PortfolioFreshness? freshness) => _$this._freshness = freshness;

  DateTime? _calculatedAt;
  DateTime? get calculatedAt => _$this._calculatedAt;
  set calculatedAt(DateTime? calculatedAt) =>
      _$this._calculatedAt = calculatedAt;

  DateTime? _oldestObservationAt;
  DateTime? get oldestObservationAt => _$this._oldestObservationAt;
  set oldestObservationAt(DateTime? oldestObservationAt) =>
      _$this._oldestObservationAt = oldestObservationAt;

  ListBuilder<PortfolioNotice>? _warnings;
  ListBuilder<PortfolioNotice> get warnings =>
      _$this._warnings ??= ListBuilder<PortfolioNotice>();
  set warnings(ListBuilder<PortfolioNotice>? warnings) =>
      _$this._warnings = warnings;

  ListBuilder<PortfolioSourceSummary>? _sources;
  ListBuilder<PortfolioSourceSummary> get sources =>
      _$this._sources ??= ListBuilder<PortfolioSourceSummary>();
  set sources(ListBuilder<PortfolioSourceSummary>? sources) =>
      _$this._sources = sources;

  PortfolioAccountPageBuilder() {
    PortfolioAccountPage._defaults(this);
  }

  PortfolioAccountPageBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _scope = $v.scope;
      _items = $v.items.toBuilder();
      _dataStatus = $v.dataStatus;
      _freshness = $v.freshness;
      _calculatedAt = $v.calculatedAt;
      _oldestObservationAt = $v.oldestObservationAt;
      _warnings = $v.warnings.toBuilder();
      _sources = $v.sources.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(PortfolioAccountPage other) {
    _$v = other as _$PortfolioAccountPage;
  }

  @override
  void update(void Function(PortfolioAccountPageBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  PortfolioAccountPage build() => _build();

  _$PortfolioAccountPage _build() {
    _$PortfolioAccountPage _$result;
    try {
      _$result = _$v ??
          _$PortfolioAccountPage._(
            scope: BuiltValueNullFieldError.checkNotNull(
                scope, r'PortfolioAccountPage', 'scope'),
            items: items.build(),
            dataStatus: BuiltValueNullFieldError.checkNotNull(
                dataStatus, r'PortfolioAccountPage', 'dataStatus'),
            freshness: BuiltValueNullFieldError.checkNotNull(
                freshness, r'PortfolioAccountPage', 'freshness'),
            calculatedAt: BuiltValueNullFieldError.checkNotNull(
                calculatedAt, r'PortfolioAccountPage', 'calculatedAt'),
            oldestObservationAt: oldestObservationAt,
            warnings: warnings.build(),
            sources: sources.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'items';
        items.build();

        _$failedField = 'warnings';
        warnings.build();
        _$failedField = 'sources';
        sources.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'PortfolioAccountPage', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint

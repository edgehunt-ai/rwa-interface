// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'portfolio_account_page.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const PortfolioAccountPageScopeEnum
    _$portfolioAccountPageScopeEnum_internalLedger =
    const PortfolioAccountPageScopeEnum._('internalLedger');
const PortfolioAccountPageScopeEnum
    _$portfolioAccountPageScopeEnum_unknownDefaultOpenApi =
    const PortfolioAccountPageScopeEnum._('unknownDefaultOpenApi');

PortfolioAccountPageScopeEnum _$portfolioAccountPageScopeEnumValueOf(
    String name) {
  switch (name) {
    case 'internalLedger':
      return _$portfolioAccountPageScopeEnum_internalLedger;
    case 'unknownDefaultOpenApi':
      return _$portfolioAccountPageScopeEnum_unknownDefaultOpenApi;
    default:
      return _$portfolioAccountPageScopeEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<PortfolioAccountPageScopeEnum>
    _$portfolioAccountPageScopeEnumValues = BuiltSet<
        PortfolioAccountPageScopeEnum>(const <PortfolioAccountPageScopeEnum>[
  _$portfolioAccountPageScopeEnum_internalLedger,
  _$portfolioAccountPageScopeEnum_unknownDefaultOpenApi,
]);

Serializer<PortfolioAccountPageScopeEnum>
    _$portfolioAccountPageScopeEnumSerializer =
    _$PortfolioAccountPageScopeEnumSerializer();

class _$PortfolioAccountPageScopeEnumSerializer
    implements PrimitiveSerializer<PortfolioAccountPageScopeEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'internalLedger': 'internal_ledger',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'internal_ledger': 'internalLedger',
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
  final bool reconciled;
  @override
  final PortfolioFreshness freshness;
  @override
  final BuiltList<PortfolioNotice> blockers;

  factory _$PortfolioAccountPage(
          [void Function(PortfolioAccountPageBuilder)? updates]) =>
      (PortfolioAccountPageBuilder()..update(updates))._build();

  _$PortfolioAccountPage._(
      {required this.scope,
      required this.items,
      required this.reconciled,
      required this.freshness,
      required this.blockers})
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
        reconciled == other.reconciled &&
        freshness == other.freshness &&
        blockers == other.blockers;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, scope.hashCode);
    _$hash = $jc(_$hash, items.hashCode);
    _$hash = $jc(_$hash, reconciled.hashCode);
    _$hash = $jc(_$hash, freshness.hashCode);
    _$hash = $jc(_$hash, blockers.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'PortfolioAccountPage')
          ..add('scope', scope)
          ..add('items', items)
          ..add('reconciled', reconciled)
          ..add('freshness', freshness)
          ..add('blockers', blockers))
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

  bool? _reconciled;
  bool? get reconciled => _$this._reconciled;
  set reconciled(bool? reconciled) => _$this._reconciled = reconciled;

  PortfolioFreshness? _freshness;
  PortfolioFreshness? get freshness => _$this._freshness;
  set freshness(PortfolioFreshness? freshness) => _$this._freshness = freshness;

  ListBuilder<PortfolioNotice>? _blockers;
  ListBuilder<PortfolioNotice> get blockers =>
      _$this._blockers ??= ListBuilder<PortfolioNotice>();
  set blockers(ListBuilder<PortfolioNotice>? blockers) =>
      _$this._blockers = blockers;

  PortfolioAccountPageBuilder() {
    PortfolioAccountPage._defaults(this);
  }

  PortfolioAccountPageBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _scope = $v.scope;
      _items = $v.items.toBuilder();
      _reconciled = $v.reconciled;
      _freshness = $v.freshness;
      _blockers = $v.blockers.toBuilder();
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
            reconciled: BuiltValueNullFieldError.checkNotNull(
                reconciled, r'PortfolioAccountPage', 'reconciled'),
            freshness: BuiltValueNullFieldError.checkNotNull(
                freshness, r'PortfolioAccountPage', 'freshness'),
            blockers: blockers.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'items';
        items.build();

        _$failedField = 'blockers';
        blockers.build();
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

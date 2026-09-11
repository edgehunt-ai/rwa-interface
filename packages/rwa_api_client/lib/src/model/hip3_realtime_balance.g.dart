// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hip3_realtime_balance.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const Hip3RealtimeBalanceScopeEnum
    _$hip3RealtimeBalanceScopeEnum_hyperliquidWallet =
    const Hip3RealtimeBalanceScopeEnum._('hyperliquidWallet');
const Hip3RealtimeBalanceScopeEnum
    _$hip3RealtimeBalanceScopeEnum_unknownDefaultOpenApi =
    const Hip3RealtimeBalanceScopeEnum._('unknownDefaultOpenApi');

Hip3RealtimeBalanceScopeEnum _$hip3RealtimeBalanceScopeEnumValueOf(
    String name) {
  switch (name) {
    case 'hyperliquidWallet':
      return _$hip3RealtimeBalanceScopeEnum_hyperliquidWallet;
    case 'unknownDefaultOpenApi':
      return _$hip3RealtimeBalanceScopeEnum_unknownDefaultOpenApi;
    default:
      return _$hip3RealtimeBalanceScopeEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<Hip3RealtimeBalanceScopeEnum>
    _$hip3RealtimeBalanceScopeEnumValues =
    BuiltSet<Hip3RealtimeBalanceScopeEnum>(const <Hip3RealtimeBalanceScopeEnum>[
  _$hip3RealtimeBalanceScopeEnum_hyperliquidWallet,
  _$hip3RealtimeBalanceScopeEnum_unknownDefaultOpenApi,
]);

Serializer<Hip3RealtimeBalanceScopeEnum>
    _$hip3RealtimeBalanceScopeEnumSerializer =
    _$Hip3RealtimeBalanceScopeEnumSerializer();

class _$Hip3RealtimeBalanceScopeEnumSerializer
    implements PrimitiveSerializer<Hip3RealtimeBalanceScopeEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'hyperliquidWallet': 'hyperliquid_wallet',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'hyperliquid_wallet': 'hyperliquidWallet',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[Hip3RealtimeBalanceScopeEnum];
  @override
  final String wireName = 'Hip3RealtimeBalanceScopeEnum';

  @override
  Object serialize(Serializers serializers, Hip3RealtimeBalanceScopeEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  Hip3RealtimeBalanceScopeEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      Hip3RealtimeBalanceScopeEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$Hip3RealtimeBalance extends Hip3RealtimeBalance {
  @override
  final Hip3RealtimeBalanceScopeEnum scope;
  @override
  final String signer;
  @override
  final Hip3Environment environment;
  @override
  final PortfolioSummary summary;
  @override
  final BuiltList<PortfolioAsset> assets;

  factory _$Hip3RealtimeBalance(
          [void Function(Hip3RealtimeBalanceBuilder)? updates]) =>
      (Hip3RealtimeBalanceBuilder()..update(updates))._build();

  _$Hip3RealtimeBalance._(
      {required this.scope,
      required this.signer,
      required this.environment,
      required this.summary,
      required this.assets})
      : super._();
  @override
  Hip3RealtimeBalance rebuild(
          void Function(Hip3RealtimeBalanceBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  Hip3RealtimeBalanceBuilder toBuilder() =>
      Hip3RealtimeBalanceBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Hip3RealtimeBalance &&
        scope == other.scope &&
        signer == other.signer &&
        environment == other.environment &&
        summary == other.summary &&
        assets == other.assets;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, scope.hashCode);
    _$hash = $jc(_$hash, signer.hashCode);
    _$hash = $jc(_$hash, environment.hashCode);
    _$hash = $jc(_$hash, summary.hashCode);
    _$hash = $jc(_$hash, assets.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'Hip3RealtimeBalance')
          ..add('scope', scope)
          ..add('signer', signer)
          ..add('environment', environment)
          ..add('summary', summary)
          ..add('assets', assets))
        .toString();
  }
}

class Hip3RealtimeBalanceBuilder
    implements Builder<Hip3RealtimeBalance, Hip3RealtimeBalanceBuilder> {
  _$Hip3RealtimeBalance? _$v;

  Hip3RealtimeBalanceScopeEnum? _scope;
  Hip3RealtimeBalanceScopeEnum? get scope => _$this._scope;
  set scope(Hip3RealtimeBalanceScopeEnum? scope) => _$this._scope = scope;

  String? _signer;
  String? get signer => _$this._signer;
  set signer(String? signer) => _$this._signer = signer;

  Hip3Environment? _environment;
  Hip3Environment? get environment => _$this._environment;
  set environment(Hip3Environment? environment) =>
      _$this._environment = environment;

  PortfolioSummaryBuilder? _summary;
  PortfolioSummaryBuilder get summary =>
      _$this._summary ??= PortfolioSummaryBuilder();
  set summary(PortfolioSummaryBuilder? summary) => _$this._summary = summary;

  ListBuilder<PortfolioAsset>? _assets;
  ListBuilder<PortfolioAsset> get assets =>
      _$this._assets ??= ListBuilder<PortfolioAsset>();
  set assets(ListBuilder<PortfolioAsset>? assets) => _$this._assets = assets;

  Hip3RealtimeBalanceBuilder() {
    Hip3RealtimeBalance._defaults(this);
  }

  Hip3RealtimeBalanceBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _scope = $v.scope;
      _signer = $v.signer;
      _environment = $v.environment;
      _summary = $v.summary.toBuilder();
      _assets = $v.assets.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Hip3RealtimeBalance other) {
    _$v = other as _$Hip3RealtimeBalance;
  }

  @override
  void update(void Function(Hip3RealtimeBalanceBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  Hip3RealtimeBalance build() => _build();

  _$Hip3RealtimeBalance _build() {
    _$Hip3RealtimeBalance _$result;
    try {
      _$result = _$v ??
          _$Hip3RealtimeBalance._(
            scope: BuiltValueNullFieldError.checkNotNull(
                scope, r'Hip3RealtimeBalance', 'scope'),
            signer: BuiltValueNullFieldError.checkNotNull(
                signer, r'Hip3RealtimeBalance', 'signer'),
            environment: BuiltValueNullFieldError.checkNotNull(
                environment, r'Hip3RealtimeBalance', 'environment'),
            summary: summary.build(),
            assets: assets.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'summary';
        summary.build();
        _$failedField = 'assets';
        assets.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'Hip3RealtimeBalance', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint

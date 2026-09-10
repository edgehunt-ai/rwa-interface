// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'portfolio_holding_page_all_of_coverage.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const PortfolioHoldingPageAllOfCoverageScopeEnum
    _$portfolioHoldingPageAllOfCoverageScopeEnum_hip3 =
    const PortfolioHoldingPageAllOfCoverageScopeEnum._('hip3');
const PortfolioHoldingPageAllOfCoverageScopeEnum
    _$portfolioHoldingPageAllOfCoverageScopeEnum_unknownDefaultOpenApi =
    const PortfolioHoldingPageAllOfCoverageScopeEnum._('unknownDefaultOpenApi');

PortfolioHoldingPageAllOfCoverageScopeEnum
    _$portfolioHoldingPageAllOfCoverageScopeEnumValueOf(String name) {
  switch (name) {
    case 'hip3':
      return _$portfolioHoldingPageAllOfCoverageScopeEnum_hip3;
    case 'unknownDefaultOpenApi':
      return _$portfolioHoldingPageAllOfCoverageScopeEnum_unknownDefaultOpenApi;
    default:
      return _$portfolioHoldingPageAllOfCoverageScopeEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<PortfolioHoldingPageAllOfCoverageScopeEnum>
    _$portfolioHoldingPageAllOfCoverageScopeEnumValues = BuiltSet<
        PortfolioHoldingPageAllOfCoverageScopeEnum>(const <PortfolioHoldingPageAllOfCoverageScopeEnum>[
  _$portfolioHoldingPageAllOfCoverageScopeEnum_hip3,
  _$portfolioHoldingPageAllOfCoverageScopeEnum_unknownDefaultOpenApi,
]);

Serializer<PortfolioHoldingPageAllOfCoverageScopeEnum>
    _$portfolioHoldingPageAllOfCoverageScopeEnumSerializer =
    _$PortfolioHoldingPageAllOfCoverageScopeEnumSerializer();

class _$PortfolioHoldingPageAllOfCoverageScopeEnumSerializer
    implements PrimitiveSerializer<PortfolioHoldingPageAllOfCoverageScopeEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'hip3': 'hip3',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'hip3': 'hip3',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[
    PortfolioHoldingPageAllOfCoverageScopeEnum
  ];
  @override
  final String wireName = 'PortfolioHoldingPageAllOfCoverageScopeEnum';

  @override
  Object serialize(Serializers serializers,
          PortfolioHoldingPageAllOfCoverageScopeEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  PortfolioHoldingPageAllOfCoverageScopeEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      PortfolioHoldingPageAllOfCoverageScopeEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$PortfolioHoldingPageAllOfCoverage
    extends PortfolioHoldingPageAllOfCoverage {
  @override
  final PortfolioHoldingPageAllOfCoverageScopeEnum scope;
  @override
  final int observedPositionCount;
  @override
  final int displayedPositionCount;
  @override
  final int unmappedPositionCount;
  @override
  final int? excludedNonHip3PositionCount;

  factory _$PortfolioHoldingPageAllOfCoverage(
          [void Function(PortfolioHoldingPageAllOfCoverageBuilder)? updates]) =>
      (PortfolioHoldingPageAllOfCoverageBuilder()..update(updates))._build();

  _$PortfolioHoldingPageAllOfCoverage._(
      {required this.scope,
      required this.observedPositionCount,
      required this.displayedPositionCount,
      required this.unmappedPositionCount,
      this.excludedNonHip3PositionCount})
      : super._();
  @override
  PortfolioHoldingPageAllOfCoverage rebuild(
          void Function(PortfolioHoldingPageAllOfCoverageBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  PortfolioHoldingPageAllOfCoverageBuilder toBuilder() =>
      PortfolioHoldingPageAllOfCoverageBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is PortfolioHoldingPageAllOfCoverage &&
        scope == other.scope &&
        observedPositionCount == other.observedPositionCount &&
        displayedPositionCount == other.displayedPositionCount &&
        unmappedPositionCount == other.unmappedPositionCount &&
        excludedNonHip3PositionCount == other.excludedNonHip3PositionCount;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, scope.hashCode);
    _$hash = $jc(_$hash, observedPositionCount.hashCode);
    _$hash = $jc(_$hash, displayedPositionCount.hashCode);
    _$hash = $jc(_$hash, unmappedPositionCount.hashCode);
    _$hash = $jc(_$hash, excludedNonHip3PositionCount.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'PortfolioHoldingPageAllOfCoverage')
          ..add('scope', scope)
          ..add('observedPositionCount', observedPositionCount)
          ..add('displayedPositionCount', displayedPositionCount)
          ..add('unmappedPositionCount', unmappedPositionCount)
          ..add('excludedNonHip3PositionCount', excludedNonHip3PositionCount))
        .toString();
  }
}

class PortfolioHoldingPageAllOfCoverageBuilder
    implements
        Builder<PortfolioHoldingPageAllOfCoverage,
            PortfolioHoldingPageAllOfCoverageBuilder> {
  _$PortfolioHoldingPageAllOfCoverage? _$v;

  PortfolioHoldingPageAllOfCoverageScopeEnum? _scope;
  PortfolioHoldingPageAllOfCoverageScopeEnum? get scope => _$this._scope;
  set scope(PortfolioHoldingPageAllOfCoverageScopeEnum? scope) =>
      _$this._scope = scope;

  int? _observedPositionCount;
  int? get observedPositionCount => _$this._observedPositionCount;
  set observedPositionCount(int? observedPositionCount) =>
      _$this._observedPositionCount = observedPositionCount;

  int? _displayedPositionCount;
  int? get displayedPositionCount => _$this._displayedPositionCount;
  set displayedPositionCount(int? displayedPositionCount) =>
      _$this._displayedPositionCount = displayedPositionCount;

  int? _unmappedPositionCount;
  int? get unmappedPositionCount => _$this._unmappedPositionCount;
  set unmappedPositionCount(int? unmappedPositionCount) =>
      _$this._unmappedPositionCount = unmappedPositionCount;

  int? _excludedNonHip3PositionCount;
  int? get excludedNonHip3PositionCount => _$this._excludedNonHip3PositionCount;
  set excludedNonHip3PositionCount(int? excludedNonHip3PositionCount) =>
      _$this._excludedNonHip3PositionCount = excludedNonHip3PositionCount;

  PortfolioHoldingPageAllOfCoverageBuilder() {
    PortfolioHoldingPageAllOfCoverage._defaults(this);
  }

  PortfolioHoldingPageAllOfCoverageBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _scope = $v.scope;
      _observedPositionCount = $v.observedPositionCount;
      _displayedPositionCount = $v.displayedPositionCount;
      _unmappedPositionCount = $v.unmappedPositionCount;
      _excludedNonHip3PositionCount = $v.excludedNonHip3PositionCount;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(PortfolioHoldingPageAllOfCoverage other) {
    _$v = other as _$PortfolioHoldingPageAllOfCoverage;
  }

  @override
  void update(
      void Function(PortfolioHoldingPageAllOfCoverageBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  PortfolioHoldingPageAllOfCoverage build() => _build();

  _$PortfolioHoldingPageAllOfCoverage _build() {
    final _$result = _$v ??
        _$PortfolioHoldingPageAllOfCoverage._(
          scope: BuiltValueNullFieldError.checkNotNull(
              scope, r'PortfolioHoldingPageAllOfCoverage', 'scope'),
          observedPositionCount: BuiltValueNullFieldError.checkNotNull(
              observedPositionCount,
              r'PortfolioHoldingPageAllOfCoverage',
              'observedPositionCount'),
          displayedPositionCount: BuiltValueNullFieldError.checkNotNull(
              displayedPositionCount,
              r'PortfolioHoldingPageAllOfCoverage',
              'displayedPositionCount'),
          unmappedPositionCount: BuiltValueNullFieldError.checkNotNull(
              unmappedPositionCount,
              r'PortfolioHoldingPageAllOfCoverage',
              'unmappedPositionCount'),
          excludedNonHip3PositionCount: excludedNonHip3PositionCount,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint

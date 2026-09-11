// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hip3_funding_payment_page.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const Hip3FundingPaymentPageQuerySourceEnum
    _$hip3FundingPaymentPageQuerySourceEnum_live =
    const Hip3FundingPaymentPageQuerySourceEnum._('live');
const Hip3FundingPaymentPageQuerySourceEnum
    _$hip3FundingPaymentPageQuerySourceEnum_archive =
    const Hip3FundingPaymentPageQuerySourceEnum._('archive');
const Hip3FundingPaymentPageQuerySourceEnum
    _$hip3FundingPaymentPageQuerySourceEnum_unknownDefaultOpenApi =
    const Hip3FundingPaymentPageQuerySourceEnum._('unknownDefaultOpenApi');

Hip3FundingPaymentPageQuerySourceEnum
    _$hip3FundingPaymentPageQuerySourceEnumValueOf(String name) {
  switch (name) {
    case 'live':
      return _$hip3FundingPaymentPageQuerySourceEnum_live;
    case 'archive':
      return _$hip3FundingPaymentPageQuerySourceEnum_archive;
    case 'unknownDefaultOpenApi':
      return _$hip3FundingPaymentPageQuerySourceEnum_unknownDefaultOpenApi;
    default:
      return _$hip3FundingPaymentPageQuerySourceEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<Hip3FundingPaymentPageQuerySourceEnum>
    _$hip3FundingPaymentPageQuerySourceEnumValues = BuiltSet<
        Hip3FundingPaymentPageQuerySourceEnum>(const <Hip3FundingPaymentPageQuerySourceEnum>[
  _$hip3FundingPaymentPageQuerySourceEnum_live,
  _$hip3FundingPaymentPageQuerySourceEnum_archive,
  _$hip3FundingPaymentPageQuerySourceEnum_unknownDefaultOpenApi,
]);

const Hip3FundingPaymentPageWarningsEnum
    _$hip3FundingPaymentPageWarningsEnum_providerHistoryRetentionNotGuaranteed =
    const Hip3FundingPaymentPageWarningsEnum._(
        'providerHistoryRetentionNotGuaranteed');
const Hip3FundingPaymentPageWarningsEnum
    _$hip3FundingPaymentPageWarningsEnum_fundingSettlementAssetUnavailable =
    const Hip3FundingPaymentPageWarningsEnum._(
        'fundingSettlementAssetUnavailable');
const Hip3FundingPaymentPageWarningsEnum
    _$hip3FundingPaymentPageWarningsEnum_historyArchiveGaps =
    const Hip3FundingPaymentPageWarningsEnum._('historyArchiveGaps');
const Hip3FundingPaymentPageWarningsEnum
    _$hip3FundingPaymentPageWarningsEnum_unknownDefaultOpenApi =
    const Hip3FundingPaymentPageWarningsEnum._('unknownDefaultOpenApi');

Hip3FundingPaymentPageWarningsEnum _$hip3FundingPaymentPageWarningsEnumValueOf(
    String name) {
  switch (name) {
    case 'providerHistoryRetentionNotGuaranteed':
      return _$hip3FundingPaymentPageWarningsEnum_providerHistoryRetentionNotGuaranteed;
    case 'fundingSettlementAssetUnavailable':
      return _$hip3FundingPaymentPageWarningsEnum_fundingSettlementAssetUnavailable;
    case 'historyArchiveGaps':
      return _$hip3FundingPaymentPageWarningsEnum_historyArchiveGaps;
    case 'unknownDefaultOpenApi':
      return _$hip3FundingPaymentPageWarningsEnum_unknownDefaultOpenApi;
    default:
      return _$hip3FundingPaymentPageWarningsEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<Hip3FundingPaymentPageWarningsEnum>
    _$hip3FundingPaymentPageWarningsEnumValues = BuiltSet<
        Hip3FundingPaymentPageWarningsEnum>(const <Hip3FundingPaymentPageWarningsEnum>[
  _$hip3FundingPaymentPageWarningsEnum_providerHistoryRetentionNotGuaranteed,
  _$hip3FundingPaymentPageWarningsEnum_fundingSettlementAssetUnavailable,
  _$hip3FundingPaymentPageWarningsEnum_historyArchiveGaps,
  _$hip3FundingPaymentPageWarningsEnum_unknownDefaultOpenApi,
]);

Serializer<Hip3FundingPaymentPageQuerySourceEnum>
    _$hip3FundingPaymentPageQuerySourceEnumSerializer =
    _$Hip3FundingPaymentPageQuerySourceEnumSerializer();
Serializer<Hip3FundingPaymentPageWarningsEnum>
    _$hip3FundingPaymentPageWarningsEnumSerializer =
    _$Hip3FundingPaymentPageWarningsEnumSerializer();

class _$Hip3FundingPaymentPageQuerySourceEnumSerializer
    implements PrimitiveSerializer<Hip3FundingPaymentPageQuerySourceEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'live': 'live',
    'archive': 'archive',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'live': 'live',
    'archive': 'archive',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[
    Hip3FundingPaymentPageQuerySourceEnum
  ];
  @override
  final String wireName = 'Hip3FundingPaymentPageQuerySourceEnum';

  @override
  Object serialize(
          Serializers serializers, Hip3FundingPaymentPageQuerySourceEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  Hip3FundingPaymentPageQuerySourceEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      Hip3FundingPaymentPageQuerySourceEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$Hip3FundingPaymentPageWarningsEnumSerializer
    implements PrimitiveSerializer<Hip3FundingPaymentPageWarningsEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'providerHistoryRetentionNotGuaranteed':
        'provider_history_retention_not_guaranteed',
    'fundingSettlementAssetUnavailable': 'funding_settlement_asset_unavailable',
    'historyArchiveGaps': 'history_archive_gaps',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'provider_history_retention_not_guaranteed':
        'providerHistoryRetentionNotGuaranteed',
    'funding_settlement_asset_unavailable': 'fundingSettlementAssetUnavailable',
    'history_archive_gaps': 'historyArchiveGaps',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[Hip3FundingPaymentPageWarningsEnum];
  @override
  final String wireName = 'Hip3FundingPaymentPageWarningsEnum';

  @override
  Object serialize(
          Serializers serializers, Hip3FundingPaymentPageWarningsEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  Hip3FundingPaymentPageWarningsEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      Hip3FundingPaymentPageWarningsEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$Hip3FundingPaymentPage extends Hip3FundingPaymentPage {
  @override
  final Hip3FundingPaymentPageQuerySourceEnum querySource;
  @override
  final Hip3ArchiveCoverage? archiveCoverage;
  @override
  final String snapshotId;
  @override
  final Hip3Environment environment;
  @override
  final DateTime observedAt;
  @override
  final BuiltList<Hip3FundingPayment> items;
  @override
  final bool hasMore;
  @override
  final String? nextCursor;
  @override
  final Hip3FundingHistoryCoverage coverage;
  @override
  final BuiltList<Hip3FundingPaymentPageWarningsEnum> warnings;

  factory _$Hip3FundingPaymentPage(
          [void Function(Hip3FundingPaymentPageBuilder)? updates]) =>
      (Hip3FundingPaymentPageBuilder()..update(updates))._build();

  _$Hip3FundingPaymentPage._(
      {required this.querySource,
      this.archiveCoverage,
      required this.snapshotId,
      required this.environment,
      required this.observedAt,
      required this.items,
      required this.hasMore,
      this.nextCursor,
      required this.coverage,
      required this.warnings})
      : super._();
  @override
  Hip3FundingPaymentPage rebuild(
          void Function(Hip3FundingPaymentPageBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  Hip3FundingPaymentPageBuilder toBuilder() =>
      Hip3FundingPaymentPageBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Hip3FundingPaymentPage &&
        querySource == other.querySource &&
        archiveCoverage == other.archiveCoverage &&
        snapshotId == other.snapshotId &&
        environment == other.environment &&
        observedAt == other.observedAt &&
        items == other.items &&
        hasMore == other.hasMore &&
        nextCursor == other.nextCursor &&
        coverage == other.coverage &&
        warnings == other.warnings;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, querySource.hashCode);
    _$hash = $jc(_$hash, archiveCoverage.hashCode);
    _$hash = $jc(_$hash, snapshotId.hashCode);
    _$hash = $jc(_$hash, environment.hashCode);
    _$hash = $jc(_$hash, observedAt.hashCode);
    _$hash = $jc(_$hash, items.hashCode);
    _$hash = $jc(_$hash, hasMore.hashCode);
    _$hash = $jc(_$hash, nextCursor.hashCode);
    _$hash = $jc(_$hash, coverage.hashCode);
    _$hash = $jc(_$hash, warnings.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'Hip3FundingPaymentPage')
          ..add('querySource', querySource)
          ..add('archiveCoverage', archiveCoverage)
          ..add('snapshotId', snapshotId)
          ..add('environment', environment)
          ..add('observedAt', observedAt)
          ..add('items', items)
          ..add('hasMore', hasMore)
          ..add('nextCursor', nextCursor)
          ..add('coverage', coverage)
          ..add('warnings', warnings))
        .toString();
  }
}

class Hip3FundingPaymentPageBuilder
    implements Builder<Hip3FundingPaymentPage, Hip3FundingPaymentPageBuilder> {
  _$Hip3FundingPaymentPage? _$v;

  Hip3FundingPaymentPageQuerySourceEnum? _querySource;
  Hip3FundingPaymentPageQuerySourceEnum? get querySource => _$this._querySource;
  set querySource(Hip3FundingPaymentPageQuerySourceEnum? querySource) =>
      _$this._querySource = querySource;

  Hip3ArchiveCoverageBuilder? _archiveCoverage;
  Hip3ArchiveCoverageBuilder get archiveCoverage =>
      _$this._archiveCoverage ??= Hip3ArchiveCoverageBuilder();
  set archiveCoverage(Hip3ArchiveCoverageBuilder? archiveCoverage) =>
      _$this._archiveCoverage = archiveCoverage;

  String? _snapshotId;
  String? get snapshotId => _$this._snapshotId;
  set snapshotId(String? snapshotId) => _$this._snapshotId = snapshotId;

  Hip3Environment? _environment;
  Hip3Environment? get environment => _$this._environment;
  set environment(Hip3Environment? environment) =>
      _$this._environment = environment;

  DateTime? _observedAt;
  DateTime? get observedAt => _$this._observedAt;
  set observedAt(DateTime? observedAt) => _$this._observedAt = observedAt;

  ListBuilder<Hip3FundingPayment>? _items;
  ListBuilder<Hip3FundingPayment> get items =>
      _$this._items ??= ListBuilder<Hip3FundingPayment>();
  set items(ListBuilder<Hip3FundingPayment>? items) => _$this._items = items;

  bool? _hasMore;
  bool? get hasMore => _$this._hasMore;
  set hasMore(bool? hasMore) => _$this._hasMore = hasMore;

  String? _nextCursor;
  String? get nextCursor => _$this._nextCursor;
  set nextCursor(String? nextCursor) => _$this._nextCursor = nextCursor;

  Hip3FundingHistoryCoverageBuilder? _coverage;
  Hip3FundingHistoryCoverageBuilder get coverage =>
      _$this._coverage ??= Hip3FundingHistoryCoverageBuilder();
  set coverage(Hip3FundingHistoryCoverageBuilder? coverage) =>
      _$this._coverage = coverage;

  ListBuilder<Hip3FundingPaymentPageWarningsEnum>? _warnings;
  ListBuilder<Hip3FundingPaymentPageWarningsEnum> get warnings =>
      _$this._warnings ??= ListBuilder<Hip3FundingPaymentPageWarningsEnum>();
  set warnings(ListBuilder<Hip3FundingPaymentPageWarningsEnum>? warnings) =>
      _$this._warnings = warnings;

  Hip3FundingPaymentPageBuilder() {
    Hip3FundingPaymentPage._defaults(this);
  }

  Hip3FundingPaymentPageBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _querySource = $v.querySource;
      _archiveCoverage = $v.archiveCoverage?.toBuilder();
      _snapshotId = $v.snapshotId;
      _environment = $v.environment;
      _observedAt = $v.observedAt;
      _items = $v.items.toBuilder();
      _hasMore = $v.hasMore;
      _nextCursor = $v.nextCursor;
      _coverage = $v.coverage.toBuilder();
      _warnings = $v.warnings.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Hip3FundingPaymentPage other) {
    _$v = other as _$Hip3FundingPaymentPage;
  }

  @override
  void update(void Function(Hip3FundingPaymentPageBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  Hip3FundingPaymentPage build() => _build();

  _$Hip3FundingPaymentPage _build() {
    _$Hip3FundingPaymentPage _$result;
    try {
      _$result = _$v ??
          _$Hip3FundingPaymentPage._(
            querySource: BuiltValueNullFieldError.checkNotNull(
                querySource, r'Hip3FundingPaymentPage', 'querySource'),
            archiveCoverage: _archiveCoverage?.build(),
            snapshotId: BuiltValueNullFieldError.checkNotNull(
                snapshotId, r'Hip3FundingPaymentPage', 'snapshotId'),
            environment: BuiltValueNullFieldError.checkNotNull(
                environment, r'Hip3FundingPaymentPage', 'environment'),
            observedAt: BuiltValueNullFieldError.checkNotNull(
                observedAt, r'Hip3FundingPaymentPage', 'observedAt'),
            items: items.build(),
            hasMore: BuiltValueNullFieldError.checkNotNull(
                hasMore, r'Hip3FundingPaymentPage', 'hasMore'),
            nextCursor: nextCursor,
            coverage: coverage.build(),
            warnings: warnings.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'archiveCoverage';
        _archiveCoverage?.build();

        _$failedField = 'items';
        items.build();

        _$failedField = 'coverage';
        coverage.build();
        _$failedField = 'warnings';
        warnings.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'Hip3FundingPaymentPage', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint

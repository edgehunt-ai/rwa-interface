// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hip3_liquidation_page.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const Hip3LiquidationPageQuerySourceEnum
    _$hip3LiquidationPageQuerySourceEnum_live =
    const Hip3LiquidationPageQuerySourceEnum._('live');
const Hip3LiquidationPageQuerySourceEnum
    _$hip3LiquidationPageQuerySourceEnum_archive =
    const Hip3LiquidationPageQuerySourceEnum._('archive');
const Hip3LiquidationPageQuerySourceEnum
    _$hip3LiquidationPageQuerySourceEnum_unknownDefaultOpenApi =
    const Hip3LiquidationPageQuerySourceEnum._('unknownDefaultOpenApi');

Hip3LiquidationPageQuerySourceEnum _$hip3LiquidationPageQuerySourceEnumValueOf(
    String name) {
  switch (name) {
    case 'live':
      return _$hip3LiquidationPageQuerySourceEnum_live;
    case 'archive':
      return _$hip3LiquidationPageQuerySourceEnum_archive;
    case 'unknownDefaultOpenApi':
      return _$hip3LiquidationPageQuerySourceEnum_unknownDefaultOpenApi;
    default:
      return _$hip3LiquidationPageQuerySourceEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<Hip3LiquidationPageQuerySourceEnum>
    _$hip3LiquidationPageQuerySourceEnumValues = BuiltSet<
        Hip3LiquidationPageQuerySourceEnum>(const <Hip3LiquidationPageQuerySourceEnum>[
  _$hip3LiquidationPageQuerySourceEnum_live,
  _$hip3LiquidationPageQuerySourceEnum_archive,
  _$hip3LiquidationPageQuerySourceEnum_unknownDefaultOpenApi,
]);

const Hip3LiquidationPageWarningsEnum
    _$hip3LiquidationPageWarningsEnum_providerHistoryRetentionNotGuaranteed =
    const Hip3LiquidationPageWarningsEnum._(
        'providerHistoryRetentionNotGuaranteed');
const Hip3LiquidationPageWarningsEnum
    _$hip3LiquidationPageWarningsEnum_historyArchiveGaps =
    const Hip3LiquidationPageWarningsEnum._('historyArchiveGaps');
const Hip3LiquidationPageWarningsEnum
    _$hip3LiquidationPageWarningsEnum_unknownDefaultOpenApi =
    const Hip3LiquidationPageWarningsEnum._('unknownDefaultOpenApi');

Hip3LiquidationPageWarningsEnum _$hip3LiquidationPageWarningsEnumValueOf(
    String name) {
  switch (name) {
    case 'providerHistoryRetentionNotGuaranteed':
      return _$hip3LiquidationPageWarningsEnum_providerHistoryRetentionNotGuaranteed;
    case 'historyArchiveGaps':
      return _$hip3LiquidationPageWarningsEnum_historyArchiveGaps;
    case 'unknownDefaultOpenApi':
      return _$hip3LiquidationPageWarningsEnum_unknownDefaultOpenApi;
    default:
      return _$hip3LiquidationPageWarningsEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<Hip3LiquidationPageWarningsEnum>
    _$hip3LiquidationPageWarningsEnumValues = BuiltSet<
        Hip3LiquidationPageWarningsEnum>(const <Hip3LiquidationPageWarningsEnum>[
  _$hip3LiquidationPageWarningsEnum_providerHistoryRetentionNotGuaranteed,
  _$hip3LiquidationPageWarningsEnum_historyArchiveGaps,
  _$hip3LiquidationPageWarningsEnum_unknownDefaultOpenApi,
]);

Serializer<Hip3LiquidationPageQuerySourceEnum>
    _$hip3LiquidationPageQuerySourceEnumSerializer =
    _$Hip3LiquidationPageQuerySourceEnumSerializer();
Serializer<Hip3LiquidationPageWarningsEnum>
    _$hip3LiquidationPageWarningsEnumSerializer =
    _$Hip3LiquidationPageWarningsEnumSerializer();

class _$Hip3LiquidationPageQuerySourceEnumSerializer
    implements PrimitiveSerializer<Hip3LiquidationPageQuerySourceEnum> {
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
  final Iterable<Type> types = const <Type>[Hip3LiquidationPageQuerySourceEnum];
  @override
  final String wireName = 'Hip3LiquidationPageQuerySourceEnum';

  @override
  Object serialize(
          Serializers serializers, Hip3LiquidationPageQuerySourceEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  Hip3LiquidationPageQuerySourceEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      Hip3LiquidationPageQuerySourceEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$Hip3LiquidationPageWarningsEnumSerializer
    implements PrimitiveSerializer<Hip3LiquidationPageWarningsEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'providerHistoryRetentionNotGuaranteed':
        'provider_history_retention_not_guaranteed',
    'historyArchiveGaps': 'history_archive_gaps',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'provider_history_retention_not_guaranteed':
        'providerHistoryRetentionNotGuaranteed',
    'history_archive_gaps': 'historyArchiveGaps',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[Hip3LiquidationPageWarningsEnum];
  @override
  final String wireName = 'Hip3LiquidationPageWarningsEnum';

  @override
  Object serialize(
          Serializers serializers, Hip3LiquidationPageWarningsEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  Hip3LiquidationPageWarningsEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      Hip3LiquidationPageWarningsEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$Hip3LiquidationPage extends Hip3LiquidationPage {
  @override
  final Hip3LiquidationPageQuerySourceEnum querySource;
  @override
  final Hip3ArchiveCoverage? archiveCoverage;
  @override
  final String snapshotId;
  @override
  final Hip3Environment environment;
  @override
  final DateTime observedAt;
  @override
  final BuiltList<Hip3Liquidation> items;
  @override
  final bool hasMore;
  @override
  final String? nextCursor;
  @override
  final Hip3LiquidationHistoryCoverage coverage;
  @override
  final BuiltList<Hip3LiquidationPageWarningsEnum> warnings;

  factory _$Hip3LiquidationPage(
          [void Function(Hip3LiquidationPageBuilder)? updates]) =>
      (Hip3LiquidationPageBuilder()..update(updates))._build();

  _$Hip3LiquidationPage._(
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
  Hip3LiquidationPage rebuild(
          void Function(Hip3LiquidationPageBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  Hip3LiquidationPageBuilder toBuilder() =>
      Hip3LiquidationPageBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Hip3LiquidationPage &&
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
    return (newBuiltValueToStringHelper(r'Hip3LiquidationPage')
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

class Hip3LiquidationPageBuilder
    implements Builder<Hip3LiquidationPage, Hip3LiquidationPageBuilder> {
  _$Hip3LiquidationPage? _$v;

  Hip3LiquidationPageQuerySourceEnum? _querySource;
  Hip3LiquidationPageQuerySourceEnum? get querySource => _$this._querySource;
  set querySource(Hip3LiquidationPageQuerySourceEnum? querySource) =>
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

  ListBuilder<Hip3Liquidation>? _items;
  ListBuilder<Hip3Liquidation> get items =>
      _$this._items ??= ListBuilder<Hip3Liquidation>();
  set items(ListBuilder<Hip3Liquidation>? items) => _$this._items = items;

  bool? _hasMore;
  bool? get hasMore => _$this._hasMore;
  set hasMore(bool? hasMore) => _$this._hasMore = hasMore;

  String? _nextCursor;
  String? get nextCursor => _$this._nextCursor;
  set nextCursor(String? nextCursor) => _$this._nextCursor = nextCursor;

  Hip3LiquidationHistoryCoverageBuilder? _coverage;
  Hip3LiquidationHistoryCoverageBuilder get coverage =>
      _$this._coverage ??= Hip3LiquidationHistoryCoverageBuilder();
  set coverage(Hip3LiquidationHistoryCoverageBuilder? coverage) =>
      _$this._coverage = coverage;

  ListBuilder<Hip3LiquidationPageWarningsEnum>? _warnings;
  ListBuilder<Hip3LiquidationPageWarningsEnum> get warnings =>
      _$this._warnings ??= ListBuilder<Hip3LiquidationPageWarningsEnum>();
  set warnings(ListBuilder<Hip3LiquidationPageWarningsEnum>? warnings) =>
      _$this._warnings = warnings;

  Hip3LiquidationPageBuilder() {
    Hip3LiquidationPage._defaults(this);
  }

  Hip3LiquidationPageBuilder get _$this {
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
  void replace(Hip3LiquidationPage other) {
    _$v = other as _$Hip3LiquidationPage;
  }

  @override
  void update(void Function(Hip3LiquidationPageBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  Hip3LiquidationPage build() => _build();

  _$Hip3LiquidationPage _build() {
    _$Hip3LiquidationPage _$result;
    try {
      _$result = _$v ??
          _$Hip3LiquidationPage._(
            querySource: BuiltValueNullFieldError.checkNotNull(
                querySource, r'Hip3LiquidationPage', 'querySource'),
            archiveCoverage: _archiveCoverage?.build(),
            snapshotId: BuiltValueNullFieldError.checkNotNull(
                snapshotId, r'Hip3LiquidationPage', 'snapshotId'),
            environment: BuiltValueNullFieldError.checkNotNull(
                environment, r'Hip3LiquidationPage', 'environment'),
            observedAt: BuiltValueNullFieldError.checkNotNull(
                observedAt, r'Hip3LiquidationPage', 'observedAt'),
            items: items.build(),
            hasMore: BuiltValueNullFieldError.checkNotNull(
                hasMore, r'Hip3LiquidationPage', 'hasMore'),
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
            r'Hip3LiquidationPage', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint

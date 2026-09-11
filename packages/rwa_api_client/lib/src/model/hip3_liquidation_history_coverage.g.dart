// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hip3_liquidation_history_coverage.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const Hip3LiquidationHistoryCoverageSource_Enum
    _$hip3LiquidationHistoryCoverageSourceEnum_hyperliquidUserNonFundingLedgerUpdates =
    const Hip3LiquidationHistoryCoverageSource_Enum._(
        'hyperliquidUserNonFundingLedgerUpdates');
const Hip3LiquidationHistoryCoverageSource_Enum
    _$hip3LiquidationHistoryCoverageSourceEnum_unknownDefaultOpenApi =
    const Hip3LiquidationHistoryCoverageSource_Enum._('unknownDefaultOpenApi');

Hip3LiquidationHistoryCoverageSource_Enum
    _$hip3LiquidationHistoryCoverageSourceEnumValueOf(String name) {
  switch (name) {
    case 'hyperliquidUserNonFundingLedgerUpdates':
      return _$hip3LiquidationHistoryCoverageSourceEnum_hyperliquidUserNonFundingLedgerUpdates;
    case 'unknownDefaultOpenApi':
      return _$hip3LiquidationHistoryCoverageSourceEnum_unknownDefaultOpenApi;
    default:
      return _$hip3LiquidationHistoryCoverageSourceEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<Hip3LiquidationHistoryCoverageSource_Enum>
    _$hip3LiquidationHistoryCoverageSourceEnumValues = BuiltSet<
        Hip3LiquidationHistoryCoverageSource_Enum>(const <Hip3LiquidationHistoryCoverageSource_Enum>[
  _$hip3LiquidationHistoryCoverageSourceEnum_hyperliquidUserNonFundingLedgerUpdates,
  _$hip3LiquidationHistoryCoverageSourceEnum_unknownDefaultOpenApi,
]);

const Hip3LiquidationHistoryCoverageStatusEnum
    _$hip3LiquidationHistoryCoverageStatusEnum_sourceExhausted =
    const Hip3LiquidationHistoryCoverageStatusEnum._('sourceExhausted');
const Hip3LiquidationHistoryCoverageStatusEnum
    _$hip3LiquidationHistoryCoverageStatusEnum_pageLimit =
    const Hip3LiquidationHistoryCoverageStatusEnum._('pageLimit');
const Hip3LiquidationHistoryCoverageStatusEnum
    _$hip3LiquidationHistoryCoverageStatusEnum_timestampSaturated =
    const Hip3LiquidationHistoryCoverageStatusEnum._('timestampSaturated');
const Hip3LiquidationHistoryCoverageStatusEnum
    _$hip3LiquidationHistoryCoverageStatusEnum_upstreamUnavailable =
    const Hip3LiquidationHistoryCoverageStatusEnum._('upstreamUnavailable');
const Hip3LiquidationHistoryCoverageStatusEnum
    _$hip3LiquidationHistoryCoverageStatusEnum_archiveComplete =
    const Hip3LiquidationHistoryCoverageStatusEnum._('archiveComplete');
const Hip3LiquidationHistoryCoverageStatusEnum
    _$hip3LiquidationHistoryCoverageStatusEnum_archivePartial =
    const Hip3LiquidationHistoryCoverageStatusEnum._('archivePartial');
const Hip3LiquidationHistoryCoverageStatusEnum
    _$hip3LiquidationHistoryCoverageStatusEnum_unknownDefaultOpenApi =
    const Hip3LiquidationHistoryCoverageStatusEnum._('unknownDefaultOpenApi');

Hip3LiquidationHistoryCoverageStatusEnum
    _$hip3LiquidationHistoryCoverageStatusEnumValueOf(String name) {
  switch (name) {
    case 'sourceExhausted':
      return _$hip3LiquidationHistoryCoverageStatusEnum_sourceExhausted;
    case 'pageLimit':
      return _$hip3LiquidationHistoryCoverageStatusEnum_pageLimit;
    case 'timestampSaturated':
      return _$hip3LiquidationHistoryCoverageStatusEnum_timestampSaturated;
    case 'upstreamUnavailable':
      return _$hip3LiquidationHistoryCoverageStatusEnum_upstreamUnavailable;
    case 'archiveComplete':
      return _$hip3LiquidationHistoryCoverageStatusEnum_archiveComplete;
    case 'archivePartial':
      return _$hip3LiquidationHistoryCoverageStatusEnum_archivePartial;
    case 'unknownDefaultOpenApi':
      return _$hip3LiquidationHistoryCoverageStatusEnum_unknownDefaultOpenApi;
    default:
      return _$hip3LiquidationHistoryCoverageStatusEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<Hip3LiquidationHistoryCoverageStatusEnum>
    _$hip3LiquidationHistoryCoverageStatusEnumValues = BuiltSet<
        Hip3LiquidationHistoryCoverageStatusEnum>(const <Hip3LiquidationHistoryCoverageStatusEnum>[
  _$hip3LiquidationHistoryCoverageStatusEnum_sourceExhausted,
  _$hip3LiquidationHistoryCoverageStatusEnum_pageLimit,
  _$hip3LiquidationHistoryCoverageStatusEnum_timestampSaturated,
  _$hip3LiquidationHistoryCoverageStatusEnum_upstreamUnavailable,
  _$hip3LiquidationHistoryCoverageStatusEnum_archiveComplete,
  _$hip3LiquidationHistoryCoverageStatusEnum_archivePartial,
  _$hip3LiquidationHistoryCoverageStatusEnum_unknownDefaultOpenApi,
]);

Serializer<Hip3LiquidationHistoryCoverageSource_Enum>
    _$hip3LiquidationHistoryCoverageSourceEnumSerializer =
    _$Hip3LiquidationHistoryCoverageSource_EnumSerializer();
Serializer<Hip3LiquidationHistoryCoverageStatusEnum>
    _$hip3LiquidationHistoryCoverageStatusEnumSerializer =
    _$Hip3LiquidationHistoryCoverageStatusEnumSerializer();

class _$Hip3LiquidationHistoryCoverageSource_EnumSerializer
    implements PrimitiveSerializer<Hip3LiquidationHistoryCoverageSource_Enum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'hyperliquidUserNonFundingLedgerUpdates':
        'hyperliquid_userNonFundingLedgerUpdates',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'hyperliquid_userNonFundingLedgerUpdates':
        'hyperliquidUserNonFundingLedgerUpdates',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[
    Hip3LiquidationHistoryCoverageSource_Enum
  ];
  @override
  final String wireName = 'Hip3LiquidationHistoryCoverageSource_Enum';

  @override
  Object serialize(Serializers serializers,
          Hip3LiquidationHistoryCoverageSource_Enum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  Hip3LiquidationHistoryCoverageSource_Enum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      Hip3LiquidationHistoryCoverageSource_Enum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$Hip3LiquidationHistoryCoverageStatusEnumSerializer
    implements PrimitiveSerializer<Hip3LiquidationHistoryCoverageStatusEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'sourceExhausted': 'source_exhausted',
    'pageLimit': 'page_limit',
    'timestampSaturated': 'timestamp_saturated',
    'upstreamUnavailable': 'upstream_unavailable',
    'archiveComplete': 'archive_complete',
    'archivePartial': 'archive_partial',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'source_exhausted': 'sourceExhausted',
    'page_limit': 'pageLimit',
    'timestamp_saturated': 'timestampSaturated',
    'upstream_unavailable': 'upstreamUnavailable',
    'archive_complete': 'archiveComplete',
    'archive_partial': 'archivePartial',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[
    Hip3LiquidationHistoryCoverageStatusEnum
  ];
  @override
  final String wireName = 'Hip3LiquidationHistoryCoverageStatusEnum';

  @override
  Object serialize(Serializers serializers,
          Hip3LiquidationHistoryCoverageStatusEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  Hip3LiquidationHistoryCoverageStatusEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      Hip3LiquidationHistoryCoverageStatusEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$Hip3LiquidationHistoryCoverage extends Hip3LiquidationHistoryCoverage {
  @override
  final Hip3LiquidationHistoryCoverageSource_Enum source_;
  @override
  final Hip3LiquidationHistoryCoverageStatusEnum status;
  @override
  final DateTime from;
  @override
  final DateTime to;
  @override
  final DateTime? resumeFrom;
  @override
  final bool retentionGuaranteed;

  factory _$Hip3LiquidationHistoryCoverage(
          [void Function(Hip3LiquidationHistoryCoverageBuilder)? updates]) =>
      (Hip3LiquidationHistoryCoverageBuilder()..update(updates))._build();

  _$Hip3LiquidationHistoryCoverage._(
      {required this.source_,
      required this.status,
      required this.from,
      required this.to,
      this.resumeFrom,
      required this.retentionGuaranteed})
      : super._();
  @override
  Hip3LiquidationHistoryCoverage rebuild(
          void Function(Hip3LiquidationHistoryCoverageBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  Hip3LiquidationHistoryCoverageBuilder toBuilder() =>
      Hip3LiquidationHistoryCoverageBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Hip3LiquidationHistoryCoverage &&
        source_ == other.source_ &&
        status == other.status &&
        from == other.from &&
        to == other.to &&
        resumeFrom == other.resumeFrom &&
        retentionGuaranteed == other.retentionGuaranteed;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, source_.hashCode);
    _$hash = $jc(_$hash, status.hashCode);
    _$hash = $jc(_$hash, from.hashCode);
    _$hash = $jc(_$hash, to.hashCode);
    _$hash = $jc(_$hash, resumeFrom.hashCode);
    _$hash = $jc(_$hash, retentionGuaranteed.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'Hip3LiquidationHistoryCoverage')
          ..add('source_', source_)
          ..add('status', status)
          ..add('from', from)
          ..add('to', to)
          ..add('resumeFrom', resumeFrom)
          ..add('retentionGuaranteed', retentionGuaranteed))
        .toString();
  }
}

class Hip3LiquidationHistoryCoverageBuilder
    implements
        Builder<Hip3LiquidationHistoryCoverage,
            Hip3LiquidationHistoryCoverageBuilder> {
  _$Hip3LiquidationHistoryCoverage? _$v;

  Hip3LiquidationHistoryCoverageSource_Enum? _source_;
  Hip3LiquidationHistoryCoverageSource_Enum? get source_ => _$this._source_;
  set source_(Hip3LiquidationHistoryCoverageSource_Enum? source_) =>
      _$this._source_ = source_;

  Hip3LiquidationHistoryCoverageStatusEnum? _status;
  Hip3LiquidationHistoryCoverageStatusEnum? get status => _$this._status;
  set status(Hip3LiquidationHistoryCoverageStatusEnum? status) =>
      _$this._status = status;

  DateTime? _from;
  DateTime? get from => _$this._from;
  set from(DateTime? from) => _$this._from = from;

  DateTime? _to;
  DateTime? get to => _$this._to;
  set to(DateTime? to) => _$this._to = to;

  DateTime? _resumeFrom;
  DateTime? get resumeFrom => _$this._resumeFrom;
  set resumeFrom(DateTime? resumeFrom) => _$this._resumeFrom = resumeFrom;

  bool? _retentionGuaranteed;
  bool? get retentionGuaranteed => _$this._retentionGuaranteed;
  set retentionGuaranteed(bool? retentionGuaranteed) =>
      _$this._retentionGuaranteed = retentionGuaranteed;

  Hip3LiquidationHistoryCoverageBuilder() {
    Hip3LiquidationHistoryCoverage._defaults(this);
  }

  Hip3LiquidationHistoryCoverageBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _source_ = $v.source_;
      _status = $v.status;
      _from = $v.from;
      _to = $v.to;
      _resumeFrom = $v.resumeFrom;
      _retentionGuaranteed = $v.retentionGuaranteed;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Hip3LiquidationHistoryCoverage other) {
    _$v = other as _$Hip3LiquidationHistoryCoverage;
  }

  @override
  void update(void Function(Hip3LiquidationHistoryCoverageBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  Hip3LiquidationHistoryCoverage build() => _build();

  _$Hip3LiquidationHistoryCoverage _build() {
    final _$result = _$v ??
        _$Hip3LiquidationHistoryCoverage._(
          source_: BuiltValueNullFieldError.checkNotNull(
              source_, r'Hip3LiquidationHistoryCoverage', 'source_'),
          status: BuiltValueNullFieldError.checkNotNull(
              status, r'Hip3LiquidationHistoryCoverage', 'status'),
          from: BuiltValueNullFieldError.checkNotNull(
              from, r'Hip3LiquidationHistoryCoverage', 'from'),
          to: BuiltValueNullFieldError.checkNotNull(
              to, r'Hip3LiquidationHistoryCoverage', 'to'),
          resumeFrom: resumeFrom,
          retentionGuaranteed: BuiltValueNullFieldError.checkNotNull(
              retentionGuaranteed,
              r'Hip3LiquidationHistoryCoverage',
              'retentionGuaranteed'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint

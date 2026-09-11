// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hip3_funding_history_coverage.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const Hip3FundingHistoryCoverageSource_Enum
    _$hip3FundingHistoryCoverageSourceEnum_hyperliquidUserFunding =
    const Hip3FundingHistoryCoverageSource_Enum._('hyperliquidUserFunding');
const Hip3FundingHistoryCoverageSource_Enum
    _$hip3FundingHistoryCoverageSourceEnum_unknownDefaultOpenApi =
    const Hip3FundingHistoryCoverageSource_Enum._('unknownDefaultOpenApi');

Hip3FundingHistoryCoverageSource_Enum
    _$hip3FundingHistoryCoverageSourceEnumValueOf(String name) {
  switch (name) {
    case 'hyperliquidUserFunding':
      return _$hip3FundingHistoryCoverageSourceEnum_hyperliquidUserFunding;
    case 'unknownDefaultOpenApi':
      return _$hip3FundingHistoryCoverageSourceEnum_unknownDefaultOpenApi;
    default:
      return _$hip3FundingHistoryCoverageSourceEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<Hip3FundingHistoryCoverageSource_Enum>
    _$hip3FundingHistoryCoverageSourceEnumValues = BuiltSet<
        Hip3FundingHistoryCoverageSource_Enum>(const <Hip3FundingHistoryCoverageSource_Enum>[
  _$hip3FundingHistoryCoverageSourceEnum_hyperliquidUserFunding,
  _$hip3FundingHistoryCoverageSourceEnum_unknownDefaultOpenApi,
]);

const Hip3FundingHistoryCoverageStatusEnum
    _$hip3FundingHistoryCoverageStatusEnum_sourceExhausted =
    const Hip3FundingHistoryCoverageStatusEnum._('sourceExhausted');
const Hip3FundingHistoryCoverageStatusEnum
    _$hip3FundingHistoryCoverageStatusEnum_pageLimit =
    const Hip3FundingHistoryCoverageStatusEnum._('pageLimit');
const Hip3FundingHistoryCoverageStatusEnum
    _$hip3FundingHistoryCoverageStatusEnum_timestampSaturated =
    const Hip3FundingHistoryCoverageStatusEnum._('timestampSaturated');
const Hip3FundingHistoryCoverageStatusEnum
    _$hip3FundingHistoryCoverageStatusEnum_upstreamUnavailable =
    const Hip3FundingHistoryCoverageStatusEnum._('upstreamUnavailable');
const Hip3FundingHistoryCoverageStatusEnum
    _$hip3FundingHistoryCoverageStatusEnum_archiveComplete =
    const Hip3FundingHistoryCoverageStatusEnum._('archiveComplete');
const Hip3FundingHistoryCoverageStatusEnum
    _$hip3FundingHistoryCoverageStatusEnum_archivePartial =
    const Hip3FundingHistoryCoverageStatusEnum._('archivePartial');
const Hip3FundingHistoryCoverageStatusEnum
    _$hip3FundingHistoryCoverageStatusEnum_unknownDefaultOpenApi =
    const Hip3FundingHistoryCoverageStatusEnum._('unknownDefaultOpenApi');

Hip3FundingHistoryCoverageStatusEnum
    _$hip3FundingHistoryCoverageStatusEnumValueOf(String name) {
  switch (name) {
    case 'sourceExhausted':
      return _$hip3FundingHistoryCoverageStatusEnum_sourceExhausted;
    case 'pageLimit':
      return _$hip3FundingHistoryCoverageStatusEnum_pageLimit;
    case 'timestampSaturated':
      return _$hip3FundingHistoryCoverageStatusEnum_timestampSaturated;
    case 'upstreamUnavailable':
      return _$hip3FundingHistoryCoverageStatusEnum_upstreamUnavailable;
    case 'archiveComplete':
      return _$hip3FundingHistoryCoverageStatusEnum_archiveComplete;
    case 'archivePartial':
      return _$hip3FundingHistoryCoverageStatusEnum_archivePartial;
    case 'unknownDefaultOpenApi':
      return _$hip3FundingHistoryCoverageStatusEnum_unknownDefaultOpenApi;
    default:
      return _$hip3FundingHistoryCoverageStatusEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<Hip3FundingHistoryCoverageStatusEnum>
    _$hip3FundingHistoryCoverageStatusEnumValues = BuiltSet<
        Hip3FundingHistoryCoverageStatusEnum>(const <Hip3FundingHistoryCoverageStatusEnum>[
  _$hip3FundingHistoryCoverageStatusEnum_sourceExhausted,
  _$hip3FundingHistoryCoverageStatusEnum_pageLimit,
  _$hip3FundingHistoryCoverageStatusEnum_timestampSaturated,
  _$hip3FundingHistoryCoverageStatusEnum_upstreamUnavailable,
  _$hip3FundingHistoryCoverageStatusEnum_archiveComplete,
  _$hip3FundingHistoryCoverageStatusEnum_archivePartial,
  _$hip3FundingHistoryCoverageStatusEnum_unknownDefaultOpenApi,
]);

Serializer<Hip3FundingHistoryCoverageSource_Enum>
    _$hip3FundingHistoryCoverageSourceEnumSerializer =
    _$Hip3FundingHistoryCoverageSource_EnumSerializer();
Serializer<Hip3FundingHistoryCoverageStatusEnum>
    _$hip3FundingHistoryCoverageStatusEnumSerializer =
    _$Hip3FundingHistoryCoverageStatusEnumSerializer();

class _$Hip3FundingHistoryCoverageSource_EnumSerializer
    implements PrimitiveSerializer<Hip3FundingHistoryCoverageSource_Enum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'hyperliquidUserFunding': 'hyperliquid_userFunding',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'hyperliquid_userFunding': 'hyperliquidUserFunding',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[
    Hip3FundingHistoryCoverageSource_Enum
  ];
  @override
  final String wireName = 'Hip3FundingHistoryCoverageSource_Enum';

  @override
  Object serialize(
          Serializers serializers, Hip3FundingHistoryCoverageSource_Enum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  Hip3FundingHistoryCoverageSource_Enum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      Hip3FundingHistoryCoverageSource_Enum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$Hip3FundingHistoryCoverageStatusEnumSerializer
    implements PrimitiveSerializer<Hip3FundingHistoryCoverageStatusEnum> {
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
    Hip3FundingHistoryCoverageStatusEnum
  ];
  @override
  final String wireName = 'Hip3FundingHistoryCoverageStatusEnum';

  @override
  Object serialize(
          Serializers serializers, Hip3FundingHistoryCoverageStatusEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  Hip3FundingHistoryCoverageStatusEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      Hip3FundingHistoryCoverageStatusEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$Hip3FundingHistoryCoverage extends Hip3FundingHistoryCoverage {
  @override
  final Hip3FundingHistoryCoverageSource_Enum source_;
  @override
  final Hip3FundingHistoryCoverageStatusEnum status;
  @override
  final DateTime from;
  @override
  final DateTime to;
  @override
  final DateTime? resumeFrom;
  @override
  final bool retentionGuaranteed;

  factory _$Hip3FundingHistoryCoverage(
          [void Function(Hip3FundingHistoryCoverageBuilder)? updates]) =>
      (Hip3FundingHistoryCoverageBuilder()..update(updates))._build();

  _$Hip3FundingHistoryCoverage._(
      {required this.source_,
      required this.status,
      required this.from,
      required this.to,
      this.resumeFrom,
      required this.retentionGuaranteed})
      : super._();
  @override
  Hip3FundingHistoryCoverage rebuild(
          void Function(Hip3FundingHistoryCoverageBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  Hip3FundingHistoryCoverageBuilder toBuilder() =>
      Hip3FundingHistoryCoverageBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Hip3FundingHistoryCoverage &&
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
    return (newBuiltValueToStringHelper(r'Hip3FundingHistoryCoverage')
          ..add('source_', source_)
          ..add('status', status)
          ..add('from', from)
          ..add('to', to)
          ..add('resumeFrom', resumeFrom)
          ..add('retentionGuaranteed', retentionGuaranteed))
        .toString();
  }
}

class Hip3FundingHistoryCoverageBuilder
    implements
        Builder<Hip3FundingHistoryCoverage, Hip3FundingHistoryCoverageBuilder> {
  _$Hip3FundingHistoryCoverage? _$v;

  Hip3FundingHistoryCoverageSource_Enum? _source_;
  Hip3FundingHistoryCoverageSource_Enum? get source_ => _$this._source_;
  set source_(Hip3FundingHistoryCoverageSource_Enum? source_) =>
      _$this._source_ = source_;

  Hip3FundingHistoryCoverageStatusEnum? _status;
  Hip3FundingHistoryCoverageStatusEnum? get status => _$this._status;
  set status(Hip3FundingHistoryCoverageStatusEnum? status) =>
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

  Hip3FundingHistoryCoverageBuilder() {
    Hip3FundingHistoryCoverage._defaults(this);
  }

  Hip3FundingHistoryCoverageBuilder get _$this {
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
  void replace(Hip3FundingHistoryCoverage other) {
    _$v = other as _$Hip3FundingHistoryCoverage;
  }

  @override
  void update(void Function(Hip3FundingHistoryCoverageBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  Hip3FundingHistoryCoverage build() => _build();

  _$Hip3FundingHistoryCoverage _build() {
    final _$result = _$v ??
        _$Hip3FundingHistoryCoverage._(
          source_: BuiltValueNullFieldError.checkNotNull(
              source_, r'Hip3FundingHistoryCoverage', 'source_'),
          status: BuiltValueNullFieldError.checkNotNull(
              status, r'Hip3FundingHistoryCoverage', 'status'),
          from: BuiltValueNullFieldError.checkNotNull(
              from, r'Hip3FundingHistoryCoverage', 'from'),
          to: BuiltValueNullFieldError.checkNotNull(
              to, r'Hip3FundingHistoryCoverage', 'to'),
          resumeFrom: resumeFrom,
          retentionGuaranteed: BuiltValueNullFieldError.checkNotNull(
              retentionGuaranteed,
              r'Hip3FundingHistoryCoverage',
              'retentionGuaranteed'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint

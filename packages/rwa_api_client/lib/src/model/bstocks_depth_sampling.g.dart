// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bstocks_depth_sampling.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const BstocksDepthSamplingGridEnum _$bstocksDepthSamplingGridEnum_n125 =
    const BstocksDepthSamplingGridEnum._('n125');
const BstocksDepthSamplingGridEnum
    _$bstocksDepthSamplingGridEnum_unknownDefaultOpenApi =
    const BstocksDepthSamplingGridEnum._('unknownDefaultOpenApi');

BstocksDepthSamplingGridEnum _$bstocksDepthSamplingGridEnumValueOf(
    String name) {
  switch (name) {
    case 'n125':
      return _$bstocksDepthSamplingGridEnum_n125;
    case 'unknownDefaultOpenApi':
      return _$bstocksDepthSamplingGridEnum_unknownDefaultOpenApi;
    default:
      return _$bstocksDepthSamplingGridEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<BstocksDepthSamplingGridEnum>
    _$bstocksDepthSamplingGridEnumValues =
    BuiltSet<BstocksDepthSamplingGridEnum>(const <BstocksDepthSamplingGridEnum>[
  _$bstocksDepthSamplingGridEnum_n125,
  _$bstocksDepthSamplingGridEnum_unknownDefaultOpenApi,
]);

const BstocksDepthSamplingAmountSemanticsEnum
    _$bstocksDepthSamplingAmountSemanticsEnum_nominalInput =
    const BstocksDepthSamplingAmountSemanticsEnum._('nominalInput');
const BstocksDepthSamplingAmountSemanticsEnum
    _$bstocksDepthSamplingAmountSemanticsEnum_unknownDefaultOpenApi =
    const BstocksDepthSamplingAmountSemanticsEnum._('unknownDefaultOpenApi');

BstocksDepthSamplingAmountSemanticsEnum
    _$bstocksDepthSamplingAmountSemanticsEnumValueOf(String name) {
  switch (name) {
    case 'nominalInput':
      return _$bstocksDepthSamplingAmountSemanticsEnum_nominalInput;
    case 'unknownDefaultOpenApi':
      return _$bstocksDepthSamplingAmountSemanticsEnum_unknownDefaultOpenApi;
    default:
      return _$bstocksDepthSamplingAmountSemanticsEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<BstocksDepthSamplingAmountSemanticsEnum>
    _$bstocksDepthSamplingAmountSemanticsEnumValues = BuiltSet<
        BstocksDepthSamplingAmountSemanticsEnum>(const <BstocksDepthSamplingAmountSemanticsEnum>[
  _$bstocksDepthSamplingAmountSemanticsEnum_nominalInput,
  _$bstocksDepthSamplingAmountSemanticsEnum_unknownDefaultOpenApi,
]);

Serializer<BstocksDepthSamplingGridEnum>
    _$bstocksDepthSamplingGridEnumSerializer =
    _$BstocksDepthSamplingGridEnumSerializer();
Serializer<BstocksDepthSamplingAmountSemanticsEnum>
    _$bstocksDepthSamplingAmountSemanticsEnumSerializer =
    _$BstocksDepthSamplingAmountSemanticsEnumSerializer();

class _$BstocksDepthSamplingGridEnumSerializer
    implements PrimitiveSerializer<BstocksDepthSamplingGridEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'n125': '1_2_5',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    '1_2_5': 'n125',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[BstocksDepthSamplingGridEnum];
  @override
  final String wireName = 'BstocksDepthSamplingGridEnum';

  @override
  Object serialize(Serializers serializers, BstocksDepthSamplingGridEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  BstocksDepthSamplingGridEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      BstocksDepthSamplingGridEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$BstocksDepthSamplingAmountSemanticsEnumSerializer
    implements PrimitiveSerializer<BstocksDepthSamplingAmountSemanticsEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'nominalInput': 'nominal_input',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'nominal_input': 'nominalInput',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[
    BstocksDepthSamplingAmountSemanticsEnum
  ];
  @override
  final String wireName = 'BstocksDepthSamplingAmountSemanticsEnum';

  @override
  Object serialize(Serializers serializers,
          BstocksDepthSamplingAmountSemanticsEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  BstocksDepthSamplingAmountSemanticsEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      BstocksDepthSamplingAmountSemanticsEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$BstocksDepthSampling extends BstocksDepthSampling {
  @override
  final BstocksDepthSamplingGridEnum grid;
  @override
  final String baseStart;
  @override
  final String quoteStart;
  @override
  final BstocksDepthSamplingAmountSemanticsEnum amountSemantics;
  @override
  final bool atomicSnapshot;
  @override
  final DateTime startedAt;
  @override
  final DateTime finishedAt;
  @override
  final int startBlock;
  @override
  final int endBlock;

  factory _$BstocksDepthSampling(
          [void Function(BstocksDepthSamplingBuilder)? updates]) =>
      (BstocksDepthSamplingBuilder()..update(updates))._build();

  _$BstocksDepthSampling._(
      {required this.grid,
      required this.baseStart,
      required this.quoteStart,
      required this.amountSemantics,
      required this.atomicSnapshot,
      required this.startedAt,
      required this.finishedAt,
      required this.startBlock,
      required this.endBlock})
      : super._();
  @override
  BstocksDepthSampling rebuild(
          void Function(BstocksDepthSamplingBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  BstocksDepthSamplingBuilder toBuilder() =>
      BstocksDepthSamplingBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is BstocksDepthSampling &&
        grid == other.grid &&
        baseStart == other.baseStart &&
        quoteStart == other.quoteStart &&
        amountSemantics == other.amountSemantics &&
        atomicSnapshot == other.atomicSnapshot &&
        startedAt == other.startedAt &&
        finishedAt == other.finishedAt &&
        startBlock == other.startBlock &&
        endBlock == other.endBlock;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, grid.hashCode);
    _$hash = $jc(_$hash, baseStart.hashCode);
    _$hash = $jc(_$hash, quoteStart.hashCode);
    _$hash = $jc(_$hash, amountSemantics.hashCode);
    _$hash = $jc(_$hash, atomicSnapshot.hashCode);
    _$hash = $jc(_$hash, startedAt.hashCode);
    _$hash = $jc(_$hash, finishedAt.hashCode);
    _$hash = $jc(_$hash, startBlock.hashCode);
    _$hash = $jc(_$hash, endBlock.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'BstocksDepthSampling')
          ..add('grid', grid)
          ..add('baseStart', baseStart)
          ..add('quoteStart', quoteStart)
          ..add('amountSemantics', amountSemantics)
          ..add('atomicSnapshot', atomicSnapshot)
          ..add('startedAt', startedAt)
          ..add('finishedAt', finishedAt)
          ..add('startBlock', startBlock)
          ..add('endBlock', endBlock))
        .toString();
  }
}

class BstocksDepthSamplingBuilder
    implements Builder<BstocksDepthSampling, BstocksDepthSamplingBuilder> {
  _$BstocksDepthSampling? _$v;

  BstocksDepthSamplingGridEnum? _grid;
  BstocksDepthSamplingGridEnum? get grid => _$this._grid;
  set grid(BstocksDepthSamplingGridEnum? grid) => _$this._grid = grid;

  String? _baseStart;
  String? get baseStart => _$this._baseStart;
  set baseStart(String? baseStart) => _$this._baseStart = baseStart;

  String? _quoteStart;
  String? get quoteStart => _$this._quoteStart;
  set quoteStart(String? quoteStart) => _$this._quoteStart = quoteStart;

  BstocksDepthSamplingAmountSemanticsEnum? _amountSemantics;
  BstocksDepthSamplingAmountSemanticsEnum? get amountSemantics =>
      _$this._amountSemantics;
  set amountSemantics(
          BstocksDepthSamplingAmountSemanticsEnum? amountSemantics) =>
      _$this._amountSemantics = amountSemantics;

  bool? _atomicSnapshot;
  bool? get atomicSnapshot => _$this._atomicSnapshot;
  set atomicSnapshot(bool? atomicSnapshot) =>
      _$this._atomicSnapshot = atomicSnapshot;

  DateTime? _startedAt;
  DateTime? get startedAt => _$this._startedAt;
  set startedAt(DateTime? startedAt) => _$this._startedAt = startedAt;

  DateTime? _finishedAt;
  DateTime? get finishedAt => _$this._finishedAt;
  set finishedAt(DateTime? finishedAt) => _$this._finishedAt = finishedAt;

  int? _startBlock;
  int? get startBlock => _$this._startBlock;
  set startBlock(int? startBlock) => _$this._startBlock = startBlock;

  int? _endBlock;
  int? get endBlock => _$this._endBlock;
  set endBlock(int? endBlock) => _$this._endBlock = endBlock;

  BstocksDepthSamplingBuilder() {
    BstocksDepthSampling._defaults(this);
  }

  BstocksDepthSamplingBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _grid = $v.grid;
      _baseStart = $v.baseStart;
      _quoteStart = $v.quoteStart;
      _amountSemantics = $v.amountSemantics;
      _atomicSnapshot = $v.atomicSnapshot;
      _startedAt = $v.startedAt;
      _finishedAt = $v.finishedAt;
      _startBlock = $v.startBlock;
      _endBlock = $v.endBlock;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(BstocksDepthSampling other) {
    _$v = other as _$BstocksDepthSampling;
  }

  @override
  void update(void Function(BstocksDepthSamplingBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  BstocksDepthSampling build() => _build();

  _$BstocksDepthSampling _build() {
    final _$result = _$v ??
        _$BstocksDepthSampling._(
          grid: BuiltValueNullFieldError.checkNotNull(
              grid, r'BstocksDepthSampling', 'grid'),
          baseStart: BuiltValueNullFieldError.checkNotNull(
              baseStart, r'BstocksDepthSampling', 'baseStart'),
          quoteStart: BuiltValueNullFieldError.checkNotNull(
              quoteStart, r'BstocksDepthSampling', 'quoteStart'),
          amountSemantics: BuiltValueNullFieldError.checkNotNull(
              amountSemantics, r'BstocksDepthSampling', 'amountSemantics'),
          atomicSnapshot: BuiltValueNullFieldError.checkNotNull(
              atomicSnapshot, r'BstocksDepthSampling', 'atomicSnapshot'),
          startedAt: BuiltValueNullFieldError.checkNotNull(
              startedAt, r'BstocksDepthSampling', 'startedAt'),
          finishedAt: BuiltValueNullFieldError.checkNotNull(
              finishedAt, r'BstocksDepthSampling', 'finishedAt'),
          startBlock: BuiltValueNullFieldError.checkNotNull(
              startBlock, r'BstocksDepthSampling', 'startBlock'),
          endBlock: BuiltValueNullFieldError.checkNotNull(
              endBlock, r'BstocksDepthSampling', 'endBlock'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint

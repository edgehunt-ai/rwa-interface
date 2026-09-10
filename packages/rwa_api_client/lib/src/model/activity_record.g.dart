// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'activity_record.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const ActivityRecordBusinessTypeEnum _$activityRecordBusinessTypeEnum_opening =
    const ActivityRecordBusinessTypeEnum._('opening');
const ActivityRecordBusinessTypeEnum _$activityRecordBusinessTypeEnum_closing =
    const ActivityRecordBusinessTypeEnum._('closing');
const ActivityRecordBusinessTypeEnum
    _$activityRecordBusinessTypeEnum_takeProfit =
    const ActivityRecordBusinessTypeEnum._('takeProfit');
const ActivityRecordBusinessTypeEnum _$activityRecordBusinessTypeEnum_stopLoss =
    const ActivityRecordBusinessTypeEnum._('stopLoss');
const ActivityRecordBusinessTypeEnum _$activityRecordBusinessTypeEnum_unknown =
    const ActivityRecordBusinessTypeEnum._('unknown');
const ActivityRecordBusinessTypeEnum
    _$activityRecordBusinessTypeEnum_unknownDefaultOpenApi =
    const ActivityRecordBusinessTypeEnum._('unknownDefaultOpenApi');

ActivityRecordBusinessTypeEnum _$activityRecordBusinessTypeEnumValueOf(
    String name) {
  switch (name) {
    case 'opening':
      return _$activityRecordBusinessTypeEnum_opening;
    case 'closing':
      return _$activityRecordBusinessTypeEnum_closing;
    case 'takeProfit':
      return _$activityRecordBusinessTypeEnum_takeProfit;
    case 'stopLoss':
      return _$activityRecordBusinessTypeEnum_stopLoss;
    case 'unknown':
      return _$activityRecordBusinessTypeEnum_unknown;
    case 'unknownDefaultOpenApi':
      return _$activityRecordBusinessTypeEnum_unknownDefaultOpenApi;
    default:
      return _$activityRecordBusinessTypeEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<ActivityRecordBusinessTypeEnum>
    _$activityRecordBusinessTypeEnumValues = BuiltSet<
        ActivityRecordBusinessTypeEnum>(const <ActivityRecordBusinessTypeEnum>[
  _$activityRecordBusinessTypeEnum_opening,
  _$activityRecordBusinessTypeEnum_closing,
  _$activityRecordBusinessTypeEnum_takeProfit,
  _$activityRecordBusinessTypeEnum_stopLoss,
  _$activityRecordBusinessTypeEnum_unknown,
  _$activityRecordBusinessTypeEnum_unknownDefaultOpenApi,
]);

const ActivityRecordChainEnum _$activityRecordChainEnum_BSC =
    const ActivityRecordChainEnum._('BSC');
const ActivityRecordChainEnum _$activityRecordChainEnum_arbitrum =
    const ActivityRecordChainEnum._('arbitrum');
const ActivityRecordChainEnum _$activityRecordChainEnum_base_ =
    const ActivityRecordChainEnum._('base_');
const ActivityRecordChainEnum _$activityRecordChainEnum_ethereum =
    const ActivityRecordChainEnum._('ethereum');
const ActivityRecordChainEnum _$activityRecordChainEnum_hyperliquid =
    const ActivityRecordChainEnum._('hyperliquid');
const ActivityRecordChainEnum _$activityRecordChainEnum_polygon =
    const ActivityRecordChainEnum._('polygon');
const ActivityRecordChainEnum _$activityRecordChainEnum_solana =
    const ActivityRecordChainEnum._('solana');
const ActivityRecordChainEnum _$activityRecordChainEnum_unknownDefaultOpenApi =
    const ActivityRecordChainEnum._('unknownDefaultOpenApi');

ActivityRecordChainEnum _$activityRecordChainEnumValueOf(String name) {
  switch (name) {
    case 'BSC':
      return _$activityRecordChainEnum_BSC;
    case 'arbitrum':
      return _$activityRecordChainEnum_arbitrum;
    case 'base_':
      return _$activityRecordChainEnum_base_;
    case 'ethereum':
      return _$activityRecordChainEnum_ethereum;
    case 'hyperliquid':
      return _$activityRecordChainEnum_hyperliquid;
    case 'polygon':
      return _$activityRecordChainEnum_polygon;
    case 'solana':
      return _$activityRecordChainEnum_solana;
    case 'unknownDefaultOpenApi':
      return _$activityRecordChainEnum_unknownDefaultOpenApi;
    default:
      return _$activityRecordChainEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<ActivityRecordChainEnum> _$activityRecordChainEnumValues =
    BuiltSet<ActivityRecordChainEnum>(const <ActivityRecordChainEnum>[
  _$activityRecordChainEnum_BSC,
  _$activityRecordChainEnum_arbitrum,
  _$activityRecordChainEnum_base_,
  _$activityRecordChainEnum_ethereum,
  _$activityRecordChainEnum_hyperliquid,
  _$activityRecordChainEnum_polygon,
  _$activityRecordChainEnum_solana,
  _$activityRecordChainEnum_unknownDefaultOpenApi,
]);

Serializer<ActivityRecordBusinessTypeEnum>
    _$activityRecordBusinessTypeEnumSerializer =
    _$ActivityRecordBusinessTypeEnumSerializer();
Serializer<ActivityRecordChainEnum> _$activityRecordChainEnumSerializer =
    _$ActivityRecordChainEnumSerializer();

class _$ActivityRecordBusinessTypeEnumSerializer
    implements PrimitiveSerializer<ActivityRecordBusinessTypeEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'opening': 'opening',
    'closing': 'closing',
    'takeProfit': 'take_profit',
    'stopLoss': 'stop_loss',
    'unknown': 'unknown',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'opening': 'opening',
    'closing': 'closing',
    'take_profit': 'takeProfit',
    'stop_loss': 'stopLoss',
    'unknown': 'unknown',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[ActivityRecordBusinessTypeEnum];
  @override
  final String wireName = 'ActivityRecordBusinessTypeEnum';

  @override
  Object serialize(
          Serializers serializers, ActivityRecordBusinessTypeEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  ActivityRecordBusinessTypeEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      ActivityRecordBusinessTypeEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$ActivityRecordChainEnumSerializer
    implements PrimitiveSerializer<ActivityRecordChainEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'BSC': 'BSC',
    'arbitrum': 'Arbitrum',
    'base_': 'Base',
    'ethereum': 'Ethereum',
    'hyperliquid': 'Hyperliquid',
    'polygon': 'Polygon',
    'solana': 'Solana',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'BSC': 'BSC',
    'Arbitrum': 'arbitrum',
    'Base': 'base_',
    'Ethereum': 'ethereum',
    'Hyperliquid': 'hyperliquid',
    'Polygon': 'polygon',
    'Solana': 'solana',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[ActivityRecordChainEnum];
  @override
  final String wireName = 'ActivityRecordChainEnum';

  @override
  Object serialize(Serializers serializers, ActivityRecordChainEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  ActivityRecordChainEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      ActivityRecordChainEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$ActivityRecord extends ActivityRecord {
  @override
  final ActivityRecordBusinessTypeEnum? businessType;
  @override
  final String id;
  @override
  final ActivityCategory category;
  @override
  final ActivityType type;
  @override
  final ActivityStatus status;
  @override
  final String title;
  @override
  final String? amount;
  @override
  final String? context;
  @override
  final String? symbol;
  @override
  final ProductKind? kind;
  @override
  final BuiltList<KeyValue>? fields;
  @override
  final String? relatedId;
  @override
  final ActivityRecordReference? reference;
  @override
  final ActivityRecordChainEnum? chain;
  @override
  final String? txHash;
  @override
  final ActivityRecordExplorer? explorer;
  @override
  final DateTime createdAt;
  @override
  final DateTime updatedAt;
  @override
  final String? asset;

  factory _$ActivityRecord([void Function(ActivityRecordBuilder)? updates]) =>
      (ActivityRecordBuilder()..update(updates))._build();

  _$ActivityRecord._(
      {this.businessType,
      required this.id,
      required this.category,
      required this.type,
      required this.status,
      required this.title,
      this.amount,
      this.context,
      this.symbol,
      this.kind,
      this.fields,
      this.relatedId,
      this.reference,
      this.chain,
      this.txHash,
      this.explorer,
      required this.createdAt,
      required this.updatedAt,
      this.asset})
      : super._();
  @override
  ActivityRecord rebuild(void Function(ActivityRecordBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ActivityRecordBuilder toBuilder() => ActivityRecordBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ActivityRecord &&
        businessType == other.businessType &&
        id == other.id &&
        category == other.category &&
        type == other.type &&
        status == other.status &&
        title == other.title &&
        amount == other.amount &&
        context == other.context &&
        symbol == other.symbol &&
        kind == other.kind &&
        fields == other.fields &&
        relatedId == other.relatedId &&
        reference == other.reference &&
        chain == other.chain &&
        txHash == other.txHash &&
        explorer == other.explorer &&
        createdAt == other.createdAt &&
        updatedAt == other.updatedAt &&
        asset == other.asset;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, businessType.hashCode);
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, category.hashCode);
    _$hash = $jc(_$hash, type.hashCode);
    _$hash = $jc(_$hash, status.hashCode);
    _$hash = $jc(_$hash, title.hashCode);
    _$hash = $jc(_$hash, amount.hashCode);
    _$hash = $jc(_$hash, context.hashCode);
    _$hash = $jc(_$hash, symbol.hashCode);
    _$hash = $jc(_$hash, kind.hashCode);
    _$hash = $jc(_$hash, fields.hashCode);
    _$hash = $jc(_$hash, relatedId.hashCode);
    _$hash = $jc(_$hash, reference.hashCode);
    _$hash = $jc(_$hash, chain.hashCode);
    _$hash = $jc(_$hash, txHash.hashCode);
    _$hash = $jc(_$hash, explorer.hashCode);
    _$hash = $jc(_$hash, createdAt.hashCode);
    _$hash = $jc(_$hash, updatedAt.hashCode);
    _$hash = $jc(_$hash, asset.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'ActivityRecord')
          ..add('businessType', businessType)
          ..add('id', id)
          ..add('category', category)
          ..add('type', type)
          ..add('status', status)
          ..add('title', title)
          ..add('amount', amount)
          ..add('context', context)
          ..add('symbol', symbol)
          ..add('kind', kind)
          ..add('fields', fields)
          ..add('relatedId', relatedId)
          ..add('reference', reference)
          ..add('chain', chain)
          ..add('txHash', txHash)
          ..add('explorer', explorer)
          ..add('createdAt', createdAt)
          ..add('updatedAt', updatedAt)
          ..add('asset', asset))
        .toString();
  }
}

class ActivityRecordBuilder
    implements Builder<ActivityRecord, ActivityRecordBuilder> {
  _$ActivityRecord? _$v;

  ActivityRecordBusinessTypeEnum? _businessType;
  ActivityRecordBusinessTypeEnum? get businessType => _$this._businessType;
  set businessType(ActivityRecordBusinessTypeEnum? businessType) =>
      _$this._businessType = businessType;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  ActivityCategory? _category;
  ActivityCategory? get category => _$this._category;
  set category(ActivityCategory? category) => _$this._category = category;

  ActivityType? _type;
  ActivityType? get type => _$this._type;
  set type(ActivityType? type) => _$this._type = type;

  ActivityStatus? _status;
  ActivityStatus? get status => _$this._status;
  set status(ActivityStatus? status) => _$this._status = status;

  String? _title;
  String? get title => _$this._title;
  set title(String? title) => _$this._title = title;

  String? _amount;
  String? get amount => _$this._amount;
  set amount(String? amount) => _$this._amount = amount;

  String? _context;
  String? get context => _$this._context;
  set context(String? context) => _$this._context = context;

  String? _symbol;
  String? get symbol => _$this._symbol;
  set symbol(String? symbol) => _$this._symbol = symbol;

  ProductKind? _kind;
  ProductKind? get kind => _$this._kind;
  set kind(ProductKind? kind) => _$this._kind = kind;

  ListBuilder<KeyValue>? _fields;
  ListBuilder<KeyValue> get fields =>
      _$this._fields ??= ListBuilder<KeyValue>();
  set fields(ListBuilder<KeyValue>? fields) => _$this._fields = fields;

  String? _relatedId;
  String? get relatedId => _$this._relatedId;
  set relatedId(String? relatedId) => _$this._relatedId = relatedId;

  ActivityRecordReferenceBuilder? _reference;
  ActivityRecordReferenceBuilder get reference =>
      _$this._reference ??= ActivityRecordReferenceBuilder();
  set reference(ActivityRecordReferenceBuilder? reference) =>
      _$this._reference = reference;

  ActivityRecordChainEnum? _chain;
  ActivityRecordChainEnum? get chain => _$this._chain;
  set chain(ActivityRecordChainEnum? chain) => _$this._chain = chain;

  String? _txHash;
  String? get txHash => _$this._txHash;
  set txHash(String? txHash) => _$this._txHash = txHash;

  ActivityRecordExplorerBuilder? _explorer;
  ActivityRecordExplorerBuilder get explorer =>
      _$this._explorer ??= ActivityRecordExplorerBuilder();
  set explorer(ActivityRecordExplorerBuilder? explorer) =>
      _$this._explorer = explorer;

  DateTime? _createdAt;
  DateTime? get createdAt => _$this._createdAt;
  set createdAt(DateTime? createdAt) => _$this._createdAt = createdAt;

  DateTime? _updatedAt;
  DateTime? get updatedAt => _$this._updatedAt;
  set updatedAt(DateTime? updatedAt) => _$this._updatedAt = updatedAt;

  String? _asset;
  String? get asset => _$this._asset;
  set asset(String? asset) => _$this._asset = asset;

  ActivityRecordBuilder() {
    ActivityRecord._defaults(this);
  }

  ActivityRecordBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _businessType = $v.businessType;
      _id = $v.id;
      _category = $v.category;
      _type = $v.type;
      _status = $v.status;
      _title = $v.title;
      _amount = $v.amount;
      _context = $v.context;
      _symbol = $v.symbol;
      _kind = $v.kind;
      _fields = $v.fields?.toBuilder();
      _relatedId = $v.relatedId;
      _reference = $v.reference?.toBuilder();
      _chain = $v.chain;
      _txHash = $v.txHash;
      _explorer = $v.explorer?.toBuilder();
      _createdAt = $v.createdAt;
      _updatedAt = $v.updatedAt;
      _asset = $v.asset;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ActivityRecord other) {
    _$v = other as _$ActivityRecord;
  }

  @override
  void update(void Function(ActivityRecordBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ActivityRecord build() => _build();

  _$ActivityRecord _build() {
    _$ActivityRecord _$result;
    try {
      _$result = _$v ??
          _$ActivityRecord._(
            businessType: businessType,
            id: BuiltValueNullFieldError.checkNotNull(
                id, r'ActivityRecord', 'id'),
            category: BuiltValueNullFieldError.checkNotNull(
                category, r'ActivityRecord', 'category'),
            type: BuiltValueNullFieldError.checkNotNull(
                type, r'ActivityRecord', 'type'),
            status: BuiltValueNullFieldError.checkNotNull(
                status, r'ActivityRecord', 'status'),
            title: BuiltValueNullFieldError.checkNotNull(
                title, r'ActivityRecord', 'title'),
            amount: amount,
            context: context,
            symbol: symbol,
            kind: kind,
            fields: _fields?.build(),
            relatedId: relatedId,
            reference: _reference?.build(),
            chain: chain,
            txHash: txHash,
            explorer: _explorer?.build(),
            createdAt: BuiltValueNullFieldError.checkNotNull(
                createdAt, r'ActivityRecord', 'createdAt'),
            updatedAt: BuiltValueNullFieldError.checkNotNull(
                updatedAt, r'ActivityRecord', 'updatedAt'),
            asset: asset,
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'fields';
        _fields?.build();

        _$failedField = 'reference';
        _reference?.build();

        _$failedField = 'explorer';
        _explorer?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'ActivityRecord', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'activity_record.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ActivityRecord extends ActivityRecord {
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
  final Chain? chain;
  @override
  final String? txHash;
  @override
  final ActivityRecordExplorer? explorer;
  @override
  final DateTime createdAt;
  @override
  final DateTime? updatedAt;
  @override
  final String? asset;

  factory _$ActivityRecord([void Function(ActivityRecordBuilder)? updates]) =>
      (ActivityRecordBuilder()..update(updates))._build();

  _$ActivityRecord._(
      {required this.id,
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
      this.updatedAt,
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

  Chain? _chain;
  Chain? get chain => _$this._chain;
  set chain(Chain? chain) => _$this._chain = chain;

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
            updatedAt: updatedAt,
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

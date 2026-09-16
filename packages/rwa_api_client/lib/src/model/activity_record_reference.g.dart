// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'activity_record_reference.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const ActivityRecordReferenceTypeEnum _$activityRecordReferenceTypeEnum_order =
    const ActivityRecordReferenceTypeEnum._('order');
const ActivityRecordReferenceTypeEnum
    _$activityRecordReferenceTypeEnum_position =
    const ActivityRecordReferenceTypeEnum._('position');
const ActivityRecordReferenceTypeEnum
    _$activityRecordReferenceTypeEnum_transfer =
    const ActivityRecordReferenceTypeEnum._('transfer');
const ActivityRecordReferenceTypeEnum _$activityRecordReferenceTypeEnum_claim =
    const ActivityRecordReferenceTypeEnum._('claim');
const ActivityRecordReferenceTypeEnum
    _$activityRecordReferenceTypeEnum_deposit =
    const ActivityRecordReferenceTypeEnum._('deposit');
const ActivityRecordReferenceTypeEnum
    _$activityRecordReferenceTypeEnum_withdrawal =
    const ActivityRecordReferenceTypeEnum._('withdrawal');
const ActivityRecordReferenceTypeEnum
    _$activityRecordReferenceTypeEnum_fundingPayment =
    const ActivityRecordReferenceTypeEnum._('fundingPayment');
const ActivityRecordReferenceTypeEnum
    _$activityRecordReferenceTypeEnum_unknownDefaultOpenApi =
    const ActivityRecordReferenceTypeEnum._('unknownDefaultOpenApi');

ActivityRecordReferenceTypeEnum _$activityRecordReferenceTypeEnumValueOf(
    String name) {
  switch (name) {
    case 'order':
      return _$activityRecordReferenceTypeEnum_order;
    case 'position':
      return _$activityRecordReferenceTypeEnum_position;
    case 'transfer':
      return _$activityRecordReferenceTypeEnum_transfer;
    case 'claim':
      return _$activityRecordReferenceTypeEnum_claim;
    case 'deposit':
      return _$activityRecordReferenceTypeEnum_deposit;
    case 'withdrawal':
      return _$activityRecordReferenceTypeEnum_withdrawal;
    case 'fundingPayment':
      return _$activityRecordReferenceTypeEnum_fundingPayment;
    case 'unknownDefaultOpenApi':
      return _$activityRecordReferenceTypeEnum_unknownDefaultOpenApi;
    default:
      return _$activityRecordReferenceTypeEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<ActivityRecordReferenceTypeEnum>
    _$activityRecordReferenceTypeEnumValues = BuiltSet<
        ActivityRecordReferenceTypeEnum>(const <ActivityRecordReferenceTypeEnum>[
  _$activityRecordReferenceTypeEnum_order,
  _$activityRecordReferenceTypeEnum_position,
  _$activityRecordReferenceTypeEnum_transfer,
  _$activityRecordReferenceTypeEnum_claim,
  _$activityRecordReferenceTypeEnum_deposit,
  _$activityRecordReferenceTypeEnum_withdrawal,
  _$activityRecordReferenceTypeEnum_fundingPayment,
  _$activityRecordReferenceTypeEnum_unknownDefaultOpenApi,
]);

Serializer<ActivityRecordReferenceTypeEnum>
    _$activityRecordReferenceTypeEnumSerializer =
    _$ActivityRecordReferenceTypeEnumSerializer();

class _$ActivityRecordReferenceTypeEnumSerializer
    implements PrimitiveSerializer<ActivityRecordReferenceTypeEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'order': 'order',
    'position': 'position',
    'transfer': 'transfer',
    'claim': 'claim',
    'deposit': 'deposit',
    'withdrawal': 'withdrawal',
    'fundingPayment': 'funding_payment',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'order': 'order',
    'position': 'position',
    'transfer': 'transfer',
    'claim': 'claim',
    'deposit': 'deposit',
    'withdrawal': 'withdrawal',
    'funding_payment': 'fundingPayment',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[ActivityRecordReferenceTypeEnum];
  @override
  final String wireName = 'ActivityRecordReferenceTypeEnum';

  @override
  Object serialize(
          Serializers serializers, ActivityRecordReferenceTypeEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  ActivityRecordReferenceTypeEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      ActivityRecordReferenceTypeEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$ActivityRecordReference extends ActivityRecordReference {
  @override
  final ActivityRecordReferenceTypeEnum type;
  @override
  final String id;

  factory _$ActivityRecordReference(
          [void Function(ActivityRecordReferenceBuilder)? updates]) =>
      (ActivityRecordReferenceBuilder()..update(updates))._build();

  _$ActivityRecordReference._({required this.type, required this.id})
      : super._();
  @override
  ActivityRecordReference rebuild(
          void Function(ActivityRecordReferenceBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ActivityRecordReferenceBuilder toBuilder() =>
      ActivityRecordReferenceBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ActivityRecordReference &&
        type == other.type &&
        id == other.id;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, type.hashCode);
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'ActivityRecordReference')
          ..add('type', type)
          ..add('id', id))
        .toString();
  }
}

class ActivityRecordReferenceBuilder
    implements
        Builder<ActivityRecordReference, ActivityRecordReferenceBuilder> {
  _$ActivityRecordReference? _$v;

  ActivityRecordReferenceTypeEnum? _type;
  ActivityRecordReferenceTypeEnum? get type => _$this._type;
  set type(ActivityRecordReferenceTypeEnum? type) => _$this._type = type;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  ActivityRecordReferenceBuilder() {
    ActivityRecordReference._defaults(this);
  }

  ActivityRecordReferenceBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _type = $v.type;
      _id = $v.id;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ActivityRecordReference other) {
    _$v = other as _$ActivityRecordReference;
  }

  @override
  void update(void Function(ActivityRecordReferenceBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ActivityRecordReference build() => _build();

  _$ActivityRecordReference _build() {
    final _$result = _$v ??
        _$ActivityRecordReference._(
          type: BuiltValueNullFieldError.checkNotNull(
              type, r'ActivityRecordReference', 'type'),
          id: BuiltValueNullFieldError.checkNotNull(
              id, r'ActivityRecordReference', 'id'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint

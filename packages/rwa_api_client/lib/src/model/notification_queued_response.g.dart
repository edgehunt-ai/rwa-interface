// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_queued_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const NotificationQueuedResponseStatusEnum
    _$notificationQueuedResponseStatusEnum_queued =
    const NotificationQueuedResponseStatusEnum._('queued');
const NotificationQueuedResponseStatusEnum
    _$notificationQueuedResponseStatusEnum_unknownDefaultOpenApi =
    const NotificationQueuedResponseStatusEnum._('unknownDefaultOpenApi');

NotificationQueuedResponseStatusEnum
    _$notificationQueuedResponseStatusEnumValueOf(String name) {
  switch (name) {
    case 'queued':
      return _$notificationQueuedResponseStatusEnum_queued;
    case 'unknownDefaultOpenApi':
      return _$notificationQueuedResponseStatusEnum_unknownDefaultOpenApi;
    default:
      return _$notificationQueuedResponseStatusEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<NotificationQueuedResponseStatusEnum>
    _$notificationQueuedResponseStatusEnumValues = BuiltSet<
        NotificationQueuedResponseStatusEnum>(const <NotificationQueuedResponseStatusEnum>[
  _$notificationQueuedResponseStatusEnum_queued,
  _$notificationQueuedResponseStatusEnum_unknownDefaultOpenApi,
]);

Serializer<NotificationQueuedResponseStatusEnum>
    _$notificationQueuedResponseStatusEnumSerializer =
    _$NotificationQueuedResponseStatusEnumSerializer();

class _$NotificationQueuedResponseStatusEnumSerializer
    implements PrimitiveSerializer<NotificationQueuedResponseStatusEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'queued': 'queued',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'queued': 'queued',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[
    NotificationQueuedResponseStatusEnum
  ];
  @override
  final String wireName = 'NotificationQueuedResponseStatusEnum';

  @override
  Object serialize(
          Serializers serializers, NotificationQueuedResponseStatusEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  NotificationQueuedResponseStatusEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      NotificationQueuedResponseStatusEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$NotificationQueuedResponse extends NotificationQueuedResponse {
  @override
  final String notificationId;
  @override
  final NotificationQueuedResponseStatusEnum status;

  factory _$NotificationQueuedResponse(
          [void Function(NotificationQueuedResponseBuilder)? updates]) =>
      (NotificationQueuedResponseBuilder()..update(updates))._build();

  _$NotificationQueuedResponse._(
      {required this.notificationId, required this.status})
      : super._();
  @override
  NotificationQueuedResponse rebuild(
          void Function(NotificationQueuedResponseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  NotificationQueuedResponseBuilder toBuilder() =>
      NotificationQueuedResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is NotificationQueuedResponse &&
        notificationId == other.notificationId &&
        status == other.status;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, notificationId.hashCode);
    _$hash = $jc(_$hash, status.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'NotificationQueuedResponse')
          ..add('notificationId', notificationId)
          ..add('status', status))
        .toString();
  }
}

class NotificationQueuedResponseBuilder
    implements
        Builder<NotificationQueuedResponse, NotificationQueuedResponseBuilder> {
  _$NotificationQueuedResponse? _$v;

  String? _notificationId;
  String? get notificationId => _$this._notificationId;
  set notificationId(String? notificationId) =>
      _$this._notificationId = notificationId;

  NotificationQueuedResponseStatusEnum? _status;
  NotificationQueuedResponseStatusEnum? get status => _$this._status;
  set status(NotificationQueuedResponseStatusEnum? status) =>
      _$this._status = status;

  NotificationQueuedResponseBuilder() {
    NotificationQueuedResponse._defaults(this);
  }

  NotificationQueuedResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _notificationId = $v.notificationId;
      _status = $v.status;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(NotificationQueuedResponse other) {
    _$v = other as _$NotificationQueuedResponse;
  }

  @override
  void update(void Function(NotificationQueuedResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  NotificationQueuedResponse build() => _build();

  _$NotificationQueuedResponse _build() {
    final _$result = _$v ??
        _$NotificationQueuedResponse._(
          notificationId: BuiltValueNullFieldError.checkNotNull(
              notificationId, r'NotificationQueuedResponse', 'notificationId'),
          status: BuiltValueNullFieldError.checkNotNull(
              status, r'NotificationQueuedResponse', 'status'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint

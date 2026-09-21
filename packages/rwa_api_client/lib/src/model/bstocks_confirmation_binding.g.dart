// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bstocks_confirmation_binding.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const BstocksConfirmationBindingStatusEnum
    _$bstocksConfirmationBindingStatusEnum_frozen =
    const BstocksConfirmationBindingStatusEnum._('frozen');
const BstocksConfirmationBindingStatusEnum
    _$bstocksConfirmationBindingStatusEnum_unknownDefaultOpenApi =
    const BstocksConfirmationBindingStatusEnum._('unknownDefaultOpenApi');

BstocksConfirmationBindingStatusEnum
    _$bstocksConfirmationBindingStatusEnumValueOf(String name) {
  switch (name) {
    case 'frozen':
      return _$bstocksConfirmationBindingStatusEnum_frozen;
    case 'unknownDefaultOpenApi':
      return _$bstocksConfirmationBindingStatusEnum_unknownDefaultOpenApi;
    default:
      return _$bstocksConfirmationBindingStatusEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<BstocksConfirmationBindingStatusEnum>
    _$bstocksConfirmationBindingStatusEnumValues = BuiltSet<
        BstocksConfirmationBindingStatusEnum>(const <BstocksConfirmationBindingStatusEnum>[
  _$bstocksConfirmationBindingStatusEnum_frozen,
  _$bstocksConfirmationBindingStatusEnum_unknownDefaultOpenApi,
]);

const BstocksConfirmationBindingDeadlineKindEnum
    _$bstocksConfirmationBindingDeadlineKindEnum_serverPreviewDeadline =
    const BstocksConfirmationBindingDeadlineKindEnum._('serverPreviewDeadline');
const BstocksConfirmationBindingDeadlineKindEnum
    _$bstocksConfirmationBindingDeadlineKindEnum_unknownDefaultOpenApi =
    const BstocksConfirmationBindingDeadlineKindEnum._('unknownDefaultOpenApi');

BstocksConfirmationBindingDeadlineKindEnum
    _$bstocksConfirmationBindingDeadlineKindEnumValueOf(String name) {
  switch (name) {
    case 'serverPreviewDeadline':
      return _$bstocksConfirmationBindingDeadlineKindEnum_serverPreviewDeadline;
    case 'unknownDefaultOpenApi':
      return _$bstocksConfirmationBindingDeadlineKindEnum_unknownDefaultOpenApi;
    default:
      return _$bstocksConfirmationBindingDeadlineKindEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<BstocksConfirmationBindingDeadlineKindEnum>
    _$bstocksConfirmationBindingDeadlineKindEnumValues = BuiltSet<
        BstocksConfirmationBindingDeadlineKindEnum>(const <BstocksConfirmationBindingDeadlineKindEnum>[
  _$bstocksConfirmationBindingDeadlineKindEnum_serverPreviewDeadline,
  _$bstocksConfirmationBindingDeadlineKindEnum_unknownDefaultOpenApi,
]);

Serializer<BstocksConfirmationBindingStatusEnum>
    _$bstocksConfirmationBindingStatusEnumSerializer =
    _$BstocksConfirmationBindingStatusEnumSerializer();
Serializer<BstocksConfirmationBindingDeadlineKindEnum>
    _$bstocksConfirmationBindingDeadlineKindEnumSerializer =
    _$BstocksConfirmationBindingDeadlineKindEnumSerializer();

class _$BstocksConfirmationBindingStatusEnumSerializer
    implements PrimitiveSerializer<BstocksConfirmationBindingStatusEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'frozen': 'frozen',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'frozen': 'frozen',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[
    BstocksConfirmationBindingStatusEnum
  ];
  @override
  final String wireName = 'BstocksConfirmationBindingStatusEnum';

  @override
  Object serialize(
          Serializers serializers, BstocksConfirmationBindingStatusEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  BstocksConfirmationBindingStatusEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      BstocksConfirmationBindingStatusEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$BstocksConfirmationBindingDeadlineKindEnumSerializer
    implements PrimitiveSerializer<BstocksConfirmationBindingDeadlineKindEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'serverPreviewDeadline': 'server_preview_deadline',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'server_preview_deadline': 'serverPreviewDeadline',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[
    BstocksConfirmationBindingDeadlineKindEnum
  ];
  @override
  final String wireName = 'BstocksConfirmationBindingDeadlineKindEnum';

  @override
  Object serialize(Serializers serializers,
          BstocksConfirmationBindingDeadlineKindEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  BstocksConfirmationBindingDeadlineKindEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      BstocksConfirmationBindingDeadlineKindEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$BstocksConfirmationBinding extends BstocksConfirmationBinding {
  @override
  final BstocksConfirmationBindingStatusEnum status;
  @override
  final DateTime expiresAt;
  @override
  final BstocksConfirmationBindingDeadlineKindEnum deadlineKind;
  @override
  final String maximumInputRaw;
  @override
  final String? minimumOutputRaw;
  @override
  final bool approvalRequiresNewPreview;

  factory _$BstocksConfirmationBinding(
          [void Function(BstocksConfirmationBindingBuilder)? updates]) =>
      (BstocksConfirmationBindingBuilder()..update(updates))._build();

  _$BstocksConfirmationBinding._(
      {required this.status,
      required this.expiresAt,
      required this.deadlineKind,
      required this.maximumInputRaw,
      this.minimumOutputRaw,
      required this.approvalRequiresNewPreview})
      : super._();
  @override
  BstocksConfirmationBinding rebuild(
          void Function(BstocksConfirmationBindingBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  BstocksConfirmationBindingBuilder toBuilder() =>
      BstocksConfirmationBindingBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is BstocksConfirmationBinding &&
        status == other.status &&
        expiresAt == other.expiresAt &&
        deadlineKind == other.deadlineKind &&
        maximumInputRaw == other.maximumInputRaw &&
        minimumOutputRaw == other.minimumOutputRaw &&
        approvalRequiresNewPreview == other.approvalRequiresNewPreview;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, status.hashCode);
    _$hash = $jc(_$hash, expiresAt.hashCode);
    _$hash = $jc(_$hash, deadlineKind.hashCode);
    _$hash = $jc(_$hash, maximumInputRaw.hashCode);
    _$hash = $jc(_$hash, minimumOutputRaw.hashCode);
    _$hash = $jc(_$hash, approvalRequiresNewPreview.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'BstocksConfirmationBinding')
          ..add('status', status)
          ..add('expiresAt', expiresAt)
          ..add('deadlineKind', deadlineKind)
          ..add('maximumInputRaw', maximumInputRaw)
          ..add('minimumOutputRaw', minimumOutputRaw)
          ..add('approvalRequiresNewPreview', approvalRequiresNewPreview))
        .toString();
  }
}

class BstocksConfirmationBindingBuilder
    implements
        Builder<BstocksConfirmationBinding, BstocksConfirmationBindingBuilder> {
  _$BstocksConfirmationBinding? _$v;

  BstocksConfirmationBindingStatusEnum? _status;
  BstocksConfirmationBindingStatusEnum? get status => _$this._status;
  set status(BstocksConfirmationBindingStatusEnum? status) =>
      _$this._status = status;

  DateTime? _expiresAt;
  DateTime? get expiresAt => _$this._expiresAt;
  set expiresAt(DateTime? expiresAt) => _$this._expiresAt = expiresAt;

  BstocksConfirmationBindingDeadlineKindEnum? _deadlineKind;
  BstocksConfirmationBindingDeadlineKindEnum? get deadlineKind =>
      _$this._deadlineKind;
  set deadlineKind(BstocksConfirmationBindingDeadlineKindEnum? deadlineKind) =>
      _$this._deadlineKind = deadlineKind;

  String? _maximumInputRaw;
  String? get maximumInputRaw => _$this._maximumInputRaw;
  set maximumInputRaw(String? maximumInputRaw) =>
      _$this._maximumInputRaw = maximumInputRaw;

  String? _minimumOutputRaw;
  String? get minimumOutputRaw => _$this._minimumOutputRaw;
  set minimumOutputRaw(String? minimumOutputRaw) =>
      _$this._minimumOutputRaw = minimumOutputRaw;

  bool? _approvalRequiresNewPreview;
  bool? get approvalRequiresNewPreview => _$this._approvalRequiresNewPreview;
  set approvalRequiresNewPreview(bool? approvalRequiresNewPreview) =>
      _$this._approvalRequiresNewPreview = approvalRequiresNewPreview;

  BstocksConfirmationBindingBuilder() {
    BstocksConfirmationBinding._defaults(this);
  }

  BstocksConfirmationBindingBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _status = $v.status;
      _expiresAt = $v.expiresAt;
      _deadlineKind = $v.deadlineKind;
      _maximumInputRaw = $v.maximumInputRaw;
      _minimumOutputRaw = $v.minimumOutputRaw;
      _approvalRequiresNewPreview = $v.approvalRequiresNewPreview;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(BstocksConfirmationBinding other) {
    _$v = other as _$BstocksConfirmationBinding;
  }

  @override
  void update(void Function(BstocksConfirmationBindingBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  BstocksConfirmationBinding build() => _build();

  _$BstocksConfirmationBinding _build() {
    final _$result = _$v ??
        _$BstocksConfirmationBinding._(
          status: BuiltValueNullFieldError.checkNotNull(
              status, r'BstocksConfirmationBinding', 'status'),
          expiresAt: BuiltValueNullFieldError.checkNotNull(
              expiresAt, r'BstocksConfirmationBinding', 'expiresAt'),
          deadlineKind: BuiltValueNullFieldError.checkNotNull(
              deadlineKind, r'BstocksConfirmationBinding', 'deadlineKind'),
          maximumInputRaw: BuiltValueNullFieldError.checkNotNull(
              maximumInputRaw,
              r'BstocksConfirmationBinding',
              'maximumInputRaw'),
          minimumOutputRaw: minimumOutputRaw,
          approvalRequiresNewPreview: BuiltValueNullFieldError.checkNotNull(
              approvalRequiresNewPreview,
              r'BstocksConfirmationBinding',
              'approvalRequiresNewPreview'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint

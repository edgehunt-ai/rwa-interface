// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'locked_executable_action_transfer_state.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const LockedExecutableActionTransferStateStatusEnum
    _$lockedExecutableActionTransferStateStatusEnum_awaitingWallet =
    const LockedExecutableActionTransferStateStatusEnum._('awaitingWallet');
const LockedExecutableActionTransferStateStatusEnum
    _$lockedExecutableActionTransferStateStatusEnum_unknownDefaultOpenApi =
    const LockedExecutableActionTransferStateStatusEnum._(
        'unknownDefaultOpenApi');

LockedExecutableActionTransferStateStatusEnum
    _$lockedExecutableActionTransferStateStatusEnumValueOf(String name) {
  switch (name) {
    case 'awaitingWallet':
      return _$lockedExecutableActionTransferStateStatusEnum_awaitingWallet;
    case 'unknownDefaultOpenApi':
      return _$lockedExecutableActionTransferStateStatusEnum_unknownDefaultOpenApi;
    default:
      return _$lockedExecutableActionTransferStateStatusEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<LockedExecutableActionTransferStateStatusEnum>
    _$lockedExecutableActionTransferStateStatusEnumValues = BuiltSet<
        LockedExecutableActionTransferStateStatusEnum>(const <LockedExecutableActionTransferStateStatusEnum>[
  _$lockedExecutableActionTransferStateStatusEnum_awaitingWallet,
  _$lockedExecutableActionTransferStateStatusEnum_unknownDefaultOpenApi,
]);

Serializer<LockedExecutableActionTransferStateStatusEnum>
    _$lockedExecutableActionTransferStateStatusEnumSerializer =
    _$LockedExecutableActionTransferStateStatusEnumSerializer();

class _$LockedExecutableActionTransferStateStatusEnumSerializer
    implements
        PrimitiveSerializer<LockedExecutableActionTransferStateStatusEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'awaitingWallet': 'awaiting_wallet',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'awaiting_wallet': 'awaitingWallet',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[
    LockedExecutableActionTransferStateStatusEnum
  ];
  @override
  final String wireName = 'LockedExecutableActionTransferStateStatusEnum';

  @override
  Object serialize(Serializers serializers,
          LockedExecutableActionTransferStateStatusEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  LockedExecutableActionTransferStateStatusEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      LockedExecutableActionTransferStateStatusEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$LockedExecutableActionTransferState
    extends LockedExecutableActionTransferState {
  @override
  final LockedExecutableActionTransferStateStatusEnum status;
  @override
  final ReadyFundingWalletAction nextAction;
  @override
  final DateTime routeLockedAt;
  @override
  final DateTime walletActionReleasedAt;

  factory _$LockedExecutableActionTransferState(
          [void Function(LockedExecutableActionTransferStateBuilder)?
              updates]) =>
      (LockedExecutableActionTransferStateBuilder()..update(updates))._build();

  _$LockedExecutableActionTransferState._(
      {required this.status,
      required this.nextAction,
      required this.routeLockedAt,
      required this.walletActionReleasedAt})
      : super._();
  @override
  LockedExecutableActionTransferState rebuild(
          void Function(LockedExecutableActionTransferStateBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  LockedExecutableActionTransferStateBuilder toBuilder() =>
      LockedExecutableActionTransferStateBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is LockedExecutableActionTransferState &&
        status == other.status &&
        nextAction == other.nextAction &&
        routeLockedAt == other.routeLockedAt &&
        walletActionReleasedAt == other.walletActionReleasedAt;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, status.hashCode);
    _$hash = $jc(_$hash, nextAction.hashCode);
    _$hash = $jc(_$hash, routeLockedAt.hashCode);
    _$hash = $jc(_$hash, walletActionReleasedAt.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'LockedExecutableActionTransferState')
          ..add('status', status)
          ..add('nextAction', nextAction)
          ..add('routeLockedAt', routeLockedAt)
          ..add('walletActionReleasedAt', walletActionReleasedAt))
        .toString();
  }
}

class LockedExecutableActionTransferStateBuilder
    implements
        Builder<LockedExecutableActionTransferState,
            LockedExecutableActionTransferStateBuilder> {
  _$LockedExecutableActionTransferState? _$v;

  LockedExecutableActionTransferStateStatusEnum? _status;
  LockedExecutableActionTransferStateStatusEnum? get status => _$this._status;
  set status(LockedExecutableActionTransferStateStatusEnum? status) =>
      _$this._status = status;

  ReadyFundingWalletActionBuilder? _nextAction;
  ReadyFundingWalletActionBuilder get nextAction =>
      _$this._nextAction ??= ReadyFundingWalletActionBuilder();
  set nextAction(ReadyFundingWalletActionBuilder? nextAction) =>
      _$this._nextAction = nextAction;

  DateTime? _routeLockedAt;
  DateTime? get routeLockedAt => _$this._routeLockedAt;
  set routeLockedAt(DateTime? routeLockedAt) =>
      _$this._routeLockedAt = routeLockedAt;

  DateTime? _walletActionReleasedAt;
  DateTime? get walletActionReleasedAt => _$this._walletActionReleasedAt;
  set walletActionReleasedAt(DateTime? walletActionReleasedAt) =>
      _$this._walletActionReleasedAt = walletActionReleasedAt;

  LockedExecutableActionTransferStateBuilder() {
    LockedExecutableActionTransferState._defaults(this);
  }

  LockedExecutableActionTransferStateBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _status = $v.status;
      _nextAction = $v.nextAction.toBuilder();
      _routeLockedAt = $v.routeLockedAt;
      _walletActionReleasedAt = $v.walletActionReleasedAt;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(LockedExecutableActionTransferState other) {
    _$v = other as _$LockedExecutableActionTransferState;
  }

  @override
  void update(
      void Function(LockedExecutableActionTransferStateBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  LockedExecutableActionTransferState build() => _build();

  _$LockedExecutableActionTransferState _build() {
    _$LockedExecutableActionTransferState _$result;
    try {
      _$result = _$v ??
          _$LockedExecutableActionTransferState._(
            status: BuiltValueNullFieldError.checkNotNull(
                status, r'LockedExecutableActionTransferState', 'status'),
            nextAction: nextAction.build(),
            routeLockedAt: BuiltValueNullFieldError.checkNotNull(routeLockedAt,
                r'LockedExecutableActionTransferState', 'routeLockedAt'),
            walletActionReleasedAt: BuiltValueNullFieldError.checkNotNull(
                walletActionReleasedAt,
                r'LockedExecutableActionTransferState',
                'walletActionReleasedAt'),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'nextAction';
        nextAction.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(r'LockedExecutableActionTransferState',
            _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint

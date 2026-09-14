// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hip3_account_abstraction.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const Hip3AccountAbstractionTargetModeEnum
    _$hip3AccountAbstractionTargetModeEnum_unifiedAccount =
    const Hip3AccountAbstractionTargetModeEnum._('unifiedAccount');
const Hip3AccountAbstractionTargetModeEnum
    _$hip3AccountAbstractionTargetModeEnum_unknownDefaultOpenApi =
    const Hip3AccountAbstractionTargetModeEnum._('unknownDefaultOpenApi');

Hip3AccountAbstractionTargetModeEnum
    _$hip3AccountAbstractionTargetModeEnumValueOf(String name) {
  switch (name) {
    case 'unifiedAccount':
      return _$hip3AccountAbstractionTargetModeEnum_unifiedAccount;
    case 'unknownDefaultOpenApi':
      return _$hip3AccountAbstractionTargetModeEnum_unknownDefaultOpenApi;
    default:
      return _$hip3AccountAbstractionTargetModeEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<Hip3AccountAbstractionTargetModeEnum>
    _$hip3AccountAbstractionTargetModeEnumValues = BuiltSet<
        Hip3AccountAbstractionTargetModeEnum>(const <Hip3AccountAbstractionTargetModeEnum>[
  _$hip3AccountAbstractionTargetModeEnum_unifiedAccount,
  _$hip3AccountAbstractionTargetModeEnum_unknownDefaultOpenApi,
]);

Serializer<Hip3AccountAbstractionTargetModeEnum>
    _$hip3AccountAbstractionTargetModeEnumSerializer =
    _$Hip3AccountAbstractionTargetModeEnumSerializer();

class _$Hip3AccountAbstractionTargetModeEnumSerializer
    implements PrimitiveSerializer<Hip3AccountAbstractionTargetModeEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'unifiedAccount': 'unifiedAccount',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'unifiedAccount': 'unifiedAccount',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[
    Hip3AccountAbstractionTargetModeEnum
  ];
  @override
  final String wireName = 'Hip3AccountAbstractionTargetModeEnum';

  @override
  Object serialize(
          Serializers serializers, Hip3AccountAbstractionTargetModeEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  Hip3AccountAbstractionTargetModeEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      Hip3AccountAbstractionTargetModeEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$Hip3AccountAbstraction extends Hip3AccountAbstraction {
  @override
  final String ownerAddress;
  @override
  final Hip3AccountAbstractionMode currentMode;
  @override
  final Hip3AccountAbstractionTargetModeEnum targetMode;
  @override
  final bool switchAvailable;
  @override
  final Hip3AgentStatus? agentStatus;
  @override
  final DateTime observedAt;

  factory _$Hip3AccountAbstraction(
          [void Function(Hip3AccountAbstractionBuilder)? updates]) =>
      (Hip3AccountAbstractionBuilder()..update(updates))._build();

  _$Hip3AccountAbstraction._(
      {required this.ownerAddress,
      required this.currentMode,
      required this.targetMode,
      required this.switchAvailable,
      this.agentStatus,
      required this.observedAt})
      : super._();
  @override
  Hip3AccountAbstraction rebuild(
          void Function(Hip3AccountAbstractionBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  Hip3AccountAbstractionBuilder toBuilder() =>
      Hip3AccountAbstractionBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Hip3AccountAbstraction &&
        ownerAddress == other.ownerAddress &&
        currentMode == other.currentMode &&
        targetMode == other.targetMode &&
        switchAvailable == other.switchAvailable &&
        agentStatus == other.agentStatus &&
        observedAt == other.observedAt;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, ownerAddress.hashCode);
    _$hash = $jc(_$hash, currentMode.hashCode);
    _$hash = $jc(_$hash, targetMode.hashCode);
    _$hash = $jc(_$hash, switchAvailable.hashCode);
    _$hash = $jc(_$hash, agentStatus.hashCode);
    _$hash = $jc(_$hash, observedAt.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'Hip3AccountAbstraction')
          ..add('ownerAddress', ownerAddress)
          ..add('currentMode', currentMode)
          ..add('targetMode', targetMode)
          ..add('switchAvailable', switchAvailable)
          ..add('agentStatus', agentStatus)
          ..add('observedAt', observedAt))
        .toString();
  }
}

class Hip3AccountAbstractionBuilder
    implements Builder<Hip3AccountAbstraction, Hip3AccountAbstractionBuilder> {
  _$Hip3AccountAbstraction? _$v;

  String? _ownerAddress;
  String? get ownerAddress => _$this._ownerAddress;
  set ownerAddress(String? ownerAddress) => _$this._ownerAddress = ownerAddress;

  Hip3AccountAbstractionMode? _currentMode;
  Hip3AccountAbstractionMode? get currentMode => _$this._currentMode;
  set currentMode(Hip3AccountAbstractionMode? currentMode) =>
      _$this._currentMode = currentMode;

  Hip3AccountAbstractionTargetModeEnum? _targetMode;
  Hip3AccountAbstractionTargetModeEnum? get targetMode => _$this._targetMode;
  set targetMode(Hip3AccountAbstractionTargetModeEnum? targetMode) =>
      _$this._targetMode = targetMode;

  bool? _switchAvailable;
  bool? get switchAvailable => _$this._switchAvailable;
  set switchAvailable(bool? switchAvailable) =>
      _$this._switchAvailable = switchAvailable;

  Hip3AgentStatus? _agentStatus;
  Hip3AgentStatus? get agentStatus => _$this._agentStatus;
  set agentStatus(Hip3AgentStatus? agentStatus) =>
      _$this._agentStatus = agentStatus;

  DateTime? _observedAt;
  DateTime? get observedAt => _$this._observedAt;
  set observedAt(DateTime? observedAt) => _$this._observedAt = observedAt;

  Hip3AccountAbstractionBuilder() {
    Hip3AccountAbstraction._defaults(this);
  }

  Hip3AccountAbstractionBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _ownerAddress = $v.ownerAddress;
      _currentMode = $v.currentMode;
      _targetMode = $v.targetMode;
      _switchAvailable = $v.switchAvailable;
      _agentStatus = $v.agentStatus;
      _observedAt = $v.observedAt;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Hip3AccountAbstraction other) {
    _$v = other as _$Hip3AccountAbstraction;
  }

  @override
  void update(void Function(Hip3AccountAbstractionBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  Hip3AccountAbstraction build() => _build();

  _$Hip3AccountAbstraction _build() {
    final _$result = _$v ??
        _$Hip3AccountAbstraction._(
          ownerAddress: BuiltValueNullFieldError.checkNotNull(
              ownerAddress, r'Hip3AccountAbstraction', 'ownerAddress'),
          currentMode: BuiltValueNullFieldError.checkNotNull(
              currentMode, r'Hip3AccountAbstraction', 'currentMode'),
          targetMode: BuiltValueNullFieldError.checkNotNull(
              targetMode, r'Hip3AccountAbstraction', 'targetMode'),
          switchAvailable: BuiltValueNullFieldError.checkNotNull(
              switchAvailable, r'Hip3AccountAbstraction', 'switchAvailable'),
          agentStatus: agentStatus,
          observedAt: BuiltValueNullFieldError.checkNotNull(
              observedAt, r'Hip3AccountAbstraction', 'observedAt'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'no_executable_action_transfer_state.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$NoExecutableActionTransferState
    extends NoExecutableActionTransferState {
  @override
  final JsonObject? nextAction;

  factory _$NoExecutableActionTransferState(
          [void Function(NoExecutableActionTransferStateBuilder)? updates]) =>
      (NoExecutableActionTransferStateBuilder()..update(updates))._build();

  _$NoExecutableActionTransferState._({this.nextAction}) : super._();
  @override
  NoExecutableActionTransferState rebuild(
          void Function(NoExecutableActionTransferStateBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  NoExecutableActionTransferStateBuilder toBuilder() =>
      NoExecutableActionTransferStateBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is NoExecutableActionTransferState &&
        nextAction == other.nextAction;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, nextAction.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'NoExecutableActionTransferState')
          ..add('nextAction', nextAction))
        .toString();
  }
}

class NoExecutableActionTransferStateBuilder
    implements
        Builder<NoExecutableActionTransferState,
            NoExecutableActionTransferStateBuilder> {
  _$NoExecutableActionTransferState? _$v;

  JsonObject? _nextAction;
  JsonObject? get nextAction => _$this._nextAction;
  set nextAction(JsonObject? nextAction) => _$this._nextAction = nextAction;

  NoExecutableActionTransferStateBuilder() {
    NoExecutableActionTransferState._defaults(this);
  }

  NoExecutableActionTransferStateBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _nextAction = $v.nextAction;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(NoExecutableActionTransferState other) {
    _$v = other as _$NoExecutableActionTransferState;
  }

  @override
  void update(void Function(NoExecutableActionTransferStateBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  NoExecutableActionTransferState build() => _build();

  _$NoExecutableActionTransferState _build() {
    final _$result = _$v ??
        _$NoExecutableActionTransferState._(
          nextAction: nextAction,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint

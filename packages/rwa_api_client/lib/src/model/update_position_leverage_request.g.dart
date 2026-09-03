// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_position_leverage_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$UpdatePositionLeverageRequest extends UpdatePositionLeverageRequest {
  @override
  final String? leverage;
  @override
  final MarginMode? marginMode;

  factory _$UpdatePositionLeverageRequest(
          [void Function(UpdatePositionLeverageRequestBuilder)? updates]) =>
      (UpdatePositionLeverageRequestBuilder()..update(updates))._build();

  _$UpdatePositionLeverageRequest._({this.leverage, this.marginMode})
      : super._();
  @override
  UpdatePositionLeverageRequest rebuild(
          void Function(UpdatePositionLeverageRequestBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  UpdatePositionLeverageRequestBuilder toBuilder() =>
      UpdatePositionLeverageRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is UpdatePositionLeverageRequest &&
        leverage == other.leverage &&
        marginMode == other.marginMode;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, leverage.hashCode);
    _$hash = $jc(_$hash, marginMode.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'UpdatePositionLeverageRequest')
          ..add('leverage', leverage)
          ..add('marginMode', marginMode))
        .toString();
  }
}

class UpdatePositionLeverageRequestBuilder
    implements
        Builder<UpdatePositionLeverageRequest,
            UpdatePositionLeverageRequestBuilder> {
  _$UpdatePositionLeverageRequest? _$v;

  String? _leverage;
  String? get leverage => _$this._leverage;
  set leverage(String? leverage) => _$this._leverage = leverage;

  MarginMode? _marginMode;
  MarginMode? get marginMode => _$this._marginMode;
  set marginMode(MarginMode? marginMode) => _$this._marginMode = marginMode;

  UpdatePositionLeverageRequestBuilder() {
    UpdatePositionLeverageRequest._defaults(this);
  }

  UpdatePositionLeverageRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _leverage = $v.leverage;
      _marginMode = $v.marginMode;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(UpdatePositionLeverageRequest other) {
    _$v = other as _$UpdatePositionLeverageRequest;
  }

  @override
  void update(void Function(UpdatePositionLeverageRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  UpdatePositionLeverageRequest build() => _build();

  _$UpdatePositionLeverageRequest _build() {
    final _$result = _$v ??
        _$UpdatePositionLeverageRequest._(
          leverage: leverage,
          marginMode: marginMode,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint

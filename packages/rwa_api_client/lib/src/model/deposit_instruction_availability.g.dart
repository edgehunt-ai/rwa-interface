// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'deposit_instruction_availability.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$DepositInstructionAvailability extends DepositInstructionAvailability {
  @override
  final String status;
  @override
  final BuiltList<String> blockers;

  factory _$DepositInstructionAvailability(
          [void Function(DepositInstructionAvailabilityBuilder)? updates]) =>
      (DepositInstructionAvailabilityBuilder()..update(updates))._build();

  _$DepositInstructionAvailability._(
      {required this.status, required this.blockers})
      : super._();
  @override
  DepositInstructionAvailability rebuild(
          void Function(DepositInstructionAvailabilityBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  DepositInstructionAvailabilityBuilder toBuilder() =>
      DepositInstructionAvailabilityBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is DepositInstructionAvailability &&
        status == other.status &&
        blockers == other.blockers;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, status.hashCode);
    _$hash = $jc(_$hash, blockers.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'DepositInstructionAvailability')
          ..add('status', status)
          ..add('blockers', blockers))
        .toString();
  }
}

class DepositInstructionAvailabilityBuilder
    implements
        Builder<DepositInstructionAvailability,
            DepositInstructionAvailabilityBuilder> {
  _$DepositInstructionAvailability? _$v;

  String? _status;
  String? get status => _$this._status;
  set status(String? status) => _$this._status = status;

  ListBuilder<String>? _blockers;
  ListBuilder<String> get blockers =>
      _$this._blockers ??= ListBuilder<String>();
  set blockers(ListBuilder<String>? blockers) => _$this._blockers = blockers;

  DepositInstructionAvailabilityBuilder() {
    DepositInstructionAvailability._defaults(this);
  }

  DepositInstructionAvailabilityBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _status = $v.status;
      _blockers = $v.blockers.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(DepositInstructionAvailability other) {
    _$v = other as _$DepositInstructionAvailability;
  }

  @override
  void update(void Function(DepositInstructionAvailabilityBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  DepositInstructionAvailability build() => _build();

  _$DepositInstructionAvailability _build() {
    _$DepositInstructionAvailability _$result;
    try {
      _$result = _$v ??
          _$DepositInstructionAvailability._(
            status: BuiltValueNullFieldError.checkNotNull(
                status, r'DepositInstructionAvailability', 'status'),
            blockers: blockers.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'blockers';
        blockers.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'DepositInstructionAvailability', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint

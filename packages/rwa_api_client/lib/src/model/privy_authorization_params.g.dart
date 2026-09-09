// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'privy_authorization_params.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$PrivyAuthorizationParams extends PrivyAuthorizationParams {
  @override
  final PrivyAuthorizationTransaction transaction;

  factory _$PrivyAuthorizationParams(
          [void Function(PrivyAuthorizationParamsBuilder)? updates]) =>
      (PrivyAuthorizationParamsBuilder()..update(updates))._build();

  _$PrivyAuthorizationParams._({required this.transaction}) : super._();
  @override
  PrivyAuthorizationParams rebuild(
          void Function(PrivyAuthorizationParamsBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  PrivyAuthorizationParamsBuilder toBuilder() =>
      PrivyAuthorizationParamsBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is PrivyAuthorizationParams &&
        transaction == other.transaction;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, transaction.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'PrivyAuthorizationParams')
          ..add('transaction', transaction))
        .toString();
  }
}

class PrivyAuthorizationParamsBuilder
    implements
        Builder<PrivyAuthorizationParams, PrivyAuthorizationParamsBuilder> {
  _$PrivyAuthorizationParams? _$v;

  PrivyAuthorizationTransactionBuilder? _transaction;
  PrivyAuthorizationTransactionBuilder get transaction =>
      _$this._transaction ??= PrivyAuthorizationTransactionBuilder();
  set transaction(PrivyAuthorizationTransactionBuilder? transaction) =>
      _$this._transaction = transaction;

  PrivyAuthorizationParamsBuilder() {
    PrivyAuthorizationParams._defaults(this);
  }

  PrivyAuthorizationParamsBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _transaction = $v.transaction.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(PrivyAuthorizationParams other) {
    _$v = other as _$PrivyAuthorizationParams;
  }

  @override
  void update(void Function(PrivyAuthorizationParamsBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  PrivyAuthorizationParams build() => _build();

  _$PrivyAuthorizationParams _build() {
    _$PrivyAuthorizationParams _$result;
    try {
      _$result = _$v ??
          _$PrivyAuthorizationParams._(
            transaction: transaction.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'transaction';
        transaction.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'PrivyAuthorizationParams', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint

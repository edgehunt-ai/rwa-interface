// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hip3_withdrawal_nonce_mapping.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$Hip3WithdrawalNonceMapping extends Hip3WithdrawalNonceMapping {
  @override
  final String? typedData;
  @override
  final String? payloadHash;

  factory _$Hip3WithdrawalNonceMapping(
          [void Function(Hip3WithdrawalNonceMappingBuilder)? updates]) =>
      (Hip3WithdrawalNonceMappingBuilder()..update(updates))._build();

  _$Hip3WithdrawalNonceMapping._({this.typedData, this.payloadHash})
      : super._();
  @override
  Hip3WithdrawalNonceMapping rebuild(
          void Function(Hip3WithdrawalNonceMappingBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  Hip3WithdrawalNonceMappingBuilder toBuilder() =>
      Hip3WithdrawalNonceMappingBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Hip3WithdrawalNonceMapping &&
        typedData == other.typedData &&
        payloadHash == other.payloadHash;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, typedData.hashCode);
    _$hash = $jc(_$hash, payloadHash.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'Hip3WithdrawalNonceMapping')
          ..add('typedData', typedData)
          ..add('payloadHash', payloadHash))
        .toString();
  }
}

class Hip3WithdrawalNonceMappingBuilder
    implements
        Builder<Hip3WithdrawalNonceMapping, Hip3WithdrawalNonceMappingBuilder> {
  _$Hip3WithdrawalNonceMapping? _$v;

  String? _typedData;
  String? get typedData => _$this._typedData;
  set typedData(String? typedData) => _$this._typedData = typedData;

  String? _payloadHash;
  String? get payloadHash => _$this._payloadHash;
  set payloadHash(String? payloadHash) => _$this._payloadHash = payloadHash;

  Hip3WithdrawalNonceMappingBuilder() {
    Hip3WithdrawalNonceMapping._defaults(this);
  }

  Hip3WithdrawalNonceMappingBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _typedData = $v.typedData;
      _payloadHash = $v.payloadHash;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Hip3WithdrawalNonceMapping other) {
    _$v = other as _$Hip3WithdrawalNonceMapping;
  }

  @override
  void update(void Function(Hip3WithdrawalNonceMappingBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  Hip3WithdrawalNonceMapping build() => _build();

  _$Hip3WithdrawalNonceMapping _build() {
    final _$result = _$v ??
        _$Hip3WithdrawalNonceMapping._(
          typedData: typedData,
          payloadHash: payloadHash,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'funding_refund_policy.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const FundingRefundPolicyAddressRoleEnum
    _$fundingRefundPolicyAddressRoleEnum_sourceWallet =
    const FundingRefundPolicyAddressRoleEnum._('sourceWallet');
const FundingRefundPolicyAddressRoleEnum
    _$fundingRefundPolicyAddressRoleEnum_unknownDefaultOpenApi =
    const FundingRefundPolicyAddressRoleEnum._('unknownDefaultOpenApi');

FundingRefundPolicyAddressRoleEnum _$fundingRefundPolicyAddressRoleEnumValueOf(
    String name) {
  switch (name) {
    case 'sourceWallet':
      return _$fundingRefundPolicyAddressRoleEnum_sourceWallet;
    case 'unknownDefaultOpenApi':
      return _$fundingRefundPolicyAddressRoleEnum_unknownDefaultOpenApi;
    default:
      return _$fundingRefundPolicyAddressRoleEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<FundingRefundPolicyAddressRoleEnum>
    _$fundingRefundPolicyAddressRoleEnumValues = BuiltSet<
        FundingRefundPolicyAddressRoleEnum>(const <FundingRefundPolicyAddressRoleEnum>[
  _$fundingRefundPolicyAddressRoleEnum_sourceWallet,
  _$fundingRefundPolicyAddressRoleEnum_unknownDefaultOpenApi,
]);

Serializer<FundingRefundPolicyAddressRoleEnum>
    _$fundingRefundPolicyAddressRoleEnumSerializer =
    _$FundingRefundPolicyAddressRoleEnumSerializer();

class _$FundingRefundPolicyAddressRoleEnumSerializer
    implements PrimitiveSerializer<FundingRefundPolicyAddressRoleEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'sourceWallet': 'source_wallet',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'source_wallet': 'sourceWallet',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[FundingRefundPolicyAddressRoleEnum];
  @override
  final String wireName = 'FundingRefundPolicyAddressRoleEnum';

  @override
  Object serialize(
          Serializers serializers, FundingRefundPolicyAddressRoleEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  FundingRefundPolicyAddressRoleEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      FundingRefundPolicyAddressRoleEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$FundingRefundPolicy extends FundingRefundPolicy {
  @override
  final String address;
  @override
  final FundingRefundPolicyAddressRoleEnum addressRole;
  @override
  final bool mayDeductGas;
  @override
  final String timingNote;

  factory _$FundingRefundPolicy(
          [void Function(FundingRefundPolicyBuilder)? updates]) =>
      (FundingRefundPolicyBuilder()..update(updates))._build();

  _$FundingRefundPolicy._(
      {required this.address,
      required this.addressRole,
      required this.mayDeductGas,
      required this.timingNote})
      : super._();
  @override
  FundingRefundPolicy rebuild(
          void Function(FundingRefundPolicyBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  FundingRefundPolicyBuilder toBuilder() =>
      FundingRefundPolicyBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is FundingRefundPolicy &&
        address == other.address &&
        addressRole == other.addressRole &&
        mayDeductGas == other.mayDeductGas &&
        timingNote == other.timingNote;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, address.hashCode);
    _$hash = $jc(_$hash, addressRole.hashCode);
    _$hash = $jc(_$hash, mayDeductGas.hashCode);
    _$hash = $jc(_$hash, timingNote.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'FundingRefundPolicy')
          ..add('address', address)
          ..add('addressRole', addressRole)
          ..add('mayDeductGas', mayDeductGas)
          ..add('timingNote', timingNote))
        .toString();
  }
}

class FundingRefundPolicyBuilder
    implements Builder<FundingRefundPolicy, FundingRefundPolicyBuilder> {
  _$FundingRefundPolicy? _$v;

  String? _address;
  String? get address => _$this._address;
  set address(String? address) => _$this._address = address;

  FundingRefundPolicyAddressRoleEnum? _addressRole;
  FundingRefundPolicyAddressRoleEnum? get addressRole => _$this._addressRole;
  set addressRole(FundingRefundPolicyAddressRoleEnum? addressRole) =>
      _$this._addressRole = addressRole;

  bool? _mayDeductGas;
  bool? get mayDeductGas => _$this._mayDeductGas;
  set mayDeductGas(bool? mayDeductGas) => _$this._mayDeductGas = mayDeductGas;

  String? _timingNote;
  String? get timingNote => _$this._timingNote;
  set timingNote(String? timingNote) => _$this._timingNote = timingNote;

  FundingRefundPolicyBuilder() {
    FundingRefundPolicy._defaults(this);
  }

  FundingRefundPolicyBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _address = $v.address;
      _addressRole = $v.addressRole;
      _mayDeductGas = $v.mayDeductGas;
      _timingNote = $v.timingNote;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(FundingRefundPolicy other) {
    _$v = other as _$FundingRefundPolicy;
  }

  @override
  void update(void Function(FundingRefundPolicyBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  FundingRefundPolicy build() => _build();

  _$FundingRefundPolicy _build() {
    final _$result = _$v ??
        _$FundingRefundPolicy._(
          address: BuiltValueNullFieldError.checkNotNull(
              address, r'FundingRefundPolicy', 'address'),
          addressRole: BuiltValueNullFieldError.checkNotNull(
              addressRole, r'FundingRefundPolicy', 'addressRole'),
          mayDeductGas: BuiltValueNullFieldError.checkNotNull(
              mayDeductGas, r'FundingRefundPolicy', 'mayDeductGas'),
          timingNote: BuiltValueNullFieldError.checkNotNull(
              timingNote, r'FundingRefundPolicy', 'timingNote'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'deposit_instruction_wallet.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const DepositInstructionWalletCustodyEnum
    _$depositInstructionWalletCustodyEnum_embeddedWallet =
    const DepositInstructionWalletCustodyEnum._('embeddedWallet');
const DepositInstructionWalletCustodyEnum
    _$depositInstructionWalletCustodyEnum_unknownDefaultOpenApi =
    const DepositInstructionWalletCustodyEnum._('unknownDefaultOpenApi');

DepositInstructionWalletCustodyEnum
    _$depositInstructionWalletCustodyEnumValueOf(String name) {
  switch (name) {
    case 'embeddedWallet':
      return _$depositInstructionWalletCustodyEnum_embeddedWallet;
    case 'unknownDefaultOpenApi':
      return _$depositInstructionWalletCustodyEnum_unknownDefaultOpenApi;
    default:
      return _$depositInstructionWalletCustodyEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<DepositInstructionWalletCustodyEnum>
    _$depositInstructionWalletCustodyEnumValues = BuiltSet<
        DepositInstructionWalletCustodyEnum>(const <DepositInstructionWalletCustodyEnum>[
  _$depositInstructionWalletCustodyEnum_embeddedWallet,
  _$depositInstructionWalletCustodyEnum_unknownDefaultOpenApi,
]);

Serializer<DepositInstructionWalletCustodyEnum>
    _$depositInstructionWalletCustodyEnumSerializer =
    _$DepositInstructionWalletCustodyEnumSerializer();

class _$DepositInstructionWalletCustodyEnumSerializer
    implements PrimitiveSerializer<DepositInstructionWalletCustodyEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'embeddedWallet': 'embedded_wallet',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'embedded_wallet': 'embeddedWallet',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[
    DepositInstructionWalletCustodyEnum
  ];
  @override
  final String wireName = 'DepositInstructionWalletCustodyEnum';

  @override
  Object serialize(
          Serializers serializers, DepositInstructionWalletCustodyEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  DepositInstructionWalletCustodyEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      DepositInstructionWalletCustodyEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$DepositInstructionWallet extends DepositInstructionWallet {
  @override
  final String walletId;
  @override
  final String address;
  @override
  final DepositInstructionWalletCustodyEnum custody;

  factory _$DepositInstructionWallet(
          [void Function(DepositInstructionWalletBuilder)? updates]) =>
      (DepositInstructionWalletBuilder()..update(updates))._build();

  _$DepositInstructionWallet._(
      {required this.walletId, required this.address, required this.custody})
      : super._();
  @override
  DepositInstructionWallet rebuild(
          void Function(DepositInstructionWalletBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  DepositInstructionWalletBuilder toBuilder() =>
      DepositInstructionWalletBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is DepositInstructionWallet &&
        walletId == other.walletId &&
        address == other.address &&
        custody == other.custody;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, walletId.hashCode);
    _$hash = $jc(_$hash, address.hashCode);
    _$hash = $jc(_$hash, custody.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'DepositInstructionWallet')
          ..add('walletId', walletId)
          ..add('address', address)
          ..add('custody', custody))
        .toString();
  }
}

class DepositInstructionWalletBuilder
    implements
        Builder<DepositInstructionWallet, DepositInstructionWalletBuilder> {
  _$DepositInstructionWallet? _$v;

  String? _walletId;
  String? get walletId => _$this._walletId;
  set walletId(String? walletId) => _$this._walletId = walletId;

  String? _address;
  String? get address => _$this._address;
  set address(String? address) => _$this._address = address;

  DepositInstructionWalletCustodyEnum? _custody;
  DepositInstructionWalletCustodyEnum? get custody => _$this._custody;
  set custody(DepositInstructionWalletCustodyEnum? custody) =>
      _$this._custody = custody;

  DepositInstructionWalletBuilder() {
    DepositInstructionWallet._defaults(this);
  }

  DepositInstructionWalletBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _walletId = $v.walletId;
      _address = $v.address;
      _custody = $v.custody;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(DepositInstructionWallet other) {
    _$v = other as _$DepositInstructionWallet;
  }

  @override
  void update(void Function(DepositInstructionWalletBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  DepositInstructionWallet build() => _build();

  _$DepositInstructionWallet _build() {
    final _$result = _$v ??
        _$DepositInstructionWallet._(
          walletId: BuiltValueNullFieldError.checkNotNull(
              walletId, r'DepositInstructionWallet', 'walletId'),
          address: BuiltValueNullFieldError.checkNotNull(
              address, r'DepositInstructionWallet', 'address'),
          custody: BuiltValueNullFieldError.checkNotNull(
              custody, r'DepositInstructionWallet', 'custody'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint

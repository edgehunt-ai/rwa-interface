// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'deposit_instructions_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$DepositInstructionsResponse extends DepositInstructionsResponse {
  @override
  final String catalogVersion;
  @override
  final DepositInstructionWallet? wallet;
  @override
  final BuiltList<DepositInstructionItem> items;
  @override
  final DateTime updatedAt;

  factory _$DepositInstructionsResponse(
          [void Function(DepositInstructionsResponseBuilder)? updates]) =>
      (DepositInstructionsResponseBuilder()..update(updates))._build();

  _$DepositInstructionsResponse._(
      {required this.catalogVersion,
      this.wallet,
      required this.items,
      required this.updatedAt})
      : super._();
  @override
  DepositInstructionsResponse rebuild(
          void Function(DepositInstructionsResponseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  DepositInstructionsResponseBuilder toBuilder() =>
      DepositInstructionsResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is DepositInstructionsResponse &&
        catalogVersion == other.catalogVersion &&
        wallet == other.wallet &&
        items == other.items &&
        updatedAt == other.updatedAt;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, catalogVersion.hashCode);
    _$hash = $jc(_$hash, wallet.hashCode);
    _$hash = $jc(_$hash, items.hashCode);
    _$hash = $jc(_$hash, updatedAt.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'DepositInstructionsResponse')
          ..add('catalogVersion', catalogVersion)
          ..add('wallet', wallet)
          ..add('items', items)
          ..add('updatedAt', updatedAt))
        .toString();
  }
}

class DepositInstructionsResponseBuilder
    implements
        Builder<DepositInstructionsResponse,
            DepositInstructionsResponseBuilder> {
  _$DepositInstructionsResponse? _$v;

  String? _catalogVersion;
  String? get catalogVersion => _$this._catalogVersion;
  set catalogVersion(String? catalogVersion) =>
      _$this._catalogVersion = catalogVersion;

  DepositInstructionWalletBuilder? _wallet;
  DepositInstructionWalletBuilder get wallet =>
      _$this._wallet ??= DepositInstructionWalletBuilder();
  set wallet(DepositInstructionWalletBuilder? wallet) =>
      _$this._wallet = wallet;

  ListBuilder<DepositInstructionItem>? _items;
  ListBuilder<DepositInstructionItem> get items =>
      _$this._items ??= ListBuilder<DepositInstructionItem>();
  set items(ListBuilder<DepositInstructionItem>? items) =>
      _$this._items = items;

  DateTime? _updatedAt;
  DateTime? get updatedAt => _$this._updatedAt;
  set updatedAt(DateTime? updatedAt) => _$this._updatedAt = updatedAt;

  DepositInstructionsResponseBuilder() {
    DepositInstructionsResponse._defaults(this);
  }

  DepositInstructionsResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _catalogVersion = $v.catalogVersion;
      _wallet = $v.wallet?.toBuilder();
      _items = $v.items.toBuilder();
      _updatedAt = $v.updatedAt;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(DepositInstructionsResponse other) {
    _$v = other as _$DepositInstructionsResponse;
  }

  @override
  void update(void Function(DepositInstructionsResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  DepositInstructionsResponse build() => _build();

  _$DepositInstructionsResponse _build() {
    _$DepositInstructionsResponse _$result;
    try {
      _$result = _$v ??
          _$DepositInstructionsResponse._(
            catalogVersion: BuiltValueNullFieldError.checkNotNull(
                catalogVersion,
                r'DepositInstructionsResponse',
                'catalogVersion'),
            wallet: _wallet?.build(),
            items: items.build(),
            updatedAt: BuiltValueNullFieldError.checkNotNull(
                updatedAt, r'DepositInstructionsResponse', 'updatedAt'),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'wallet';
        _wallet?.build();
        _$failedField = 'items';
        items.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'DepositInstructionsResponse', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'deposit_instruction_item.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$DepositInstructionItem extends DepositInstructionItem {
  @override
  final OneOf oneOf;

  factory _$DepositInstructionItem(
          [void Function(DepositInstructionItemBuilder)? updates]) =>
      (DepositInstructionItemBuilder()..update(updates))._build();

  _$DepositInstructionItem._({required this.oneOf}) : super._();
  @override
  DepositInstructionItem rebuild(
          void Function(DepositInstructionItemBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  DepositInstructionItemBuilder toBuilder() =>
      DepositInstructionItemBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is DepositInstructionItem && oneOf == other.oneOf;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, oneOf.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'DepositInstructionItem')
          ..add('oneOf', oneOf))
        .toString();
  }
}

class DepositInstructionItemBuilder
    implements Builder<DepositInstructionItem, DepositInstructionItemBuilder> {
  _$DepositInstructionItem? _$v;

  OneOf? _oneOf;
  OneOf? get oneOf => _$this._oneOf;
  set oneOf(OneOf? oneOf) => _$this._oneOf = oneOf;

  DepositInstructionItemBuilder() {
    DepositInstructionItem._defaults(this);
  }

  DepositInstructionItemBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _oneOf = $v.oneOf;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(DepositInstructionItem other) {
    _$v = other as _$DepositInstructionItem;
  }

  @override
  void update(void Function(DepositInstructionItemBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  DepositInstructionItem build() => _build();

  _$DepositInstructionItem _build() {
    final _$result = _$v ??
        _$DepositInstructionItem._(
          oneOf: BuiltValueNullFieldError.checkNotNull(
              oneOf, r'DepositInstructionItem', 'oneOf'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint

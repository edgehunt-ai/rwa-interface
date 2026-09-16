//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'wallet_action_kind.g.dart';

class WalletActionKind extends EnumClass {

  @BuiltValueEnumConst(wireName: r'erc20_approval')
  static const WalletActionKind erc20Approval = _$erc20Approval;
  @BuiltValueEnumConst(wireName: r'origin_transaction')
  static const WalletActionKind originTransaction = _$originTransaction;
  @BuiltValueEnumConst(wireName: r'erc20_transfer')
  static const WalletActionKind erc20Transfer = _$erc20Transfer;
  @BuiltValueEnumConst(wireName: r'spot_swap')
  static const WalletActionKind spotSwap = _$spotSwap;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const WalletActionKind unknownDefaultOpenApi = _$unknownDefaultOpenApi;

  static Serializer<WalletActionKind> get serializer => _$walletActionKindSerializer;

  const WalletActionKind._(String name): super(name);

  static BuiltSet<WalletActionKind> get values => _$values;
  static WalletActionKind valueOf(String name) => _$valueOf(name);
}

/// Optionally, enum_class can generate a mixin to go with your enum for use
/// with Angular. It exposes your enum constants as getters. So, if you mix it
/// in to your Dart component class, the values become available to the
/// corresponding Angular template.
///
/// Trigger mixin generation by writing a line like this one next to your enum.
abstract class WalletActionKindMixin = Object with _$WalletActionKindMixin;


//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'account_deletion_blocker.g.dart';

class AccountDeletionBlocker extends EnumClass {

  @BuiltValueEnumConst(wireName: r'open_orders')
  static const AccountDeletionBlocker openOrders = _$openOrders;
  @BuiltValueEnumConst(wireName: r'open_positions')
  static const AccountDeletionBlocker openPositions = _$openPositions;
  @BuiltValueEnumConst(wireName: r'funds_in_flight')
  static const AccountDeletionBlocker fundsInFlight = _$fundsInFlight;
  @BuiltValueEnumConst(wireName: r'withdrawable_assets_remaining')
  static const AccountDeletionBlocker withdrawableAssetsRemaining = _$withdrawableAssetsRemaining;
  @BuiltValueEnumConst(wireName: r'legal_retention')
  static const AccountDeletionBlocker legalRetention = _$legalRetention;
  @BuiltValueEnumConst(wireName: r'identity_review')
  static const AccountDeletionBlocker identityReview = _$identityReview;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const AccountDeletionBlocker unknownDefaultOpenApi = _$unknownDefaultOpenApi;

  static Serializer<AccountDeletionBlocker> get serializer => _$accountDeletionBlockerSerializer;

  const AccountDeletionBlocker._(String name): super(name);

  static BuiltSet<AccountDeletionBlocker> get values => _$values;
  static AccountDeletionBlocker valueOf(String name) => _$valueOf(name);
}

/// Optionally, enum_class can generate a mixin to go with your enum for use
/// with Angular. It exposes your enum constants as getters. So, if you mix it
/// in to your Dart component class, the values become available to the
/// corresponding Angular template.
///
/// Trigger mixin generation by writing a line like this one next to your enum.
abstract class AccountDeletionBlockerMixin = Object with _$AccountDeletionBlockerMixin;


//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'unified_funding_blocker.g.dart';

class UnifiedFundingBlocker extends EnumClass {

  @BuiltValueEnumConst(wireName: r'wallet_unavailable')
  static const UnifiedFundingBlocker walletUnavailable = _$walletUnavailable;
  @BuiltValueEnumConst(wireName: r'balance_unavailable')
  static const UnifiedFundingBlocker balanceUnavailable = _$balanceUnavailable;
  @BuiltValueEnumConst(wireName: r'balance_stale')
  static const UnifiedFundingBlocker balanceStale = _$balanceStale;
  @BuiltValueEnumConst(wireName: r'price_unavailable')
  static const UnifiedFundingBlocker priceUnavailable = _$priceUnavailable;
  @BuiltValueEnumConst(wireName: r'reservation_unavailable')
  static const UnifiedFundingBlocker reservationUnavailable = _$reservationUnavailable;
  @BuiltValueEnumConst(wireName: r'transfer_state_unavailable')
  static const UnifiedFundingBlocker transferStateUnavailable = _$transferStateUnavailable;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const UnifiedFundingBlocker unknownDefaultOpenApi = _$unknownDefaultOpenApi;

  static Serializer<UnifiedFundingBlocker> get serializer => _$unifiedFundingBlockerSerializer;

  const UnifiedFundingBlocker._(String name): super(name);

  static BuiltSet<UnifiedFundingBlocker> get values => _$values;
  static UnifiedFundingBlocker valueOf(String name) => _$valueOf(name);
}

/// Optionally, enum_class can generate a mixin to go with your enum for use
/// with Angular. It exposes your enum constants as getters. So, if you mix it
/// in to your Dart component class, the values become available to the
/// corresponding Angular template.
///
/// Trigger mixin generation by writing a line like this one next to your enum.
abstract class UnifiedFundingBlockerMixin = Object with _$UnifiedFundingBlockerMixin;


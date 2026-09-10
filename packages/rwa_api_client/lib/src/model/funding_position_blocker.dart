//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'funding_position_blocker.g.dart';

class FundingPositionBlocker extends EnumClass {

  /// Fail-closed reason that makes one exact source position ineligible for funding.
  @BuiltValueEnumConst(wireName: r'wallet_unavailable')
  static const FundingPositionBlocker walletUnavailable = _$walletUnavailable;
  /// Fail-closed reason that makes one exact source position ineligible for funding.
  @BuiltValueEnumConst(wireName: r'balance_unavailable')
  static const FundingPositionBlocker balanceUnavailable = _$balanceUnavailable;
  /// Fail-closed reason that makes one exact source position ineligible for funding.
  @BuiltValueEnumConst(wireName: r'balance_stale')
  static const FundingPositionBlocker balanceStale = _$balanceStale;
  /// Fail-closed reason that makes one exact source position ineligible for funding.
  @BuiltValueEnumConst(wireName: r'gas_balance_unavailable')
  static const FundingPositionBlocker gasBalanceUnavailable = _$gasBalanceUnavailable;
  /// Fail-closed reason that makes one exact source position ineligible for funding.
  @BuiltValueEnumConst(wireName: r'gas_balance_insufficient')
  static const FundingPositionBlocker gasBalanceInsufficient = _$gasBalanceInsufficient;
  /// Fail-closed reason that makes one exact source position ineligible for funding.
  @BuiltValueEnumConst(wireName: r'token_metadata_unavailable')
  static const FundingPositionBlocker tokenMetadataUnavailable = _$tokenMetadataUnavailable;
  /// Fail-closed reason that makes one exact source position ineligible for funding.
  @BuiltValueEnumConst(wireName: r'token_metadata_invalid')
  static const FundingPositionBlocker tokenMetadataInvalid = _$tokenMetadataInvalid;
  /// Fail-closed reason that makes one exact source position ineligible for funding.
  @BuiltValueEnumConst(wireName: r'chain_unavailable')
  static const FundingPositionBlocker chainUnavailable = _$chainUnavailable;
  /// Fail-closed reason that makes one exact source position ineligible for funding.
  @BuiltValueEnumConst(wireName: r'chain_unsupported')
  static const FundingPositionBlocker chainUnsupported = _$chainUnsupported;
  /// Fail-closed reason that makes one exact source position ineligible for funding.
  @BuiltValueEnumConst(wireName: r'price_unavailable')
  static const FundingPositionBlocker priceUnavailable = _$priceUnavailable;
  /// Fail-closed reason that makes one exact source position ineligible for funding.
  @BuiltValueEnumConst(wireName: r'fully_reserved')
  static const FundingPositionBlocker fullyReserved = _$fullyReserved;
  /// Fail-closed reason that makes one exact source position ineligible for funding.
  @BuiltValueEnumConst(wireName: r'no_safe_route')
  static const FundingPositionBlocker noSafeRoute = _$noSafeRoute;
  /// Fail-closed reason that makes one exact source position ineligible for funding.
  @BuiltValueEnumConst(wireName: r'circuit_open')
  static const FundingPositionBlocker circuitOpen = _$circuitOpen;
  /// Fail-closed reason that makes one exact source position ineligible for funding.
  @BuiltValueEnumConst(wireName: r'action_disabled')
  static const FundingPositionBlocker actionDisabled = _$actionDisabled;
  /// Fail-closed reason that makes one exact source position ineligible for funding.
  @BuiltValueEnumConst(wireName: r'asset_not_allowed')
  static const FundingPositionBlocker assetNotAllowed = _$assetNotAllowed;
  /// Fail-closed reason that makes one exact source position ineligible for funding.
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const FundingPositionBlocker unknownDefaultOpenApi = _$unknownDefaultOpenApi;

  static Serializer<FundingPositionBlocker> get serializer => _$fundingPositionBlockerSerializer;

  const FundingPositionBlocker._(String name): super(name);

  static BuiltSet<FundingPositionBlocker> get values => _$values;
  static FundingPositionBlocker valueOf(String name) => _$valueOf(name);
}

/// Optionally, enum_class can generate a mixin to go with your enum for use
/// with Angular. It exposes your enum constants as getters. So, if you mix it
/// in to your Dart component class, the values become available to the
/// corresponding Angular template.
///
/// Trigger mixin generation by writing a line like this one next to your enum.
abstract class FundingPositionBlockerMixin = Object with _$FundingPositionBlockerMixin;


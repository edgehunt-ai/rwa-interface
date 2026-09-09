//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'funding_route_blocker.g.dart';

class FundingRouteBlocker extends EnumClass {

  @BuiltValueEnumConst(wireName: r'provider_unavailable')
  static const FundingRouteBlocker providerUnavailable = _$providerUnavailable;
  @BuiltValueEnumConst(wireName: r'route_unsupported')
  static const FundingRouteBlocker routeUnsupported = _$routeUnsupported;
  @BuiltValueEnumConst(wireName: r'token_unsupported')
  static const FundingRouteBlocker tokenUnsupported = _$tokenUnsupported;
  @BuiltValueEnumConst(wireName: r'exact_output_unsupported')
  static const FundingRouteBlocker exactOutputUnsupported = _$exactOutputUnsupported;
  @BuiltValueEnumConst(wireName: r'liquidity_insufficient')
  static const FundingRouteBlocker liquidityInsufficient = _$liquidityInsufficient;
  @BuiltValueEnumConst(wireName: r'route_paused')
  static const FundingRouteBlocker routePaused = _$routePaused;
  @BuiltValueEnumConst(wireName: r'capability_stale')
  static const FundingRouteBlocker capabilityStale = _$capabilityStale;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const FundingRouteBlocker unknownDefaultOpenApi = _$unknownDefaultOpenApi;

  static Serializer<FundingRouteBlocker> get serializer => _$fundingRouteBlockerSerializer;

  const FundingRouteBlocker._(String name): super(name);

  static BuiltSet<FundingRouteBlocker> get values => _$values;
  static FundingRouteBlocker valueOf(String name) => _$valueOf(name);
}

/// Optionally, enum_class can generate a mixin to go with your enum for use
/// with Angular. It exposes your enum constants as getters. So, if you mix it
/// in to your Dart component class, the values become available to the
/// corresponding Angular template.
///
/// Trigger mixin generation by writing a line like this one next to your enum.
abstract class FundingRouteBlockerMixin = Object with _$FundingRouteBlockerMixin;


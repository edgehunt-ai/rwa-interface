// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'funding_route_blocker.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const FundingRouteBlocker _$providerUnavailable =
    const FundingRouteBlocker._('providerUnavailable');
const FundingRouteBlocker _$routeUnsupported =
    const FundingRouteBlocker._('routeUnsupported');
const FundingRouteBlocker _$tokenUnsupported =
    const FundingRouteBlocker._('tokenUnsupported');
const FundingRouteBlocker _$exactOutputUnsupported =
    const FundingRouteBlocker._('exactOutputUnsupported');
const FundingRouteBlocker _$liquidityInsufficient =
    const FundingRouteBlocker._('liquidityInsufficient');
const FundingRouteBlocker _$routePaused =
    const FundingRouteBlocker._('routePaused');
const FundingRouteBlocker _$capabilityStale =
    const FundingRouteBlocker._('capabilityStale');
const FundingRouteBlocker _$unknownDefaultOpenApi =
    const FundingRouteBlocker._('unknownDefaultOpenApi');

FundingRouteBlocker _$valueOf(String name) {
  switch (name) {
    case 'providerUnavailable':
      return _$providerUnavailable;
    case 'routeUnsupported':
      return _$routeUnsupported;
    case 'tokenUnsupported':
      return _$tokenUnsupported;
    case 'exactOutputUnsupported':
      return _$exactOutputUnsupported;
    case 'liquidityInsufficient':
      return _$liquidityInsufficient;
    case 'routePaused':
      return _$routePaused;
    case 'capabilityStale':
      return _$capabilityStale;
    case 'unknownDefaultOpenApi':
      return _$unknownDefaultOpenApi;
    default:
      return _$unknownDefaultOpenApi;
  }
}

final BuiltSet<FundingRouteBlocker> _$values =
    BuiltSet<FundingRouteBlocker>(const <FundingRouteBlocker>[
  _$providerUnavailable,
  _$routeUnsupported,
  _$tokenUnsupported,
  _$exactOutputUnsupported,
  _$liquidityInsufficient,
  _$routePaused,
  _$capabilityStale,
  _$unknownDefaultOpenApi,
]);

class _$FundingRouteBlockerMeta {
  const _$FundingRouteBlockerMeta();
  FundingRouteBlocker get providerUnavailable => _$providerUnavailable;
  FundingRouteBlocker get routeUnsupported => _$routeUnsupported;
  FundingRouteBlocker get tokenUnsupported => _$tokenUnsupported;
  FundingRouteBlocker get exactOutputUnsupported => _$exactOutputUnsupported;
  FundingRouteBlocker get liquidityInsufficient => _$liquidityInsufficient;
  FundingRouteBlocker get routePaused => _$routePaused;
  FundingRouteBlocker get capabilityStale => _$capabilityStale;
  FundingRouteBlocker get unknownDefaultOpenApi => _$unknownDefaultOpenApi;
  FundingRouteBlocker valueOf(String name) => _$valueOf(name);
  BuiltSet<FundingRouteBlocker> get values => _$values;
}

abstract class _$FundingRouteBlockerMixin {
  // ignore: non_constant_identifier_names
  _$FundingRouteBlockerMeta get FundingRouteBlocker =>
      const _$FundingRouteBlockerMeta();
}

Serializer<FundingRouteBlocker> _$fundingRouteBlockerSerializer =
    _$FundingRouteBlockerSerializer();

class _$FundingRouteBlockerSerializer
    implements PrimitiveSerializer<FundingRouteBlocker> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'providerUnavailable': 'provider_unavailable',
    'routeUnsupported': 'route_unsupported',
    'tokenUnsupported': 'token_unsupported',
    'exactOutputUnsupported': 'exact_output_unsupported',
    'liquidityInsufficient': 'liquidity_insufficient',
    'routePaused': 'route_paused',
    'capabilityStale': 'capability_stale',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'provider_unavailable': 'providerUnavailable',
    'route_unsupported': 'routeUnsupported',
    'token_unsupported': 'tokenUnsupported',
    'exact_output_unsupported': 'exactOutputUnsupported',
    'liquidity_insufficient': 'liquidityInsufficient',
    'route_paused': 'routePaused',
    'capability_stale': 'capabilityStale',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[FundingRouteBlocker];
  @override
  final String wireName = 'FundingRouteBlocker';

  @override
  Object serialize(Serializers serializers, FundingRouteBlocker object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  FundingRouteBlocker deserialize(Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      FundingRouteBlocker.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint

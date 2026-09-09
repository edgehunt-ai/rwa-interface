// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'funding_plan_blocker.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const FundingPlanBlocker _$targetBalanceUnavailable =
    const FundingPlanBlocker._('targetBalanceUnavailable');
const FundingPlanBlocker _$targetBalanceStale =
    const FundingPlanBlocker._('targetBalanceStale');
const FundingPlanBlocker _$sourceBalanceUnavailable =
    const FundingPlanBlocker._('sourceBalanceUnavailable');
const FundingPlanBlocker _$sourceBalanceStale =
    const FundingPlanBlocker._('sourceBalanceStale');
const FundingPlanBlocker _$sourceBalanceInvalid =
    const FundingPlanBlocker._('sourceBalanceInvalid');
const FundingPlanBlocker _$singleSourceInsufficient =
    const FundingPlanBlocker._('singleSourceInsufficient');
const FundingPlanBlocker _$noSafeRoute =
    const FundingPlanBlocker._('noSafeRoute');
const FundingPlanBlocker _$providerUnavailable =
    const FundingPlanBlocker._('providerUnavailable');
const FundingPlanBlocker _$quoteExpired =
    const FundingPlanBlocker._('quoteExpired');
const FundingPlanBlocker _$routeDisabled =
    const FundingPlanBlocker._('routeDisabled');
const FundingPlanBlocker _$manualReviewRequired =
    const FundingPlanBlocker._('manualReviewRequired');
const FundingPlanBlocker _$unknownDefaultOpenApi =
    const FundingPlanBlocker._('unknownDefaultOpenApi');

FundingPlanBlocker _$valueOf(String name) {
  switch (name) {
    case 'targetBalanceUnavailable':
      return _$targetBalanceUnavailable;
    case 'targetBalanceStale':
      return _$targetBalanceStale;
    case 'sourceBalanceUnavailable':
      return _$sourceBalanceUnavailable;
    case 'sourceBalanceStale':
      return _$sourceBalanceStale;
    case 'sourceBalanceInvalid':
      return _$sourceBalanceInvalid;
    case 'singleSourceInsufficient':
      return _$singleSourceInsufficient;
    case 'noSafeRoute':
      return _$noSafeRoute;
    case 'providerUnavailable':
      return _$providerUnavailable;
    case 'quoteExpired':
      return _$quoteExpired;
    case 'routeDisabled':
      return _$routeDisabled;
    case 'manualReviewRequired':
      return _$manualReviewRequired;
    case 'unknownDefaultOpenApi':
      return _$unknownDefaultOpenApi;
    default:
      return _$unknownDefaultOpenApi;
  }
}

final BuiltSet<FundingPlanBlocker> _$values =
    BuiltSet<FundingPlanBlocker>(const <FundingPlanBlocker>[
  _$targetBalanceUnavailable,
  _$targetBalanceStale,
  _$sourceBalanceUnavailable,
  _$sourceBalanceStale,
  _$sourceBalanceInvalid,
  _$singleSourceInsufficient,
  _$noSafeRoute,
  _$providerUnavailable,
  _$quoteExpired,
  _$routeDisabled,
  _$manualReviewRequired,
  _$unknownDefaultOpenApi,
]);

class _$FundingPlanBlockerMeta {
  const _$FundingPlanBlockerMeta();
  FundingPlanBlocker get targetBalanceUnavailable => _$targetBalanceUnavailable;
  FundingPlanBlocker get targetBalanceStale => _$targetBalanceStale;
  FundingPlanBlocker get sourceBalanceUnavailable => _$sourceBalanceUnavailable;
  FundingPlanBlocker get sourceBalanceStale => _$sourceBalanceStale;
  FundingPlanBlocker get sourceBalanceInvalid => _$sourceBalanceInvalid;
  FundingPlanBlocker get singleSourceInsufficient => _$singleSourceInsufficient;
  FundingPlanBlocker get noSafeRoute => _$noSafeRoute;
  FundingPlanBlocker get providerUnavailable => _$providerUnavailable;
  FundingPlanBlocker get quoteExpired => _$quoteExpired;
  FundingPlanBlocker get routeDisabled => _$routeDisabled;
  FundingPlanBlocker get manualReviewRequired => _$manualReviewRequired;
  FundingPlanBlocker get unknownDefaultOpenApi => _$unknownDefaultOpenApi;
  FundingPlanBlocker valueOf(String name) => _$valueOf(name);
  BuiltSet<FundingPlanBlocker> get values => _$values;
}

abstract class _$FundingPlanBlockerMixin {
  // ignore: non_constant_identifier_names
  _$FundingPlanBlockerMeta get FundingPlanBlocker =>
      const _$FundingPlanBlockerMeta();
}

Serializer<FundingPlanBlocker> _$fundingPlanBlockerSerializer =
    _$FundingPlanBlockerSerializer();

class _$FundingPlanBlockerSerializer
    implements PrimitiveSerializer<FundingPlanBlocker> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'targetBalanceUnavailable': 'target_balance_unavailable',
    'targetBalanceStale': 'target_balance_stale',
    'sourceBalanceUnavailable': 'source_balance_unavailable',
    'sourceBalanceStale': 'source_balance_stale',
    'sourceBalanceInvalid': 'source_balance_invalid',
    'singleSourceInsufficient': 'single_source_insufficient',
    'noSafeRoute': 'no_safe_route',
    'providerUnavailable': 'provider_unavailable',
    'quoteExpired': 'quote_expired',
    'routeDisabled': 'route_disabled',
    'manualReviewRequired': 'manual_review_required',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'target_balance_unavailable': 'targetBalanceUnavailable',
    'target_balance_stale': 'targetBalanceStale',
    'source_balance_unavailable': 'sourceBalanceUnavailable',
    'source_balance_stale': 'sourceBalanceStale',
    'source_balance_invalid': 'sourceBalanceInvalid',
    'single_source_insufficient': 'singleSourceInsufficient',
    'no_safe_route': 'noSafeRoute',
    'provider_unavailable': 'providerUnavailable',
    'quote_expired': 'quoteExpired',
    'route_disabled': 'routeDisabled',
    'manual_review_required': 'manualReviewRequired',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[FundingPlanBlocker];
  @override
  final String wireName = 'FundingPlanBlocker';

  @override
  Object serialize(Serializers serializers, FundingPlanBlocker object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  FundingPlanBlocker deserialize(Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      FundingPlanBlocker.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint

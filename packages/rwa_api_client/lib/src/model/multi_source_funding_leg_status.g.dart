// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'multi_source_funding_leg_status.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const MultiSourceFundingLegStatus _$planned =
    const MultiSourceFundingLegStatus._('planned');
const MultiSourceFundingLegStatus _$actionReleased =
    const MultiSourceFundingLegStatus._('actionReleased');
const MultiSourceFundingLegStatus _$submitted =
    const MultiSourceFundingLegStatus._('submitted');
const MultiSourceFundingLegStatus _$originConfirmed =
    const MultiSourceFundingLegStatus._('originConfirmed');
const MultiSourceFundingLegStatus _$providerConfirmed =
    const MultiSourceFundingLegStatus._('providerConfirmed');
const MultiSourceFundingLegStatus _$targetConfirmed =
    const MultiSourceFundingLegStatus._('targetConfirmed');
const MultiSourceFundingLegStatus _$completed =
    const MultiSourceFundingLegStatus._('completed');
const MultiSourceFundingLegStatus _$cancelledAsUnneeded =
    const MultiSourceFundingLegStatus._('cancelledAsUnneeded');
const MultiSourceFundingLegStatus _$failed =
    const MultiSourceFundingLegStatus._('failed');
const MultiSourceFundingLegStatus _$ambiguous =
    const MultiSourceFundingLegStatus._('ambiguous');
const MultiSourceFundingLegStatus _$manualReview =
    const MultiSourceFundingLegStatus._('manualReview');
const MultiSourceFundingLegStatus _$unknownDefaultOpenApi =
    const MultiSourceFundingLegStatus._('unknownDefaultOpenApi');

MultiSourceFundingLegStatus _$valueOf(String name) {
  switch (name) {
    case 'planned':
      return _$planned;
    case 'actionReleased':
      return _$actionReleased;
    case 'submitted':
      return _$submitted;
    case 'originConfirmed':
      return _$originConfirmed;
    case 'providerConfirmed':
      return _$providerConfirmed;
    case 'targetConfirmed':
      return _$targetConfirmed;
    case 'completed':
      return _$completed;
    case 'cancelledAsUnneeded':
      return _$cancelledAsUnneeded;
    case 'failed':
      return _$failed;
    case 'ambiguous':
      return _$ambiguous;
    case 'manualReview':
      return _$manualReview;
    case 'unknownDefaultOpenApi':
      return _$unknownDefaultOpenApi;
    default:
      return _$unknownDefaultOpenApi;
  }
}

final BuiltSet<MultiSourceFundingLegStatus> _$values =
    BuiltSet<MultiSourceFundingLegStatus>(const <MultiSourceFundingLegStatus>[
  _$planned,
  _$actionReleased,
  _$submitted,
  _$originConfirmed,
  _$providerConfirmed,
  _$targetConfirmed,
  _$completed,
  _$cancelledAsUnneeded,
  _$failed,
  _$ambiguous,
  _$manualReview,
  _$unknownDefaultOpenApi,
]);

class _$MultiSourceFundingLegStatusMeta {
  const _$MultiSourceFundingLegStatusMeta();
  MultiSourceFundingLegStatus get planned => _$planned;
  MultiSourceFundingLegStatus get actionReleased => _$actionReleased;
  MultiSourceFundingLegStatus get submitted => _$submitted;
  MultiSourceFundingLegStatus get originConfirmed => _$originConfirmed;
  MultiSourceFundingLegStatus get providerConfirmed => _$providerConfirmed;
  MultiSourceFundingLegStatus get targetConfirmed => _$targetConfirmed;
  MultiSourceFundingLegStatus get completed => _$completed;
  MultiSourceFundingLegStatus get cancelledAsUnneeded => _$cancelledAsUnneeded;
  MultiSourceFundingLegStatus get failed => _$failed;
  MultiSourceFundingLegStatus get ambiguous => _$ambiguous;
  MultiSourceFundingLegStatus get manualReview => _$manualReview;
  MultiSourceFundingLegStatus get unknownDefaultOpenApi =>
      _$unknownDefaultOpenApi;
  MultiSourceFundingLegStatus valueOf(String name) => _$valueOf(name);
  BuiltSet<MultiSourceFundingLegStatus> get values => _$values;
}

abstract class _$MultiSourceFundingLegStatusMixin {
  // ignore: non_constant_identifier_names
  _$MultiSourceFundingLegStatusMeta get MultiSourceFundingLegStatus =>
      const _$MultiSourceFundingLegStatusMeta();
}

Serializer<MultiSourceFundingLegStatus>
    _$multiSourceFundingLegStatusSerializer =
    _$MultiSourceFundingLegStatusSerializer();

class _$MultiSourceFundingLegStatusSerializer
    implements PrimitiveSerializer<MultiSourceFundingLegStatus> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'planned': 'planned',
    'actionReleased': 'action_released',
    'submitted': 'submitted',
    'originConfirmed': 'origin_confirmed',
    'providerConfirmed': 'provider_confirmed',
    'targetConfirmed': 'target_confirmed',
    'completed': 'completed',
    'cancelledAsUnneeded': 'cancelled_as_unneeded',
    'failed': 'failed',
    'ambiguous': 'ambiguous',
    'manualReview': 'manual_review',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'planned': 'planned',
    'action_released': 'actionReleased',
    'submitted': 'submitted',
    'origin_confirmed': 'originConfirmed',
    'provider_confirmed': 'providerConfirmed',
    'target_confirmed': 'targetConfirmed',
    'completed': 'completed',
    'cancelled_as_unneeded': 'cancelledAsUnneeded',
    'failed': 'failed',
    'ambiguous': 'ambiguous',
    'manual_review': 'manualReview',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[MultiSourceFundingLegStatus];
  @override
  final String wireName = 'MultiSourceFundingLegStatus';

  @override
  Object serialize(Serializers serializers, MultiSourceFundingLegStatus object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  MultiSourceFundingLegStatus deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      MultiSourceFundingLegStatus.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint

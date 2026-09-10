// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'funding_session_status.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const FundingSessionStatus _$editing = const FundingSessionStatus._('editing');
const FundingSessionStatus _$readyToConfirm =
    const FundingSessionStatus._('readyToConfirm');
const FundingSessionStatus _$transferring =
    const FundingSessionStatus._('transferring');
const FundingSessionStatus _$funded = const FundingSessionStatus._('funded');
const FundingSessionStatus _$expired = const FundingSessionStatus._('expired');
const FundingSessionStatus _$cancelled =
    const FundingSessionStatus._('cancelled');
const FundingSessionStatus _$manualReview =
    const FundingSessionStatus._('manualReview');
const FundingSessionStatus _$unknownDefaultOpenApi =
    const FundingSessionStatus._('unknownDefaultOpenApi');

FundingSessionStatus _$valueOf(String name) {
  switch (name) {
    case 'editing':
      return _$editing;
    case 'readyToConfirm':
      return _$readyToConfirm;
    case 'transferring':
      return _$transferring;
    case 'funded':
      return _$funded;
    case 'expired':
      return _$expired;
    case 'cancelled':
      return _$cancelled;
    case 'manualReview':
      return _$manualReview;
    case 'unknownDefaultOpenApi':
      return _$unknownDefaultOpenApi;
    default:
      return _$unknownDefaultOpenApi;
  }
}

final BuiltSet<FundingSessionStatus> _$values =
    BuiltSet<FundingSessionStatus>(const <FundingSessionStatus>[
  _$editing,
  _$readyToConfirm,
  _$transferring,
  _$funded,
  _$expired,
  _$cancelled,
  _$manualReview,
  _$unknownDefaultOpenApi,
]);

class _$FundingSessionStatusMeta {
  const _$FundingSessionStatusMeta();
  FundingSessionStatus get editing => _$editing;
  FundingSessionStatus get readyToConfirm => _$readyToConfirm;
  FundingSessionStatus get transferring => _$transferring;
  FundingSessionStatus get funded => _$funded;
  FundingSessionStatus get expired => _$expired;
  FundingSessionStatus get cancelled => _$cancelled;
  FundingSessionStatus get manualReview => _$manualReview;
  FundingSessionStatus get unknownDefaultOpenApi => _$unknownDefaultOpenApi;
  FundingSessionStatus valueOf(String name) => _$valueOf(name);
  BuiltSet<FundingSessionStatus> get values => _$values;
}

abstract class _$FundingSessionStatusMixin {
  // ignore: non_constant_identifier_names
  _$FundingSessionStatusMeta get FundingSessionStatus =>
      const _$FundingSessionStatusMeta();
}

Serializer<FundingSessionStatus> _$fundingSessionStatusSerializer =
    _$FundingSessionStatusSerializer();

class _$FundingSessionStatusSerializer
    implements PrimitiveSerializer<FundingSessionStatus> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'editing': 'editing',
    'readyToConfirm': 'ready_to_confirm',
    'transferring': 'transferring',
    'funded': 'funded',
    'expired': 'expired',
    'cancelled': 'cancelled',
    'manualReview': 'manual_review',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'editing': 'editing',
    'ready_to_confirm': 'readyToConfirm',
    'transferring': 'transferring',
    'funded': 'funded',
    'expired': 'expired',
    'cancelled': 'cancelled',
    'manual_review': 'manualReview',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[FundingSessionStatus];
  @override
  final String wireName = 'FundingSessionStatus';

  @override
  Object serialize(Serializers serializers, FundingSessionStatus object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  FundingSessionStatus deserialize(Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      FundingSessionStatus.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint

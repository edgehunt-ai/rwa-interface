// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transfer_target_credit_status.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const TransferTargetCreditStatus _$pending =
    const TransferTargetCreditStatus._('pending');
const TransferTargetCreditStatus _$confirmed =
    const TransferTargetCreditStatus._('confirmed');
const TransferTargetCreditStatus _$unavailable =
    const TransferTargetCreditStatus._('unavailable');
const TransferTargetCreditStatus _$ambiguous =
    const TransferTargetCreditStatus._('ambiguous');
const TransferTargetCreditStatus _$manualReview =
    const TransferTargetCreditStatus._('manualReview');
const TransferTargetCreditStatus _$unknownDefaultOpenApi =
    const TransferTargetCreditStatus._('unknownDefaultOpenApi');

TransferTargetCreditStatus _$valueOf(String name) {
  switch (name) {
    case 'pending':
      return _$pending;
    case 'confirmed':
      return _$confirmed;
    case 'unavailable':
      return _$unavailable;
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

final BuiltSet<TransferTargetCreditStatus> _$values =
    BuiltSet<TransferTargetCreditStatus>(const <TransferTargetCreditStatus>[
  _$pending,
  _$confirmed,
  _$unavailable,
  _$ambiguous,
  _$manualReview,
  _$unknownDefaultOpenApi,
]);

class _$TransferTargetCreditStatusMeta {
  const _$TransferTargetCreditStatusMeta();
  TransferTargetCreditStatus get pending => _$pending;
  TransferTargetCreditStatus get confirmed => _$confirmed;
  TransferTargetCreditStatus get unavailable => _$unavailable;
  TransferTargetCreditStatus get ambiguous => _$ambiguous;
  TransferTargetCreditStatus get manualReview => _$manualReview;
  TransferTargetCreditStatus get unknownDefaultOpenApi =>
      _$unknownDefaultOpenApi;
  TransferTargetCreditStatus valueOf(String name) => _$valueOf(name);
  BuiltSet<TransferTargetCreditStatus> get values => _$values;
}

abstract class _$TransferTargetCreditStatusMixin {
  // ignore: non_constant_identifier_names
  _$TransferTargetCreditStatusMeta get TransferTargetCreditStatus =>
      const _$TransferTargetCreditStatusMeta();
}

Serializer<TransferTargetCreditStatus> _$transferTargetCreditStatusSerializer =
    _$TransferTargetCreditStatusSerializer();

class _$TransferTargetCreditStatusSerializer
    implements PrimitiveSerializer<TransferTargetCreditStatus> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'pending': 'pending',
    'confirmed': 'confirmed',
    'unavailable': 'unavailable',
    'ambiguous': 'ambiguous',
    'manualReview': 'manual_review',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'pending': 'pending',
    'confirmed': 'confirmed',
    'unavailable': 'unavailable',
    'ambiguous': 'ambiguous',
    'manual_review': 'manualReview',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[TransferTargetCreditStatus];
  @override
  final String wireName = 'TransferTargetCreditStatus';

  @override
  Object serialize(Serializers serializers, TransferTargetCreditStatus object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  TransferTargetCreditStatus deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      TransferTargetCreditStatus.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint

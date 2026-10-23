// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'native_cancellation_status.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const NativeCancellationStatus _$awaitingUserAuthorization =
    const NativeCancellationStatus._('awaitingUserAuthorization');
const NativeCancellationStatus _$submitting =
    const NativeCancellationStatus._('submitting');
const NativeCancellationStatus _$providerSubmitted =
    const NativeCancellationStatus._('providerSubmitted');
const NativeCancellationStatus _$confirmed =
    const NativeCancellationStatus._('confirmed');
const NativeCancellationStatus _$ambiguous =
    const NativeCancellationStatus._('ambiguous');
const NativeCancellationStatus _$failed =
    const NativeCancellationStatus._('failed');

NativeCancellationStatus _$valueOf(String name) {
  switch (name) {
    case 'awaitingUserAuthorization':
      return _$awaitingUserAuthorization;
    case 'submitting':
      return _$submitting;
    case 'providerSubmitted':
      return _$providerSubmitted;
    case 'confirmed':
      return _$confirmed;
    case 'ambiguous':
      return _$ambiguous;
    case 'failed':
      return _$failed;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<NativeCancellationStatus> _$values =
    BuiltSet<NativeCancellationStatus>(const <NativeCancellationStatus>[
  _$awaitingUserAuthorization,
  _$submitting,
  _$providerSubmitted,
  _$confirmed,
  _$ambiguous,
  _$failed,
]);

class _$NativeCancellationStatusMeta {
  const _$NativeCancellationStatusMeta();
  NativeCancellationStatus get awaitingUserAuthorization =>
      _$awaitingUserAuthorization;
  NativeCancellationStatus get submitting => _$submitting;
  NativeCancellationStatus get providerSubmitted => _$providerSubmitted;
  NativeCancellationStatus get confirmed => _$confirmed;
  NativeCancellationStatus get ambiguous => _$ambiguous;
  NativeCancellationStatus get failed => _$failed;
  NativeCancellationStatus valueOf(String name) => _$valueOf(name);
  BuiltSet<NativeCancellationStatus> get values => _$values;
}

abstract class _$NativeCancellationStatusMixin {
  // ignore: non_constant_identifier_names
  _$NativeCancellationStatusMeta get NativeCancellationStatus =>
      const _$NativeCancellationStatusMeta();
}

Serializer<NativeCancellationStatus> _$nativeCancellationStatusSerializer =
    _$NativeCancellationStatusSerializer();

class _$NativeCancellationStatusSerializer
    implements PrimitiveSerializer<NativeCancellationStatus> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'awaitingUserAuthorization': 'awaiting_user_authorization',
    'submitting': 'submitting',
    'providerSubmitted': 'provider_submitted',
    'confirmed': 'confirmed',
    'ambiguous': 'ambiguous',
    'failed': 'failed',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'awaiting_user_authorization': 'awaitingUserAuthorization',
    'submitting': 'submitting',
    'provider_submitted': 'providerSubmitted',
    'confirmed': 'confirmed',
    'ambiguous': 'ambiguous',
    'failed': 'failed',
  };

  @override
  final Iterable<Type> types = const <Type>[NativeCancellationStatus];
  @override
  final String wireName = 'NativeCancellationStatus';

  @override
  Object serialize(Serializers serializers, NativeCancellationStatus object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  NativeCancellationStatus deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      NativeCancellationStatus.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint

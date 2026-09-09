// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'gas_sponsorship_decision.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const GasSponsorshipDecision _$eligible =
    const GasSponsorshipDecision._('eligible');
const GasSponsorshipDecision _$userGasConfirmationRequired =
    const GasSponsorshipDecision._('userGasConfirmationRequired');
const GasSponsorshipDecision _$unavailable =
    const GasSponsorshipDecision._('unavailable');
const GasSponsorshipDecision _$limitExceeded =
    const GasSponsorshipDecision._('limitExceeded');
const GasSponsorshipDecision _$circuitOpen =
    const GasSponsorshipDecision._('circuitOpen');
const GasSponsorshipDecision _$providerRejected =
    const GasSponsorshipDecision._('providerRejected');
const GasSponsorshipDecision _$providerAmbiguous =
    const GasSponsorshipDecision._('providerAmbiguous');
const GasSponsorshipDecision _$unknownDefaultOpenApi =
    const GasSponsorshipDecision._('unknownDefaultOpenApi');

GasSponsorshipDecision _$valueOf(String name) {
  switch (name) {
    case 'eligible':
      return _$eligible;
    case 'userGasConfirmationRequired':
      return _$userGasConfirmationRequired;
    case 'unavailable':
      return _$unavailable;
    case 'limitExceeded':
      return _$limitExceeded;
    case 'circuitOpen':
      return _$circuitOpen;
    case 'providerRejected':
      return _$providerRejected;
    case 'providerAmbiguous':
      return _$providerAmbiguous;
    case 'unknownDefaultOpenApi':
      return _$unknownDefaultOpenApi;
    default:
      return _$unknownDefaultOpenApi;
  }
}

final BuiltSet<GasSponsorshipDecision> _$values =
    BuiltSet<GasSponsorshipDecision>(const <GasSponsorshipDecision>[
  _$eligible,
  _$userGasConfirmationRequired,
  _$unavailable,
  _$limitExceeded,
  _$circuitOpen,
  _$providerRejected,
  _$providerAmbiguous,
  _$unknownDefaultOpenApi,
]);

class _$GasSponsorshipDecisionMeta {
  const _$GasSponsorshipDecisionMeta();
  GasSponsorshipDecision get eligible => _$eligible;
  GasSponsorshipDecision get userGasConfirmationRequired =>
      _$userGasConfirmationRequired;
  GasSponsorshipDecision get unavailable => _$unavailable;
  GasSponsorshipDecision get limitExceeded => _$limitExceeded;
  GasSponsorshipDecision get circuitOpen => _$circuitOpen;
  GasSponsorshipDecision get providerRejected => _$providerRejected;
  GasSponsorshipDecision get providerAmbiguous => _$providerAmbiguous;
  GasSponsorshipDecision get unknownDefaultOpenApi => _$unknownDefaultOpenApi;
  GasSponsorshipDecision valueOf(String name) => _$valueOf(name);
  BuiltSet<GasSponsorshipDecision> get values => _$values;
}

abstract class _$GasSponsorshipDecisionMixin {
  // ignore: non_constant_identifier_names
  _$GasSponsorshipDecisionMeta get GasSponsorshipDecision =>
      const _$GasSponsorshipDecisionMeta();
}

Serializer<GasSponsorshipDecision> _$gasSponsorshipDecisionSerializer =
    _$GasSponsorshipDecisionSerializer();

class _$GasSponsorshipDecisionSerializer
    implements PrimitiveSerializer<GasSponsorshipDecision> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'eligible': 'eligible',
    'userGasConfirmationRequired': 'user_gas_confirmation_required',
    'unavailable': 'unavailable',
    'limitExceeded': 'limit_exceeded',
    'circuitOpen': 'circuit_open',
    'providerRejected': 'provider_rejected',
    'providerAmbiguous': 'provider_ambiguous',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'eligible': 'eligible',
    'user_gas_confirmation_required': 'userGasConfirmationRequired',
    'unavailable': 'unavailable',
    'limit_exceeded': 'limitExceeded',
    'circuit_open': 'circuitOpen',
    'provider_rejected': 'providerRejected',
    'provider_ambiguous': 'providerAmbiguous',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[GasSponsorshipDecision];
  @override
  final String wireName = 'GasSponsorshipDecision';

  @override
  Object serialize(Serializers serializers, GasSponsorshipDecision object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  GasSponsorshipDecision deserialize(Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      GasSponsorshipDecision.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint

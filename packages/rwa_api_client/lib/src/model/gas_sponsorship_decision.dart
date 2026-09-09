//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'gas_sponsorship_decision.g.dart';

class GasSponsorshipDecision extends EnumClass {

  @BuiltValueEnumConst(wireName: r'eligible')
  static const GasSponsorshipDecision eligible = _$eligible;
  @BuiltValueEnumConst(wireName: r'user_gas_confirmation_required')
  static const GasSponsorshipDecision userGasConfirmationRequired = _$userGasConfirmationRequired;
  @BuiltValueEnumConst(wireName: r'unavailable')
  static const GasSponsorshipDecision unavailable = _$unavailable;
  @BuiltValueEnumConst(wireName: r'limit_exceeded')
  static const GasSponsorshipDecision limitExceeded = _$limitExceeded;
  @BuiltValueEnumConst(wireName: r'circuit_open')
  static const GasSponsorshipDecision circuitOpen = _$circuitOpen;
  @BuiltValueEnumConst(wireName: r'provider_rejected')
  static const GasSponsorshipDecision providerRejected = _$providerRejected;
  @BuiltValueEnumConst(wireName: r'provider_ambiguous')
  static const GasSponsorshipDecision providerAmbiguous = _$providerAmbiguous;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const GasSponsorshipDecision unknownDefaultOpenApi = _$unknownDefaultOpenApi;

  static Serializer<GasSponsorshipDecision> get serializer => _$gasSponsorshipDecisionSerializer;

  const GasSponsorshipDecision._(String name): super(name);

  static BuiltSet<GasSponsorshipDecision> get values => _$values;
  static GasSponsorshipDecision valueOf(String name) => _$valueOf(name);
}

/// Optionally, enum_class can generate a mixin to go with your enum for use
/// with Angular. It exposes your enum constants as getters. So, if you mix it
/// in to your Dart component class, the values become available to the
/// corresponding Angular template.
///
/// Trigger mixin generation by writing a line like this one next to your enum.
abstract class GasSponsorshipDecisionMixin = Object with _$GasSponsorshipDecisionMixin;


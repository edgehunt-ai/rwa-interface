//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'native_cancellation_status.g.dart';

class NativeCancellationStatus extends EnumClass {

  @BuiltValueEnumConst(wireName: r'awaiting_user_authorization')
  static const NativeCancellationStatus awaitingUserAuthorization = _$awaitingUserAuthorization;
  @BuiltValueEnumConst(wireName: r'submitting')
  static const NativeCancellationStatus submitting = _$submitting;
  @BuiltValueEnumConst(wireName: r'provider_submitted')
  static const NativeCancellationStatus providerSubmitted = _$providerSubmitted;
  @BuiltValueEnumConst(wireName: r'confirmed')
  static const NativeCancellationStatus confirmed = _$confirmed;
  @BuiltValueEnumConst(wireName: r'ambiguous')
  static const NativeCancellationStatus ambiguous = _$ambiguous;
  @BuiltValueEnumConst(wireName: r'failed')
  static const NativeCancellationStatus failed = _$failed;

  static Serializer<NativeCancellationStatus> get serializer => _$nativeCancellationStatusSerializer;

  const NativeCancellationStatus._(String name): super(name);

  static BuiltSet<NativeCancellationStatus> get values => _$values;
  static NativeCancellationStatus valueOf(String name) => _$valueOf(name);
}

/// Optionally, enum_class can generate a mixin to go with your enum for use
/// with Angular. It exposes your enum constants as getters. So, if you mix it
/// in to your Dart component class, the values become available to the
/// corresponding Angular template.
///
/// Trigger mixin generation by writing a line like this one next to your enum.
abstract class NativeCancellationStatusMixin = Object with _$NativeCancellationStatusMixin;


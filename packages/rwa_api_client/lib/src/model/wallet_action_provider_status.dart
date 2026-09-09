//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'wallet_action_provider_status.g.dart';

class WalletActionProviderStatus extends EnumClass {
  @BuiltValueEnumConst(wireName: r'not_submitted')
  static const WalletActionProviderStatus notSubmitted = _$notSubmitted;
  @BuiltValueEnumConst(wireName: r'submitted')
  static const WalletActionProviderStatus submitted = _$submitted;
  @BuiltValueEnumConst(wireName: r'pending')
  static const WalletActionProviderStatus pending = _$pending;
  @BuiltValueEnumConst(wireName: r'confirmed')
  static const WalletActionProviderStatus confirmed = _$confirmed;
  @BuiltValueEnumConst(wireName: r'reverted')
  static const WalletActionProviderStatus reverted = _$reverted;
  @BuiltValueEnumConst(wireName: r'failed')
  static const WalletActionProviderStatus failed = _$failed;
  @BuiltValueEnumConst(wireName: r'unknown')
  static const WalletActionProviderStatus unknown = _$unknown;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const WalletActionProviderStatus unknownDefaultOpenApi =
      _$unknownDefaultOpenApi;

  static Serializer<WalletActionProviderStatus> get serializer =>
      _$walletActionProviderStatusSerializer;

  const WalletActionProviderStatus._(String name) : super(name);

  static BuiltSet<WalletActionProviderStatus> get values => _$values;
  static WalletActionProviderStatus valueOf(String name) => _$valueOf(name);
}

/// Optionally, enum_class can generate a mixin to go with your enum for use
/// with Angular. It exposes your enum constants as getters. So, if you mix it
/// in to your Dart component class, the values become available to the
/// corresponding Angular template.
///
/// Trigger mixin generation by writing a line like this one next to your enum.
abstract class WalletActionProviderStatusMixin = Object
    with _$WalletActionProviderStatusMixin;

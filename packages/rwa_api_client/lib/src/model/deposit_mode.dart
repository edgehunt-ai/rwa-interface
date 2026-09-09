//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'deposit_mode.g.dart';

@Deprecated('DepositMode has been deprecated')
class DepositMode extends EnumClass {

  /// Legacy input retained only for the side-effect-free POST compatibility adapter.
  @BuiltValueEnumConst(wireName: r'wallet')
  static const DepositMode wallet = _$wallet;
  /// Legacy input retained only for the side-effect-free POST compatibility adapter.
  @BuiltValueEnumConst(wireName: r'trade')
  static const DepositMode trade = _$trade;
  /// Legacy input retained only for the side-effect-free POST compatibility adapter.
  @BuiltValueEnumConst(wireName: r'external_import')
  static const DepositMode externalImport = _$externalImport;
  /// Legacy input retained only for the side-effect-free POST compatibility adapter.
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const DepositMode unknownDefaultOpenApi = _$unknownDefaultOpenApi;

  static Serializer<DepositMode> get serializer => _$depositModeSerializer;

  const DepositMode._(String name): super(name);

  static BuiltSet<DepositMode> get values => _$values;
  static DepositMode valueOf(String name) => _$valueOf(name);
}

/// Optionally, enum_class can generate a mixin to go with your enum for use
/// with Angular. It exposes your enum constants as getters. So, if you mix it
/// in to your Dart component class, the values become available to the
/// corresponding Angular template.
///
/// Trigger mixin generation by writing a line like this one next to your enum.
abstract class DepositModeMixin = Object with _$DepositModeMixin;


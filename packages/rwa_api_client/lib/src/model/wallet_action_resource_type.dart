//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'wallet_action_resource_type.g.dart';

class WalletActionResourceType extends EnumClass {
  @BuiltValueEnumConst(wireName: r'transfer')
  static const WalletActionResourceType transfer = _$transfer;
  @BuiltValueEnumConst(wireName: r'order')
  static const WalletActionResourceType order = _$order;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const WalletActionResourceType unknownDefaultOpenApi =
      _$unknownDefaultOpenApi;

  static Serializer<WalletActionResourceType> get serializer =>
      _$walletActionResourceTypeSerializer;

  const WalletActionResourceType._(String name) : super(name);

  static BuiltSet<WalletActionResourceType> get values => _$values;
  static WalletActionResourceType valueOf(String name) => _$valueOf(name);
}

/// Optionally, enum_class can generate a mixin to go with your enum for use
/// with Angular. It exposes your enum constants as getters. So, if you mix it
/// in to your Dart component class, the values become available to the
/// corresponding Angular template.
///
/// Trigger mixin generation by writing a line like this one next to your enum.
abstract class WalletActionResourceTypeMixin = Object
    with _$WalletActionResourceTypeMixin;

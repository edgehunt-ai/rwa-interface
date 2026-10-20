//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'native_delivery_state.g.dart';

class NativeDeliveryState extends EnumClass {

  /// prepared is undispatched authority. dispatching means possible external delivery, not failure. voided is transactional revocation before dispatch. cancelled requires exact canonical nonce-consumption proof and is retracted on reorg. None is business completion by itself. 
  @BuiltValueEnumConst(wireName: r'prepared')
  static const NativeDeliveryState prepared = _$prepared;
  /// prepared is undispatched authority. dispatching means possible external delivery, not failure. voided is transactional revocation before dispatch. cancelled requires exact canonical nonce-consumption proof and is retracted on reorg. None is business completion by itself. 
  @BuiltValueEnumConst(wireName: r'dispatching')
  static const NativeDeliveryState dispatching = _$dispatching;
  /// prepared is undispatched authority. dispatching means possible external delivery, not failure. voided is transactional revocation before dispatch. cancelled requires exact canonical nonce-consumption proof and is retracted on reorg. None is business completion by itself. 
  @BuiltValueEnumConst(wireName: r'rejected')
  static const NativeDeliveryState rejected = _$rejected;
  /// prepared is undispatched authority. dispatching means possible external delivery, not failure. voided is transactional revocation before dispatch. cancelled requires exact canonical nonce-consumption proof and is retracted on reorg. None is business completion by itself. 
  @BuiltValueEnumConst(wireName: r'voided')
  static const NativeDeliveryState voided = _$voided;
  /// prepared is undispatched authority. dispatching means possible external delivery, not failure. voided is transactional revocation before dispatch. cancelled requires exact canonical nonce-consumption proof and is retracted on reorg. None is business completion by itself. 
  @BuiltValueEnumConst(wireName: r'cancelled')
  static const NativeDeliveryState cancelled = _$cancelled;

  static Serializer<NativeDeliveryState> get serializer => _$nativeDeliveryStateSerializer;

  const NativeDeliveryState._(String name): super(name);

  static BuiltSet<NativeDeliveryState> get values => _$values;
  static NativeDeliveryState valueOf(String name) => _$valueOf(name);
}

/// Optionally, enum_class can generate a mixin to go with your enum for use
/// with Angular. It exposes your enum constants as getters. So, if you mix it
/// in to your Dart component class, the values become available to the
/// corresponding Angular template.
///
/// Trigger mixin generation by writing a line like this one next to your enum.
abstract class NativeDeliveryStateMixin = Object with _$NativeDeliveryStateMixin;


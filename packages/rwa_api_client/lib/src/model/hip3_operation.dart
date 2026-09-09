//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'hip3_operation.g.dart';

class Hip3Operation extends EnumClass {

  @BuiltValueEnumConst(wireName: r'place_order')
  static const Hip3Operation placeOrder = _$placeOrder;
  @BuiltValueEnumConst(wireName: r'cancel_order')
  static const Hip3Operation cancelOrder = _$cancelOrder;
  @BuiltValueEnumConst(wireName: r'close_position')
  static const Hip3Operation closePosition = _$closePosition;
  @BuiltValueEnumConst(wireName: r'set_tpsl')
  static const Hip3Operation setTpsl = _$setTpsl;
  @BuiltValueEnumConst(wireName: r'clear_tpsl')
  static const Hip3Operation clearTpsl = _$clearTpsl;
  @BuiltValueEnumConst(wireName: r'set_leverage')
  static const Hip3Operation setLeverage = _$setLeverage;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const Hip3Operation unknownDefaultOpenApi = _$unknownDefaultOpenApi;

  static Serializer<Hip3Operation> get serializer => _$hip3OperationSerializer;

  const Hip3Operation._(String name): super(name);

  static BuiltSet<Hip3Operation> get values => _$values;
  static Hip3Operation valueOf(String name) => _$valueOf(name);
}

/// Optionally, enum_class can generate a mixin to go with your enum for use
/// with Angular. It exposes your enum constants as getters. So, if you mix it
/// in to your Dart component class, the values become available to the
/// corresponding Angular template.
///
/// Trigger mixin generation by writing a line like this one next to your enum.
abstract class Hip3OperationMixin = Object with _$Hip3OperationMixin;


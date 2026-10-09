//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/json_object.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:one_of/any_of.dart';

part 'bstock_order_wallet_action_state_not.g.dart';

/// BstockOrderWalletActionStateNot
@BuiltValue()
abstract class BstockOrderWalletActionStateNot implements Built<BstockOrderWalletActionStateNot, BstockOrderWalletActionStateNotBuilder> {
  /// Any Of [JsonObject]
  AnyOf get anyOf;

  BstockOrderWalletActionStateNot._();

  factory BstockOrderWalletActionStateNot([void updates(BstockOrderWalletActionStateNotBuilder b)]) = _$BstockOrderWalletActionStateNot;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(BstockOrderWalletActionStateNotBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<BstockOrderWalletActionStateNot> get serializer => _$BstockOrderWalletActionStateNotSerializer();
}

class _$BstockOrderWalletActionStateNotSerializer implements PrimitiveSerializer<BstockOrderWalletActionStateNot> {
  @override
  final Iterable<Type> types = const [BstockOrderWalletActionStateNot, _$BstockOrderWalletActionStateNot];

  @override
  final String wireName = r'BstockOrderWalletActionStateNot';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    BstockOrderWalletActionStateNot object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
  }

  @override
  Object serialize(
    Serializers serializers,
    BstockOrderWalletActionStateNot object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final anyOf = object.anyOf;
    return serializers.serialize(anyOf, specifiedType: FullType(AnyOf, anyOf.valueTypes.map((type) => FullType(type)).toList()))!;
  }

  @override
  BstockOrderWalletActionStateNot deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = BstockOrderWalletActionStateNotBuilder();
    Object? anyOfDataSrc;
    final targetType = const FullType(AnyOf, [FullType.nullable(JsonObject), FullType.nullable(JsonObject), FullType.nullable(JsonObject), FullType.nullable(JsonObject), FullType.nullable(JsonObject), FullType.nullable(JsonObject), FullType.nullable(JsonObject), FullType.nullable(JsonObject), FullType.nullable(JsonObject), ]);
    anyOfDataSrc = serialized;
    result.anyOf = serializers.deserialize(anyOfDataSrc, specifiedType: targetType) as AnyOf;
    return result.build();
  }
}


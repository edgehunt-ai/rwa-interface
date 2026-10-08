//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'hip3_order_capacity_side.g.dart';

/// Hip3OrderCapacitySide
///
/// Properties:
/// * [venueMaximumQuantity] - HL activeAssetData.maxTradeSzs 对应方向的原始资产数量上限，未扣除平台额外手续费预留或套用平台名义金额上限。
/// * [availableMarginUsdc] - HL availableToTrade 对应方向额度，扣除尚未反映在当前 HL 观测中的本地预留并截断至零；未扣本次订单的手续费预留。可能含抵消反向仓位的额度，不是钱包余额或可提现额。
@BuiltValue()
abstract class Hip3OrderCapacitySide implements Built<Hip3OrderCapacitySide, Hip3OrderCapacitySideBuilder> {
  /// HL activeAssetData.maxTradeSzs 对应方向的原始资产数量上限，未扣除平台额外手续费预留或套用平台名义金额上限。
  @BuiltValueField(wireName: r'venue_maximum_quantity')
  String get venueMaximumQuantity;

  /// HL availableToTrade 对应方向额度，扣除尚未反映在当前 HL 观测中的本地预留并截断至零；未扣本次订单的手续费预留。可能含抵消反向仓位的额度，不是钱包余额或可提现额。
  @BuiltValueField(wireName: r'available_margin_usdc')
  String get availableMarginUsdc;

  Hip3OrderCapacitySide._();

  factory Hip3OrderCapacitySide([void updates(Hip3OrderCapacitySideBuilder b)]) = _$Hip3OrderCapacitySide;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(Hip3OrderCapacitySideBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<Hip3OrderCapacitySide> get serializer => _$Hip3OrderCapacitySideSerializer();
}

class _$Hip3OrderCapacitySideSerializer implements PrimitiveSerializer<Hip3OrderCapacitySide> {
  @override
  final Iterable<Type> types = const [Hip3OrderCapacitySide, _$Hip3OrderCapacitySide];

  @override
  final String wireName = r'Hip3OrderCapacitySide';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    Hip3OrderCapacitySide object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'venue_maximum_quantity';
    yield serializers.serialize(
      object.venueMaximumQuantity,
      specifiedType: const FullType(String),
    );
    yield r'available_margin_usdc';
    yield serializers.serialize(
      object.availableMarginUsdc,
      specifiedType: const FullType(String),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    Hip3OrderCapacitySide object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required Hip3OrderCapacitySideBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'venue_maximum_quantity':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.venueMaximumQuantity = valueDes;
          break;
        case r'available_margin_usdc':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.availableMarginUsdc = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  Hip3OrderCapacitySide deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = Hip3OrderCapacitySideBuilder();
    final serializedList = (serialized as Iterable<Object?>).toList();
    final unhandled = <Object?>[];
    _deserializeProperties(
      serializers,
      serialized,
      specifiedType: specifiedType,
      serializedList: serializedList,
      unhandled: unhandled,
      result: result,
    );
    return result.build();
  }
}


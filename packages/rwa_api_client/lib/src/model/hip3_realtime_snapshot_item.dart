//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:rwa_api_client/src/model/hip3_realtime_position_item.dart';
import 'package:built_collection/built_collection.dart';
import 'package:rwa_api_client/src/model/hip3_realtime_candle.dart';
import 'package:rwa_api_client/src/model/hip3_realtime_balance_item.dart';
import 'package:rwa_api_client/src/model/hip3_realtime_order_item.dart';
import 'package:rwa_api_client/src/model/hip3_realtime_candle_item.dart';
import 'package:rwa_api_client/src/model/hip3_realtime_price_item.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:one_of/one_of.dart';

part 'hip3_realtime_snapshot_item.g.dart';

/// Hip3RealtimeSnapshotItem
///
/// Properties:
/// * [event] 
/// * [data] 
@BuiltValue()
abstract class Hip3RealtimeSnapshotItem implements Built<Hip3RealtimeSnapshotItem, Hip3RealtimeSnapshotItemBuilder> {
  /// One Of [Hip3RealtimeBalanceItem], [Hip3RealtimeCandleItem], [Hip3RealtimeOrderItem], [Hip3RealtimePositionItem], [Hip3RealtimePriceItem]
  OneOf get oneOf;

  static const String discriminatorFieldName = r'event';

  static const Map<String, Type> discriminatorMapping = {
    r'hip3_balance': Hip3RealtimeBalanceItem,
    r'hip3_candle': Hip3RealtimeCandleItem,
    r'hip3_order': Hip3RealtimeOrderItem,
    r'hip3_position': Hip3RealtimePositionItem,
    r'hip3_price': Hip3RealtimePriceItem,
  };

  Hip3RealtimeSnapshotItem._();

  factory Hip3RealtimeSnapshotItem([void updates(Hip3RealtimeSnapshotItemBuilder b)]) = _$Hip3RealtimeSnapshotItem;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(Hip3RealtimeSnapshotItemBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<Hip3RealtimeSnapshotItem> get serializer => _$Hip3RealtimeSnapshotItemSerializer();
}

extension Hip3RealtimeSnapshotItemDiscriminatorExt on Hip3RealtimeSnapshotItem {
    String? get discriminatorValue {
        if (this is Hip3RealtimeBalanceItem) {
            return r'hip3_balance';
        }
        if (this is Hip3RealtimeCandleItem) {
            return r'hip3_candle';
        }
        if (this is Hip3RealtimeOrderItem) {
            return r'hip3_order';
        }
        if (this is Hip3RealtimePositionItem) {
            return r'hip3_position';
        }
        if (this is Hip3RealtimePriceItem) {
            return r'hip3_price';
        }
        return null;
    }
}
extension Hip3RealtimeSnapshotItemBuilderDiscriminatorExt on Hip3RealtimeSnapshotItemBuilder {
    String? get discriminatorValue {
        if (this is Hip3RealtimeBalanceItemBuilder) {
            return r'hip3_balance';
        }
        if (this is Hip3RealtimeCandleItemBuilder) {
            return r'hip3_candle';
        }
        if (this is Hip3RealtimeOrderItemBuilder) {
            return r'hip3_order';
        }
        if (this is Hip3RealtimePositionItemBuilder) {
            return r'hip3_position';
        }
        if (this is Hip3RealtimePriceItemBuilder) {
            return r'hip3_price';
        }
        return null;
    }
}

class _$Hip3RealtimeSnapshotItemSerializer implements PrimitiveSerializer<Hip3RealtimeSnapshotItem> {
  @override
  final Iterable<Type> types = const [Hip3RealtimeSnapshotItem, _$Hip3RealtimeSnapshotItem];

  @override
  final String wireName = r'Hip3RealtimeSnapshotItem';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    Hip3RealtimeSnapshotItem object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
  }

  @override
  Object serialize(
    Serializers serializers,
    Hip3RealtimeSnapshotItem object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final oneOf = object.oneOf;
    return serializers.serialize(oneOf.value, specifiedType: FullType(oneOf.valueType))!;
  }

  @override
  Hip3RealtimeSnapshotItem deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = Hip3RealtimeSnapshotItemBuilder();
    Object? oneOfDataSrc;
    final serializedList = (serialized as Iterable<Object?>).toList();
    final discIndex = serializedList.indexOf(Hip3RealtimeSnapshotItem.discriminatorFieldName) + 1;
    final discValue = serializers.deserialize(serializedList[discIndex], specifiedType: FullType(String)) as String;
    oneOfDataSrc = serialized;
    final oneOfTypes = [Hip3RealtimeBalanceItem, Hip3RealtimeCandleItem, Hip3RealtimeOrderItem, Hip3RealtimePositionItem, Hip3RealtimePriceItem, ];
    Object oneOfResult;
    Type oneOfType;
    switch (discValue) {
      case r'hip3_balance':
        oneOfResult = serializers.deserialize(
          oneOfDataSrc,
          specifiedType: FullType(Hip3RealtimeBalanceItem),
        ) as Hip3RealtimeBalanceItem;
        oneOfType = Hip3RealtimeBalanceItem;
        break;
      case r'hip3_candle':
        oneOfResult = serializers.deserialize(
          oneOfDataSrc,
          specifiedType: FullType(Hip3RealtimeCandleItem),
        ) as Hip3RealtimeCandleItem;
        oneOfType = Hip3RealtimeCandleItem;
        break;
      case r'hip3_order':
        oneOfResult = serializers.deserialize(
          oneOfDataSrc,
          specifiedType: FullType(Hip3RealtimeOrderItem),
        ) as Hip3RealtimeOrderItem;
        oneOfType = Hip3RealtimeOrderItem;
        break;
      case r'hip3_position':
        oneOfResult = serializers.deserialize(
          oneOfDataSrc,
          specifiedType: FullType(Hip3RealtimePositionItem),
        ) as Hip3RealtimePositionItem;
        oneOfType = Hip3RealtimePositionItem;
        break;
      case r'hip3_price':
        oneOfResult = serializers.deserialize(
          oneOfDataSrc,
          specifiedType: FullType(Hip3RealtimePriceItem),
        ) as Hip3RealtimePriceItem;
        oneOfType = Hip3RealtimePriceItem;
        break;
      default:
        throw UnsupportedError("Couldn't deserialize oneOf for the discriminator value: ${discValue}");
    }
    result.oneOf = OneOfDynamic(typeIndex: oneOfTypes.indexOf(oneOfType), types: oneOfTypes, value: oneOfResult);
    return result.build();
  }
}

class Hip3RealtimeSnapshotItemEventEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'hip3_candle')
  static const Hip3RealtimeSnapshotItemEventEnum hip3Candle = _$hip3RealtimeSnapshotItemEventEnum_hip3Candle;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const Hip3RealtimeSnapshotItemEventEnum unknownDefaultOpenApi = _$hip3RealtimeSnapshotItemEventEnum_unknownDefaultOpenApi;

  static Serializer<Hip3RealtimeSnapshotItemEventEnum> get serializer => _$hip3RealtimeSnapshotItemEventEnumSerializer;

  const Hip3RealtimeSnapshotItemEventEnum._(String name): super(name);

  static BuiltSet<Hip3RealtimeSnapshotItemEventEnum> get values => _$hip3RealtimeSnapshotItemEventEnumValues;
  static Hip3RealtimeSnapshotItemEventEnum valueOf(String name) => _$hip3RealtimeSnapshotItemEventEnumValueOf(name);
}


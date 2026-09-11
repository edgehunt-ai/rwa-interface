//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:rwa_api_client/src/model/product_kind.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'realtime_price_update.g.dart';

/// RealtimePriceUpdate
///
/// Properties:
/// * [symbol] 
/// * [kind] 
/// * [price] - 十进制字符串，避免浮点误差
/// * [change24hPercent] - 十进制字符串，避免浮点误差
/// * [updatedAt] 
@BuiltValue(instantiable: false)
abstract class RealtimePriceUpdate  {
  @BuiltValueField(wireName: r'symbol')
  String get symbol;

  @BuiltValueField(wireName: r'kind')
  ProductKind get kind;
  // enum kindEnum {  bstock,  perp,  };

  /// 十进制字符串，避免浮点误差
  @BuiltValueField(wireName: r'price')
  String get price;

  /// 十进制字符串，避免浮点误差
  @BuiltValueField(wireName: r'change_24h_percent')
  String get change24hPercent;

  @BuiltValueField(wireName: r'updated_at')
  DateTime get updatedAt;

  @BuiltValueSerializer(custom: true)
  static Serializer<RealtimePriceUpdate> get serializer => _$RealtimePriceUpdateSerializer();
}

class _$RealtimePriceUpdateSerializer implements PrimitiveSerializer<RealtimePriceUpdate> {
  @override
  final Iterable<Type> types = const [RealtimePriceUpdate];

  @override
  final String wireName = r'RealtimePriceUpdate';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    RealtimePriceUpdate object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'symbol';
    yield serializers.serialize(
      object.symbol,
      specifiedType: const FullType(String),
    );
    yield r'kind';
    yield serializers.serialize(
      object.kind,
      specifiedType: const FullType(ProductKind),
    );
    yield r'price';
    yield serializers.serialize(
      object.price,
      specifiedType: const FullType(String),
    );
    yield r'change_24h_percent';
    yield serializers.serialize(
      object.change24hPercent,
      specifiedType: const FullType(String),
    );
    yield r'updated_at';
    yield serializers.serialize(
      object.updatedAt,
      specifiedType: const FullType(DateTime),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    RealtimePriceUpdate object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  @override
  RealtimePriceUpdate deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return serializers.deserialize(serialized, specifiedType: FullType($RealtimePriceUpdate)) as $RealtimePriceUpdate;
  }
}

/// a concrete implementation of [RealtimePriceUpdate], since [RealtimePriceUpdate] is not instantiable
@BuiltValue(instantiable: true)
abstract class $RealtimePriceUpdate implements RealtimePriceUpdate, Built<$RealtimePriceUpdate, $RealtimePriceUpdateBuilder> {
  $RealtimePriceUpdate._();

  factory $RealtimePriceUpdate([void Function($RealtimePriceUpdateBuilder)? updates]) = _$$RealtimePriceUpdate;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults($RealtimePriceUpdateBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<$RealtimePriceUpdate> get serializer => _$$RealtimePriceUpdateSerializer();
}

class _$$RealtimePriceUpdateSerializer implements PrimitiveSerializer<$RealtimePriceUpdate> {
  @override
  final Iterable<Type> types = const [$RealtimePriceUpdate, _$$RealtimePriceUpdate];

  @override
  final String wireName = r'$RealtimePriceUpdate';

  @override
  Object serialize(
    Serializers serializers,
    $RealtimePriceUpdate object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return serializers.serialize(object, specifiedType: FullType(RealtimePriceUpdate))!;
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required RealtimePriceUpdateBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'symbol':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.symbol = valueDes;
          break;
        case r'kind':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(ProductKind),
          ) as ProductKind;
          result.kind = valueDes;
          break;
        case r'price':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.price = valueDes;
          break;
        case r'change_24h_percent':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.change24hPercent = valueDes;
          break;
        case r'updated_at':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DateTime),
          ) as DateTime;
          result.updatedAt = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  $RealtimePriceUpdate deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = $RealtimePriceUpdateBuilder();
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


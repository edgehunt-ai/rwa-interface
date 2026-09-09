//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:rwa_api_client/src/model/product_kind.dart';
import 'package:rwa_api_client/src/model/candle_point.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'realtime_candle_update.g.dart';

/// RealtimeCandleUpdate
///
/// Properties:
/// * [symbol] 
/// * [kind] 
/// * [interval] 
/// * [point] 
@BuiltValue()
abstract class RealtimeCandleUpdate implements Built<RealtimeCandleUpdate, RealtimeCandleUpdateBuilder> {
  @BuiltValueField(wireName: r'symbol')
  String get symbol;

  @BuiltValueField(wireName: r'kind')
  ProductKind get kind;
  // enum kindEnum {  bstock,  perp,  };

  @BuiltValueField(wireName: r'interval')
  RealtimeCandleUpdateIntervalEnum get interval;
  // enum intervalEnum {  1m,  5m,  15m,  1h,  4h,  1d,  };

  @BuiltValueField(wireName: r'point')
  CandlePoint get point;

  RealtimeCandleUpdate._();

  factory RealtimeCandleUpdate([void updates(RealtimeCandleUpdateBuilder b)]) = _$RealtimeCandleUpdate;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(RealtimeCandleUpdateBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<RealtimeCandleUpdate> get serializer => _$RealtimeCandleUpdateSerializer();
}

class _$RealtimeCandleUpdateSerializer implements PrimitiveSerializer<RealtimeCandleUpdate> {
  @override
  final Iterable<Type> types = const [RealtimeCandleUpdate, _$RealtimeCandleUpdate];

  @override
  final String wireName = r'RealtimeCandleUpdate';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    RealtimeCandleUpdate object, {
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
    yield r'interval';
    yield serializers.serialize(
      object.interval,
      specifiedType: const FullType(RealtimeCandleUpdateIntervalEnum),
    );
    yield r'point';
    yield serializers.serialize(
      object.point,
      specifiedType: const FullType(CandlePoint),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    RealtimeCandleUpdate object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required RealtimeCandleUpdateBuilder result,
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
        case r'interval':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(RealtimeCandleUpdateIntervalEnum),
          ) as RealtimeCandleUpdateIntervalEnum;
          result.interval = valueDes;
          break;
        case r'point':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(CandlePoint),
          ) as CandlePoint;
          result.point.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  RealtimeCandleUpdate deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = RealtimeCandleUpdateBuilder();
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

class RealtimeCandleUpdateIntervalEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'1m')
  static const RealtimeCandleUpdateIntervalEnum n1m = _$realtimeCandleUpdateIntervalEnum_n1m;
  @BuiltValueEnumConst(wireName: r'5m')
  static const RealtimeCandleUpdateIntervalEnum n5m = _$realtimeCandleUpdateIntervalEnum_n5m;
  @BuiltValueEnumConst(wireName: r'15m')
  static const RealtimeCandleUpdateIntervalEnum n15m = _$realtimeCandleUpdateIntervalEnum_n15m;
  @BuiltValueEnumConst(wireName: r'1h')
  static const RealtimeCandleUpdateIntervalEnum n1h = _$realtimeCandleUpdateIntervalEnum_n1h;
  @BuiltValueEnumConst(wireName: r'4h')
  static const RealtimeCandleUpdateIntervalEnum n4h = _$realtimeCandleUpdateIntervalEnum_n4h;
  @BuiltValueEnumConst(wireName: r'1d')
  static const RealtimeCandleUpdateIntervalEnum n1d = _$realtimeCandleUpdateIntervalEnum_n1d;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const RealtimeCandleUpdateIntervalEnum unknownDefaultOpenApi = _$realtimeCandleUpdateIntervalEnum_unknownDefaultOpenApi;

  static Serializer<RealtimeCandleUpdateIntervalEnum> get serializer => _$realtimeCandleUpdateIntervalEnumSerializer;

  const RealtimeCandleUpdateIntervalEnum._(String name): super(name);

  static BuiltSet<RealtimeCandleUpdateIntervalEnum> get values => _$realtimeCandleUpdateIntervalEnumValues;
  static RealtimeCandleUpdateIntervalEnum valueOf(String name) => _$realtimeCandleUpdateIntervalEnumValueOf(name);
}


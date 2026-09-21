//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'bstocks_depth_sampling.g.dart';

/// BstocksDepthSampling
///
/// Properties:
/// * [grid] 
/// * [baseStart] - 十进制字符串，避免浮点误差
/// * [quoteStart] - 十进制字符串，避免浮点误差
/// * [amountSemantics] 
/// * [atomicSnapshot] 
/// * [startedAt] 
/// * [finishedAt] 
/// * [startBlock] 
/// * [endBlock] 
@BuiltValue()
abstract class BstocksDepthSampling implements Built<BstocksDepthSampling, BstocksDepthSamplingBuilder> {
  @BuiltValueField(wireName: r'grid')
  BstocksDepthSamplingGridEnum get grid;
  // enum gridEnum {  1_2_5,  };

  /// 十进制字符串，避免浮点误差
  @BuiltValueField(wireName: r'base_start')
  String get baseStart;

  /// 十进制字符串，避免浮点误差
  @BuiltValueField(wireName: r'quote_start')
  String get quoteStart;

  @BuiltValueField(wireName: r'amount_semantics')
  BstocksDepthSamplingAmountSemanticsEnum get amountSemantics;
  // enum amountSemanticsEnum {  nominal_input,  };

  @BuiltValueField(wireName: r'atomic_snapshot')
  bool get atomicSnapshot;

  @BuiltValueField(wireName: r'started_at')
  DateTime get startedAt;

  @BuiltValueField(wireName: r'finished_at')
  DateTime get finishedAt;

  @BuiltValueField(wireName: r'start_block')
  int get startBlock;

  @BuiltValueField(wireName: r'end_block')
  int get endBlock;

  BstocksDepthSampling._();

  factory BstocksDepthSampling([void updates(BstocksDepthSamplingBuilder b)]) = _$BstocksDepthSampling;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(BstocksDepthSamplingBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<BstocksDepthSampling> get serializer => _$BstocksDepthSamplingSerializer();
}

class _$BstocksDepthSamplingSerializer implements PrimitiveSerializer<BstocksDepthSampling> {
  @override
  final Iterable<Type> types = const [BstocksDepthSampling, _$BstocksDepthSampling];

  @override
  final String wireName = r'BstocksDepthSampling';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    BstocksDepthSampling object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'grid';
    yield serializers.serialize(
      object.grid,
      specifiedType: const FullType(BstocksDepthSamplingGridEnum),
    );
    yield r'base_start';
    yield serializers.serialize(
      object.baseStart,
      specifiedType: const FullType(String),
    );
    yield r'quote_start';
    yield serializers.serialize(
      object.quoteStart,
      specifiedType: const FullType(String),
    );
    yield r'amount_semantics';
    yield serializers.serialize(
      object.amountSemantics,
      specifiedType: const FullType(BstocksDepthSamplingAmountSemanticsEnum),
    );
    yield r'atomic_snapshot';
    yield serializers.serialize(
      object.atomicSnapshot,
      specifiedType: const FullType(bool),
    );
    yield r'started_at';
    yield serializers.serialize(
      object.startedAt,
      specifiedType: const FullType(DateTime),
    );
    yield r'finished_at';
    yield serializers.serialize(
      object.finishedAt,
      specifiedType: const FullType(DateTime),
    );
    yield r'start_block';
    yield serializers.serialize(
      object.startBlock,
      specifiedType: const FullType(int),
    );
    yield r'end_block';
    yield serializers.serialize(
      object.endBlock,
      specifiedType: const FullType(int),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    BstocksDepthSampling object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required BstocksDepthSamplingBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'grid':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BstocksDepthSamplingGridEnum),
          ) as BstocksDepthSamplingGridEnum;
          result.grid = valueDes;
          break;
        case r'base_start':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.baseStart = valueDes;
          break;
        case r'quote_start':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.quoteStart = valueDes;
          break;
        case r'amount_semantics':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BstocksDepthSamplingAmountSemanticsEnum),
          ) as BstocksDepthSamplingAmountSemanticsEnum;
          result.amountSemantics = valueDes;
          break;
        case r'atomic_snapshot':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.atomicSnapshot = valueDes;
          break;
        case r'started_at':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DateTime),
          ) as DateTime;
          result.startedAt = valueDes;
          break;
        case r'finished_at':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DateTime),
          ) as DateTime;
          result.finishedAt = valueDes;
          break;
        case r'start_block':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.startBlock = valueDes;
          break;
        case r'end_block':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.endBlock = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  BstocksDepthSampling deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = BstocksDepthSamplingBuilder();
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

class BstocksDepthSamplingGridEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'1_2_5')
  static const BstocksDepthSamplingGridEnum n125 = _$bstocksDepthSamplingGridEnum_n125;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const BstocksDepthSamplingGridEnum unknownDefaultOpenApi = _$bstocksDepthSamplingGridEnum_unknownDefaultOpenApi;

  static Serializer<BstocksDepthSamplingGridEnum> get serializer => _$bstocksDepthSamplingGridEnumSerializer;

  const BstocksDepthSamplingGridEnum._(String name): super(name);

  static BuiltSet<BstocksDepthSamplingGridEnum> get values => _$bstocksDepthSamplingGridEnumValues;
  static BstocksDepthSamplingGridEnum valueOf(String name) => _$bstocksDepthSamplingGridEnumValueOf(name);
}

class BstocksDepthSamplingAmountSemanticsEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'nominal_input')
  static const BstocksDepthSamplingAmountSemanticsEnum nominalInput = _$bstocksDepthSamplingAmountSemanticsEnum_nominalInput;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const BstocksDepthSamplingAmountSemanticsEnum unknownDefaultOpenApi = _$bstocksDepthSamplingAmountSemanticsEnum_unknownDefaultOpenApi;

  static Serializer<BstocksDepthSamplingAmountSemanticsEnum> get serializer => _$bstocksDepthSamplingAmountSemanticsEnumSerializer;

  const BstocksDepthSamplingAmountSemanticsEnum._(String name): super(name);

  static BuiltSet<BstocksDepthSamplingAmountSemanticsEnum> get values => _$bstocksDepthSamplingAmountSemanticsEnumValues;
  static BstocksDepthSamplingAmountSemanticsEnum valueOf(String name) => _$bstocksDepthSamplingAmountSemanticsEnumValueOf(name);
}


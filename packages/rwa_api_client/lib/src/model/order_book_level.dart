//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'order_book_level.g.dart';

/// OrderBookLevel
///
/// Properties:
/// * [price] - HIP3 为档位价；PropAMM 为整笔 quote_amount/size 均价，买入向上、卖出向下舍入到最多18位。
/// * [size] - PropAMM 为整笔基础资产总量。卖出含基础资产输入费，买入为预计收到量；不可跨行相加。
/// * [quoteAmount] - 仅 PropAMM，整笔报价资产金额；买入含输入费，卖出为预计收到量。
/// * [nominalInputRaw] - 原始最小单位的无符号十进制整数字符串；不允许指数、小数或负号。
/// * [grossInputRaw] - 原始最小单位的无符号十进制整数字符串；不允许指数、小数或负号。
/// * [inputFeeRaw] - 输入 token 手续费原始整数单位，不是 BNB gas。
/// * [outputRaw] - 原始最小单位的无符号十进制整数字符串；不允许指数、小数或负号。
/// * [validAfterBlock] 
/// * [validUntilBlock] 
@BuiltValue()
abstract class OrderBookLevel implements Built<OrderBookLevel, OrderBookLevelBuilder> {
  /// HIP3 为档位价；PropAMM 为整笔 quote_amount/size 均价，买入向上、卖出向下舍入到最多18位。
  @BuiltValueField(wireName: r'price')
  String get price;

  /// PropAMM 为整笔基础资产总量。卖出含基础资产输入费，买入为预计收到量；不可跨行相加。
  @BuiltValueField(wireName: r'size')
  String get size;

  /// 仅 PropAMM，整笔报价资产金额；买入含输入费，卖出为预计收到量。
  @BuiltValueField(wireName: r'quote_amount')
  String? get quoteAmount;

  /// 原始最小单位的无符号十进制整数字符串；不允许指数、小数或负号。
  @BuiltValueField(wireName: r'nominal_input_raw')
  String? get nominalInputRaw;

  /// 原始最小单位的无符号十进制整数字符串；不允许指数、小数或负号。
  @BuiltValueField(wireName: r'gross_input_raw')
  String? get grossInputRaw;

  /// 输入 token 手续费原始整数单位，不是 BNB gas。
  @BuiltValueField(wireName: r'input_fee_raw')
  String? get inputFeeRaw;

  /// 原始最小单位的无符号十进制整数字符串；不允许指数、小数或负号。
  @BuiltValueField(wireName: r'output_raw')
  String? get outputRaw;

  @BuiltValueField(wireName: r'valid_after_block')
  int? get validAfterBlock;

  @BuiltValueField(wireName: r'valid_until_block')
  int? get validUntilBlock;

  OrderBookLevel._();

  factory OrderBookLevel([void updates(OrderBookLevelBuilder b)]) = _$OrderBookLevel;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(OrderBookLevelBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<OrderBookLevel> get serializer => _$OrderBookLevelSerializer();
}

class _$OrderBookLevelSerializer implements PrimitiveSerializer<OrderBookLevel> {
  @override
  final Iterable<Type> types = const [OrderBookLevel, _$OrderBookLevel];

  @override
  final String wireName = r'OrderBookLevel';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    OrderBookLevel object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'price';
    yield serializers.serialize(
      object.price,
      specifiedType: const FullType(String),
    );
    yield r'size';
    yield serializers.serialize(
      object.size,
      specifiedType: const FullType(String),
    );
    if (object.quoteAmount != null) {
      yield r'quote_amount';
      yield serializers.serialize(
        object.quoteAmount,
        specifiedType: const FullType(String),
      );
    }
    if (object.nominalInputRaw != null) {
      yield r'nominal_input_raw';
      yield serializers.serialize(
        object.nominalInputRaw,
        specifiedType: const FullType(String),
      );
    }
    if (object.grossInputRaw != null) {
      yield r'gross_input_raw';
      yield serializers.serialize(
        object.grossInputRaw,
        specifiedType: const FullType(String),
      );
    }
    if (object.inputFeeRaw != null) {
      yield r'input_fee_raw';
      yield serializers.serialize(
        object.inputFeeRaw,
        specifiedType: const FullType(String),
      );
    }
    if (object.outputRaw != null) {
      yield r'output_raw';
      yield serializers.serialize(
        object.outputRaw,
        specifiedType: const FullType(String),
      );
    }
    if (object.validAfterBlock != null) {
      yield r'valid_after_block';
      yield serializers.serialize(
        object.validAfterBlock,
        specifiedType: const FullType(int),
      );
    }
    if (object.validUntilBlock != null) {
      yield r'valid_until_block';
      yield serializers.serialize(
        object.validUntilBlock,
        specifiedType: const FullType(int),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    OrderBookLevel object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required OrderBookLevelBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'price':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.price = valueDes;
          break;
        case r'size':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.size = valueDes;
          break;
        case r'quote_amount':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.quoteAmount = valueDes;
          break;
        case r'nominal_input_raw':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.nominalInputRaw = valueDes;
          break;
        case r'gross_input_raw':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.grossInputRaw = valueDes;
          break;
        case r'input_fee_raw':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.inputFeeRaw = valueDes;
          break;
        case r'output_raw':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.outputRaw = valueDes;
          break;
        case r'valid_after_block':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(int),
          ) as int?;
          if (valueDes == null) continue;
          result.validAfterBlock = valueDes;
          break;
        case r'valid_until_block':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(int),
          ) as int?;
          if (valueDes == null) continue;
          result.validUntilBlock = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  OrderBookLevel deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = OrderBookLevelBuilder();
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


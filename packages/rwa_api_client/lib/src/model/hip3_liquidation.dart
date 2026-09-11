//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:rwa_api_client/src/model/hip3_liquidation_position.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'hip3_liquidation.g.dart';

/// 一个权威强平账本事件，可包含多个HIP3产品。positions保留全部HIP3仓位，原生仓位仅计数，不改变事件级价值范围。
///
/// Properties:
/// * [id] - 同一钱包和环境的同一事件跨查询窗口保持稳定，可去重。
/// * [providerAccountValue] - 十进制字符串，避免浮点误差
/// * [accountValueScope] - 对应来源Cross账户价值或Isolated逐仓账户价值，不是所选HIP3产品的损益，不猜测结算资产。
/// * [marginMode] 
/// * [positions] 
/// * [excludedNativePositionCount] 
/// * [transactionHash] 
/// * [occurredAt] 
@BuiltValue()
abstract class Hip3Liquidation implements Built<Hip3Liquidation, Hip3LiquidationBuilder> {
  /// 同一钱包和环境的同一事件跨查询窗口保持稳定，可去重。
  @BuiltValueField(wireName: r'id')
  String get id;

  /// 十进制字符串，避免浮点误差
  @BuiltValueField(wireName: r'provider_account_value')
  String get providerAccountValue;

  /// 对应来源Cross账户价值或Isolated逐仓账户价值，不是所选HIP3产品的损益，不猜测结算资产。
  @BuiltValueField(wireName: r'account_value_scope')
  Hip3LiquidationAccountValueScopeEnum get accountValueScope;
  // enum accountValueScopeEnum {  cross_account,  isolated_account,  };

  @BuiltValueField(wireName: r'margin_mode')
  Hip3LiquidationMarginModeEnum get marginMode;
  // enum marginModeEnum {  cross,  isolated,  };

  @BuiltValueField(wireName: r'positions')
  BuiltList<Hip3LiquidationPosition> get positions;

  @BuiltValueField(wireName: r'excluded_native_position_count')
  int get excludedNativePositionCount;

  @BuiltValueField(wireName: r'transaction_hash')
  String get transactionHash;

  @BuiltValueField(wireName: r'occurred_at')
  DateTime get occurredAt;

  Hip3Liquidation._();

  factory Hip3Liquidation([void updates(Hip3LiquidationBuilder b)]) = _$Hip3Liquidation;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(Hip3LiquidationBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<Hip3Liquidation> get serializer => _$Hip3LiquidationSerializer();
}

class _$Hip3LiquidationSerializer implements PrimitiveSerializer<Hip3Liquidation> {
  @override
  final Iterable<Type> types = const [Hip3Liquidation, _$Hip3Liquidation];

  @override
  final String wireName = r'Hip3Liquidation';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    Hip3Liquidation object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'id';
    yield serializers.serialize(
      object.id,
      specifiedType: const FullType(String),
    );
    yield r'provider_account_value';
    yield serializers.serialize(
      object.providerAccountValue,
      specifiedType: const FullType(String),
    );
    yield r'account_value_scope';
    yield serializers.serialize(
      object.accountValueScope,
      specifiedType: const FullType(Hip3LiquidationAccountValueScopeEnum),
    );
    yield r'margin_mode';
    yield serializers.serialize(
      object.marginMode,
      specifiedType: const FullType(Hip3LiquidationMarginModeEnum),
    );
    yield r'positions';
    yield serializers.serialize(
      object.positions,
      specifiedType: const FullType(BuiltList, [FullType(Hip3LiquidationPosition)]),
    );
    yield r'excluded_native_position_count';
    yield serializers.serialize(
      object.excludedNativePositionCount,
      specifiedType: const FullType(int),
    );
    yield r'transaction_hash';
    yield serializers.serialize(
      object.transactionHash,
      specifiedType: const FullType(String),
    );
    yield r'occurred_at';
    yield serializers.serialize(
      object.occurredAt,
      specifiedType: const FullType(DateTime),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    Hip3Liquidation object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required Hip3LiquidationBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.id = valueDes;
          break;
        case r'provider_account_value':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.providerAccountValue = valueDes;
          break;
        case r'account_value_scope':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(Hip3LiquidationAccountValueScopeEnum),
          ) as Hip3LiquidationAccountValueScopeEnum;
          result.accountValueScope = valueDes;
          break;
        case r'margin_mode':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(Hip3LiquidationMarginModeEnum),
          ) as Hip3LiquidationMarginModeEnum;
          result.marginMode = valueDes;
          break;
        case r'positions':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(Hip3LiquidationPosition)]),
          ) as BuiltList<Hip3LiquidationPosition>;
          result.positions.replace(valueDes);
          break;
        case r'excluded_native_position_count':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.excludedNativePositionCount = valueDes;
          break;
        case r'transaction_hash':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.transactionHash = valueDes;
          break;
        case r'occurred_at':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DateTime),
          ) as DateTime;
          result.occurredAt = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  Hip3Liquidation deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = Hip3LiquidationBuilder();
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

class Hip3LiquidationAccountValueScopeEnum extends EnumClass {

  /// 对应来源Cross账户价值或Isolated逐仓账户价值，不是所选HIP3产品的损益，不猜测结算资产。
  @BuiltValueEnumConst(wireName: r'cross_account')
  static const Hip3LiquidationAccountValueScopeEnum crossAccount = _$hip3LiquidationAccountValueScopeEnum_crossAccount;
  /// 对应来源Cross账户价值或Isolated逐仓账户价值，不是所选HIP3产品的损益，不猜测结算资产。
  @BuiltValueEnumConst(wireName: r'isolated_account')
  static const Hip3LiquidationAccountValueScopeEnum isolatedAccount = _$hip3LiquidationAccountValueScopeEnum_isolatedAccount;
  /// 对应来源Cross账户价值或Isolated逐仓账户价值，不是所选HIP3产品的损益，不猜测结算资产。
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const Hip3LiquidationAccountValueScopeEnum unknownDefaultOpenApi = _$hip3LiquidationAccountValueScopeEnum_unknownDefaultOpenApi;

  static Serializer<Hip3LiquidationAccountValueScopeEnum> get serializer => _$hip3LiquidationAccountValueScopeEnumSerializer;

  const Hip3LiquidationAccountValueScopeEnum._(String name): super(name);

  static BuiltSet<Hip3LiquidationAccountValueScopeEnum> get values => _$hip3LiquidationAccountValueScopeEnumValues;
  static Hip3LiquidationAccountValueScopeEnum valueOf(String name) => _$hip3LiquidationAccountValueScopeEnumValueOf(name);
}

class Hip3LiquidationMarginModeEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'cross')
  static const Hip3LiquidationMarginModeEnum cross = _$hip3LiquidationMarginModeEnum_cross;
  @BuiltValueEnumConst(wireName: r'isolated')
  static const Hip3LiquidationMarginModeEnum isolated = _$hip3LiquidationMarginModeEnum_isolated;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const Hip3LiquidationMarginModeEnum unknownDefaultOpenApi = _$hip3LiquidationMarginModeEnum_unknownDefaultOpenApi;

  static Serializer<Hip3LiquidationMarginModeEnum> get serializer => _$hip3LiquidationMarginModeEnumSerializer;

  const Hip3LiquidationMarginModeEnum._(String name): super(name);

  static BuiltSet<Hip3LiquidationMarginModeEnum> get values => _$hip3LiquidationMarginModeEnumValues;
  static Hip3LiquidationMarginModeEnum valueOf(String name) => _$hip3LiquidationMarginModeEnumValueOf(name);
}


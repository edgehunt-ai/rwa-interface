//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:rwa_api_client/src/model/hip3_withdrawal_rail.dart';
import 'package:rwa_api_client/src/model/hip3_collateral_risk_preview.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'hip3_withdrawal_preview.g.dart';

/// Hip3WithdrawalPreview
///
/// Properties:
/// * [amount] - 十进制字符串，避免浮点误差
/// * [fee] - 十进制字符串，避免浮点误差
/// * [minimumReceived] - 十进制字符串，避免浮点误差
/// * [rail] 
/// * [destinationAddress] 
/// * [chainId] - 自有 Arbitrum 钱包所在链，主网 42161 / 测试网 421614。
/// * [maximumTransferable] - 十进制字符串，避免浮点误差
/// * [blockers] 
/// * [riskPreview] 
@BuiltValue()
abstract class Hip3WithdrawalPreview implements Built<Hip3WithdrawalPreview, Hip3WithdrawalPreviewBuilder> {
  /// 十进制字符串，避免浮点误差
  @BuiltValueField(wireName: r'amount')
  String get amount;

  /// 十进制字符串，避免浮点误差
  @BuiltValueField(wireName: r'fee')
  String get fee;

  /// 十进制字符串，避免浮点误差
  @BuiltValueField(wireName: r'minimum_received')
  String get minimumReceived;

  @BuiltValueField(wireName: r'rail')
  Hip3WithdrawalRail get rail;
  // enum railEnum {  bridge2,  float,  };

  @BuiltValueField(wireName: r'destination_address')
  String get destinationAddress;

  /// 自有 Arbitrum 钱包所在链，主网 42161 / 测试网 421614。
  @BuiltValueField(wireName: r'chain_id')
  String get chainId;

  /// 十进制字符串，避免浮点误差
  @BuiltValueField(wireName: r'maximum_transferable')
  String get maximumTransferable;

  @BuiltValueField(wireName: r'blockers')
  BuiltList<Hip3WithdrawalPreviewBlockersEnum> get blockers;
  // enum blockersEnum {  insufficient_withdrawable_balance,  };

  @BuiltValueField(wireName: r'risk_preview')
  Hip3CollateralRiskPreview get riskPreview;

  Hip3WithdrawalPreview._();

  factory Hip3WithdrawalPreview([void updates(Hip3WithdrawalPreviewBuilder b)]) = _$Hip3WithdrawalPreview;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(Hip3WithdrawalPreviewBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<Hip3WithdrawalPreview> get serializer => _$Hip3WithdrawalPreviewSerializer();
}

class _$Hip3WithdrawalPreviewSerializer implements PrimitiveSerializer<Hip3WithdrawalPreview> {
  @override
  final Iterable<Type> types = const [Hip3WithdrawalPreview, _$Hip3WithdrawalPreview];

  @override
  final String wireName = r'Hip3WithdrawalPreview';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    Hip3WithdrawalPreview object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'amount';
    yield serializers.serialize(
      object.amount,
      specifiedType: const FullType(String),
    );
    yield r'fee';
    yield serializers.serialize(
      object.fee,
      specifiedType: const FullType(String),
    );
    yield r'minimum_received';
    yield serializers.serialize(
      object.minimumReceived,
      specifiedType: const FullType(String),
    );
    yield r'rail';
    yield serializers.serialize(
      object.rail,
      specifiedType: const FullType(Hip3WithdrawalRail),
    );
    yield r'destination_address';
    yield serializers.serialize(
      object.destinationAddress,
      specifiedType: const FullType(String),
    );
    yield r'chain_id';
    yield serializers.serialize(
      object.chainId,
      specifiedType: const FullType(String),
    );
    yield r'maximum_transferable';
    yield serializers.serialize(
      object.maximumTransferable,
      specifiedType: const FullType(String),
    );
    yield r'blockers';
    yield serializers.serialize(
      object.blockers,
      specifiedType: const FullType(BuiltList, [FullType(Hip3WithdrawalPreviewBlockersEnum)]),
    );
    yield r'risk_preview';
    yield serializers.serialize(
      object.riskPreview,
      specifiedType: const FullType(Hip3CollateralRiskPreview),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    Hip3WithdrawalPreview object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required Hip3WithdrawalPreviewBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'amount':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.amount = valueDes;
          break;
        case r'fee':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.fee = valueDes;
          break;
        case r'minimum_received':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.minimumReceived = valueDes;
          break;
        case r'rail':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(Hip3WithdrawalRail),
          ) as Hip3WithdrawalRail;
          result.rail = valueDes;
          break;
        case r'destination_address':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.destinationAddress = valueDes;
          break;
        case r'chain_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.chainId = valueDes;
          break;
        case r'maximum_transferable':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.maximumTransferable = valueDes;
          break;
        case r'blockers':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(Hip3WithdrawalPreviewBlockersEnum)]),
          ) as BuiltList<Hip3WithdrawalPreviewBlockersEnum>;
          result.blockers.replace(valueDes);
          break;
        case r'risk_preview':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(Hip3CollateralRiskPreview),
          ) as Hip3CollateralRiskPreview;
          result.riskPreview.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  Hip3WithdrawalPreview deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = Hip3WithdrawalPreviewBuilder();
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

class Hip3WithdrawalPreviewBlockersEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'insufficient_withdrawable_balance')
  static const Hip3WithdrawalPreviewBlockersEnum insufficientWithdrawableBalance = _$hip3WithdrawalPreviewBlockersEnum_insufficientWithdrawableBalance;

  static Serializer<Hip3WithdrawalPreviewBlockersEnum> get serializer => _$hip3WithdrawalPreviewBlockersEnumSerializer;

  const Hip3WithdrawalPreviewBlockersEnum._(String name): super(name);

  static BuiltSet<Hip3WithdrawalPreviewBlockersEnum> get values => _$hip3WithdrawalPreviewBlockersEnumValues;
  static Hip3WithdrawalPreviewBlockersEnum valueOf(String name) => _$hip3WithdrawalPreviewBlockersEnumValueOf(name);
}


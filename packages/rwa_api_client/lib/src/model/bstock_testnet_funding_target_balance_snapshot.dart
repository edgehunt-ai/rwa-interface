//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:rwa_api_client/src/model/bstock_testnet_funding_target_asset.dart';
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'bstock_testnet_funding_target_balance_snapshot.g.dart';

/// BstockTestnetFundingTargetBalanceSnapshot
///
/// Properties:
/// * [account] 
/// * [accountRef] 
/// * [asset] 
/// * [availableAmount] - 十进制字符串，避免浮点误差
/// * [source_] 
/// * [observedAt] 
/// * [validUntil] 
@BuiltValue()
abstract class BstockTestnetFundingTargetBalanceSnapshot implements Built<BstockTestnetFundingTargetBalanceSnapshot, BstockTestnetFundingTargetBalanceSnapshotBuilder> {
  @BuiltValueField(wireName: r'account')
  BstockTestnetFundingTargetBalanceSnapshotAccountEnum get account;
  // enum accountEnum {  bstocks,  };

  @BuiltValueField(wireName: r'account_ref')
  String get accountRef;

  @BuiltValueField(wireName: r'asset')
  BstockTestnetFundingTargetAsset get asset;

  /// 十进制字符串，避免浮点误差
  @BuiltValueField(wireName: r'available_amount')
  String get availableAmount;

  @BuiltValueField(wireName: r'source')
  BstockTestnetFundingTargetBalanceSnapshotSource_Enum get source_;
  // enum source_Enum {  bsc_rpc,  };

  @BuiltValueField(wireName: r'observed_at')
  DateTime get observedAt;

  @BuiltValueField(wireName: r'valid_until')
  DateTime get validUntil;

  BstockTestnetFundingTargetBalanceSnapshot._();

  factory BstockTestnetFundingTargetBalanceSnapshot([void updates(BstockTestnetFundingTargetBalanceSnapshotBuilder b)]) = _$BstockTestnetFundingTargetBalanceSnapshot;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(BstockTestnetFundingTargetBalanceSnapshotBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<BstockTestnetFundingTargetBalanceSnapshot> get serializer => _$BstockTestnetFundingTargetBalanceSnapshotSerializer();
}

class _$BstockTestnetFundingTargetBalanceSnapshotSerializer implements PrimitiveSerializer<BstockTestnetFundingTargetBalanceSnapshot> {
  @override
  final Iterable<Type> types = const [BstockTestnetFundingTargetBalanceSnapshot, _$BstockTestnetFundingTargetBalanceSnapshot];

  @override
  final String wireName = r'BstockTestnetFundingTargetBalanceSnapshot';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    BstockTestnetFundingTargetBalanceSnapshot object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'account';
    yield serializers.serialize(
      object.account,
      specifiedType: const FullType(BstockTestnetFundingTargetBalanceSnapshotAccountEnum),
    );
    yield r'account_ref';
    yield serializers.serialize(
      object.accountRef,
      specifiedType: const FullType(String),
    );
    yield r'asset';
    yield serializers.serialize(
      object.asset,
      specifiedType: const FullType(BstockTestnetFundingTargetAsset),
    );
    yield r'available_amount';
    yield serializers.serialize(
      object.availableAmount,
      specifiedType: const FullType(String),
    );
    yield r'source';
    yield serializers.serialize(
      object.source_,
      specifiedType: const FullType(BstockTestnetFundingTargetBalanceSnapshotSource_Enum),
    );
    yield r'observed_at';
    yield serializers.serialize(
      object.observedAt,
      specifiedType: const FullType(DateTime),
    );
    yield r'valid_until';
    yield serializers.serialize(
      object.validUntil,
      specifiedType: const FullType(DateTime),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    BstockTestnetFundingTargetBalanceSnapshot object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required BstockTestnetFundingTargetBalanceSnapshotBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'account':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BstockTestnetFundingTargetBalanceSnapshotAccountEnum),
          ) as BstockTestnetFundingTargetBalanceSnapshotAccountEnum;
          result.account = valueDes;
          break;
        case r'account_ref':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.accountRef = valueDes;
          break;
        case r'asset':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BstockTestnetFundingTargetAsset),
          ) as BstockTestnetFundingTargetAsset;
          result.asset.replace(valueDes);
          break;
        case r'available_amount':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.availableAmount = valueDes;
          break;
        case r'source':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BstockTestnetFundingTargetBalanceSnapshotSource_Enum),
          ) as BstockTestnetFundingTargetBalanceSnapshotSource_Enum;
          result.source_ = valueDes;
          break;
        case r'observed_at':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DateTime),
          ) as DateTime;
          result.observedAt = valueDes;
          break;
        case r'valid_until':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DateTime),
          ) as DateTime;
          result.validUntil = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  BstockTestnetFundingTargetBalanceSnapshot deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = BstockTestnetFundingTargetBalanceSnapshotBuilder();
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

class BstockTestnetFundingTargetBalanceSnapshotAccountEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'bstocks')
  static const BstockTestnetFundingTargetBalanceSnapshotAccountEnum bstocks = _$bstockTestnetFundingTargetBalanceSnapshotAccountEnum_bstocks;

  static Serializer<BstockTestnetFundingTargetBalanceSnapshotAccountEnum> get serializer => _$bstockTestnetFundingTargetBalanceSnapshotAccountEnumSerializer;

  const BstockTestnetFundingTargetBalanceSnapshotAccountEnum._(String name): super(name);

  static BuiltSet<BstockTestnetFundingTargetBalanceSnapshotAccountEnum> get values => _$bstockTestnetFundingTargetBalanceSnapshotAccountEnumValues;
  static BstockTestnetFundingTargetBalanceSnapshotAccountEnum valueOf(String name) => _$bstockTestnetFundingTargetBalanceSnapshotAccountEnumValueOf(name);
}

class BstockTestnetFundingTargetBalanceSnapshotSource_Enum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'bsc_rpc')
  static const BstockTestnetFundingTargetBalanceSnapshotSource_Enum bscRpc = _$bstockTestnetFundingTargetBalanceSnapshotSourceEnum_bscRpc;

  static Serializer<BstockTestnetFundingTargetBalanceSnapshotSource_Enum> get serializer => _$bstockTestnetFundingTargetBalanceSnapshotSourceEnumSerializer;

  const BstockTestnetFundingTargetBalanceSnapshotSource_Enum._(String name): super(name);

  static BuiltSet<BstockTestnetFundingTargetBalanceSnapshotSource_Enum> get values => _$bstockTestnetFundingTargetBalanceSnapshotSourceEnumValues;
  static BstockTestnetFundingTargetBalanceSnapshotSource_Enum valueOf(String name) => _$bstockTestnetFundingTargetBalanceSnapshotSourceEnumValueOf(name);
}


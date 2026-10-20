//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:rwa_api_client/src/model/bstock_funding_target_asset.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'bstock_funding_target_balance_snapshot.g.dart';

/// BstockFundingTargetBalanceSnapshot
///
/// Properties:
/// * [account] 
/// * [accountRef] 
/// * [asset] 
/// * [targetEnvironment] - Frozen target environment when explicitly known; never inferred from a symbol.
/// * [availableAmount] - 十进制字符串，避免浮点误差。请求最多60位整数和18位小数，不接受整数部分多余前导零； 各操作另行校验正负、范围及资产精度，不以此通用响应标量代替业务准入。 
/// * [source_] 
/// * [observedAt] 
/// * [validUntil] 
@BuiltValue()
abstract class BstockFundingTargetBalanceSnapshot implements Built<BstockFundingTargetBalanceSnapshot, BstockFundingTargetBalanceSnapshotBuilder> {
  @BuiltValueField(wireName: r'account')
  BstockFundingTargetBalanceSnapshotAccountEnum get account;
  // enum accountEnum {  bstocks,  };

  @BuiltValueField(wireName: r'account_ref')
  String get accountRef;

  @BuiltValueField(wireName: r'asset')
  BstockFundingTargetAsset get asset;

  /// Frozen target environment when explicitly known; never inferred from a symbol.
  @BuiltValueField(wireName: r'target_environment')
  BstockFundingTargetBalanceSnapshotTargetEnvironmentEnum? get targetEnvironment;
  // enum targetEnvironmentEnum {  mainnet,  testnet,  };

  /// 十进制字符串，避免浮点误差。请求最多60位整数和18位小数，不接受整数部分多余前导零； 各操作另行校验正负、范围及资产精度，不以此通用响应标量代替业务准入。 
  @BuiltValueField(wireName: r'available_amount')
  String get availableAmount;

  @BuiltValueField(wireName: r'source')
  BstockFundingTargetBalanceSnapshotSource_Enum get source_;
  // enum source_Enum {  bsc_rpc,  };

  @BuiltValueField(wireName: r'observed_at')
  DateTime get observedAt;

  @BuiltValueField(wireName: r'valid_until')
  DateTime get validUntil;

  BstockFundingTargetBalanceSnapshot._();

  factory BstockFundingTargetBalanceSnapshot([void updates(BstockFundingTargetBalanceSnapshotBuilder b)]) = _$BstockFundingTargetBalanceSnapshot;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(BstockFundingTargetBalanceSnapshotBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<BstockFundingTargetBalanceSnapshot> get serializer => _$BstockFundingTargetBalanceSnapshotSerializer();
}

class _$BstockFundingTargetBalanceSnapshotSerializer implements PrimitiveSerializer<BstockFundingTargetBalanceSnapshot> {
  @override
  final Iterable<Type> types = const [BstockFundingTargetBalanceSnapshot, _$BstockFundingTargetBalanceSnapshot];

  @override
  final String wireName = r'BstockFundingTargetBalanceSnapshot';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    BstockFundingTargetBalanceSnapshot object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'account';
    yield serializers.serialize(
      object.account,
      specifiedType: const FullType(BstockFundingTargetBalanceSnapshotAccountEnum),
    );
    yield r'account_ref';
    yield serializers.serialize(
      object.accountRef,
      specifiedType: const FullType(String),
    );
    yield r'asset';
    yield serializers.serialize(
      object.asset,
      specifiedType: const FullType(BstockFundingTargetAsset),
    );
    if (object.targetEnvironment != null) {
      yield r'target_environment';
      yield serializers.serialize(
        object.targetEnvironment,
        specifiedType: const FullType.nullable(BstockFundingTargetBalanceSnapshotTargetEnvironmentEnum),
      );
    }
    yield r'available_amount';
    yield serializers.serialize(
      object.availableAmount,
      specifiedType: const FullType(String),
    );
    yield r'source';
    yield serializers.serialize(
      object.source_,
      specifiedType: const FullType(BstockFundingTargetBalanceSnapshotSource_Enum),
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
    BstockFundingTargetBalanceSnapshot object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required BstockFundingTargetBalanceSnapshotBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'account':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BstockFundingTargetBalanceSnapshotAccountEnum),
          ) as BstockFundingTargetBalanceSnapshotAccountEnum;
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
            specifiedType: const FullType(BstockFundingTargetAsset),
          ) as BstockFundingTargetAsset;
          result.asset.replace(valueDes);
          break;
        case r'target_environment':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(BstockFundingTargetBalanceSnapshotTargetEnvironmentEnum),
          ) as BstockFundingTargetBalanceSnapshotTargetEnvironmentEnum?;
          if (valueDes == null) continue;
          result.targetEnvironment = valueDes;
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
            specifiedType: const FullType(BstockFundingTargetBalanceSnapshotSource_Enum),
          ) as BstockFundingTargetBalanceSnapshotSource_Enum;
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
  BstockFundingTargetBalanceSnapshot deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = BstockFundingTargetBalanceSnapshotBuilder();
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

class BstockFundingTargetBalanceSnapshotAccountEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'bstocks')
  static const BstockFundingTargetBalanceSnapshotAccountEnum bstocks = _$bstockFundingTargetBalanceSnapshotAccountEnum_bstocks;

  static Serializer<BstockFundingTargetBalanceSnapshotAccountEnum> get serializer => _$bstockFundingTargetBalanceSnapshotAccountEnumSerializer;

  const BstockFundingTargetBalanceSnapshotAccountEnum._(String name): super(name);

  static BuiltSet<BstockFundingTargetBalanceSnapshotAccountEnum> get values => _$bstockFundingTargetBalanceSnapshotAccountEnumValues;
  static BstockFundingTargetBalanceSnapshotAccountEnum valueOf(String name) => _$bstockFundingTargetBalanceSnapshotAccountEnumValueOf(name);
}

class BstockFundingTargetBalanceSnapshotTargetEnvironmentEnum extends EnumClass {

  /// Frozen target environment when explicitly known; never inferred from a symbol.
  @BuiltValueEnumConst(wireName: r'mainnet')
  static const BstockFundingTargetBalanceSnapshotTargetEnvironmentEnum mainnet = _$bstockFundingTargetBalanceSnapshotTargetEnvironmentEnum_mainnet;
  /// Frozen target environment when explicitly known; never inferred from a symbol.
  @BuiltValueEnumConst(wireName: r'testnet')
  static const BstockFundingTargetBalanceSnapshotTargetEnvironmentEnum testnet = _$bstockFundingTargetBalanceSnapshotTargetEnvironmentEnum_testnet;

  static Serializer<BstockFundingTargetBalanceSnapshotTargetEnvironmentEnum> get serializer => _$bstockFundingTargetBalanceSnapshotTargetEnvironmentEnumSerializer;

  const BstockFundingTargetBalanceSnapshotTargetEnvironmentEnum._(String name): super(name);

  static BuiltSet<BstockFundingTargetBalanceSnapshotTargetEnvironmentEnum> get values => _$bstockFundingTargetBalanceSnapshotTargetEnvironmentEnumValues;
  static BstockFundingTargetBalanceSnapshotTargetEnvironmentEnum valueOf(String name) => _$bstockFundingTargetBalanceSnapshotTargetEnvironmentEnumValueOf(name);
}

class BstockFundingTargetBalanceSnapshotSource_Enum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'bsc_rpc')
  static const BstockFundingTargetBalanceSnapshotSource_Enum bscRpc = _$bstockFundingTargetBalanceSnapshotSourceEnum_bscRpc;

  static Serializer<BstockFundingTargetBalanceSnapshotSource_Enum> get serializer => _$bstockFundingTargetBalanceSnapshotSourceEnumSerializer;

  const BstockFundingTargetBalanceSnapshotSource_Enum._(String name): super(name);

  static BuiltSet<BstockFundingTargetBalanceSnapshotSource_Enum> get values => _$bstockFundingTargetBalanceSnapshotSourceEnumValues;
  static BstockFundingTargetBalanceSnapshotSource_Enum valueOf(String name) => _$bstockFundingTargetBalanceSnapshotSourceEnumValueOf(name);
}


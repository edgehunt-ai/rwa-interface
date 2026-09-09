//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:rwa_api_client/src/model/perp_funding_target_asset.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'perp_funding_target_balance_snapshot.g.dart';

/// PerpFundingTargetBalanceSnapshot
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
abstract class PerpFundingTargetBalanceSnapshot implements Built<PerpFundingTargetBalanceSnapshot, PerpFundingTargetBalanceSnapshotBuilder> {
  @BuiltValueField(wireName: r'account')
  PerpFundingTargetBalanceSnapshotAccountEnum get account;
  // enum accountEnum {  hip3,  };

  @BuiltValueField(wireName: r'account_ref')
  String get accountRef;

  @BuiltValueField(wireName: r'asset')
  PerpFundingTargetAsset get asset;

  /// 十进制字符串，避免浮点误差
  @BuiltValueField(wireName: r'available_amount')
  String get availableAmount;

  @BuiltValueField(wireName: r'source')
  PerpFundingTargetBalanceSnapshotSource_Enum get source_;
  // enum source_Enum {  hyperliquid_info,  };

  @BuiltValueField(wireName: r'observed_at')
  DateTime get observedAt;

  @BuiltValueField(wireName: r'valid_until')
  DateTime get validUntil;

  PerpFundingTargetBalanceSnapshot._();

  factory PerpFundingTargetBalanceSnapshot([void updates(PerpFundingTargetBalanceSnapshotBuilder b)]) = _$PerpFundingTargetBalanceSnapshot;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(PerpFundingTargetBalanceSnapshotBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<PerpFundingTargetBalanceSnapshot> get serializer => _$PerpFundingTargetBalanceSnapshotSerializer();
}

class _$PerpFundingTargetBalanceSnapshotSerializer implements PrimitiveSerializer<PerpFundingTargetBalanceSnapshot> {
  @override
  final Iterable<Type> types = const [PerpFundingTargetBalanceSnapshot, _$PerpFundingTargetBalanceSnapshot];

  @override
  final String wireName = r'PerpFundingTargetBalanceSnapshot';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    PerpFundingTargetBalanceSnapshot object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'account';
    yield serializers.serialize(
      object.account,
      specifiedType: const FullType(PerpFundingTargetBalanceSnapshotAccountEnum),
    );
    yield r'account_ref';
    yield serializers.serialize(
      object.accountRef,
      specifiedType: const FullType(String),
    );
    yield r'asset';
    yield serializers.serialize(
      object.asset,
      specifiedType: const FullType(PerpFundingTargetAsset),
    );
    yield r'available_amount';
    yield serializers.serialize(
      object.availableAmount,
      specifiedType: const FullType(String),
    );
    yield r'source';
    yield serializers.serialize(
      object.source_,
      specifiedType: const FullType(PerpFundingTargetBalanceSnapshotSource_Enum),
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
    PerpFundingTargetBalanceSnapshot object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required PerpFundingTargetBalanceSnapshotBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'account':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(PerpFundingTargetBalanceSnapshotAccountEnum),
          ) as PerpFundingTargetBalanceSnapshotAccountEnum;
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
            specifiedType: const FullType(PerpFundingTargetAsset),
          ) as PerpFundingTargetAsset;
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
            specifiedType: const FullType(PerpFundingTargetBalanceSnapshotSource_Enum),
          ) as PerpFundingTargetBalanceSnapshotSource_Enum;
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
  PerpFundingTargetBalanceSnapshot deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = PerpFundingTargetBalanceSnapshotBuilder();
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

class PerpFundingTargetBalanceSnapshotAccountEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'hip3')
  static const PerpFundingTargetBalanceSnapshotAccountEnum hip3 = _$perpFundingTargetBalanceSnapshotAccountEnum_hip3;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const PerpFundingTargetBalanceSnapshotAccountEnum unknownDefaultOpenApi = _$perpFundingTargetBalanceSnapshotAccountEnum_unknownDefaultOpenApi;

  static Serializer<PerpFundingTargetBalanceSnapshotAccountEnum> get serializer => _$perpFundingTargetBalanceSnapshotAccountEnumSerializer;

  const PerpFundingTargetBalanceSnapshotAccountEnum._(String name): super(name);

  static BuiltSet<PerpFundingTargetBalanceSnapshotAccountEnum> get values => _$perpFundingTargetBalanceSnapshotAccountEnumValues;
  static PerpFundingTargetBalanceSnapshotAccountEnum valueOf(String name) => _$perpFundingTargetBalanceSnapshotAccountEnumValueOf(name);
}

class PerpFundingTargetBalanceSnapshotSource_Enum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'hyperliquid_info')
  static const PerpFundingTargetBalanceSnapshotSource_Enum hyperliquidInfo = _$perpFundingTargetBalanceSnapshotSourceEnum_hyperliquidInfo;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const PerpFundingTargetBalanceSnapshotSource_Enum unknownDefaultOpenApi = _$perpFundingTargetBalanceSnapshotSourceEnum_unknownDefaultOpenApi;

  static Serializer<PerpFundingTargetBalanceSnapshotSource_Enum> get serializer => _$perpFundingTargetBalanceSnapshotSourceEnumSerializer;

  const PerpFundingTargetBalanceSnapshotSource_Enum._(String name): super(name);

  static BuiltSet<PerpFundingTargetBalanceSnapshotSource_Enum> get values => _$perpFundingTargetBalanceSnapshotSourceEnumValues;
  static PerpFundingTargetBalanceSnapshotSource_Enum valueOf(String name) => _$perpFundingTargetBalanceSnapshotSourceEnumValueOf(name);
}


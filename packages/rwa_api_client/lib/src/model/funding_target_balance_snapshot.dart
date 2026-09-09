//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:rwa_api_client/src/model/funding_target_balance_source.dart';
import 'package:rwa_api_client/src/model/funding_asset_identity.dart';
import 'package:rwa_api_client/src/model/account_kind.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'funding_target_balance_snapshot.g.dart';

/// FundingTargetBalanceSnapshot
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
abstract class FundingTargetBalanceSnapshot implements Built<FundingTargetBalanceSnapshot, FundingTargetBalanceSnapshotBuilder> {
  @BuiltValueField(wireName: r'account')
  AccountKind get account;
  // enum accountEnum {  app,  bstocks,  hip3,  };

  @BuiltValueField(wireName: r'account_ref')
  String get accountRef;

  @BuiltValueField(wireName: r'asset')
  FundingAssetIdentity get asset;

  /// 十进制字符串，避免浮点误差
  @BuiltValueField(wireName: r'available_amount')
  String get availableAmount;

  @BuiltValueField(wireName: r'source')
  FundingTargetBalanceSource get source_;
  // enum source_Enum {  bsc_rpc,  hyperliquid_info,  };

  @BuiltValueField(wireName: r'observed_at')
  DateTime get observedAt;

  @BuiltValueField(wireName: r'valid_until')
  DateTime get validUntil;

  FundingTargetBalanceSnapshot._();

  factory FundingTargetBalanceSnapshot([void updates(FundingTargetBalanceSnapshotBuilder b)]) = _$FundingTargetBalanceSnapshot;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(FundingTargetBalanceSnapshotBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<FundingTargetBalanceSnapshot> get serializer => _$FundingTargetBalanceSnapshotSerializer();
}

class _$FundingTargetBalanceSnapshotSerializer implements PrimitiveSerializer<FundingTargetBalanceSnapshot> {
  @override
  final Iterable<Type> types = const [FundingTargetBalanceSnapshot, _$FundingTargetBalanceSnapshot];

  @override
  final String wireName = r'FundingTargetBalanceSnapshot';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    FundingTargetBalanceSnapshot object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'account';
    yield serializers.serialize(
      object.account,
      specifiedType: const FullType(AccountKind),
    );
    yield r'account_ref';
    yield serializers.serialize(
      object.accountRef,
      specifiedType: const FullType(String),
    );
    yield r'asset';
    yield serializers.serialize(
      object.asset,
      specifiedType: const FullType(FundingAssetIdentity),
    );
    yield r'available_amount';
    yield serializers.serialize(
      object.availableAmount,
      specifiedType: const FullType(String),
    );
    yield r'source';
    yield serializers.serialize(
      object.source_,
      specifiedType: const FullType(FundingTargetBalanceSource),
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
    FundingTargetBalanceSnapshot object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required FundingTargetBalanceSnapshotBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'account':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(AccountKind),
          ) as AccountKind;
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
            specifiedType: const FullType(FundingAssetIdentity),
          ) as FundingAssetIdentity;
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
            specifiedType: const FullType(FundingTargetBalanceSource),
          ) as FundingTargetBalanceSource;
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
  FundingTargetBalanceSnapshot deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = FundingTargetBalanceSnapshotBuilder();
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


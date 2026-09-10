//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:rwa_api_client/src/model/funding_source_asset_identity.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'funding_source_position_snapshot.g.dart';

/// Immutable account-position evidence frozen into one allocation leg.
///
/// Properties:
/// * [positionId] - Account-scoped opaque source-position identifier.
/// * [walletId] 
/// * [walletAddress] 
/// * [asset] 
/// * [availableAmount] - 十进制字符串，避免浮点误差
/// * [reservedAmount] - 十进制字符串，避免浮点误差
/// * [gasAsset] 
/// * [gasBalance] - 十进制字符串，避免浮点误差
/// * [observedAt] 
/// * [validUntil] 
@BuiltValue()
abstract class FundingSourcePositionSnapshot implements Built<FundingSourcePositionSnapshot, FundingSourcePositionSnapshotBuilder> {
  /// Account-scoped opaque source-position identifier.
  @BuiltValueField(wireName: r'position_id')
  String get positionId;

  @BuiltValueField(wireName: r'wallet_id')
  String get walletId;

  @BuiltValueField(wireName: r'wallet_address')
  String get walletAddress;

  @BuiltValueField(wireName: r'asset')
  FundingSourceAssetIdentity get asset;

  /// 十进制字符串，避免浮点误差
  @BuiltValueField(wireName: r'available_amount')
  String get availableAmount;

  /// 十进制字符串，避免浮点误差
  @BuiltValueField(wireName: r'reserved_amount')
  String get reservedAmount;

  @BuiltValueField(wireName: r'gas_asset')
  String get gasAsset;

  /// 十进制字符串，避免浮点误差
  @BuiltValueField(wireName: r'gas_balance')
  String get gasBalance;

  @BuiltValueField(wireName: r'observed_at')
  DateTime get observedAt;

  @BuiltValueField(wireName: r'valid_until')
  DateTime get validUntil;

  FundingSourcePositionSnapshot._();

  factory FundingSourcePositionSnapshot([void updates(FundingSourcePositionSnapshotBuilder b)]) = _$FundingSourcePositionSnapshot;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(FundingSourcePositionSnapshotBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<FundingSourcePositionSnapshot> get serializer => _$FundingSourcePositionSnapshotSerializer();
}

class _$FundingSourcePositionSnapshotSerializer implements PrimitiveSerializer<FundingSourcePositionSnapshot> {
  @override
  final Iterable<Type> types = const [FundingSourcePositionSnapshot, _$FundingSourcePositionSnapshot];

  @override
  final String wireName = r'FundingSourcePositionSnapshot';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    FundingSourcePositionSnapshot object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'position_id';
    yield serializers.serialize(
      object.positionId,
      specifiedType: const FullType(String),
    );
    yield r'wallet_id';
    yield serializers.serialize(
      object.walletId,
      specifiedType: const FullType(String),
    );
    yield r'wallet_address';
    yield serializers.serialize(
      object.walletAddress,
      specifiedType: const FullType(String),
    );
    yield r'asset';
    yield serializers.serialize(
      object.asset,
      specifiedType: const FullType(FundingSourceAssetIdentity),
    );
    yield r'available_amount';
    yield serializers.serialize(
      object.availableAmount,
      specifiedType: const FullType(String),
    );
    yield r'reserved_amount';
    yield serializers.serialize(
      object.reservedAmount,
      specifiedType: const FullType(String),
    );
    yield r'gas_asset';
    yield serializers.serialize(
      object.gasAsset,
      specifiedType: const FullType(String),
    );
    yield r'gas_balance';
    yield serializers.serialize(
      object.gasBalance,
      specifiedType: const FullType(String),
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
    FundingSourcePositionSnapshot object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required FundingSourcePositionSnapshotBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'position_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.positionId = valueDes;
          break;
        case r'wallet_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.walletId = valueDes;
          break;
        case r'wallet_address':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.walletAddress = valueDes;
          break;
        case r'asset':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(FundingSourceAssetIdentity),
          ) as FundingSourceAssetIdentity;
          result.asset.replace(valueDes);
          break;
        case r'available_amount':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.availableAmount = valueDes;
          break;
        case r'reserved_amount':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.reservedAmount = valueDes;
          break;
        case r'gas_asset':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.gasAsset = valueDes;
          break;
        case r'gas_balance':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.gasBalance = valueDes;
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
  FundingSourcePositionSnapshot deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = FundingSourcePositionSnapshotBuilder();
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


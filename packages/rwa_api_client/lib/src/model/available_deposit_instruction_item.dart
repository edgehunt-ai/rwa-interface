//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:rwa_api_client/src/model/deposit_credit_target.dart';
import 'package:rwa_api_client/src/model/funding_source_asset_identity.dart';
import 'package:rwa_api_client/src/model/available_deposit_rail_availability.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'available_deposit_instruction_item.g.dart';

/// One available exact chain-token identity. The QR payload is non-empty and the referenced availability variant requires zero blockers. 
///
/// Properties:
/// * [identity] 
/// * [minDeposit] - 十进制字符串，避免浮点误差
/// * [confirmationsRequired] 
/// * [estimatedArrivalSeconds] 
/// * [qrPayload] - ERC-681 payload for the response wallet and exact item identity. Clients must additionally validate the embedded recipient and identity before display. 
/// * [creditedTo] 
/// * [availability] 
/// * [warning] 
@BuiltValue()
abstract class AvailableDepositInstructionItem implements Built<AvailableDepositInstructionItem, AvailableDepositInstructionItemBuilder> {
  @BuiltValueField(wireName: r'identity')
  FundingSourceAssetIdentity get identity;

  /// 十进制字符串，避免浮点误差
  @BuiltValueField(wireName: r'min_deposit')
  String get minDeposit;

  @BuiltValueField(wireName: r'confirmations_required')
  int get confirmationsRequired;

  @BuiltValueField(wireName: r'estimated_arrival_seconds')
  int get estimatedArrivalSeconds;

  /// ERC-681 payload for the response wallet and exact item identity. Clients must additionally validate the embedded recipient and identity before display. 
  @BuiltValueField(wireName: r'qr_payload')
  String get qrPayload;

  @BuiltValueField(wireName: r'credited_to')
  DepositCreditTarget get creditedTo;
  // enum creditedToEnum {  wallet,  };

  @BuiltValueField(wireName: r'availability')
  AvailableDepositRailAvailability get availability;

  @BuiltValueField(wireName: r'warning')
  String get warning;

  AvailableDepositInstructionItem._();

  factory AvailableDepositInstructionItem([void updates(AvailableDepositInstructionItemBuilder b)]) = _$AvailableDepositInstructionItem;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(AvailableDepositInstructionItemBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<AvailableDepositInstructionItem> get serializer => _$AvailableDepositInstructionItemSerializer();
}

class _$AvailableDepositInstructionItemSerializer implements PrimitiveSerializer<AvailableDepositInstructionItem> {
  @override
  final Iterable<Type> types = const [AvailableDepositInstructionItem, _$AvailableDepositInstructionItem];

  @override
  final String wireName = r'AvailableDepositInstructionItem';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    AvailableDepositInstructionItem object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'identity';
    yield serializers.serialize(
      object.identity,
      specifiedType: const FullType(FundingSourceAssetIdentity),
    );
    yield r'min_deposit';
    yield serializers.serialize(
      object.minDeposit,
      specifiedType: const FullType(String),
    );
    yield r'confirmations_required';
    yield serializers.serialize(
      object.confirmationsRequired,
      specifiedType: const FullType(int),
    );
    yield r'estimated_arrival_seconds';
    yield serializers.serialize(
      object.estimatedArrivalSeconds,
      specifiedType: const FullType(int),
    );
    yield r'qr_payload';
    yield serializers.serialize(
      object.qrPayload,
      specifiedType: const FullType(String),
    );
    yield r'credited_to';
    yield serializers.serialize(
      object.creditedTo,
      specifiedType: const FullType(DepositCreditTarget),
    );
    yield r'availability';
    yield serializers.serialize(
      object.availability,
      specifiedType: const FullType(AvailableDepositRailAvailability),
    );
    yield r'warning';
    yield serializers.serialize(
      object.warning,
      specifiedType: const FullType(String),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    AvailableDepositInstructionItem object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required AvailableDepositInstructionItemBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'identity':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(FundingSourceAssetIdentity),
          ) as FundingSourceAssetIdentity;
          result.identity.replace(valueDes);
          break;
        case r'min_deposit':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.minDeposit = valueDes;
          break;
        case r'confirmations_required':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.confirmationsRequired = valueDes;
          break;
        case r'estimated_arrival_seconds':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.estimatedArrivalSeconds = valueDes;
          break;
        case r'qr_payload':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.qrPayload = valueDes;
          break;
        case r'credited_to':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DepositCreditTarget),
          ) as DepositCreditTarget;
          result.creditedTo = valueDes;
          break;
        case r'availability':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(AvailableDepositRailAvailability),
          ) as AvailableDepositRailAvailability;
          result.availability.replace(valueDes);
          break;
        case r'warning':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.warning = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  AvailableDepositInstructionItem deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = AvailableDepositInstructionItemBuilder();
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


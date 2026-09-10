//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:rwa_api_client/src/model/deposit_credit_target.dart';
import 'package:rwa_api_client/src/model/funding_source_asset_identity.dart';
import 'package:rwa_api_client/src/model/unavailable_deposit_rail_availability.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'unavailable_deposit_instruction_item.g.dart';

/// One unavailable exact chain-token identity. It is explanatory only and must not contain a `qr_payload`; `additionalProperties: false` rejects one. Availability requires at least one blocker. 
///
/// Properties:
/// * [identity] 
/// * [minDeposit] - 十进制字符串，避免浮点误差
/// * [confirmationsRequired] 
/// * [estimatedArrivalSeconds] 
/// * [creditedTo] 
/// * [availability] 
/// * [warning] 
@BuiltValue()
abstract class UnavailableDepositInstructionItem implements Built<UnavailableDepositInstructionItem, UnavailableDepositInstructionItemBuilder> {
  @BuiltValueField(wireName: r'identity')
  FundingSourceAssetIdentity get identity;

  /// 十进制字符串，避免浮点误差
  @BuiltValueField(wireName: r'min_deposit')
  String get minDeposit;

  @BuiltValueField(wireName: r'confirmations_required')
  int get confirmationsRequired;

  @BuiltValueField(wireName: r'estimated_arrival_seconds')
  int get estimatedArrivalSeconds;

  @BuiltValueField(wireName: r'credited_to')
  DepositCreditTarget get creditedTo;
  // enum creditedToEnum {  wallet,  };

  @BuiltValueField(wireName: r'availability')
  UnavailableDepositRailAvailability get availability;

  @BuiltValueField(wireName: r'warning')
  String get warning;

  UnavailableDepositInstructionItem._();

  factory UnavailableDepositInstructionItem([void updates(UnavailableDepositInstructionItemBuilder b)]) = _$UnavailableDepositInstructionItem;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(UnavailableDepositInstructionItemBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<UnavailableDepositInstructionItem> get serializer => _$UnavailableDepositInstructionItemSerializer();
}

class _$UnavailableDepositInstructionItemSerializer implements PrimitiveSerializer<UnavailableDepositInstructionItem> {
  @override
  final Iterable<Type> types = const [UnavailableDepositInstructionItem, _$UnavailableDepositInstructionItem];

  @override
  final String wireName = r'UnavailableDepositInstructionItem';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    UnavailableDepositInstructionItem object, {
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
    yield r'credited_to';
    yield serializers.serialize(
      object.creditedTo,
      specifiedType: const FullType(DepositCreditTarget),
    );
    yield r'availability';
    yield serializers.serialize(
      object.availability,
      specifiedType: const FullType(UnavailableDepositRailAvailability),
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
    UnavailableDepositInstructionItem object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required UnavailableDepositInstructionItemBuilder result,
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
            specifiedType: const FullType(UnavailableDepositRailAvailability),
          ) as UnavailableDepositRailAvailability;
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
  UnavailableDepositInstructionItem deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = UnavailableDepositInstructionItemBuilder();
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


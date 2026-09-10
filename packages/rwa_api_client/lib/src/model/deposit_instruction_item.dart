//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:rwa_api_client/src/model/available_deposit_instruction_item.dart';
import 'package:rwa_api_client/src/model/deposit_credit_target.dart';
import 'package:rwa_api_client/src/model/funding_source_asset_identity.dart';
import 'package:rwa_api_client/src/model/unavailable_deposit_rail_availability.dart';
import 'package:rwa_api_client/src/model/unavailable_deposit_instruction_item.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:one_of/one_of.dart';

part 'deposit_instruction_item.g.dart';

/// Strict available/unavailable item union. Variant selection is structural: an available item has a non-empty QR payload and zero blockers; an unavailable item omits QR payload entirely and has at least one blocker. 
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
abstract class DepositInstructionItem implements Built<DepositInstructionItem, DepositInstructionItemBuilder> {
  /// One Of [AvailableDepositInstructionItem], [UnavailableDepositInstructionItem]
  OneOf get oneOf;

  DepositInstructionItem._();

  factory DepositInstructionItem([void updates(DepositInstructionItemBuilder b)]) = _$DepositInstructionItem;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(DepositInstructionItemBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<DepositInstructionItem> get serializer => _$DepositInstructionItemSerializer();
}

class _$DepositInstructionItemSerializer implements PrimitiveSerializer<DepositInstructionItem> {
  @override
  final Iterable<Type> types = const [DepositInstructionItem, _$DepositInstructionItem];

  @override
  final String wireName = r'DepositInstructionItem';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    DepositInstructionItem object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
  }

  @override
  Object serialize(
    Serializers serializers,
    DepositInstructionItem object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final oneOf = object.oneOf;
    return serializers.serialize(oneOf.value, specifiedType: FullType(oneOf.valueType))!;
  }

  @override
  DepositInstructionItem deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = DepositInstructionItemBuilder();
    Object? oneOfDataSrc;
    final targetType = const FullType(OneOf, [FullType(AvailableDepositInstructionItem), FullType(UnavailableDepositInstructionItem), ]);
    oneOfDataSrc = serialized;
    result.oneOf = serializers.deserialize(oneOfDataSrc, specifiedType: targetType) as OneOf;
    return result.build();
  }
}


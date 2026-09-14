//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:rwa_api_client/src/model/deposit_credit_target.dart';
import 'package:rwa_api_client/src/model/funding_source_asset_identity.dart';
import 'package:rwa_api_client/src/model/deposit_instruction_availability.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'deposit_instruction_item.g.dart';

/// DepositInstructionItem
///
/// Properties:
/// * [identity] 
/// * [minDeposit] - 十进制字符串，避免浮点误差
/// * [confirmationsRequired] 
/// * [estimatedArrivalSeconds] 
/// * [qrPayload] - Present only when availability.status is available.
/// * [creditedTo] 
/// * [availability] 
/// * [warning] 
@BuiltValue()
abstract class DepositInstructionItem implements Built<DepositInstructionItem, DepositInstructionItemBuilder> {
  @BuiltValueField(wireName: r'identity')
  FundingSourceAssetIdentity get identity;

  /// 十进制字符串，避免浮点误差
  @BuiltValueField(wireName: r'min_deposit')
  String get minDeposit;

  @BuiltValueField(wireName: r'confirmations_required')
  int get confirmationsRequired;

  @BuiltValueField(wireName: r'estimated_arrival_seconds')
  int get estimatedArrivalSeconds;

  /// Present only when availability.status is available.
  @BuiltValueField(wireName: r'qr_payload')
  String? get qrPayload;

  @BuiltValueField(wireName: r'credited_to')
  DepositCreditTarget get creditedTo;
  // enum creditedToEnum {  wallet,  };

  @BuiltValueField(wireName: r'availability')
  DepositInstructionAvailability get availability;

  @BuiltValueField(wireName: r'warning')
  String get warning;

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
    if (object.qrPayload != null) {
      yield r'qr_payload';
      yield serializers.serialize(
        object.qrPayload,
        specifiedType: const FullType(String),
      );
    }
    yield r'credited_to';
    yield serializers.serialize(
      object.creditedTo,
      specifiedType: const FullType(DepositCreditTarget),
    );
    yield r'availability';
    yield serializers.serialize(
      object.availability,
      specifiedType: const FullType(DepositInstructionAvailability),
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
    DepositInstructionItem object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required DepositInstructionItemBuilder result,
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
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
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
            specifiedType: const FullType(DepositInstructionAvailability),
          ) as DepositInstructionAvailability;
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
  DepositInstructionItem deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = DepositInstructionItemBuilder();
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


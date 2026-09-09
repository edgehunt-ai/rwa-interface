//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'funding_refund_policy.g.dart';

/// FundingRefundPolicy
///
/// Properties:
/// * [address]
/// * [addressRole]
/// * [mayDeductGas]
/// * [timingNote] - Must not promise an instant or full refund.
@BuiltValue()
abstract class FundingRefundPolicy
    implements Built<FundingRefundPolicy, FundingRefundPolicyBuilder> {
  @BuiltValueField(wireName: r'address')
  String get address;

  @BuiltValueField(wireName: r'address_role')
  FundingRefundPolicyAddressRoleEnum get addressRole;
  // enum addressRoleEnum {  source_wallet,  };

  @BuiltValueField(wireName: r'may_deduct_gas')
  bool get mayDeductGas;

  /// Must not promise an instant or full refund.
  @BuiltValueField(wireName: r'timing_note')
  String get timingNote;

  FundingRefundPolicy._();

  factory FundingRefundPolicy([void updates(FundingRefundPolicyBuilder b)]) =
      _$FundingRefundPolicy;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(FundingRefundPolicyBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<FundingRefundPolicy> get serializer =>
      _$FundingRefundPolicySerializer();
}

class _$FundingRefundPolicySerializer
    implements PrimitiveSerializer<FundingRefundPolicy> {
  @override
  final Iterable<Type> types = const [
    FundingRefundPolicy,
    _$FundingRefundPolicy
  ];

  @override
  final String wireName = r'FundingRefundPolicy';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    FundingRefundPolicy object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'address';
    yield serializers.serialize(
      object.address,
      specifiedType: const FullType(String),
    );
    yield r'address_role';
    yield serializers.serialize(
      object.addressRole,
      specifiedType: const FullType(FundingRefundPolicyAddressRoleEnum),
    );
    yield r'may_deduct_gas';
    yield serializers.serialize(
      object.mayDeductGas,
      specifiedType: const FullType(bool),
    );
    yield r'timing_note';
    yield serializers.serialize(
      object.timingNote,
      specifiedType: const FullType(String),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    FundingRefundPolicy object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object,
            specifiedType: specifiedType)
        .toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required FundingRefundPolicyBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'address':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.address = valueDes;
          break;
        case r'address_role':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(FundingRefundPolicyAddressRoleEnum),
          ) as FundingRefundPolicyAddressRoleEnum;
          result.addressRole = valueDes;
          break;
        case r'may_deduct_gas':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.mayDeductGas = valueDes;
          break;
        case r'timing_note':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.timingNote = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  FundingRefundPolicy deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = FundingRefundPolicyBuilder();
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

class FundingRefundPolicyAddressRoleEnum extends EnumClass {
  @BuiltValueEnumConst(wireName: r'source_wallet')
  static const FundingRefundPolicyAddressRoleEnum sourceWallet =
      _$fundingRefundPolicyAddressRoleEnum_sourceWallet;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const FundingRefundPolicyAddressRoleEnum unknownDefaultOpenApi =
      _$fundingRefundPolicyAddressRoleEnum_unknownDefaultOpenApi;

  static Serializer<FundingRefundPolicyAddressRoleEnum> get serializer =>
      _$fundingRefundPolicyAddressRoleEnumSerializer;

  const FundingRefundPolicyAddressRoleEnum._(String name) : super(name);

  static BuiltSet<FundingRefundPolicyAddressRoleEnum> get values =>
      _$fundingRefundPolicyAddressRoleEnumValues;
  static FundingRefundPolicyAddressRoleEnum valueOf(String name) =>
      _$fundingRefundPolicyAddressRoleEnumValueOf(name);
}

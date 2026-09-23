//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'funding_session_transfer_snapshot.g.dart';

/// Frozen transfer intent stored on a session created from `transfer`.
///
/// Properties:
/// * [kind] 
/// * [destination] 
/// * [amount] - 十进制字符串，避免浮点误差
@BuiltValue()
abstract class FundingSessionTransferSnapshot implements Built<FundingSessionTransferSnapshot, FundingSessionTransferSnapshotBuilder> {
  @BuiltValueField(wireName: r'kind')
  FundingSessionTransferSnapshotKindEnum get kind;
  // enum kindEnum {  account_transfer,  };

  @BuiltValueField(wireName: r'destination')
  FundingSessionTransferSnapshotDestinationEnum get destination;
  // enum destinationEnum {  hip3_margin,  };

  /// 十进制字符串，避免浮点误差
  @BuiltValueField(wireName: r'amount')
  String get amount;

  FundingSessionTransferSnapshot._();

  factory FundingSessionTransferSnapshot([void updates(FundingSessionTransferSnapshotBuilder b)]) = _$FundingSessionTransferSnapshot;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(FundingSessionTransferSnapshotBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<FundingSessionTransferSnapshot> get serializer => _$FundingSessionTransferSnapshotSerializer();
}

class _$FundingSessionTransferSnapshotSerializer implements PrimitiveSerializer<FundingSessionTransferSnapshot> {
  @override
  final Iterable<Type> types = const [FundingSessionTransferSnapshot, _$FundingSessionTransferSnapshot];

  @override
  final String wireName = r'FundingSessionTransferSnapshot';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    FundingSessionTransferSnapshot object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'kind';
    yield serializers.serialize(
      object.kind,
      specifiedType: const FullType(FundingSessionTransferSnapshotKindEnum),
    );
    yield r'destination';
    yield serializers.serialize(
      object.destination,
      specifiedType: const FullType(FundingSessionTransferSnapshotDestinationEnum),
    );
    yield r'amount';
    yield serializers.serialize(
      object.amount,
      specifiedType: const FullType(String),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    FundingSessionTransferSnapshot object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required FundingSessionTransferSnapshotBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'kind':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(FundingSessionTransferSnapshotKindEnum),
          ) as FundingSessionTransferSnapshotKindEnum;
          result.kind = valueDes;
          break;
        case r'destination':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(FundingSessionTransferSnapshotDestinationEnum),
          ) as FundingSessionTransferSnapshotDestinationEnum;
          result.destination = valueDes;
          break;
        case r'amount':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.amount = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  FundingSessionTransferSnapshot deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = FundingSessionTransferSnapshotBuilder();
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

class FundingSessionTransferSnapshotKindEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'account_transfer')
  static const FundingSessionTransferSnapshotKindEnum accountTransfer = _$fundingSessionTransferSnapshotKindEnum_accountTransfer;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const FundingSessionTransferSnapshotKindEnum unknownDefaultOpenApi = _$fundingSessionTransferSnapshotKindEnum_unknownDefaultOpenApi;

  static Serializer<FundingSessionTransferSnapshotKindEnum> get serializer => _$fundingSessionTransferSnapshotKindEnumSerializer;

  const FundingSessionTransferSnapshotKindEnum._(String name): super(name);

  static BuiltSet<FundingSessionTransferSnapshotKindEnum> get values => _$fundingSessionTransferSnapshotKindEnumValues;
  static FundingSessionTransferSnapshotKindEnum valueOf(String name) => _$fundingSessionTransferSnapshotKindEnumValueOf(name);
}

class FundingSessionTransferSnapshotDestinationEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'hip3_margin')
  static const FundingSessionTransferSnapshotDestinationEnum hip3Margin = _$fundingSessionTransferSnapshotDestinationEnum_hip3Margin;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const FundingSessionTransferSnapshotDestinationEnum unknownDefaultOpenApi = _$fundingSessionTransferSnapshotDestinationEnum_unknownDefaultOpenApi;

  static Serializer<FundingSessionTransferSnapshotDestinationEnum> get serializer => _$fundingSessionTransferSnapshotDestinationEnumSerializer;

  const FundingSessionTransferSnapshotDestinationEnum._(String name): super(name);

  static BuiltSet<FundingSessionTransferSnapshotDestinationEnum> get values => _$fundingSessionTransferSnapshotDestinationEnumValues;
  static FundingSessionTransferSnapshotDestinationEnum valueOf(String name) => _$fundingSessionTransferSnapshotDestinationEnumValueOf(name);
}


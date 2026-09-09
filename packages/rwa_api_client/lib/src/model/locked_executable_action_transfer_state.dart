//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:rwa_api_client/src/model/ready_funding_wallet_action.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'locked_executable_action_transfer_state.g.dart';

/// LockedExecutableActionTransferState
///
/// Properties:
/// * [status]
/// * [nextAction]
/// * [routeLockedAt]
/// * [walletActionReleasedAt]
@BuiltValue()
abstract class LockedExecutableActionTransferState
    implements
        Built<LockedExecutableActionTransferState,
            LockedExecutableActionTransferStateBuilder> {
  @BuiltValueField(wireName: r'status')
  LockedExecutableActionTransferStateStatusEnum get status;
  // enum statusEnum {  awaiting_wallet,  };

  @BuiltValueField(wireName: r'next_action')
  ReadyFundingWalletAction get nextAction;

  @BuiltValueField(wireName: r'route_locked_at')
  DateTime get routeLockedAt;

  @BuiltValueField(wireName: r'wallet_action_released_at')
  DateTime get walletActionReleasedAt;

  LockedExecutableActionTransferState._();

  factory LockedExecutableActionTransferState(
          [void updates(LockedExecutableActionTransferStateBuilder b)]) =
      _$LockedExecutableActionTransferState;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(LockedExecutableActionTransferStateBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<LockedExecutableActionTransferState> get serializer =>
      _$LockedExecutableActionTransferStateSerializer();
}

class _$LockedExecutableActionTransferStateSerializer
    implements PrimitiveSerializer<LockedExecutableActionTransferState> {
  @override
  final Iterable<Type> types = const [
    LockedExecutableActionTransferState,
    _$LockedExecutableActionTransferState
  ];

  @override
  final String wireName = r'LockedExecutableActionTransferState';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    LockedExecutableActionTransferState object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'status';
    yield serializers.serialize(
      object.status,
      specifiedType:
          const FullType(LockedExecutableActionTransferStateStatusEnum),
    );
    yield r'next_action';
    yield serializers.serialize(
      object.nextAction,
      specifiedType: const FullType(ReadyFundingWalletAction),
    );
    yield r'route_locked_at';
    yield serializers.serialize(
      object.routeLockedAt,
      specifiedType: const FullType(DateTime),
    );
    yield r'wallet_action_released_at';
    yield serializers.serialize(
      object.walletActionReleasedAt,
      specifiedType: const FullType(DateTime),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    LockedExecutableActionTransferState object, {
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
    required LockedExecutableActionTransferStateBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'status':
          final valueDes = serializers.deserialize(
            value,
            specifiedType:
                const FullType(LockedExecutableActionTransferStateStatusEnum),
          ) as LockedExecutableActionTransferStateStatusEnum;
          result.status = valueDes;
          break;
        case r'next_action':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(ReadyFundingWalletAction),
          ) as ReadyFundingWalletAction;
          result.nextAction.replace(valueDes);
          break;
        case r'route_locked_at':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DateTime),
          ) as DateTime;
          result.routeLockedAt = valueDes;
          break;
        case r'wallet_action_released_at':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DateTime),
          ) as DateTime;
          result.walletActionReleasedAt = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  LockedExecutableActionTransferState deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = LockedExecutableActionTransferStateBuilder();
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

class LockedExecutableActionTransferStateStatusEnum extends EnumClass {
  @BuiltValueEnumConst(wireName: r'awaiting_wallet')
  static const LockedExecutableActionTransferStateStatusEnum awaitingWallet =
      _$lockedExecutableActionTransferStateStatusEnum_awaitingWallet;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const LockedExecutableActionTransferStateStatusEnum
      unknownDefaultOpenApi =
      _$lockedExecutableActionTransferStateStatusEnum_unknownDefaultOpenApi;

  static Serializer<LockedExecutableActionTransferStateStatusEnum>
      get serializer =>
          _$lockedExecutableActionTransferStateStatusEnumSerializer;

  const LockedExecutableActionTransferStateStatusEnum._(String name)
      : super(name);

  static BuiltSet<LockedExecutableActionTransferStateStatusEnum> get values =>
      _$lockedExecutableActionTransferStateStatusEnumValues;
  static LockedExecutableActionTransferStateStatusEnum valueOf(String name) =>
      _$lockedExecutableActionTransferStateStatusEnumValueOf(name);
}

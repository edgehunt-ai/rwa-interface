//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:rwa_api_client/src/model/realtime_deposit_event.dart';
import 'package:rwa_api_client/src/model/realtime_position_event.dart';
import 'package:rwa_api_client/src/model/hip3_realtime_candle_event.dart';
import 'package:rwa_api_client/src/model/realtime_activity_event.dart';
import 'package:rwa_api_client/src/model/realtime_price_event.dart';
import 'package:rwa_api_client/src/model/hip3_realtime_position_event.dart';
import 'package:rwa_api_client/src/model/realtime_transfer_event.dart';
import 'package:rwa_api_client/src/model/hip3_realtime_order_event.dart';
import 'package:rwa_api_client/src/model/realtime_withdrawal_event.dart';
import 'package:rwa_api_client/src/model/realtime_session_event.dart';
import 'package:rwa_api_client/src/model/hip3_realtime_price_event.dart';
import 'package:rwa_api_client/src/model/realtime_resync_required_event.dart';
import 'package:built_collection/built_collection.dart';
import 'package:rwa_api_client/src/model/realtime_claim_event.dart';
import 'package:rwa_api_client/src/model/realtime_balance_event.dart';
import 'package:rwa_api_client/src/model/realtime_order_event.dart';
import 'package:rwa_api_client/src/model/realtime_resync_required_event_all_of_data.dart';
import 'package:rwa_api_client/src/model/hip3_realtime_snapshot_event.dart';
import 'package:rwa_api_client/src/model/realtime_candle_event.dart';
import 'package:rwa_api_client/src/model/hip3_realtime_balance_event.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:one_of/one_of.dart';

part 'realtime_event.g.dart';

/// SSE 事件载荷。`event_id` 等于 SSE 的 `id:` 值；客户端应持久化它，在重连时通过 `Last-Event-ID` 传回。前台已消费的同一业务实体事件可用于抑制重复推送通知。 
///
/// Properties:
/// * [eventId] - 同时作为 SSE `id:` 字段发送的单调递增事件标识，用于断线续传和去重
/// * [emittedAt] 
/// * [event] 
/// * [data] 
@BuiltValue()
abstract class RealtimeEvent implements Built<RealtimeEvent, RealtimeEventBuilder> {
  /// One Of [Hip3RealtimeBalanceEvent], [Hip3RealtimeCandleEvent], [Hip3RealtimeOrderEvent], [Hip3RealtimePositionEvent], [Hip3RealtimePriceEvent], [Hip3RealtimeSnapshotEvent], [RealtimeActivityEvent], [RealtimeBalanceEvent], [RealtimeCandleEvent], [RealtimeClaimEvent], [RealtimeDepositEvent], [RealtimeOrderEvent], [RealtimePositionEvent], [RealtimePriceEvent], [RealtimeResyncRequiredEvent], [RealtimeSessionEvent], [RealtimeTransferEvent], [RealtimeWithdrawalEvent]
  OneOf get oneOf;

  static const String discriminatorFieldName = r'event';

  static const Map<String, Type> discriminatorMapping = {
    r'activity': RealtimeActivityEvent,
    r'balance': RealtimeBalanceEvent,
    r'candle': RealtimeCandleEvent,
    r'claim': RealtimeClaimEvent,
    r'deposit': RealtimeDepositEvent,
    r'hip3_balance': Hip3RealtimeBalanceEvent,
    r'hip3_candle': Hip3RealtimeCandleEvent,
    r'hip3_order': Hip3RealtimeOrderEvent,
    r'hip3_position': Hip3RealtimePositionEvent,
    r'hip3_price': Hip3RealtimePriceEvent,
    r'hip3_snapshot': Hip3RealtimeSnapshotEvent,
    r'order': RealtimeOrderEvent,
    r'position': RealtimePositionEvent,
    r'price': RealtimePriceEvent,
    r'resync_required': RealtimeResyncRequiredEvent,
    r'session': RealtimeSessionEvent,
    r'transfer': RealtimeTransferEvent,
    r'withdrawal': RealtimeWithdrawalEvent,
  };

  RealtimeEvent._();

  factory RealtimeEvent([void updates(RealtimeEventBuilder b)]) = _$RealtimeEvent;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(RealtimeEventBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<RealtimeEvent> get serializer => _$RealtimeEventSerializer();
}

extension RealtimeEventDiscriminatorExt on RealtimeEvent {
    String? get discriminatorValue {
        if (this is RealtimeActivityEvent) {
            return r'activity';
        }
        if (this is RealtimeBalanceEvent) {
            return r'balance';
        }
        if (this is RealtimeCandleEvent) {
            return r'candle';
        }
        if (this is RealtimeClaimEvent) {
            return r'claim';
        }
        if (this is RealtimeDepositEvent) {
            return r'deposit';
        }
        if (this is Hip3RealtimeBalanceEvent) {
            return r'hip3_balance';
        }
        if (this is Hip3RealtimeCandleEvent) {
            return r'hip3_candle';
        }
        if (this is Hip3RealtimeOrderEvent) {
            return r'hip3_order';
        }
        if (this is Hip3RealtimePositionEvent) {
            return r'hip3_position';
        }
        if (this is Hip3RealtimePriceEvent) {
            return r'hip3_price';
        }
        if (this is Hip3RealtimeSnapshotEvent) {
            return r'hip3_snapshot';
        }
        if (this is RealtimeOrderEvent) {
            return r'order';
        }
        if (this is RealtimePositionEvent) {
            return r'position';
        }
        if (this is RealtimePriceEvent) {
            return r'price';
        }
        if (this is RealtimeResyncRequiredEvent) {
            return r'resync_required';
        }
        if (this is RealtimeSessionEvent) {
            return r'session';
        }
        if (this is RealtimeTransferEvent) {
            return r'transfer';
        }
        if (this is RealtimeWithdrawalEvent) {
            return r'withdrawal';
        }
        return null;
    }
}
extension RealtimeEventBuilderDiscriminatorExt on RealtimeEventBuilder {
    String? get discriminatorValue {
        if (this is RealtimeActivityEventBuilder) {
            return r'activity';
        }
        if (this is RealtimeBalanceEventBuilder) {
            return r'balance';
        }
        if (this is RealtimeCandleEventBuilder) {
            return r'candle';
        }
        if (this is RealtimeClaimEventBuilder) {
            return r'claim';
        }
        if (this is RealtimeDepositEventBuilder) {
            return r'deposit';
        }
        if (this is Hip3RealtimeBalanceEventBuilder) {
            return r'hip3_balance';
        }
        if (this is Hip3RealtimeCandleEventBuilder) {
            return r'hip3_candle';
        }
        if (this is Hip3RealtimeOrderEventBuilder) {
            return r'hip3_order';
        }
        if (this is Hip3RealtimePositionEventBuilder) {
            return r'hip3_position';
        }
        if (this is Hip3RealtimePriceEventBuilder) {
            return r'hip3_price';
        }
        if (this is Hip3RealtimeSnapshotEventBuilder) {
            return r'hip3_snapshot';
        }
        if (this is RealtimeOrderEventBuilder) {
            return r'order';
        }
        if (this is RealtimePositionEventBuilder) {
            return r'position';
        }
        if (this is RealtimePriceEventBuilder) {
            return r'price';
        }
        if (this is RealtimeResyncRequiredEventBuilder) {
            return r'resync_required';
        }
        if (this is RealtimeSessionEventBuilder) {
            return r'session';
        }
        if (this is RealtimeTransferEventBuilder) {
            return r'transfer';
        }
        if (this is RealtimeWithdrawalEventBuilder) {
            return r'withdrawal';
        }
        return null;
    }
}

class _$RealtimeEventSerializer implements PrimitiveSerializer<RealtimeEvent> {
  @override
  final Iterable<Type> types = const [RealtimeEvent, _$RealtimeEvent];

  @override
  final String wireName = r'RealtimeEvent';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    RealtimeEvent object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
  }

  @override
  Object serialize(
    Serializers serializers,
    RealtimeEvent object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final oneOf = object.oneOf;
    return serializers.serialize(oneOf.value, specifiedType: FullType(oneOf.valueType))!;
  }

  @override
  RealtimeEvent deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = RealtimeEventBuilder();
    Object? oneOfDataSrc;
    final serializedList = (serialized as Iterable<Object?>).toList();
    final discIndex = serializedList.indexOf(RealtimeEvent.discriminatorFieldName) + 1;
    final discValue = serializers.deserialize(serializedList[discIndex], specifiedType: FullType(String)) as String;
    oneOfDataSrc = serialized;
    final oneOfTypes = [RealtimeActivityEvent, RealtimeBalanceEvent, RealtimeCandleEvent, RealtimeClaimEvent, RealtimeDepositEvent, Hip3RealtimeBalanceEvent, Hip3RealtimeCandleEvent, Hip3RealtimeOrderEvent, Hip3RealtimePositionEvent, Hip3RealtimePriceEvent, Hip3RealtimeSnapshotEvent, RealtimeOrderEvent, RealtimePositionEvent, RealtimePriceEvent, RealtimeResyncRequiredEvent, RealtimeSessionEvent, RealtimeTransferEvent, RealtimeWithdrawalEvent, ];
    Object oneOfResult;
    Type oneOfType;
    switch (discValue) {
      case r'activity':
        oneOfResult = serializers.deserialize(
          oneOfDataSrc,
          specifiedType: FullType(RealtimeActivityEvent),
        ) as RealtimeActivityEvent;
        oneOfType = RealtimeActivityEvent;
        break;
      case r'balance':
        oneOfResult = serializers.deserialize(
          oneOfDataSrc,
          specifiedType: FullType(RealtimeBalanceEvent),
        ) as RealtimeBalanceEvent;
        oneOfType = RealtimeBalanceEvent;
        break;
      case r'candle':
        oneOfResult = serializers.deserialize(
          oneOfDataSrc,
          specifiedType: FullType(RealtimeCandleEvent),
        ) as RealtimeCandleEvent;
        oneOfType = RealtimeCandleEvent;
        break;
      case r'claim':
        oneOfResult = serializers.deserialize(
          oneOfDataSrc,
          specifiedType: FullType(RealtimeClaimEvent),
        ) as RealtimeClaimEvent;
        oneOfType = RealtimeClaimEvent;
        break;
      case r'deposit':
        oneOfResult = serializers.deserialize(
          oneOfDataSrc,
          specifiedType: FullType(RealtimeDepositEvent),
        ) as RealtimeDepositEvent;
        oneOfType = RealtimeDepositEvent;
        break;
      case r'hip3_balance':
        oneOfResult = serializers.deserialize(
          oneOfDataSrc,
          specifiedType: FullType(Hip3RealtimeBalanceEvent),
        ) as Hip3RealtimeBalanceEvent;
        oneOfType = Hip3RealtimeBalanceEvent;
        break;
      case r'hip3_candle':
        oneOfResult = serializers.deserialize(
          oneOfDataSrc,
          specifiedType: FullType(Hip3RealtimeCandleEvent),
        ) as Hip3RealtimeCandleEvent;
        oneOfType = Hip3RealtimeCandleEvent;
        break;
      case r'hip3_order':
        oneOfResult = serializers.deserialize(
          oneOfDataSrc,
          specifiedType: FullType(Hip3RealtimeOrderEvent),
        ) as Hip3RealtimeOrderEvent;
        oneOfType = Hip3RealtimeOrderEvent;
        break;
      case r'hip3_position':
        oneOfResult = serializers.deserialize(
          oneOfDataSrc,
          specifiedType: FullType(Hip3RealtimePositionEvent),
        ) as Hip3RealtimePositionEvent;
        oneOfType = Hip3RealtimePositionEvent;
        break;
      case r'hip3_price':
        oneOfResult = serializers.deserialize(
          oneOfDataSrc,
          specifiedType: FullType(Hip3RealtimePriceEvent),
        ) as Hip3RealtimePriceEvent;
        oneOfType = Hip3RealtimePriceEvent;
        break;
      case r'hip3_snapshot':
        oneOfResult = serializers.deserialize(
          oneOfDataSrc,
          specifiedType: FullType(Hip3RealtimeSnapshotEvent),
        ) as Hip3RealtimeSnapshotEvent;
        oneOfType = Hip3RealtimeSnapshotEvent;
        break;
      case r'order':
        oneOfResult = serializers.deserialize(
          oneOfDataSrc,
          specifiedType: FullType(RealtimeOrderEvent),
        ) as RealtimeOrderEvent;
        oneOfType = RealtimeOrderEvent;
        break;
      case r'position':
        oneOfResult = serializers.deserialize(
          oneOfDataSrc,
          specifiedType: FullType(RealtimePositionEvent),
        ) as RealtimePositionEvent;
        oneOfType = RealtimePositionEvent;
        break;
      case r'price':
        oneOfResult = serializers.deserialize(
          oneOfDataSrc,
          specifiedType: FullType(RealtimePriceEvent),
        ) as RealtimePriceEvent;
        oneOfType = RealtimePriceEvent;
        break;
      case r'resync_required':
        oneOfResult = serializers.deserialize(
          oneOfDataSrc,
          specifiedType: FullType(RealtimeResyncRequiredEvent),
        ) as RealtimeResyncRequiredEvent;
        oneOfType = RealtimeResyncRequiredEvent;
        break;
      case r'session':
        oneOfResult = serializers.deserialize(
          oneOfDataSrc,
          specifiedType: FullType(RealtimeSessionEvent),
        ) as RealtimeSessionEvent;
        oneOfType = RealtimeSessionEvent;
        break;
      case r'transfer':
        oneOfResult = serializers.deserialize(
          oneOfDataSrc,
          specifiedType: FullType(RealtimeTransferEvent),
        ) as RealtimeTransferEvent;
        oneOfType = RealtimeTransferEvent;
        break;
      case r'withdrawal':
        oneOfResult = serializers.deserialize(
          oneOfDataSrc,
          specifiedType: FullType(RealtimeWithdrawalEvent),
        ) as RealtimeWithdrawalEvent;
        oneOfType = RealtimeWithdrawalEvent;
        break;
      default:
        throw UnsupportedError("Couldn't deserialize oneOf for the discriminator value: ${discValue}");
    }
    result.oneOf = OneOfDynamic(typeIndex: oneOfTypes.indexOf(oneOfType), types: oneOfTypes, value: oneOfResult);
    return result.build();
  }
}

class RealtimeEventEventEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'resync_required')
  static const RealtimeEventEventEnum resyncRequired = _$realtimeEventEventEnum_resyncRequired;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const RealtimeEventEventEnum unknownDefaultOpenApi = _$realtimeEventEventEnum_unknownDefaultOpenApi;

  static Serializer<RealtimeEventEventEnum> get serializer => _$realtimeEventEventEnumSerializer;

  const RealtimeEventEventEnum._(String name): super(name);

  static BuiltSet<RealtimeEventEventEnum> get values => _$realtimeEventEventEnumValues;
  static RealtimeEventEventEnum valueOf(String name) => _$realtimeEventEventEnumValueOf(name);
}


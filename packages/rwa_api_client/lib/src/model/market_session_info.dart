//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:rwa_api_client/src/model/session_segment.dart';
import 'package:rwa_api_client/src/model/session_kind.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'market_session_info.g.dart';

/// MarketSessionInfo
///
/// Properties:
/// * [timezone]
/// * [current]
/// * [currentLabel]
/// * [currentDescription]
/// * [nextSession]
/// * [nextTransitionAt]
/// * [secondsUntilTransition] - 距下一次时段切换的秒数，用于「距开盘 02:14:33」倒计时
/// * [isHoliday]
/// * [holidayName]
/// * [segments]
@BuiltValue()
abstract class MarketSessionInfo
    implements Built<MarketSessionInfo, MarketSessionInfoBuilder> {
  @BuiltValueField(wireName: r'timezone')
  String get timezone;

  @BuiltValueField(wireName: r'current')
  SessionKind get current;
  // enum currentEnum {  premarket,  regular,  after,  overnight,  weekend,  holiday,  };

  @BuiltValueField(wireName: r'current_label')
  String? get currentLabel;

  @BuiltValueField(wireName: r'current_description')
  String? get currentDescription;

  @BuiltValueField(wireName: r'next_session')
  SessionKind? get nextSession;
  // enum nextSessionEnum {  premarket,  regular,  after,  overnight,  weekend,  holiday,  };

  @BuiltValueField(wireName: r'next_transition_at')
  DateTime? get nextTransitionAt;

  /// 距下一次时段切换的秒数，用于「距开盘 02:14:33」倒计时
  @BuiltValueField(wireName: r'seconds_until_transition')
  int? get secondsUntilTransition;

  @BuiltValueField(wireName: r'is_holiday')
  bool? get isHoliday;

  @BuiltValueField(wireName: r'holiday_name')
  String? get holidayName;

  @BuiltValueField(wireName: r'segments')
  BuiltList<SessionSegment>? get segments;

  MarketSessionInfo._();

  factory MarketSessionInfo([void updates(MarketSessionInfoBuilder b)]) =
      _$MarketSessionInfo;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(MarketSessionInfoBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<MarketSessionInfo> get serializer =>
      _$MarketSessionInfoSerializer();
}

class _$MarketSessionInfoSerializer
    implements PrimitiveSerializer<MarketSessionInfo> {
  @override
  final Iterable<Type> types = const [MarketSessionInfo, _$MarketSessionInfo];

  @override
  final String wireName = r'MarketSessionInfo';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    MarketSessionInfo object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'timezone';
    yield serializers.serialize(
      object.timezone,
      specifiedType: const FullType(String),
    );
    yield r'current';
    yield serializers.serialize(
      object.current,
      specifiedType: const FullType(SessionKind),
    );
    if (object.currentLabel != null) {
      yield r'current_label';
      yield serializers.serialize(
        object.currentLabel,
        specifiedType: const FullType(String),
      );
    }
    if (object.currentDescription != null) {
      yield r'current_description';
      yield serializers.serialize(
        object.currentDescription,
        specifiedType: const FullType(String),
      );
    }
    if (object.nextSession != null) {
      yield r'next_session';
      yield serializers.serialize(
        object.nextSession,
        specifiedType: const FullType(SessionKind),
      );
    }
    if (object.nextTransitionAt != null) {
      yield r'next_transition_at';
      yield serializers.serialize(
        object.nextTransitionAt,
        specifiedType: const FullType(DateTime),
      );
    }
    if (object.secondsUntilTransition != null) {
      yield r'seconds_until_transition';
      yield serializers.serialize(
        object.secondsUntilTransition,
        specifiedType: const FullType(int),
      );
    }
    if (object.isHoliday != null) {
      yield r'is_holiday';
      yield serializers.serialize(
        object.isHoliday,
        specifiedType: const FullType(bool),
      );
    }
    if (object.holidayName != null) {
      yield r'holiday_name';
      yield serializers.serialize(
        object.holidayName,
        specifiedType: const FullType.nullable(String),
      );
    }
    if (object.segments != null) {
      yield r'segments';
      yield serializers.serialize(
        object.segments,
        specifiedType: const FullType(BuiltList, [FullType(SessionSegment)]),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    MarketSessionInfo object, {
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
    required MarketSessionInfoBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'timezone':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.timezone = valueDes;
          break;
        case r'current':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(SessionKind),
          ) as SessionKind;
          result.current = valueDes;
          break;
        case r'current_label':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.currentLabel = valueDes;
          break;
        case r'current_description':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.currentDescription = valueDes;
          break;
        case r'next_session':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(SessionKind),
          ) as SessionKind?;
          if (valueDes == null) continue;
          result.nextSession = valueDes;
          break;
        case r'next_transition_at':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(DateTime),
          ) as DateTime?;
          if (valueDes == null) continue;
          result.nextTransitionAt = valueDes;
          break;
        case r'seconds_until_transition':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(int),
          ) as int?;
          if (valueDes == null) continue;
          result.secondsUntilTransition = valueDes;
          break;
        case r'is_holiday':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(bool),
          ) as bool?;
          if (valueDes == null) continue;
          result.isHoliday = valueDes;
          break;
        case r'holiday_name':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.holidayName = valueDes;
          break;
        case r'segments':
          final valueDes = serializers.deserialize(
            value,
            specifiedType:
                const FullType.nullable(BuiltList, [FullType(SessionSegment)]),
          ) as BuiltList<SessionSegment>?;
          if (valueDes == null) continue;
          result.segments.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  MarketSessionInfo deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = MarketSessionInfoBuilder();
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

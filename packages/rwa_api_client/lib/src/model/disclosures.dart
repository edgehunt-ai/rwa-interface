//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:rwa_api_client/src/model/key_value.dart';
import 'package:built_collection/built_collection.dart';
import 'package:rwa_api_client/src/model/disclosures_sessions_inner.dart';
import 'package:rwa_api_client/src/model/disclosures_always_on.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'disclosures.g.dart';

/// Disclosures
///
/// Properties:
/// * [alwaysOn] 
/// * [sessions] - 各交易时段的说明
/// * [riskNotices] 
@BuiltValue()
abstract class Disclosures implements Built<Disclosures, DisclosuresBuilder> {
  @BuiltValueField(wireName: r'always_on')
  DisclosuresAlwaysOn? get alwaysOn;

  /// 各交易时段的说明
  @BuiltValueField(wireName: r'sessions')
  BuiltList<DisclosuresSessionsInner>? get sessions;

  @BuiltValueField(wireName: r'risk_notices')
  BuiltList<KeyValue>? get riskNotices;

  Disclosures._();

  factory Disclosures([void updates(DisclosuresBuilder b)]) = _$Disclosures;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(DisclosuresBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<Disclosures> get serializer => _$DisclosuresSerializer();
}

class _$DisclosuresSerializer implements PrimitiveSerializer<Disclosures> {
  @override
  final Iterable<Type> types = const [Disclosures, _$Disclosures];

  @override
  final String wireName = r'Disclosures';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    Disclosures object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.alwaysOn != null) {
      yield r'always_on';
      yield serializers.serialize(
        object.alwaysOn,
        specifiedType: const FullType(DisclosuresAlwaysOn),
      );
    }
    if (object.sessions != null) {
      yield r'sessions';
      yield serializers.serialize(
        object.sessions,
        specifiedType: const FullType(BuiltList, [FullType(DisclosuresSessionsInner)]),
      );
    }
    if (object.riskNotices != null) {
      yield r'risk_notices';
      yield serializers.serialize(
        object.riskNotices,
        specifiedType: const FullType(BuiltList, [FullType(KeyValue)]),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    Disclosures object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required DisclosuresBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'always_on':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(DisclosuresAlwaysOn),
          ) as DisclosuresAlwaysOn?;
          if (valueDes == null) continue;
          result.alwaysOn.replace(valueDes);
          break;
        case r'sessions':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(BuiltList, [FullType(DisclosuresSessionsInner)]),
          ) as BuiltList<DisclosuresSessionsInner>?;
          if (valueDes == null) continue;
          result.sessions.replace(valueDes);
          break;
        case r'risk_notices':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(BuiltList, [FullType(KeyValue)]),
          ) as BuiltList<KeyValue>?;
          if (valueDes == null) continue;
          result.riskNotices.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  Disclosures deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = DisclosuresBuilder();
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


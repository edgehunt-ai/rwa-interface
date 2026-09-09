//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'activity_record_explorer.g.dart';

/// 区块链浏览器链接
///
/// Properties:
/// * [name] 
/// * [url] 
@BuiltValue()
abstract class ActivityRecordExplorer implements Built<ActivityRecordExplorer, ActivityRecordExplorerBuilder> {
  @BuiltValueField(wireName: r'name')
  String get name;

  @BuiltValueField(wireName: r'url')
  String get url;

  ActivityRecordExplorer._();

  factory ActivityRecordExplorer([void updates(ActivityRecordExplorerBuilder b)]) = _$ActivityRecordExplorer;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ActivityRecordExplorerBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ActivityRecordExplorer> get serializer => _$ActivityRecordExplorerSerializer();
}

class _$ActivityRecordExplorerSerializer implements PrimitiveSerializer<ActivityRecordExplorer> {
  @override
  final Iterable<Type> types = const [ActivityRecordExplorer, _$ActivityRecordExplorer];

  @override
  final String wireName = r'ActivityRecordExplorer';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ActivityRecordExplorer object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'name';
    yield serializers.serialize(
      object.name,
      specifiedType: const FullType(String),
    );
    yield r'url';
    yield serializers.serialize(
      object.url,
      specifiedType: const FullType(String),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    ActivityRecordExplorer object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required ActivityRecordExplorerBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'name':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.name = valueDes;
          break;
        case r'url':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.url = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  ActivityRecordExplorer deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ActivityRecordExplorerBuilder();
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


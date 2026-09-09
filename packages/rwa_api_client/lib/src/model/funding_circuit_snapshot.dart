//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:rwa_api_client/src/model/funding_rail_circuit.dart';
import 'package:rwa_api_client/src/model/funding_global_circuit.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'funding_circuit_snapshot.g.dart';

/// API 响应时从持久化 circuit 表实时读取的 global 与当前 rail 快照。 缺失、重复或无法完整读取时服务端必须返回 unavailable，不得合成 closed。
///
/// Properties:
/// * [global] 
/// * [rail] 
@BuiltValue()
abstract class FundingCircuitSnapshot implements Built<FundingCircuitSnapshot, FundingCircuitSnapshotBuilder> {
  @BuiltValueField(wireName: r'global')
  FundingGlobalCircuit get global;

  @BuiltValueField(wireName: r'rail')
  FundingRailCircuit get rail;

  FundingCircuitSnapshot._();

  factory FundingCircuitSnapshot([void updates(FundingCircuitSnapshotBuilder b)]) = _$FundingCircuitSnapshot;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(FundingCircuitSnapshotBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<FundingCircuitSnapshot> get serializer => _$FundingCircuitSnapshotSerializer();
}

class _$FundingCircuitSnapshotSerializer implements PrimitiveSerializer<FundingCircuitSnapshot> {
  @override
  final Iterable<Type> types = const [FundingCircuitSnapshot, _$FundingCircuitSnapshot];

  @override
  final String wireName = r'FundingCircuitSnapshot';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    FundingCircuitSnapshot object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'global';
    yield serializers.serialize(
      object.global,
      specifiedType: const FullType(FundingGlobalCircuit),
    );
    yield r'rail';
    yield serializers.serialize(
      object.rail,
      specifiedType: const FullType(FundingRailCircuit),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    FundingCircuitSnapshot object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required FundingCircuitSnapshotBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'global':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(FundingGlobalCircuit),
          ) as FundingGlobalCircuit;
          result.global.replace(valueDes);
          break;
        case r'rail':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(FundingRailCircuit),
          ) as FundingRailCircuit;
          result.rail.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  FundingCircuitSnapshot deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = FundingCircuitSnapshotBuilder();
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


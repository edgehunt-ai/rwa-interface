//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:rwa_api_client/src/model/funding_session_source_allocation_input.dart';
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'funding_session_selection_request.g.dart';

/// Replaces the editable source selection for the expected session version. A selection below the minimum may be saved, but the returned session must keep transfer confirmation disabled. 非null的amount仅用于standalone account_transfer会话，且必须提供：按最新余额之上的净补资额重设minimum。 订单驱动会话必须省略amount或传null，不允许覆盖冻结订单资金需求。HIP3补资须正数且精确到8位小数（末尾零等价）。 allocations最多三项，source_position_id必须互不相同；同一ID即使input_amount不同也会返回422。 
///
/// Properties:
/// * [version] 
/// * [amount] - 十进制字符串，避免浮点误差。请求最多60位整数和18位小数，不接受整数部分多余前导零； 各操作另行校验正负、范围及资产精度，不以此通用响应标量代替业务准入。 
/// * [allocations] 
@BuiltValue()
abstract class FundingSessionSelectionRequest implements Built<FundingSessionSelectionRequest, FundingSessionSelectionRequestBuilder> {
  @BuiltValueField(wireName: r'version')
  int get version;

  /// 十进制字符串，避免浮点误差。请求最多60位整数和18位小数，不接受整数部分多余前导零； 各操作另行校验正负、范围及资产精度，不以此通用响应标量代替业务准入。 
  @BuiltValueField(wireName: r'amount')
  String? get amount;

  @BuiltValueField(wireName: r'allocations')
  BuiltSet<FundingSessionSourceAllocationInput> get allocations;

  FundingSessionSelectionRequest._();

  factory FundingSessionSelectionRequest([void updates(FundingSessionSelectionRequestBuilder b)]) = _$FundingSessionSelectionRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(FundingSessionSelectionRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<FundingSessionSelectionRequest> get serializer => _$FundingSessionSelectionRequestSerializer();
}

class _$FundingSessionSelectionRequestSerializer implements PrimitiveSerializer<FundingSessionSelectionRequest> {
  @override
  final Iterable<Type> types = const [FundingSessionSelectionRequest, _$FundingSessionSelectionRequest];

  @override
  final String wireName = r'FundingSessionSelectionRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    FundingSessionSelectionRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'version';
    yield serializers.serialize(
      object.version,
      specifiedType: const FullType(int),
    );
    if (object.amount != null) {
      yield r'amount';
      yield serializers.serialize(
        object.amount,
        specifiedType: const FullType.nullable(String),
      );
    }
    yield r'allocations';
    yield serializers.serialize(
      object.allocations,
      specifiedType: const FullType(BuiltSet, [FullType(FundingSessionSourceAllocationInput)]),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    FundingSessionSelectionRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required FundingSessionSelectionRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'version':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.version = valueDes;
          break;
        case r'amount':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.amount = valueDes;
          break;
        case r'allocations':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltSet, [FullType(FundingSessionSourceAllocationInput)]),
          ) as BuiltSet<FundingSessionSourceAllocationInput>;
          result.allocations.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  FundingSessionSelectionRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = FundingSessionSelectionRequestBuilder();
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


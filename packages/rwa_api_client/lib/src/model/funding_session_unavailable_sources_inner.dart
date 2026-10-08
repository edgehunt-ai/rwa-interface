//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:rwa_api_client/src/model/funding_source_asset_identity.dart';
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'funding_session_unavailable_sources_inner.g.dart';

/// FundingSessionUnavailableSourcesInner
///
/// Properties:
/// * [asset] 
/// * [failureReason] - unavailable=链上/RPC 读失败；stale=观测过旧；invalid=读数不合法。
@BuiltValue()
abstract class FundingSessionUnavailableSourcesInner implements Built<FundingSessionUnavailableSourcesInner, FundingSessionUnavailableSourcesInnerBuilder> {
  @BuiltValueField(wireName: r'asset')
  FundingSourceAssetIdentity get asset;

  /// unavailable=链上/RPC 读失败；stale=观测过旧；invalid=读数不合法。
  @BuiltValueField(wireName: r'failure_reason')
  FundingSessionUnavailableSourcesInnerFailureReasonEnum get failureReason;
  // enum failureReasonEnum {  unavailable,  stale,  invalid,  };

  FundingSessionUnavailableSourcesInner._();

  factory FundingSessionUnavailableSourcesInner([void updates(FundingSessionUnavailableSourcesInnerBuilder b)]) = _$FundingSessionUnavailableSourcesInner;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(FundingSessionUnavailableSourcesInnerBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<FundingSessionUnavailableSourcesInner> get serializer => _$FundingSessionUnavailableSourcesInnerSerializer();
}

class _$FundingSessionUnavailableSourcesInnerSerializer implements PrimitiveSerializer<FundingSessionUnavailableSourcesInner> {
  @override
  final Iterable<Type> types = const [FundingSessionUnavailableSourcesInner, _$FundingSessionUnavailableSourcesInner];

  @override
  final String wireName = r'FundingSessionUnavailableSourcesInner';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    FundingSessionUnavailableSourcesInner object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'asset';
    yield serializers.serialize(
      object.asset,
      specifiedType: const FullType(FundingSourceAssetIdentity),
    );
    yield r'failure_reason';
    yield serializers.serialize(
      object.failureReason,
      specifiedType: const FullType(FundingSessionUnavailableSourcesInnerFailureReasonEnum),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    FundingSessionUnavailableSourcesInner object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required FundingSessionUnavailableSourcesInnerBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'asset':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(FundingSourceAssetIdentity),
          ) as FundingSourceAssetIdentity;
          result.asset.replace(valueDes);
          break;
        case r'failure_reason':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(FundingSessionUnavailableSourcesInnerFailureReasonEnum),
          ) as FundingSessionUnavailableSourcesInnerFailureReasonEnum;
          result.failureReason = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  FundingSessionUnavailableSourcesInner deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = FundingSessionUnavailableSourcesInnerBuilder();
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

class FundingSessionUnavailableSourcesInnerFailureReasonEnum extends EnumClass {

  /// unavailable=链上/RPC 读失败；stale=观测过旧；invalid=读数不合法。
  @BuiltValueEnumConst(wireName: r'unavailable')
  static const FundingSessionUnavailableSourcesInnerFailureReasonEnum unavailable = _$fundingSessionUnavailableSourcesInnerFailureReasonEnum_unavailable;
  /// unavailable=链上/RPC 读失败；stale=观测过旧；invalid=读数不合法。
  @BuiltValueEnumConst(wireName: r'stale')
  static const FundingSessionUnavailableSourcesInnerFailureReasonEnum stale = _$fundingSessionUnavailableSourcesInnerFailureReasonEnum_stale;
  /// unavailable=链上/RPC 读失败；stale=观测过旧；invalid=读数不合法。
  @BuiltValueEnumConst(wireName: r'invalid')
  static const FundingSessionUnavailableSourcesInnerFailureReasonEnum invalid = _$fundingSessionUnavailableSourcesInnerFailureReasonEnum_invalid;

  static Serializer<FundingSessionUnavailableSourcesInnerFailureReasonEnum> get serializer => _$fundingSessionUnavailableSourcesInnerFailureReasonEnumSerializer;

  const FundingSessionUnavailableSourcesInnerFailureReasonEnum._(String name): super(name);

  static BuiltSet<FundingSessionUnavailableSourcesInnerFailureReasonEnum> get values => _$fundingSessionUnavailableSourcesInnerFailureReasonEnumValues;
  static FundingSessionUnavailableSourcesInnerFailureReasonEnum valueOf(String name) => _$fundingSessionUnavailableSourcesInnerFailureReasonEnumValueOf(name);
}


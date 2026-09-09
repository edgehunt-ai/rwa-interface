//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:rwa_api_client/src/model/funding_provider.dart';
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'completed_funding_provider_observation.g.dart';

/// CompletedFundingProviderObservation
///
/// Properties:
/// * [provider]
/// * [status]
/// * [observedAt]
@BuiltValue()
abstract class CompletedFundingProviderObservation
    implements
        Built<CompletedFundingProviderObservation,
            CompletedFundingProviderObservationBuilder> {
  @BuiltValueField(wireName: r'provider')
  FundingProvider get provider;
  // enum providerEnum {  across,  relay,  };

  @BuiltValueField(wireName: r'status')
  CompletedFundingProviderObservationStatusEnum get status;
  // enum statusEnum {  succeeded,  };

  @BuiltValueField(wireName: r'observed_at')
  DateTime get observedAt;

  CompletedFundingProviderObservation._();

  factory CompletedFundingProviderObservation(
          [void updates(CompletedFundingProviderObservationBuilder b)]) =
      _$CompletedFundingProviderObservation;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(CompletedFundingProviderObservationBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<CompletedFundingProviderObservation> get serializer =>
      _$CompletedFundingProviderObservationSerializer();
}

class _$CompletedFundingProviderObservationSerializer
    implements PrimitiveSerializer<CompletedFundingProviderObservation> {
  @override
  final Iterable<Type> types = const [
    CompletedFundingProviderObservation,
    _$CompletedFundingProviderObservation
  ];

  @override
  final String wireName = r'CompletedFundingProviderObservation';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    CompletedFundingProviderObservation object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'provider';
    yield serializers.serialize(
      object.provider,
      specifiedType: const FullType(FundingProvider),
    );
    yield r'status';
    yield serializers.serialize(
      object.status,
      specifiedType:
          const FullType(CompletedFundingProviderObservationStatusEnum),
    );
    yield r'observed_at';
    yield serializers.serialize(
      object.observedAt,
      specifiedType: const FullType(DateTime),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    CompletedFundingProviderObservation object, {
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
    required CompletedFundingProviderObservationBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'provider':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(FundingProvider),
          ) as FundingProvider;
          result.provider = valueDes;
          break;
        case r'status':
          final valueDes = serializers.deserialize(
            value,
            specifiedType:
                const FullType(CompletedFundingProviderObservationStatusEnum),
          ) as CompletedFundingProviderObservationStatusEnum;
          result.status = valueDes;
          break;
        case r'observed_at':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DateTime),
          ) as DateTime;
          result.observedAt = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  CompletedFundingProviderObservation deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = CompletedFundingProviderObservationBuilder();
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

class CompletedFundingProviderObservationStatusEnum extends EnumClass {
  @BuiltValueEnumConst(wireName: r'succeeded')
  static const CompletedFundingProviderObservationStatusEnum succeeded =
      _$completedFundingProviderObservationStatusEnum_succeeded;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const CompletedFundingProviderObservationStatusEnum
      unknownDefaultOpenApi =
      _$completedFundingProviderObservationStatusEnum_unknownDefaultOpenApi;

  static Serializer<CompletedFundingProviderObservationStatusEnum>
      get serializer =>
          _$completedFundingProviderObservationStatusEnumSerializer;

  const CompletedFundingProviderObservationStatusEnum._(String name)
      : super(name);

  static BuiltSet<CompletedFundingProviderObservationStatusEnum> get values =>
      _$completedFundingProviderObservationStatusEnumValues;
  static CompletedFundingProviderObservationStatusEnum valueOf(String name) =>
      _$completedFundingProviderObservationStatusEnumValueOf(name);
}

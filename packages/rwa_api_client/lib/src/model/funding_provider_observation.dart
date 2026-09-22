//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:rwa_api_client/src/model/funding_provider.dart';
import 'package:rwa_api_client/src/model/transfer_provider_status.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'funding_provider_observation.g.dart';

/// FundingProviderObservation
///
/// Properties:
/// * [provider] 
/// * [status] 
/// * [observedAt] 
@BuiltValue()
abstract class FundingProviderObservation implements Built<FundingProviderObservation, FundingProviderObservationBuilder> {
  @BuiltValueField(wireName: r'provider')
  FundingProvider get provider;
  // enum providerEnum {  across,  relay,  hyperliquid_bridge2,  platform_float,  };

  @BuiltValueField(wireName: r'status')
  TransferProviderStatus get status;
  // enum statusEnum {  pending,  processing,  succeeded,  failed,  refund_pending,  refunded,  unknown,  manual_review,  };

  @BuiltValueField(wireName: r'observed_at')
  DateTime get observedAt;

  FundingProviderObservation._();

  factory FundingProviderObservation([void updates(FundingProviderObservationBuilder b)]) = _$FundingProviderObservation;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(FundingProviderObservationBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<FundingProviderObservation> get serializer => _$FundingProviderObservationSerializer();
}

class _$FundingProviderObservationSerializer implements PrimitiveSerializer<FundingProviderObservation> {
  @override
  final Iterable<Type> types = const [FundingProviderObservation, _$FundingProviderObservation];

  @override
  final String wireName = r'FundingProviderObservation';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    FundingProviderObservation object, {
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
      specifiedType: const FullType(TransferProviderStatus),
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
    FundingProviderObservation object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required FundingProviderObservationBuilder result,
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
            specifiedType: const FullType(TransferProviderStatus),
          ) as TransferProviderStatus;
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
  FundingProviderObservation deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = FundingProviderObservationBuilder();
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


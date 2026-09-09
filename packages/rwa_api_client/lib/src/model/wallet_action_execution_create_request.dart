//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:rwa_api_client/src/model/gas_payment_mode.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'wallet_action_execution_create_request.g.dart';

/// WalletActionExecutionCreateRequest
///
/// Properties:
/// * [mode] 
@BuiltValue()
abstract class WalletActionExecutionCreateRequest implements Built<WalletActionExecutionCreateRequest, WalletActionExecutionCreateRequestBuilder> {
  @BuiltValueField(wireName: r'mode')
  GasPaymentMode get mode;
  // enum modeEnum {  app_sponsored,  user_paid_native,  };

  WalletActionExecutionCreateRequest._();

  factory WalletActionExecutionCreateRequest([void updates(WalletActionExecutionCreateRequestBuilder b)]) = _$WalletActionExecutionCreateRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(WalletActionExecutionCreateRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<WalletActionExecutionCreateRequest> get serializer => _$WalletActionExecutionCreateRequestSerializer();
}

class _$WalletActionExecutionCreateRequestSerializer implements PrimitiveSerializer<WalletActionExecutionCreateRequest> {
  @override
  final Iterable<Type> types = const [WalletActionExecutionCreateRequest, _$WalletActionExecutionCreateRequest];

  @override
  final String wireName = r'WalletActionExecutionCreateRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    WalletActionExecutionCreateRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'mode';
    yield serializers.serialize(
      object.mode,
      specifiedType: const FullType(GasPaymentMode),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    WalletActionExecutionCreateRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required WalletActionExecutionCreateRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'mode':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(GasPaymentMode),
          ) as GasPaymentMode;
          result.mode = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  WalletActionExecutionCreateRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = WalletActionExecutionCreateRequestBuilder();
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


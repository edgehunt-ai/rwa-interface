//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'bstocks_wallet_action_submission.g.dart';

/// BstocksWalletActionSubmission
///
/// Properties:
/// * [orderId] 
/// * [actionId] 
/// * [status] 
/// * [submittedTransactionHash] 
/// * [updatedAt] 
@BuiltValue()
abstract class BstocksWalletActionSubmission implements Built<BstocksWalletActionSubmission, BstocksWalletActionSubmissionBuilder> {
  @BuiltValueField(wireName: r'order_id')
  String get orderId;

  @BuiltValueField(wireName: r'action_id')
  String get actionId;

  @BuiltValueField(wireName: r'status')
  BstocksWalletActionSubmissionStatusEnum get status;
  // enum statusEnum {  submitted,  confirmed,  manual_review,  };

  @BuiltValueField(wireName: r'submitted_transaction_hash')
  String get submittedTransactionHash;

  @BuiltValueField(wireName: r'updated_at')
  DateTime get updatedAt;

  BstocksWalletActionSubmission._();

  factory BstocksWalletActionSubmission([void updates(BstocksWalletActionSubmissionBuilder b)]) = _$BstocksWalletActionSubmission;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(BstocksWalletActionSubmissionBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<BstocksWalletActionSubmission> get serializer => _$BstocksWalletActionSubmissionSerializer();
}

class _$BstocksWalletActionSubmissionSerializer implements PrimitiveSerializer<BstocksWalletActionSubmission> {
  @override
  final Iterable<Type> types = const [BstocksWalletActionSubmission, _$BstocksWalletActionSubmission];

  @override
  final String wireName = r'BstocksWalletActionSubmission';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    BstocksWalletActionSubmission object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'order_id';
    yield serializers.serialize(
      object.orderId,
      specifiedType: const FullType(String),
    );
    yield r'action_id';
    yield serializers.serialize(
      object.actionId,
      specifiedType: const FullType(String),
    );
    yield r'status';
    yield serializers.serialize(
      object.status,
      specifiedType: const FullType(BstocksWalletActionSubmissionStatusEnum),
    );
    yield r'submitted_transaction_hash';
    yield serializers.serialize(
      object.submittedTransactionHash,
      specifiedType: const FullType(String),
    );
    yield r'updated_at';
    yield serializers.serialize(
      object.updatedAt,
      specifiedType: const FullType(DateTime),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    BstocksWalletActionSubmission object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required BstocksWalletActionSubmissionBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'order_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.orderId = valueDes;
          break;
        case r'action_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.actionId = valueDes;
          break;
        case r'status':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BstocksWalletActionSubmissionStatusEnum),
          ) as BstocksWalletActionSubmissionStatusEnum;
          result.status = valueDes;
          break;
        case r'submitted_transaction_hash':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.submittedTransactionHash = valueDes;
          break;
        case r'updated_at':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DateTime),
          ) as DateTime;
          result.updatedAt = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  BstocksWalletActionSubmission deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = BstocksWalletActionSubmissionBuilder();
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

class BstocksWalletActionSubmissionStatusEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'submitted')
  static const BstocksWalletActionSubmissionStatusEnum submitted = _$bstocksWalletActionSubmissionStatusEnum_submitted;
  @BuiltValueEnumConst(wireName: r'confirmed')
  static const BstocksWalletActionSubmissionStatusEnum confirmed = _$bstocksWalletActionSubmissionStatusEnum_confirmed;
  @BuiltValueEnumConst(wireName: r'manual_review')
  static const BstocksWalletActionSubmissionStatusEnum manualReview = _$bstocksWalletActionSubmissionStatusEnum_manualReview;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const BstocksWalletActionSubmissionStatusEnum unknownDefaultOpenApi = _$bstocksWalletActionSubmissionStatusEnum_unknownDefaultOpenApi;

  static Serializer<BstocksWalletActionSubmissionStatusEnum> get serializer => _$bstocksWalletActionSubmissionStatusEnumSerializer;

  const BstocksWalletActionSubmissionStatusEnum._(String name): super(name);

  static BuiltSet<BstocksWalletActionSubmissionStatusEnum> get values => _$bstocksWalletActionSubmissionStatusEnumValues;
  static BstocksWalletActionSubmissionStatusEnum valueOf(String name) => _$bstocksWalletActionSubmissionStatusEnumValueOf(name);
}

